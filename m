Received: from eggs.gnu.org ([2001:4830:134:3::10]:34448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dXB6s-0003Km-7G
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:51:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dXB6n-0003ep-92
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:51:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dXB6n-0003e1-2O
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:51:05 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 17 Jul 2017 15:50:41 -0300
Message-Id: <20170717185051.18740-6-ehabkost@redhat.com>
In-Reply-To: <20170717185051.18740-1-ehabkost@redhat.com>
References: <20170717185051.18740-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 05/15] Revert "machine: Convert abstract
 typename on compat_props to subclass names"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

This reverts commit 0bcba41fe379e4c6834adcf1456d9099db31a5b2.

The bug addressed by that commit is now fixed in a better way by the
commit "qdev: fix the order compat and global properties are applied".

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20170711004303.3902-4-ehabkost@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/core/machine.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index dc431fa..41b53a1 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -770,18 +770,11 @@ static void machine_class_finalize(ObjectClass *klass, void *data)
     g_free(mc->name);
 }
 
-static void machine_register_compat_for_subclass(ObjectClass *oc, void *opaque)
-{
-    GlobalProperty *p = opaque;
-    register_compat_prop(object_class_get_name(oc), p->property, p->value);
-}
-
 void machine_register_compat_props(MachineState *machine)
 {
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     int i;
     GlobalProperty *p;
-    ObjectClass *oc;
 
     if (!mc->compat_props) {
         return;
@@ -789,22 +782,9 @@ void machine_register_compat_props(MachineState *machine)
 
     for (i = 0; i < mc->compat_props->len; i++) {
         p = g_array_index(mc->compat_props, GlobalProperty *, i);
-        oc = object_class_by_name(p->driver);
-        if (oc && object_class_is_abstract(oc)) {
-            /* temporary hack to make sure we do not override
-             * globals set explicitly on -global: if an abstract class
-             * is on compat_props, register globals for all its
-             * non-abstract subtypes instead.
-             *
-             * This doesn't solve the problem for cases where
-             * a non-abstract typename mentioned on compat_props
-             * has subclasses, like spapr-pci-host-bridge.
-             */
-            object_class_foreach(machine_register_compat_for_subclass,
-                                 p->driver, false, p);
-        } else {
-            register_compat_prop(p->driver, p->property, p->value);
-        }
+        /* Machine compat_props must never cause errors: */
+        p->errp = &error_abort;
+        qdev_prop_register_global(p);
     }
 }
 
-- 
2.9.4
