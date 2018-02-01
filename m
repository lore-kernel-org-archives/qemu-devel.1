Received: from eggs.gnu.org ([2001:4830:134:3::10]:35069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ehIWg-00041W-8u
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:19:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ehIWf-0006n7-5G
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:19:54 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu,  1 Feb 2018 18:19:35 +0100
Message-Id: <20180201171935.29403-3-cohuck@redhat.com>
In-Reply-To: <20180201171935.29403-1-cohuck@redhat.com>
References: <20180201171935.29403-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH v3 2/2] s390x/cpumodel: allow zpci features in
 qemu model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: rth@twiddle.net, agraf@suse.de, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

AEN and AIS can be provided unconditionally, ZPCI should be turned on
manually.

With -cpu qemu,zpci=on, the guest kernel can now successfully detect
virtio-pci devices under tcg.

Also fixup the order of the MSA_EXT_{3,4} flags while at it.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu_models.c   | 6 ++++++
 target/s390x/gen-features.c | 6 +++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 212a5f0697..250d931d7e 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -23,6 +23,7 @@
 #include "qapi/qmp/qbool.h"
 #ifndef CONFIG_USER_ONLY
 #include "sysemu/arch_init.h"
+#include "hw/pci/pci.h"
 #endif
 
 #define CPUDEF_INIT(_type, _gen, _ec_ga, _mha_pow, _hmfai, _name, _desc) \
@@ -1271,6 +1272,11 @@ static void register_types(void)
 
     /* init all bitmaps from gnerated data initially */
     s390_init_feat_bitmap(qemu_max_cpu_feat_init, qemu_max_cpu_feat);
+#ifndef CONFIG_USER_ONLY
+    if (!pci_available) {
+        clear_bit(S390_FEAT_ZPCI, qemu_max_cpu_feat);
+    }
+#endif
     for (i = 0; i < ARRAY_SIZE(s390_cpu_defs); i++) {
         s390_init_feat_bitmap(s390_cpu_defs[i].base_init,
                               s390_cpu_defs[i].base_feat);
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 0570f597ec..89a140c9a7 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -572,8 +572,10 @@ static uint16_t qemu_LATEST[] = {
     S390_FEAT_STFLE_49,
     S390_FEAT_LOCAL_TLB_CLEARING,
     S390_FEAT_INTERLOCKED_ACCESS_2,
-    S390_FEAT_MSA_EXT_4,
+    S390_FEAT_ADAPTER_EVENT_NOTIFICATION,
+    S390_FEAT_ADAPTER_INT_SUPPRESSION,
     S390_FEAT_MSA_EXT_3,
+    S390_FEAT_MSA_EXT_4,
 };
 
 /* add all new definitions before this point */
@@ -582,6 +584,8 @@ static uint16_t qemu_MAX[] = {
     S390_FEAT_STFLE_53,
     /* generates a dependency warning, leave it out for now */
     S390_FEAT_MSA_EXT_5,
+    /* only with CONFIG_PCI */
+    S390_FEAT_ZPCI,
 };
 
 /****** END FEATURE DEFS ******/
-- 
2.13.6
