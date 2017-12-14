Received: from eggs.gnu.org ([2001:4830:134:3::10]:56090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePX3p-0001Ey-FD
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:12:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePX3m-0008E4-JX
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:12:41 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 14 Dec 2017 18:09:51 +0100
Message-Id: <20171214171004.25058-34-cohuck@redhat.com>
In-Reply-To: <20171214171004.25058-1-cohuck@redhat.com>
References: <20171214171004.25058-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 33/46] s390x/tcg: fix and cleanup mcck injection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

The architecture mode indication wasn't stored. The split of certain
64bit fields was unnecessary. Also, the complete clock comparator, not
just bit 0-55 (starting at byte 1) was stored.

We now generate a proper MCIC via the same helper we use for KVM.

There is more to clean up, but we will change the other parts later on
either way.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20171208160207.26494-3-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/excp_helper.c | 12 ++++++------
 target/s390x/internal.h    |  6 +++---
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index d831537544..f4697a884d 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -395,6 +395,9 @@ static void do_mchk_interrupt(CPUS390XState *env)
 
     lowcore = cpu_map_lowcore(env);
 
+    /* we are always in z/Architecture mode */
+    lowcore->ar_access_id = 1;
+
     for (i = 0; i < 16; i++) {
         lowcore->floating_pt_save_area[i] = cpu_to_be64(get_freg(env, i)->ll);
         lowcore->gpregs_save_area[i] = cpu_to_be64(env->regs[i]);
@@ -404,13 +407,10 @@ static void do_mchk_interrupt(CPUS390XState *env)
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
     mask = be64_to_cpu(lowcore->mcck_new_psw.mask);
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
2.13.6
