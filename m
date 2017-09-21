Received: from eggs.gnu.org ([2001:4830:134:3::10]:36049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dv93o-0003lB-JX
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 17:31:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dv93j-0005Cd-MB
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 17:31:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dv93j-0005CN-Dl
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 17:30:59 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 21 Sep 2017 23:30:52 +0200
Message-Id: <20170921213052.1765-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1] s390x/kvm: fix and cleanup storing CPU
 status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, david@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

env->psa is a 64bit value, while we copy 4 bytes into the save area,
resulting always in 0 getting stored.

Let's try to reduce such errors by using a proper structure. While at
it, use correct cpu->be conversion (and get_psw_mask()), as we will be
reusing this code for TCG soon.

Signed-off-by: David Hildenbrand <david@redhat.com>
---

Found with my fancy SIGP kvm-unit-tests I am currently working on. And
looks like there is even more ... stay tuned :)

 target/s390x/kvm.c | 63 +++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 20 deletions(-)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 720cb1d833..21c22f48b9 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1548,22 +1548,38 @@ static int do_store_adtl_status(S390CPU *cpu, hwaddr addr, hwaddr len)
     return 0;
 }
 
+struct sigp_save_area {
+    uint64_t    fprs[16];                       /* 0x0000 */
+    uint64_t    grs[16];                        /* 0x0080 */
+    PSW         psw;                            /* 0x0100 */
+    uint8_t     pad_0x0110[0x0118 - 0x0110];    /* 0x0110 */
+    uint32_t    prefix;                         /* 0x0118 */
+    uint32_t    fpc;                            /* 0x011c */
+    uint8_t     pad_0x0120[0x0124 - 0x0120];    /* 0x0120 */
+    uint32_t    todpr;                          /* 0x0124 */
+    uint64_t    cputm;                          /* 0x0128 */
+    uint64_t    ckc;                            /* 0x0130 */
+    uint8_t     pad_0x0138[0x0140 - 0x0138];    /* 0x0138 */
+    uint32_t    ars[16];                        /* 0x0140 */
+    uint64_t    crs[16];                        /* 0x0384 */
+} QEMU_PACKED;
+
 #define KVM_S390_STORE_STATUS_DEF_ADDR offsetof(LowCore, floating_pt_save_area)
-#define SAVE_AREA_SIZE 512
 static int kvm_s390_store_status(S390CPU *cpu, hwaddr addr, bool store_arch)
 {
     static const uint8_t ar_id = 1;
-    uint64_t ckc = cpu->env.ckc >> 8;
-    void *mem;
+    struct sigp_save_area *sa;
+    hwaddr len = sizeof(*sa);
     int i;
-    hwaddr len = SAVE_AREA_SIZE;
 
-    mem = cpu_physical_memory_map(addr, &len, 1);
-    if (!mem) {
+    QEMU_BUILD_BUG_ON(sizeof(*sa) != 512);
+
+    sa = cpu_physical_memory_map(addr, &len, 1);
+    if (!sa) {
         return -EFAULT;
     }
-    if (len != SAVE_AREA_SIZE) {
-        cpu_physical_memory_unmap(mem, len, 1, 0);
+    if (len != sizeof(*sa)) {
+        cpu_physical_memory_unmap(sa, len, 1, 0);
         return -EFAULT;
     }
 
@@ -1571,19 +1587,26 @@ static int kvm_s390_store_status(S390CPU *cpu, hwaddr addr, bool store_arch)
         cpu_physical_memory_write(offsetof(LowCore, ar_access_id), &ar_id, 1);
     }
     for (i = 0; i < 16; ++i) {
-        *((uint64_t *)mem + i) = get_freg(&cpu->env, i)->ll;
-    }
-    memcpy(mem + 128, &cpu->env.regs, 128);
-    memcpy(mem + 256, &cpu->env.psw, 16);
-    memcpy(mem + 280, &cpu->env.psa, 4);
-    memcpy(mem + 284, &cpu->env.fpc, 4);
-    memcpy(mem + 292, &cpu->env.todpr, 4);
-    memcpy(mem + 296, &cpu->env.cputm, 8);
-    memcpy(mem + 304, &ckc, 8);
-    memcpy(mem + 320, &cpu->env.aregs, 64);
-    memcpy(mem + 384, &cpu->env.cregs, 128);
+        sa->fprs[i] = cpu_to_be64(get_freg(&cpu->env, i)->ll);
+    }
+    for (i = 0; i < 16; ++i) {
+        sa->grs[i] = cpu_to_be64(cpu->env.regs[i]);
+    }
+    sa->psw.addr = cpu_to_be64(cpu->env.psw.addr);
+    sa->psw.mask = cpu_to_be64(get_psw_mask(&cpu->env));
+    sa->prefix = cpu_to_be32(cpu->env.psa);
+    sa->fpc = cpu_to_be32(cpu->env.fpc);
+    sa->todpr = cpu_to_be32(cpu->env.todpr);
+    sa->cputm = cpu_to_be64(cpu->env.cputm);
+    sa->ckc = cpu_to_be64(cpu->env.ckc >> 8);
+    for (i = 0; i < 16; ++i) {
+        sa->ars[i] = cpu_to_be32(cpu->env.aregs[i]);
+    }
+    for (i = 0; i < 16; ++i) {
+        sa->ars[i] = cpu_to_be64(cpu->env.cregs[i]);
+    }
 
-    cpu_physical_memory_unmap(mem, len, 1, len);
+    cpu_physical_memory_unmap(sa, len, 1, len);
 
     return 0;
 }
-- 
2.13.5
