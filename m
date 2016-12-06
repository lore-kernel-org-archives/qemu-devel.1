Received: from eggs.gnu.org ([2001:4830:134:3::10]:39179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cELTE-0002I9-NR
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 14:32:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cELT9-0001WN-3N
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 14:32:08 -0500
Date: Tue, 6 Dec 2016 17:31:59 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20161206193159.GE4027@thinpad.lan.raisama.net>
References: <148104617887.7699.984921868108236415.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<20161206191952.GD4027@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161206191952.GD4027@thinpad.lan.raisama.net>
Subject: [Qemu-devel] [RFC for-2.8] machine: Convert abstract typename on
 compat_props to subclass names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Dec 06, 2016 at 05:19:52PM -0200, Eduardo Habkost wrote:
> On Tue, Dec 06, 2016 at 06:50:47PM +0100, Greg Kurz wrote:
> > Since commit "9a4c0e220d8a hw/virtio-pci: fix virtio behaviour", passing
> > -device virtio-blk-pci.disable-modern=off has no effect on 2.6 machine
> > types because the internal virtio-pci.disable-modern=on compat property
> > always prevail.
> > 
> > This should ideally be fixed in the qdev properties core code, but it is
> > too late in the QEMU 2.8 schedule. So this patch fixes the issue by setting
> > the compat properties for every virtio-*-pci subtypes instead of the base
> > virtio-pci type.
> > 
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> 
> So, it looks like the bug is present in many other cases...
> 
> I have hacked QEMU to print a warning in case the driver name in
> compat_props refer to an abstract class or a class that have any
> subclasses. The results are below:
> 
>  apic-common.legacy-instance-id set for abstract class
>  apic-common.vapic set for abstract class
>  i386-cpu.arat set for abstract class
>  i386-cpu.check set for abstract class
>  i386-cpu.cpuid-0xb set for abstract class
>  i386-cpu.fill-mtrr-mask set for abstract class
>  i386-cpu.full-cpuid-auto-level set for abstract class
>  i386-cpu.l3-cache set for abstract class
>  i386-cpu.pmu set for abstract class
>  pci-device.command_serr_enable set for abstract class
>  pci-device.rombar set for abstract class
>  pci-device.x-pcie-lnksta-dllla set for abstract class
>  powerpc64-cpu.pre-2.8-migration set for abstract class
>  s390-skeys.migration-enabled set for abstract class
>  spapr-pci-host-bridge.ddw set for superclass
>  spapr-pci-host-bridge.dynamic-reconfiguration set for superclass
>  spapr-pci-host-bridge.mem64_win_size set for superclass
>  spapr-pci-host-bridge.mem_win_size set for superclass
>  spapr-pci-host-bridge.pre-2.8-migration set for superclass
>  usb-device.full-path set for abstract class
>  usb-device.msos-desc set for abstract class
>  virtio-pci.disable-legacy set for abstract class
>  virtio-pci.disable-modern set for abstract class
>  virtio-pci.migrate-extra set for abstract class
>  virtio-pci.page-per-vq set for abstract class
>  virtio-pci.virtio-pci-bus-master-bug-migration set for abstract class
>  virtio-pci.x-disable-pcie set for abstract class
>  x86_64-cpu.arat set for abstract class
>  x86_64-cpu.check set for abstract class
>  x86_64-cpu.cpuid-0xb set for abstract class
>  x86_64-cpu.fill-mtrr-mask set for abstract class
>  x86_64-cpu.full-cpuid-auto-level set for abstract class
>  x86_64-cpu.l3-cache set for abstract class
>  x86_64-cpu.pmu set for abstract class
> 
> I believe the cases where we are likely to cause real-world bugs
> are virtio-pci and the *-cpu classes (because -cpu is translated
> to -global).
> 
> I'm not sure what should be the right fix in 2.8. I am
> considering a temporary hack to translate abstract class names in
> compat_props to global properties for all subclasses, in case
> they refer to an abstract class. This way we fix the bug where
> -global doesn't override compat_props properly, but keep the
> rules for -global untouched.

What about this?

(untested)

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/core/machine.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index b0fd91f..49f9007 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -554,6 +554,25 @@ static void machine_class_finalize(ObjectClass *klass, void *data)
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
@@ -565,10 +584,20 @@ void machine_register_compat_props(MachineState *machine)
     }
 
     for (i = 0; i < mc->compat_props->len; i++) {
+        ObjectClass *oc;
         p = g_array_index(mc->compat_props, GlobalProperty *, i);
-        /* Machine compat_props must never cause errors: */
-        p->errp = &error_abort;
-        qdev_prop_register_global(p);
+        oc = object_class_by_name(p->driver);
+        if (oc && object_class_is_abstract(oc)) {
+            /* temporary hack to make sure we will never override
+             * globals set explicitly on -global: if an abstract class
+             * is on compat_props, register globals for each of their
+             * subclasses instead.
+             */
+            object_class_foreach(machine_register_compat_for_subclass,
+                                 p->driver, false, p);
+        } else {
+            register_compat_prop(p->driver, p->property, p->value);
+        }
     }
 }
 
-- 
2.7.4
