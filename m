Received: from eggs.gnu.org ([2001:4830:134:3::10]:37338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dG9OJ-0002NF-IH
	for qemu-devel@nongnu.org; Wed, 31 May 2017 15:34:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dG9OG-0003OJ-Io
	for qemu-devel@nongnu.org; Wed, 31 May 2017 15:34:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dG9OG-0003NG-BJ
	for qemu-devel@nongnu.org; Wed, 31 May 2017 15:34:44 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 31 May 2017 21:34:33 +0200
Message-Id: <20170531193434.6918-2-david@redhat.com>
In-Reply-To: <20170531193434.6918-1-david@redhat.com>
References: <20170531193434.6918-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 1/2] s390x/cpumodel: take care of the cpuid
 format bit for KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, david@redhat.com

Let's also properly forward that bit. It should always be set. I
verified it under z/VM, it seems to be always set there. For now,
zKVM guests never get that bit set when the CPU model is active.

The PoP mentiones, that z800 + z900 (HW generation 7) always set this
bit to 0, so let's take care of that.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu_models.c |  1 +
 target/s390x/cpu_models.h | 10 +++++++---
 target/s390x/kvm.c        |  1 +
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 8d27363..9e23535 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -740,6 +740,7 @@ void s390_realize_cpu_model(CPUState *cs, Error **errp)
     /* copy over properties that can vary */
     cpu->model->lowest_ibc = max_model->lowest_ibc;
     cpu->model->cpu_id = max_model->cpu_id;
+    cpu->model->cpu_id_format = max_model->cpu_id_format;
     cpu->model->cpu_ver = max_model->cpu_ver;
 
     check_consistency(cpu->model);
diff --git a/target/s390x/cpu_models.h b/target/s390x/cpu_models.h
index 136a602..d41f8d6 100644
--- a/target/s390x/cpu_models.h
+++ b/target/s390x/cpu_models.h
@@ -46,6 +46,7 @@ typedef struct S390CPUModel {
     /* values copied from the "host" model, can change during migration */
     uint16_t lowest_ibc;    /* lowest IBC that the hardware supports */
     uint32_t cpu_id;        /* CPU id */
+    uint8_t cpu_id_format;  /* CPU id format bit */
     uint8_t cpu_ver;        /* CPU version, usually "ff" for kvm */
 } S390CPUModel;
 
@@ -54,12 +55,14 @@ typedef struct S390CPUModel {
  *
  * bits 0-7: Zeroes (ff for kvm)
  * bits 8-31: CPU ID (serial number)
- * bits 32-48: Machine type
- * bits 48-63: Zeroes
+ * bits 32-47: Machine type
+ * bit  48: CPU ID format
+ * bits 49-63: Zeroes
  */
 #define cpuid_type(x)     (((x) >> 16) & 0xffff)
 #define cpuid_id(x)       (((x) >> 32) & 0xffffff)
 #define cpuid_ver(x)      (((x) >> 56) & 0xff)
+#define cpuid_format(x)   (((x) >> 15) & 0x1)
 
 #define lowest_ibc(x)     (((uint32_t)(x) >> 16) & 0xfff)
 #define unblocked_ibc(x)  ((uint32_t)(x) & 0xfff)
@@ -92,7 +95,8 @@ static inline uint64_t s390_cpuid_from_cpu_model(const S390CPUModel *model)
 {
     return ((uint64_t)model->cpu_ver << 56) |
            ((uint64_t)model->cpu_id << 32) |
-           ((uint64_t)model->def->type << 16);
+           ((uint64_t)model->def->type << 16) |
+           (model->def->gen == 7 ? 0 : (uint64_t)model->cpu_id_format << 15);
 }
 S390CPUDef const *s390_find_cpu_def(uint16_t type, uint8_t gen, uint8_t ec_ga,
                                     S390FeatBitmap features);
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index ba1e60f..a3d0019 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -2580,6 +2580,7 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
         unblocked_ibc = unblocked_ibc(prop.ibc);
     }
     model->cpu_id = cpuid_id(prop.cpuid);
+    model->cpu_id_format = cpuid_format(prop.cpuid);
     model->cpu_ver = 0xff;
 
     /* get supported cpu features indicated via STFL(E) */
-- 
2.9.3
