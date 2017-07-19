Received: from eggs.gnu.org ([2001:4830:134:3::10]:50578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dXlmS-0000vd-1q
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 06:00:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dXlmN-0006HB-6n
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 06:00:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dXlmM-0006GY-VC
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 06:00:27 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 19 Jul 2017 11:50:30 +0200
Message-Id: <20170719095033.20482-3-david@redhat.com>
In-Reply-To: <20170719095033.20482-1-david@redhat.com>
References: <20170719095033.20482-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 2/5] target/s390x: indicate query
 subfunction in s390_fill_feat_block
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

We'll have to do the same for TCG, so let's just move it in there.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu_features.c | 31 ++++++++++++++++++++++++++-----
 target/s390x/kvm.c          | 13 -------------
 2 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index fa887d9..8b14917 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -336,11 +336,32 @@ void s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
     S390Feat feat;
     int bit_nr;
 
-    if (type == S390_FEAT_TYPE_STFL && test_bit(S390_FEAT_ZARCH, features)) {
-        /* Features that are always active */
-        data[0] |= 0x20;  /* z/Architecture */
-        data[17] |= 0x20; /* Configuration-z-architectural-mode */
-    }
+    switch (type) {
+    case S390_FEAT_TYPE_STFL:
+        if (test_bit(S390_FEAT_ZARCH, features)) {
+            /* Features that are always active */
+            data[0] |= 0x20;  /* z/Architecture */
+            data[17] |= 0x20; /* Configuration-z-architectural-mode */
+        }
+        break;
+    case S390_FEAT_TYPE_PTFF:
+    case S390_FEAT_TYPE_KMAC:
+    case S390_FEAT_TYPE_KMC:
+    case S390_FEAT_TYPE_KM:
+    case S390_FEAT_TYPE_KIMD:
+    case S390_FEAT_TYPE_KLMD:
+    case S390_FEAT_TYPE_PCKMO:
+    case S390_FEAT_TYPE_KMCTR:
+    case S390_FEAT_TYPE_KMF:
+    case S390_FEAT_TYPE_KMO:
+    case S390_FEAT_TYPE_PCC:
+    case S390_FEAT_TYPE_PPNO:
+    case S390_FEAT_TYPE_KMA:
+        data[0] |= 0x80; /* query is always available */
+        break;
+    default:
+        break;
+    };
 
     feat = find_first_bit(features, S390_FEAT_MAX);
     while (feat < S390_FEAT_MAX) {
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 831492f..999ea57 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -2506,41 +2506,28 @@ static int configure_cpu_subfunc(const S390FeatBitmap features)
     s390_fill_feat_block(features, S390_FEAT_TYPE_PLO, prop.plo);
     if (test_bit(S390_FEAT_TOD_CLOCK_STEERING, features)) {
         s390_fill_feat_block(features, S390_FEAT_TYPE_PTFF, prop.ptff);
-        prop.ptff[0] |= 0x80; /* query is always available */
     }
     if (test_bit(S390_FEAT_MSA, features)) {
         s390_fill_feat_block(features, S390_FEAT_TYPE_KMAC, prop.kmac);
-        prop.kmac[0] |= 0x80; /* query is always available */
         s390_fill_feat_block(features, S390_FEAT_TYPE_KMC, prop.kmc);
-        prop.kmc[0] |= 0x80; /* query is always available */
         s390_fill_feat_block(features, S390_FEAT_TYPE_KM, prop.km);
-        prop.km[0] |= 0x80; /* query is always available */
         s390_fill_feat_block(features, S390_FEAT_TYPE_KIMD, prop.kimd);
-        prop.kimd[0] |= 0x80; /* query is always available */
         s390_fill_feat_block(features, S390_FEAT_TYPE_KLMD, prop.klmd);
-        prop.klmd[0] |= 0x80; /* query is always available */
     }
     if (test_bit(S390_FEAT_MSA_EXT_3, features)) {
         s390_fill_feat_block(features, S390_FEAT_TYPE_PCKMO, prop.pckmo);
-        prop.pckmo[0] |= 0x80; /* query is always available */
     }
     if (test_bit(S390_FEAT_MSA_EXT_4, features)) {
         s390_fill_feat_block(features, S390_FEAT_TYPE_KMCTR, prop.kmctr);
-        prop.kmctr[0] |= 0x80; /* query is always available */
         s390_fill_feat_block(features, S390_FEAT_TYPE_KMF, prop.kmf);
-        prop.kmf[0] |= 0x80; /* query is always available */
         s390_fill_feat_block(features, S390_FEAT_TYPE_KMO, prop.kmo);
-        prop.kmo[0] |= 0x80; /* query is always available */
         s390_fill_feat_block(features, S390_FEAT_TYPE_PCC, prop.pcc);
-        prop.pcc[0] |= 0x80; /* query is always available */
     }
     if (test_bit(S390_FEAT_MSA_EXT_5, features)) {
         s390_fill_feat_block(features, S390_FEAT_TYPE_PPNO, prop.ppno);
-        prop.ppno[0] |= 0x80; /* query is always available */
     }
     if (test_bit(S390_FEAT_MSA_EXT_8, features)) {
         s390_fill_feat_block(features, S390_FEAT_TYPE_KMA, prop.kma);
-        prop.kma[0] |= 0x80; /* query is always available */
     }
     return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
 }
-- 
2.9.4
