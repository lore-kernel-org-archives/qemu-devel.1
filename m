Received: from eggs.gnu.org ([2001:4830:134:3::10]:60097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eLqHF-00069j-M3
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 07:55:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eLqHE-0000El-Pl
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 07:55:17 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon,  4 Dec 2017 13:55:02 +0100
Message-Id: <20171204125505.29203-3-david@redhat.com>
In-Reply-To: <20171204125505.29203-1-david@redhat.com>
References: <20171204125505.29203-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 for-2.12 2/5] s390x/tcg: fix and cleanup
 mcck injection
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

The architecture mode indication wasn't stored. The split of certain
64bit fields was unnecessary. Also, the complete clock comparator, not
just bit 0-55 (starting at byte 1) was stored.

We now generate a proper MCIC via the same helper we use for KVM.

While at it, also get rid of two local variables. There is be more to
clean up, but we will change the other parts later on either way.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/excp_helper.c | 18 ++++++++----------
 target/s390x/internal.h    |  6 +++---
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index d831537544..840cf7641a 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -369,7 +369,6 @@ static void do_io_interrupt(CPUS390XState *env)
 static void do_mchk_interrupt(CPUS390XState *env)
 {
     S390CPU *cpu = s390_env_get_cpu(env);
-    uint64_t mask, addr;
     LowCore *lowcore;
     MchkQueue *q;
     int i;
@@ -395,6 +394,9 @@ static void do_mchk_interrupt(CPUS390XState *env)
 
     lowcore = cpu_map_lowcore(env);
 
+    /* we are always in z/Architecture mode */
+    lowcore->ar_access_id = 1;
+
     for (i = 0; i < 16; i++) {
         lowcore->floating_pt_save_area[i] = cpu_to_be64(get_freg(env, i)->ll);
         lowcore->gpregs_save_area[i] = cpu_to_be64(env->regs[i]);
@@ -404,17 +406,12 @@ static void do_mchk_interrupt(CPUS390XState *env)
     lowcore->prefixreg_save_area = cpu_to_be32(env->psa);
     lowcore->fpt_creg_save_area = cpu_to_be32(env->fpc);
     lowcore->tod_progreg_save_area = cpu_to_be32(env->todpr);
-    lowcore->cpu_timer_save_area[0] = cpu_to_be32(env->cputm >> 32);
-    lowcore->cpu_timer_save_area[1] = cpu_to_be32((uint32_t)env->cputm);
-    lowcore->clock_comp_save_area[0] = cpu_to_be32(env->ckc >> 32);
-    lowcore->clock_comp_save_area[1] = cpu_to_be32((uint32_t)env->ckc);
+    lowcore->cpu_timer_save_area = cpu_to_be64(env->cputm);
+    lowcore->clock_comp_save_area = cpu_to_be64(env->ckc >> 8);
 
-    lowcore->mcck_interruption_code[0] = cpu_to_be32(0x00400f1d);
-    lowcore->mcck_interruption_code[1] = cpu_to_be32(0x40330000);
+    lowcore->mcic = cpu_to_be64(s390_build_validity_mcic() | MCIC_SC_CP);
     lowcore->mcck_old_psw.mask = cpu_to_be64(get_psw_mask(env));
     lowcore->mcck_old_psw.addr = cpu_to_be64(env->psw.addr);
-    mask = be64_to_cpu(lowcore->mcck_new_psw.mask);
-    addr = be64_to_cpu(lowcore->mcck_new_psw.addr);
 
     cpu_unmap_lowcore(lowcore);
 
@@ -426,7 +423,8 @@ static void do_mchk_interrupt(CPUS390XState *env)
     DPRINTF("%s: %" PRIx64 " %" PRIx64 "\n", __func__,
             env->psw.mask, env->psw.addr);
 
-    load_psw(env, mask, addr);
+    load_psw(env, be64_to_cpu(lowcore->mcck_new_psw.mask),
+             be64_to_cpu(lowcore->mcck_new_psw.addr));
 }
 
 void s390_cpu_do_interrupt(CPUState *cs)
diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index 6817b2c432..1a88e4beb4 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -43,7 +43,7 @@ typedef struct LowCore {
     uint8_t         pad3[0xc8 - 0xc4];        /* 0x0c4 */
     uint32_t        stfl_fac_list;            /* 0x0c8 */
     uint8_t         pad4[0xe8 - 0xcc];        /* 0x0cc */
-    uint32_t        mcck_interruption_code[2]; /* 0x0e8 */
+    uint64_t        mcic;                     /* 0x0e8 */
     uint8_t         pad5[0xf4 - 0xf0];        /* 0x0f0 */
     uint32_t        external_damage_code;     /* 0x0f4 */
     uint64_t        failing_storage_address;  /* 0x0f8 */
@@ -118,8 +118,8 @@ typedef struct LowCore {
     uint32_t        fpt_creg_save_area;        /* 0x131c */
     uint8_t         pad16[0x1324 - 0x1320];    /* 0x1320 */
     uint32_t        tod_progreg_save_area;     /* 0x1324 */
-    uint32_t        cpu_timer_save_area[2];    /* 0x1328 */
-    uint32_t        clock_comp_save_area[2];   /* 0x1330 */
+    uint64_t        cpu_timer_save_area;       /* 0x1328 */
+    uint64_t        clock_comp_save_area;      /* 0x1330 */
     uint8_t         pad17[0x1340 - 0x1338];    /* 0x1338 */
     uint32_t        access_regs_save_area[16]; /* 0x1340 */
     uint64_t        cregs_save_area[16];       /* 0x1380 */
-- 
2.14.3
