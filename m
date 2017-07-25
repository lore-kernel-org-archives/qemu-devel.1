Received: from eggs.gnu.org ([2001:4830:134:3::10]:44191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dZwKo-0001xX-PF
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:40:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dZwKn-0003er-Nq
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:40:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dZwKn-0003dD-F1
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 05:40:57 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 25 Jul 2017 11:40:18 +0200
Message-Id: <20170725094026.5376-7-cohuck@redhat.com>
In-Reply-To: <20170725094026.5376-1-cohuck@redhat.com>
References: <20170725094026.5376-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL for-2.10 06/14] target/s390x: introduce
 (test|set)_be_bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, thuth@redhat.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Using ordinary bitmap operations to set/test bits does not work properly
on architectures !s390x. Let's drop (test|set)_bit_inv and introduce
(test|set)_be_bit instead. These functions work on uint8_t array, not on
unsigned longs arrays and are for now only used in the context of
CPU features.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170720123721.12366-4-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu_features.c |  8 ++++----
 target/s390x/cpu_features.h |  8 ++++++++
 target/s390x/kvm.c          | 14 ++------------
 3 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 8b1491734f..1d3a036393 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -340,8 +340,8 @@ void s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
     case S390_FEAT_TYPE_STFL:
         if (test_bit(S390_FEAT_ZARCH, features)) {
             /* Features that are always active */
-            data[0] |= 0x20;  /* z/Architecture */
-            data[17] |= 0x20; /* Configuration-z-architectural-mode */
+            set_be_bit(2, data);   /* z/Architecture */
+            set_be_bit(138, data); /* Configuration-z-architectural-mode */
         }
         break;
     case S390_FEAT_TYPE_PTFF:
@@ -357,7 +357,7 @@ void s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
     case S390_FEAT_TYPE_PCC:
     case S390_FEAT_TYPE_PPNO:
     case S390_FEAT_TYPE_KMA:
-        data[0] |= 0x80; /* query is always available */
+        set_be_bit(0, data); /* query is always available */
         break;
     default:
         break;
@@ -368,7 +368,7 @@ void s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
         if (s390_features[feat].type == type) {
             bit_nr = s390_features[feat].bit;
             /* big endian on uint8_t array */
-            data[bit_nr / 8] |= 0x80 >> (bit_nr % 8);
+            set_be_bit(bit_nr, data);
         }
         feat = find_next_bit(features, S390_FEAT_MAX, feat + 1);
     }
diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
index 770435e0cc..e306aa7ab2 100644
--- a/target/s390x/cpu_features.h
+++ b/target/s390x/cpu_features.h
@@ -93,4 +93,12 @@ const S390FeatGroupDef *s390_feat_group_def(S390FeatGroup group);
 
 #define BE_BIT_NR(BIT) (BIT ^ (BITS_PER_LONG - 1))
 
+static inline void set_be_bit(unsigned int bit_nr, uint8_t *array)
+{
+    array[bit_nr / 8] |= 0x80 >> (bit_nr % 8);
+}
+static inline bool test_be_bit(unsigned int bit_nr, const uint8_t *array)
+{
+    return array[bit_nr / 8] & (0x80 >> (bit_nr % 8));
+}
 #endif /* TARGET_S390X_CPU_FEATURES_H */
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 999ea570c3..9bec48152f 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -2430,16 +2430,6 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
     abort();
 }
 
-static inline int test_bit_inv(long nr, const unsigned long *addr)
-{
-    return test_bit(BE_BIT_NR(nr), addr);
-}
-
-static inline void set_bit_inv(long nr, unsigned long *addr)
-{
-    set_bit(BE_BIT_NR(nr), addr);
-}
-
 static int query_cpu_subfunc(S390FeatBitmap features)
 {
     struct kvm_s390_vm_cpu_subfunc prop;
@@ -2566,7 +2556,7 @@ static int query_cpu_feat(S390FeatBitmap features)
     }
 
     for (i = 0; i < ARRAY_SIZE(kvm_to_feat); i++) {
-        if (test_bit_inv(kvm_to_feat[i][0], (unsigned long *)prop.feat)) {
+        if (test_be_bit(kvm_to_feat[i][0], (uint8_t *) prop.feat)) {
             set_bit(kvm_to_feat[i][1], features);
         }
     }
@@ -2585,7 +2575,7 @@ static int configure_cpu_feat(const S390FeatBitmap features)
 
     for (i = 0; i < ARRAY_SIZE(kvm_to_feat); i++) {
         if (test_bit(kvm_to_feat[i][1], features)) {
-            set_bit_inv(kvm_to_feat[i][0], (unsigned long *)prop.feat);
+            set_be_bit(kvm_to_feat[i][0], (uint8_t *) prop.feat);
         }
     }
     return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
-- 
2.13.3
