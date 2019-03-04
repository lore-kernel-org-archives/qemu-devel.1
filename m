Received: from eggs.gnu.org ([209.51.188.92]:38100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h0rjl-0002oh-6H
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 12:50:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h0rjk-0003Bu-66
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 12:50:49 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190225183757.27378-1-armbru@redhat.com>
	<20190225183757.27378-7-armbru@redhat.com>
Date: Mon, 04 Mar 2019 18:50:40 +0100
In-Reply-To: <20190225183757.27378-7-armbru@redhat.com> (Markus Armbruster's
	message of "Mon, 25 Feb 2019 19:37:57 +0100")
Message-ID: <87bm2qzfyn.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC PATCH 6/6] pc: Support firmware configuration
 with -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, lersek@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, pkrempa@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com

The problem at hand is how to destroy a device created with
qdev_create() without ever realizing it.

This hack passes tests:

diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index ed608a53d3..1bd538796b 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -116,14 +116,9 @@ static void pc_system_flash_cleanup_unused(PCMachineState *pcms)
             prop_name = g_strdup_printf("pflash%d", i);
             object_property_del(OBJECT(pcms), prop_name, &error_abort);
             g_free(prop_name);
-            /*
-             * FIXME delete @dev_obj.  Straight object_unref() is
-             * wrong, since it leaves dangling references in the
-             * parent bus behind.  object_unparent() doesn't work,
-             * either: since @dev_obj hasn't been realized,
-             * dev_obj->parent is null, and object_unparent() does
-             * nothing.
-             */
+            object_ref(dev_obj);
+            object_get_class(dev_obj)->unparent(dev_obj);
+            object_unref(dev_obj);
             pcms->flash[i] = NULL;
         }
     }

If you have a better idea, please let me know.

Here's how I arrived at my hack.  We need to undo qdev_create().
qdev_create() is qdev_try_create() plus error handling.  The latter is
uninteresting here, so let's have a look at just the former:

    DeviceState *qdev_try_create(BusState *bus, const char *type)
    {
        DeviceState *dev;

        if (object_class_by_name(type) == NULL) {
            return NULL;
        }
        dev = DEVICE(object_new(type));
        if (!dev) {
            return NULL;
        }

        if (!bus) {
            /* Assert that the device really is a SysBusDevice before
             * we put it onto the sysbus. Non-sysbus devices which aren't
             * being put onto a bus should be created with object_new(TYPE_FOO),
             * not qdev_create(NULL, TYPE_FOO).
             */
            g_assert(object_dynamic_cast(OBJECT(dev), TYPE_SYS_BUS_DEVICE));
            bus = sysbus_get_default();
        }

--->    qdev_set_parent_bus(dev, bus);
        object_unref(OBJECT(dev));
        return dev;
    }

We need to undo qdev_set_parent_bus().

    void qdev_set_parent_bus(DeviceState *dev, BusState *bus)
    {
        bool replugging = dev->parent_bus != NULL;

        if (replugging) {
            /* Keep a reference to the device while it's not plugged into
             * any bus, to avoid it potentially evaporating when it is
             * dereffed in bus_remove_child().
             */
            object_ref(OBJECT(dev));
            bus_remove_child(dev->parent_bus, dev);
            object_unref(OBJECT(dev->parent_bus));
        }
        dev->parent_bus = bus;
        object_ref(OBJECT(bus));
--->    bus_add_child(bus, dev);
        if (replugging) {
            object_unref(OBJECT(dev));
        }
    }

dev->parent_bus is null, since we didn't realize the device.  All we
need to undo is bus_add_child(), with bus_remove_child().  Destruction
of realized devices does that here:

    static void device_unparent(Object *obj)
    {
        DeviceState *dev = DEVICE(obj);
        BusState *bus;

        if (dev->realized) {
            object_property_set_bool(obj, false, "realized", NULL);
        }
        while (dev->num_child_bus) {
            bus = QLIST_FIRST(&dev->child_bus);
            object_unparent(OBJECT(bus));
        }
        if (dev->parent_bus) {
            bus_remove_child(dev->parent_bus, dev);
            object_unref(OBJECT(dev->parent_bus));
            dev->parent_bus = NULL;
        }
    }

dev->realized is false, dev->num_child_bus is zero, dev->parent_bus is
main_system_bus.  Okay, this does what we need.  Now how do we call it?
It's static...  but it's a method:

    static void device_class_init(ObjectClass *class, void *data)
    {
        DeviceClass *dc = DEVICE_CLASS(class);

        class->unparent = device_unparent;
        [...]
    }

Alright, we can call object_get_class(dev_obj)->unparent(dev_obj).

Final complication: if I call just that, the device's reference counter
goes down to zero in the middle of device_unparent(), and we use after
free.  So I bracket he call with object_ref() and object_unref().
