Received: from eggs.gnu.org ([2001:4830:134:3::10]:48072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cnsjA-0007np-5d
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 16:07:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cnsj6-0005fZ-4v
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 16:07:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cnsj5-0005f4-So
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 16:07:24 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 14 Mar 2017 17:06:41 -0300
Message-Id: <20170314200641.2958-2-ehabkost@redhat.com>
In-Reply-To: <20170314200641.2958-1-ehabkost@redhat.com>
References: <20170314200641.2958-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 1/1] machine: Convert abstract typename on
 compat_props to subclass names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Original problem description by Greg Kurz:

> Since commit "9a4c0e220d8a hw/virtio-pci: fix virtio
> behaviour", passing -device virtio-blk-pci.disable-modern=off
> has no effect on 2.6 machine types because the internal
> virtio-pci.disable-modern=on compat property always prevail.

The same bug also affects other abstract type names mentioned on
compat_props by machine-types: apic-common, i386-cpu, pci-device,
powerpc64-cpu, s390-skeys, spapr-pci-host-bridge, usb-device,
virtio-pci, x86_64-cpu.

The right fix for this problem is to make sure compat_props and
-global options are always applied in the order they are
registered, instead of reordering them based on the type
hierarchy. But changing the ordering rules of -global is risky
and might break existing configurations, so we shouldn't do that
on a stable branch.

This is a temporary hack that will work around the bug when
registering compat_props properties: if we find an abstract class
on compat_props, register properties for all its non-abstract
subtypes instead. This will make sure -global won't be overridden
by compat_props, while keeping the existing ordering rules on
-global options.

Note that there's one case that won't be fixed by this hack:
"-global spapr-pci-vfio-host-bridge.<option>=<value>" won't be
able to override compat_props, because spapr-pci-host-bridge is
not an abstract class.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <1481575745-26120-1-git-send-email-ehabkost@redhat.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Tested-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/core/machine.c | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 0699750336..0d92672203 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -585,11 +585,31 @@ static void machine_class_finalize(ObjectClass *klass, void *data)
     g_free(mc->name);
 }
 
+static void register_compat_prop(const char *driver,
+                                 const char *property,
+                                 const char *value)
+{
+    GlobalProperty *p = g_new0(GlobalProperty, 1);
+    /* Machine compat_props must never cause errors: */
+    p->errp = &error_abort;
+    p->driver = driver;
+    p->property = property;
+    p->value = value;
+    qdev_prop_register_global(p);
+}
+
+static void machine_register_compat_for_subclass(ObjectClass *oc, void *opaque)
+{
+    GlobalProperty *p = opaque;
+    register_compat_prop(object_class_get_name(oc), p->property, p->value);
+}
+
 void machine_register_compat_props(MachineState *machine)
 {
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     int i;
     GlobalProperty *p;
+    ObjectClass *oc;
 
     if (!mc->compat_props) {
         return;
@@ -597,9 +617,22 @@ void machine_register_compat_props(MachineState *machine)
 
     for (i = 0; i < mc->compat_props->len; i++) {
         p = g_array_index(mc->compat_props, GlobalProperty *, i);
-        /* Machine compat_props must never cause errors: */
-        p->errp = &error_abort;
-        qdev_prop_register_global(p);
+        oc = object_class_by_name(p->driver);
+        if (oc && object_class_is_abstract(oc)) {
+            /* temporary hack to make sure we do not override
+             * globals set explicitly on -global: if an abstract class
+             * is on compat_props, register globals for all its
+             * non-abstract subtypes instead.
+             *
+             * This doesn't solve the problem for cases where
+             * a non-abstract typename mentioned on compat_props
+             * has subclasses, like spapr-pci-host-bridge.
+             */
+            object_class_foreach(machine_register_compat_for_subclass,
+                                 p->driver, false, p);
+        } else {
+            register_compat_prop(p->driver, p->property, p->value);
+        }
     }
 }
 
-- 
2.11.0.259.g40922b1
