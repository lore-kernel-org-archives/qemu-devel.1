Received: from eggs.gnu.org ([2001:4830:134:3::10]:44205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eEFHl-00084q-7e
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:00:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eEFHh-0003Gb-0U
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:00:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43004)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eEFHg-0003GB-L0
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:00:20 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B73CE7EA9A
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 14:00:19 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1509617407-21191-1-git-send-email-thuth@redhat.com>
	<1509617407-21191-3-git-send-email-thuth@redhat.com>
Date: Mon, 13 Nov 2017 15:00:03 +0100
In-Reply-To: <1509617407-21191-3-git-send-email-thuth@redhat.com> (Thomas
	Huth's message of "Thu, 2 Nov 2017 11:10:06 +0100")
Message-ID: <87vaiecm8s.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 2/2] qdev: Check for the availability of
 a hotplug controller before adding a device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, david@redhat.com

Thomas Huth <thuth@redhat.com> writes:

> The qdev_unplug() function contains a g_assert(hotplug_ctrl) statement,
> so QEMU crashes when the user tries to device_add + device_del a device
> that does not have a corresponding hotplug controller. This could be
> provoked for a couple of devices in the past (see commit 4c93950659487c7ad
> or 84ebd3e8c7d4fe955 for example), and can currently for example also be
> triggered like this:
>
> $ s390x-softmmu/qemu-system-s390x -M none -nographic 
> QEMU 2.10.50 monitor - type 'help' for more information
> (qemu) device_add qemu-s390x-cpu,id=x
> (qemu) device_del x
> **
> ERROR:qemu/qdev-monitor.c:872:qdev_unplug: assertion failed: (hotplug_ctrl)
> Aborted (core dumped)
>
> So devices clearly need a hotplug controller when they should be usable
> with device_add.
> The code in qdev_device_add() already checks whether the bus has a proper
> hotplug controller,

Where?  Hmm, I guess it's this one:

    if (qdev_hotplug && bus && !qbus_is_hotpluggable(bus)) {
        error_setg(errp, QERR_BUS_NO_HOTPLUG, bus->name);
        return NULL;
    }

>                     but for devices that do not have a corresponding bus,
> there is no appropriate check available yet. In that case we should check
> whether the machine itself provides a suitable hotplug controller and
> refuse to plug the device if none is available.
>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/core/qdev.c         | 28 ++++++++++++++++++++--------
>  include/hw/qdev-core.h |  1 +
>  qdev-monitor.c         |  5 +++++
>  3 files changed, 26 insertions(+), 8 deletions(-)
>
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 1111295..f739753 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -253,19 +253,31 @@ void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
>      dev->alias_required_for_version = required_for_version;
>  }
>  
> +HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev)
> +{
> +    MachineState *machine;
> +    MachineClass *mc;
> +    Object *m_obj = qdev_get_machine();
> +
> +    if (object_dynamic_cast(m_obj, TYPE_MACHINE)) {
> +        machine = MACHINE(m_obj);
> +        mc = MACHINE_GET_CLASS(machine);
> +        if (mc->get_hotplug_handler) {
> +            return mc->get_hotplug_handler(machine, dev);
> +        }
> +    }
> +
> +    return NULL;
> +}
> +
>  HotplugHandler *qdev_get_hotplug_handler(DeviceState *dev)
>  {
> -    HotplugHandler *hotplug_ctrl = NULL;
> +    HotplugHandler *hotplug_ctrl;
>  
>      if (dev->parent_bus && dev->parent_bus->hotplug_handler) {
>          hotplug_ctrl = dev->parent_bus->hotplug_handler;
> -    } else if (object_dynamic_cast(qdev_get_machine(), TYPE_MACHINE)) {
> -        MachineState *machine = MACHINE(qdev_get_machine());
> -        MachineClass *mc = MACHINE_GET_CLASS(machine);
> -
> -        if (mc->get_hotplug_handler) {
> -            hotplug_ctrl = mc->get_hotplug_handler(machine, dev);
> -        }
> +    } else {
> +        hotplug_ctrl = qdev_get_machine_hotplug_handler(dev);
>      }
>      return hotplug_ctrl;
>  }

qdev_get_machine_hotplug_handler() factored out of
qdev_get_hotplug_handler().  Okay.  Announcing it in the commit message
could've saved me a few review brainwaves.

> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 0a71bf8..51473ee 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -286,6 +286,7 @@ DeviceState *qdev_try_create(BusState *bus, const char *name);
>  void qdev_init_nofail(DeviceState *dev);
>  void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
>                                   int required_for_version);
> +HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev);
>  HotplugHandler *qdev_get_hotplug_handler(DeviceState *dev);
>  void qdev_unplug(DeviceState *dev, Error **errp);
>  void qdev_simple_device_unplug_cb(HotplugHandler *hotplug_dev,
> diff --git a/qdev-monitor.c b/qdev-monitor.c
> index 9188d20..38c0fc2 100644
> --- a/qdev-monitor.c
> +++ b/qdev-monitor.c
> @@ -614,6 +614,11 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
>  
       if (qdev_hotplug && bus && !qbus_is_hotpluggable(bus)) {
           error_setg(errp, QERR_BUS_NO_HOTPLUG, bus->name);
           return NULL;
       }

       if (!migration_is_idle()) {
           error_setg(errp, "device_add not allowed while migrating");
           return NULL;
       }

       /* create device */
       dev = DEVICE(object_new(driver));

>      if (bus) {
>          qdev_set_parent_bus(dev, bus);
> +    } else if (qdev_hotplug && !qdev_get_machine_hotplug_handler(dev)) {
> +        /* No bus, no machine hotplug handler --> device is not hotpluggable */

Long line.

> +        error_setg(&err, "Device '%s' can not be hotplugged on this machine",
> +                   driver);
> +        goto err_del_dev;
>      }
>  
>      qdev_set_id(dev, qemu_opts_id(opts));

Hmm.  We need to check "can hotplug" in two separate ways, with bus and
without bus.  Can we keep the two ways on one place?  Something like

       if (qdev_hotplug) {
           if (bus && !qbus_is_hotpluggable(bus)) {
               error_setg(errp, QERR_BUS_NO_HOTPLUG, bus->name);
               return NULL;
           }
           if (!bus && !qdev_get_machine_hotplug_handler(dev)) {
               error_setg(&err,
                          "Machine doesn't support hot-plugging device '%s'"
                          driver);
               return NULL;
           }
      }
