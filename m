Received: from eggs.gnu.org ([209.51.188.92]:43555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gx5wN-0004LF-L8
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 03:12:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gx5wL-0007Cw-NT
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 03:12:15 -0500
From: David Hildenbrand <david@redhat.com>
Date: Fri, 22 Feb 2019 09:11:53 +0100
Message-Id: <20190222081153.14206-4-david@redhat.com>
In-Reply-To: <20190222081153.14206-1-david@redhat.com>
References: <20190222081153.14206-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 3/3] s390x/tcg: Save vregs to extended mchk
 save area
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>

If we have vector registers and the designation is not zero, we have
to try to write the vector registers. If the designation is zero or
if storing fails, we must not indicate validity. s390_build_validity_mcic()
automatically already sets validity if the vector instruction facility
is installed.

As long as we don't support the guarded-storage facility, the alignemnt &
size of the area is always 1024 bytes.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/excp_helper.c | 46 ++++++++++++++++++++++++++++++++++++--
 target/s390x/internal.h    |  4 +++-
 2 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index a758649f47..f84bfb1284 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -347,10 +347,41 @@ static void do_io_interrupt(CPUS390XState *env)
     load_psw(env, mask, addr);
 }
 
+typedef struct MchkExtSaveArea {
+    uint64_t    vregs[32][2];                     /* 0x0000 */
+    uint8_t     pad_0x0200[0x0400 - 0x0200];      /* 0x0200 */
+} MchkExtSaveArea;
+QEMU_BUILD_BUG_ON(sizeof(MchkExtSaveArea) != 1024);
+
+static int mchk_store_vregs(CPUS390XState *env, uint64_t mcesao)
+{
+    hwaddr len = sizeof(MchkExtSaveArea);
+    MchkExtSaveArea *sa;
+    int i;
+
+    sa = cpu_physical_memory_map(mcesao, &len, 1);
+    if (!sa) {
+        return -EFAULT;
+    }
+    if (len != sizeof(MchkExtSaveArea)) {
+        cpu_physical_memory_unmap(sa, len, 1, 0);
+        return -EFAULT;
+    }
+
+    for (i = 0; i < 32; i++) {
+        sa->vregs[i][0] = cpu_to_be64(env->vregs[i][0].ll);
+        sa->vregs[i][1] = cpu_to_be64(env->vregs[i][1].ll);
+    }
+
+    cpu_physical_memory_unmap(sa, len, 1, len);
+    return 0;
+}
+
 static void do_mchk_interrupt(CPUS390XState *env)
 {
     QEMUS390FLICState *flic = QEMU_S390_FLIC(s390_get_flic());
-    uint64_t mask, addr;
+    uint64_t mcic = s390_build_validity_mcic() | MCIC_SC_CP;
+    uint64_t mask, addr, mcesao = 0;
     LowCore *lowcore;
     int i;
 
@@ -362,6 +393,17 @@ static void do_mchk_interrupt(CPUS390XState *env)
 
     lowcore = cpu_map_lowcore(env);
 
+    /* extended save area */
+    if (mcic & MCIC_VB_VR) {
+        /* length and alignment is 1024 bytes */
+        mcesao = be64_to_cpu(lowcore->mcesad) & ~0x3ffull;
+    }
+
+    /* try to store vector registers */
+    if (!mcesao || mchk_store_vregs(env, mcesao)) {
+        mcic &= ~MCIC_VB_VR;
+    }
+
     /* we are always in z/Architecture mode */
     lowcore->ar_access_id = 1;
 
@@ -377,7 +419,7 @@ static void do_mchk_interrupt(CPUS390XState *env)
     lowcore->cpu_timer_save_area = cpu_to_be64(env->cputm);
     lowcore->clock_comp_save_area = cpu_to_be64(env->ckc >> 8);
 
-    lowcore->mcic = cpu_to_be64(s390_build_validity_mcic() | MCIC_SC_CP);
+    lowcore->mcic = cpu_to_be64(mcic);
     lowcore->mcck_old_psw.mask = cpu_to_be64(get_psw_mask(env));
     lowcore->mcck_old_psw.addr = cpu_to_be64(env->psw.addr);
     mask = be64_to_cpu(lowcore->mcck_new_psw.mask);
diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index 122fe037bc..cbeef3515b 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -101,7 +101,9 @@ typedef struct LowCore {
     /* whether the kernel died with panic() or not */
     uint32_t        panic_magic;              /* 0xe00 */
 
-    uint8_t         pad13[0x11b8 - 0xe04];    /* 0xe04 */
+    uint8_t         pad13[0x11b0 - 0xe04];    /* 0xe04 */
+
+    uint64_t        mcesad;                    /* 0x11B0 */
 
     /* 64 bit extparam used for pfault, diag 250 etc  */
     uint64_t        ext_params2;               /* 0x11B8 */
-- 
2.17.2
