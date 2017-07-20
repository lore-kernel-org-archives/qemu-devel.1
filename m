Received: from eggs.gnu.org ([2001:4830:134:3::10]:43419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dYAi6-0006gn-Ao
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 08:37:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dYAi2-0004Vl-3K
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 08:37:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dYAi1-0004VK-QR
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 08:37:38 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 20 Jul 2017 14:37:21 +0200
Message-Id: <20170720123721.12366-6-david@redhat.com>
In-Reply-To: <20170720123721.12366-1-david@redhat.com>
References: <20170720123721.12366-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 5/5] target/s390x: improve baselining if
 certain base features are missing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, thuth@redhat.com, cohuck@redhat.com, jjherne@linux.vnet.ibm.com, david@redhat.com, borntraeger@de.ibm.com

There are certain features that we put into base models, but that are
not relevant for the actual search. The most famous example are
MSA subfunctions that might be disabled on certain real hardware out
there.

While the kvm host model detection will usually detect the correct model
on such machines (as it will in the common case not pass features to check
for into s390_find_cpu_def()), baselining will fall back to a quite old
model just because some MSA subfunctions are missing.

Let's improve that by ignoring lack of these features while performing
the search for a base model.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu_models.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index f4e5bb6..92120f4 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -78,6 +78,9 @@ static S390CPUDef s390_cpu_defs[] = {
     CPUDEF_INIT(0x3906, 14, 1, 47, 0x08000000U, "z14", "IBM z14 GA1"),
 };
 
+/* features part of a base model but not relevant for finding a base model */
+S390FeatBitmap ignored_base_feat;
+
 void s390_cpudef_featoff(uint8_t gen, uint8_t ec_ga, S390Feat feat)
 {
     const S390CPUDef *def;
@@ -237,6 +240,11 @@ const S390CPUDef *s390_find_cpu_def(uint16_t type, uint8_t gen, uint8_t ec_ga,
         if (features) {
             /* see if the model satisfies the minimum features */
             bitmap_andnot(missing, def->base_feat, features, S390_FEAT_MAX);
+            /*
+             * Ignore certain features that are in the base model, but not
+             * relevant for the search (esp. MSA subfunctions).
+             */
+            bitmap_andnot(missing, missing, ignored_base_feat, S390_FEAT_MAX);
             if (!bitmap_empty(missing, S390_FEAT_MAX)) {
                 break;
             }
@@ -1209,10 +1217,35 @@ static const TypeInfo host_s390_cpu_type_info = {
 };
 #endif
 
+static void init_ignored_base_feat(void)
+{
+    static const int feats[] = {
+         /* MSA subfunctions that could not be available on certain machines */
+         S390_FEAT_KMAC_DEA,
+         S390_FEAT_KMAC_TDEA_128,
+         S390_FEAT_KMAC_TDEA_192,
+         S390_FEAT_KMC_DEA,
+         S390_FEAT_KMC_TDEA_128,
+         S390_FEAT_KMC_TDEA_192,
+         S390_FEAT_KM_DEA,
+         S390_FEAT_KM_TDEA_128,
+         S390_FEAT_KM_TDEA_192,
+         S390_FEAT_KIMD_SHA_1,
+         S390_FEAT_KLMD_SHA_1,
+    };
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(feats); i++) {
+        set_bit(feats[i], ignored_base_feat);
+    }
+}
+
 static void register_types(void)
 {
     int i;
 
+    init_ignored_base_feat();
+
     /* init all bitmaps from gnerated data initially */
     for (i = 0; i < ARRAY_SIZE(s390_cpu_defs); i++) {
         s390_init_feat_bitmap(s390_cpu_defs[i].base_init,
-- 
2.9.4
