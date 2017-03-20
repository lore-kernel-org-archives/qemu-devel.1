Received: from eggs.gnu.org ([2001:4830:134:3::10]:40815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qh-0001dw-5s
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qc-0004tO-8k
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34947)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6Qb-0004sC-VL
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:30 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8lol025636
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:29 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29ae098ud1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:28 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 17:09:28 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:07:59 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-36-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 35/81] machine: Convert abstract typename on
 compat_props to subclass names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>

From: Eduardo Habkost <ehabkost@redhat.com>

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
(cherry picked from commit 0bcba41fe379e4c6834adcf1456d9099db31a5b2)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/core/machine.c | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index b0fd91f..213e8e0 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -554,11 +554,31 @@ static void machine_class_finalize(ObjectClass *klass, void *data)
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
@@ -566,9 +586,22 @@ void machine_register_compat_props(MachineState *machine)
 
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
2.7.4
