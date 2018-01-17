Received: from eggs.gnu.org ([2001:4830:134:3::10]:46968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ebrij-0000RN-Gc
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 12:41:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ebrii-0008Hh-EM
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 12:41:53 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed, 17 Jan 2018 18:40:41 +0100
Message-Id: <20180117174047.6382-13-david@redhat.com>
In-Reply-To: <20180117174047.6382-1-david@redhat.com>
References: <20180117174047.6382-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 12/18] s390x: fix size + content of STSI
 blocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

All blocks are 4k in size, which is only true for two of them right now.
Also some reserved fields were wrong, fix it and convert all reserved
fields to u8.

This also fixes the LPAR part output in /proc/sysinfo under TCG. (for
now, everything was indicated as 0)

While at it, introduce typedefs for these structs and use it in KVM
code. Not changing misc_helper.c as that will be overhauled soon.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.h | 46 ++++++++++++++++++++++++++--------------------
 target/s390x/kvm.c |  2 +-
 2 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index b4a88830de..31593a5381 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -436,29 +436,31 @@ static inline void setcc(S390CPU *cpu, uint64_t cc)
 #define STSI_R1_SEL2_MASK       0x000000000000ffffULL
 
 /* Basic Machine Configuration */
-struct sysib_111 {
-    uint32_t res1[8];
+typedef struct sysib_111 {
+    uint8_t  res1[32];
     uint8_t  manuf[16];
     uint8_t  type[4];
     uint8_t  res2[12];
     uint8_t  model[16];
     uint8_t  sequence[16];
     uint8_t  plant[4];
-    uint8_t  res3[156];
-};
+    uint8_t  res3[3996];
+} sysib_111;
+QEMU_BUILD_BUG_ON(sizeof(sysib_111) != 4096);
 
 /* Basic Machine CPU */
-struct sysib_121 {
-    uint32_t res1[80];
+typedef struct sysib_121 {
+    uint8_t  res1[80];
     uint8_t  sequence[16];
     uint8_t  plant[4];
     uint8_t  res2[2];
     uint16_t cpu_addr;
-    uint8_t  res3[152];
-};
+    uint8_t  res3[3992];
+} sysib_121;
+QEMU_BUILD_BUG_ON(sizeof(sysib_121) != 4096);
 
 /* Basic Machine CPUs */
-struct sysib_122 {
+typedef struct sysib_122 {
     uint8_t res1[32];
     uint32_t capability;
     uint16_t total_cpus;
@@ -466,21 +468,23 @@ struct sysib_122 {
     uint16_t standby_cpus;
     uint16_t reserved_cpus;
     uint16_t adjustments[2026];
-};
+} sysib_122;
+QEMU_BUILD_BUG_ON(sizeof(sysib_122) != 4096);
 
 /* LPAR CPU */
-struct sysib_221 {
-    uint32_t res1[80];
+typedef struct sysib_221 {
+    uint8_t  res1[80];
     uint8_t  sequence[16];
     uint8_t  plant[4];
     uint16_t cpu_id;
     uint16_t cpu_addr;
-    uint8_t  res3[152];
-};
+    uint8_t  res3[3992];
+} sysib_221;
+QEMU_BUILD_BUG_ON(sizeof(sysib_221) != 4096);
 
 /* LPAR CPUs */
-struct sysib_222 {
-    uint32_t res1[32];
+typedef struct sysib_222 {
+    uint8_t  res1[32];
     uint16_t lpar_num;
     uint8_t  res2;
     uint8_t  lcpuc;
@@ -493,11 +497,12 @@ struct sysib_222 {
     uint8_t  res3[16];
     uint16_t dedicated_cpus;
     uint16_t shared_cpus;
-    uint8_t  res4[180];
-};
+    uint8_t  res4[4020];
+} sysib_222;
+QEMU_BUILD_BUG_ON(sizeof(sysib_222) != 4096);
 
 /* VM CPUs */
-struct sysib_322 {
+typedef struct sysib_322 {
     uint8_t  res1[31];
     uint8_t  count;
     struct {
@@ -516,7 +521,8 @@ struct sysib_322 {
     } vm[8];
     uint8_t res4[1504];
     uint8_t ext_names[8][256];
-};
+} sysib_322;
+QEMU_BUILD_BUG_ON(sizeof(sysib_322) != 4096);
 
 /* MMU defines */
 #define _ASCE_ORIGIN            ~0xfffULL /* segment table origin             */
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index aeec1125e1..54640aabc7 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1666,7 +1666,7 @@ static int handle_tsch(S390CPU *cpu)
 
 static void insert_stsi_3_2_2(S390CPU *cpu, __u64 addr, uint8_t ar)
 {
-    struct sysib_322 sysib;
+    sysib_322 sysib;
     int del;
 
     if (s390_cpu_virt_mem_read(cpu, addr, ar, &sysib, sizeof(sysib))) {
-- 
2.14.3
