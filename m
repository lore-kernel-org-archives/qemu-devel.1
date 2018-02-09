Received: from eggs.gnu.org ([2001:4830:134:3::10]:43525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ek4wQ-00025s-C7
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:26:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ek4wP-00066Y-1p
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:25:58 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  9 Feb 2018 10:25:08 +0100
Message-Id: <20180209092524.31348-14-cohuck@redhat.com>
In-Reply-To: <20180209092524.31348-1-cohuck@redhat.com>
References: <20180209092524.31348-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 13/29] s390x: fix size + content of STSI blocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, rth@twiddle.net, agraf@suse.de, david@redhat.com, thuth@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

All blocks are 4k in size, which is only true for two of them right now.
Also some reserved fields were wrong, fix it and convert all reserved
fields to u8.

This also fixes the LPAR part output in /proc/sysinfo under TCG. (for
now, everything was indicated as 0)

While at it, introduce typedefs for these structs and use them in TCG/KVM
code.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180129125623.21729-13-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu.h         | 46 ++++++++++++++++++++++++++--------------------
 target/s390x/kvm.c         |  2 +-
 target/s390x/misc_helper.c | 12 ++++++------
 3 files changed, 33 insertions(+), 27 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 76c31d970f..1475d705a4 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -437,29 +437,31 @@ static inline void setcc(S390CPU *cpu, uint64_t cc)
 #define STSI_R1_SEL2_MASK       0x000000000000ffffULL
 
 /* Basic Machine Configuration */
-struct sysib_111 {
-    uint32_t res1[8];
+typedef struct SysIB_111 {
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
+} SysIB_111;
+QEMU_BUILD_BUG_ON(sizeof(SysIB_111) != 4096);
 
 /* Basic Machine CPU */
-struct sysib_121 {
-    uint32_t res1[80];
+typedef struct SysIB_121 {
+    uint8_t  res1[80];
     uint8_t  sequence[16];
     uint8_t  plant[4];
     uint8_t  res2[2];
     uint16_t cpu_addr;
-    uint8_t  res3[152];
-};
+    uint8_t  res3[3992];
+} SysIB_121;
+QEMU_BUILD_BUG_ON(sizeof(SysIB_121) != 4096);
 
 /* Basic Machine CPUs */
-struct sysib_122 {
+typedef struct SysIB_122 {
     uint8_t res1[32];
     uint32_t capability;
     uint16_t total_cpus;
@@ -467,21 +469,23 @@ struct sysib_122 {
     uint16_t standby_cpus;
     uint16_t reserved_cpus;
     uint16_t adjustments[2026];
-};
+} SysIB_122;
+QEMU_BUILD_BUG_ON(sizeof(SysIB_122) != 4096);
 
 /* LPAR CPU */
-struct sysib_221 {
-    uint32_t res1[80];
+typedef struct SysIB_221 {
+    uint8_t  res1[80];
     uint8_t  sequence[16];
     uint8_t  plant[4];
     uint16_t cpu_id;
     uint16_t cpu_addr;
-    uint8_t  res3[152];
-};
+    uint8_t  res3[3992];
+} SysIB_221;
+QEMU_BUILD_BUG_ON(sizeof(SysIB_221) != 4096);
 
 /* LPAR CPUs */
-struct sysib_222 {
-    uint32_t res1[32];
+typedef struct SysIB_222 {
+    uint8_t  res1[32];
     uint16_t lpar_num;
     uint8_t  res2;
     uint8_t  lcpuc;
@@ -494,11 +498,12 @@ struct sysib_222 {
     uint8_t  res3[16];
     uint16_t dedicated_cpus;
     uint16_t shared_cpus;
-    uint8_t  res4[180];
-};
+    uint8_t  res4[4020];
+} SysIB_222;
+QEMU_BUILD_BUG_ON(sizeof(SysIB_222) != 4096);
 
 /* VM CPUs */
-struct sysib_322 {
+typedef struct SysIB_322 {
     uint8_t  res1[31];
     uint8_t  count;
     struct {
@@ -517,7 +522,8 @@ struct sysib_322 {
     } vm[8];
     uint8_t res4[1504];
     uint8_t ext_names[8][256];
-};
+} SysIB_322;
+QEMU_BUILD_BUG_ON(sizeof(SysIB_322) != 4096);
 
 /* MMU defines */
 #define _ASCE_ORIGIN            ~0xfffULL /* segment table origin             */
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index db5fe084ff..bfd14723f1 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1675,7 +1675,7 @@ static int handle_tsch(S390CPU *cpu)
 
 static void insert_stsi_3_2_2(S390CPU *cpu, __u64 addr, uint8_t ar)
 {
-    struct sysib_322 sysib;
+    SysIB_322 sysib;
     int del;
 
     if (s390_cpu_virt_mem_read(cpu, addr, ar, &sysib, sizeof(sysib))) {
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 6ee7e8a64a..466231de0b 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -217,7 +217,7 @@ uint32_t HELPER(stsi)(CPUS390XState *env, uint64_t a0,
     case STSI_LEVEL_1:
         if ((sel1 == 1) && (sel2 == 1)) {
             /* Basic Machine Configuration */
-            struct sysib_111 sysib;
+            SysIB_111 sysib;
             char type[5] = {};
 
             memset(&sysib, 0, sizeof(sysib));
@@ -232,7 +232,7 @@ uint32_t HELPER(stsi)(CPUS390XState *env, uint64_t a0,
             cpu_physical_memory_write(a0, &sysib, sizeof(sysib));
         } else if ((sel1 == 2) && (sel2 == 1)) {
             /* Basic Machine CPU */
-            struct sysib_121 sysib;
+            SysIB_121 sysib;
 
             memset(&sysib, 0, sizeof(sysib));
             /* XXX make different for different CPUs? */
@@ -242,7 +242,7 @@ uint32_t HELPER(stsi)(CPUS390XState *env, uint64_t a0,
             cpu_physical_memory_write(a0, &sysib, sizeof(sysib));
         } else if ((sel1 == 2) && (sel2 == 2)) {
             /* Basic Machine CPUs */
-            struct sysib_122 sysib;
+            SysIB_122 sysib;
 
             memset(&sysib, 0, sizeof(sysib));
             stl_p(&sysib.capability, 0x443afc29);
@@ -260,7 +260,7 @@ uint32_t HELPER(stsi)(CPUS390XState *env, uint64_t a0,
         {
             if ((sel1 == 2) && (sel2 == 1)) {
                 /* LPAR CPU */
-                struct sysib_221 sysib;
+                SysIB_221 sysib;
 
                 memset(&sysib, 0, sizeof(sysib));
                 /* XXX make different for different CPUs? */
@@ -271,7 +271,7 @@ uint32_t HELPER(stsi)(CPUS390XState *env, uint64_t a0,
                 cpu_physical_memory_write(a0, &sysib, sizeof(sysib));
             } else if ((sel1 == 2) && (sel2 == 2)) {
                 /* LPAR CPUs */
-                struct sysib_222 sysib;
+                SysIB_222 sysib;
 
                 memset(&sysib, 0, sizeof(sysib));
                 stw_p(&sysib.lpar_num, 0);
@@ -295,7 +295,7 @@ uint32_t HELPER(stsi)(CPUS390XState *env, uint64_t a0,
         {
             if ((sel1 == 2) && (sel2 == 2)) {
                 /* VM CPUs */
-                struct sysib_322 sysib;
+                SysIB_322 sysib;
 
                 memset(&sysib, 0, sizeof(sysib));
                 sysib.count = 1;
-- 
2.13.6
