Received: from eggs.gnu.org ([2001:4830:134:3::10]:56339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6Es-0001Mn-9Z
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:53:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6Er-0004xN-IN
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:53:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dn6Er-0004x4-CT
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:53:13 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 30 Aug 2017 18:52:11 +0200
Message-Id: <20170830165252.13421-4-cohuck@redhat.com>
In-Reply-To: <20170830165252.13421-1-cohuck@redhat.com>
References: <20170830165252.13421-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 03/44] s390x: introduce 2.11 compat machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 17 ++++++++++++++++-
 include/hw/compat.h        |  3 +++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 1c7af39ce6..d3d67b8d77 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -432,6 +432,9 @@ bool css_migration_enabled(void)
     }                                                                         \
     type_init(ccw_machine_register_##suffix)
 
+#define CCW_COMPAT_2_10 \
+        HW_COMPAT_2_10
+
 #define CCW_COMPAT_2_9 \
         HW_COMPAT_2_9 \
         {\
@@ -506,8 +509,18 @@ bool css_migration_enabled(void)
             .value    = "0",\
         },
 
+static void ccw_machine_2_11_instance_options(MachineState *machine)
+{
+}
+
+static void ccw_machine_2_11_class_options(MachineClass *mc)
+{
+}
+DEFINE_CCW_MACHINE(2_11, "2.11", true);
+
 static void ccw_machine_2_10_instance_options(MachineState *machine)
 {
+    ccw_machine_2_11_instance_options(machine);
     if (css_migration_enabled()) {
         css_register_vmstate();
     }
@@ -515,8 +528,10 @@ static void ccw_machine_2_10_instance_options(MachineState *machine)
 
 static void ccw_machine_2_10_class_options(MachineClass *mc)
 {
+    ccw_machine_2_11_class_options(mc);
+    SET_MACHINE_COMPAT(mc, CCW_COMPAT_2_10);
 }
-DEFINE_CCW_MACHINE(2_10, "2.10", true);
+DEFINE_CCW_MACHINE(2_10, "2.10", false);
 
 static void ccw_machine_2_9_instance_options(MachineState *machine)
 {
diff --git a/include/hw/compat.h b/include/hw/compat.h
index 08f36004da..3e101f8f67 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -1,6 +1,9 @@
 #ifndef HW_COMPAT_H
 #define HW_COMPAT_H
 
+#define HW_COMPAT_2_10 \
+    /* empty */
+
 #define HW_COMPAT_2_9 \
     {\
         .driver   = "pci-bridge",\
-- 
2.13.5
