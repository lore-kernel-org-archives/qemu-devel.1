Received: from eggs.gnu.org ([2001:4830:134:3::10]:40018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.zbitskiy@gmail.com>) id 1fmNm7-00066D-RH
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 14:29:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.zbitskiy@gmail.com>) id 1fmNm6-0005MY-Qz
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 14:29:07 -0400
From: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
Date: Sun,  5 Aug 2018 14:28:27 -0400
Message-Id: <20180805182832.3012-3-pavel.zbitskiy@gmail.com>
In-Reply-To: <20180805182832.3012-1-pavel.zbitskiy@gmail.com>
References: <20180805182832.3012-1-pavel.zbitskiy@gmail.com>
Subject: [Qemu-devel] [PATCH 2/6] target/s390x: fix CSST decoding and
 runtime alignment check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Pavel Zbitskiy <pavel.zbitskiy@gmail.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, "open list:S390" <qemu-s390x@nongnu.org>

CSST is defined as:

    C(0xc802, CSST,    SSF,   CASS, la1, a2, 0, 0, csst, 0)

It means that the first parameter is handled by in1_la1().
in1_la1() fills addr1 field, and not in1.

Furthermore, when extract32() is used for the alignment check, the
third parameter should specify the number of trailing bits that must
be 0. For FC these numbers are:

    FC=0: 2
    FC=1: 3
    FC=2: 4

For SC these numbers are:

    SC=0: 0
    SC=1: 1
    SC=2: 2
    SC=3: 3
    SC=4: 4

Signed-off-by: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
---
 target/s390x/mem_helper.c | 2 +-
 target/s390x/translate.c  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index e21a47fb4d..c94dbf3fcb 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1442,7 +1442,7 @@ static uint32_t do_csst(CPUS390XState *env, uint32_t r3, uint64_t a1,
     }
 
     /* Sanity check the alignments.  */
-    if (extract32(a1, 0, 4 << fc) || extract32(a2, 0, 1 << sc)) {
+    if (extract32(a1, 0, fc + 2) || extract32(a2, 0, sc)) {
         goto spec_exception;
     }
 
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index efdc88e227..f318fb6e4e 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2050,9 +2050,9 @@ static DisasJumpType op_csst(DisasContext *s, DisasOps *o)
     TCGv_i32 t_r3 = tcg_const_i32(r3);
 
     if (tb_cflags(s->base.tb) & CF_PARALLEL) {
-        gen_helper_csst_parallel(cc_op, cpu_env, t_r3, o->in1, o->in2);
+        gen_helper_csst_parallel(cc_op, cpu_env, t_r3, o->addr1, o->in2);
     } else {
-        gen_helper_csst(cc_op, cpu_env, t_r3, o->in1, o->in2);
+        gen_helper_csst(cc_op, cpu_env, t_r3, o->addr1, o->in2);
     }
     tcg_temp_free_i32(t_r3);
 
-- 
2.16.2.windows.1
