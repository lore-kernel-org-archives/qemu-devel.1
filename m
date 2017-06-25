Received: from eggs.gnu.org ([2001:4830:134:3::10]:57923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dP3Sk-0007bl-72
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 05:04:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dP3Sh-0005Jc-0z
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 05:04:10 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Sun, 25 Jun 2017 12:03:56 +0300
Message-Id: <149838143590.6497.11184953059640962891.stgit@frigg.lan>
In-Reply-To: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
References: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v9 05/26] target: [tcg] Redefine DISAS_* onto
 the generic translation framework (DJ_*)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Laurent Vivier <laurent@vivier.eu>, Alexander Graf <agraf@suse.de>, Guan Xuetao <gxt@mprc.pku.edu.cn>, "open list:ARM" <qemu-arm@nongnu.org>

Temporarily redefine DISAS_* values based on DJ_TARGET. They should
disappear as targets get ported to the generic framework.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
Acked-by: David Gibson <david@gibson.dropbear.id.au> (ppc)
Acked-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com> (i386)
Acked-by: Laurent Vivier <laurent@vivier.eu> (m68k)
Reviewed-by: Alex Ben=C3=A9e <alex.benee@linaro.org> (arm)
---
 include/exec/exec-all.h      |   11 +++++++----
 target/arm/translate.h       |   19 ++++++++++---------
 target/cris/translate.c      |    3 ++-
 target/m68k/translate.c      |    3 ++-
 target/s390x/translate.c     |    3 ++-
 target/unicore32/translate.c |    3 ++-
 6 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 1ec7637170..5d693cefd1 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -36,10 +36,13 @@ typedef ram_addr_t tb_page_addr_t;
 #endif
=20
 /* is_jmp field values */
-#define DISAS_NEXT    0 /* next instruction can be analyzed */
-#define DISAS_JUMP    1 /* only pc was modified dynamically */
-#define DISAS_UPDATE  2 /* cpu state was modified dynamically */
-#define DISAS_TB_JUMP 3 /* only pc was modified statically */
+/* TODO: delete after all targets are transitioned to generic translatio=
n */
+#include "exec/translate-block.h"
+#define DISAS_NEXT    DJ_NEXT           /* next instruction can be analy=
zed */
+#define DISAS_JUMP    (DJ_TARGET + 0)   /* only pc was modified dynamica=
lly */
+#define DISAS_UPDATE  (DJ_TARGET + 1)   /* cpu state was modified dynami=
cally */
+#define DISAS_TB_JUMP (DJ_TARGET + 2)   /* only pc was modified statical=
ly */
+#define DISAS_TARGET  (DJ_TARGET + 3)   /* base for target-specific valu=
es */
=20
 #include "qemu/log.h"
=20
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 15d383d9af..e42fdbe61c 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -120,29 +120,30 @@ static void disas_set_insn_syndrome(DisasContext *s=
, uint32_t syn)
 }
=20
 /* target-specific extra values for is_jmp */
+/* TODO: rename as DJ_* when transitioning this target to generic transl=
ation */
 /* These instructions trap after executing, so the A32/T32 decoder must
  * defer them until after the conditional execution state has been updat=
ed.
  * WFI also needs special handling when single-stepping.
  */
-#define DISAS_WFI 4
-#define DISAS_SWI 5
+#define DISAS_WFI (DISAS_TARGET + 0)
+#define DISAS_SWI (DISAS_TARGET + 1)
 /* For instructions which unconditionally cause an exception we can skip
  * emitting unreachable code at the end of the TB in the A64 decoder
  */
-#define DISAS_EXC 6
+#define DISAS_EXC (DISAS_TARGET + 2)
 /* WFE */
-#define DISAS_WFE 7
-#define DISAS_HVC 8
-#define DISAS_SMC 9
-#define DISAS_YIELD 10
+#define DISAS_WFE (DISAS_TARGET + 3)
+#define DISAS_HVC (DISAS_TARGET + 4)
+#define DISAS_SMC (DISAS_TARGET + 5)
+#define DISAS_YIELD (DISAS_TARGET + 6)
 /* M profile branch which might be an exception return (and so needs
  * custom end-of-TB code)
  */
-#define DISAS_BX_EXCRET 11
+#define DISAS_BX_EXCRET (DISAS_TARGET + 7)
 /* For instructions which want an immediate exit to the main loop,
  * as opposed to attempting to use lookup_and_goto_ptr.
  */
-#define DISAS_EXIT 12
+#define DISAS_EXIT (DISAS_TARGET + 8)
=20
 #ifdef TARGET_AARCH64
 void a64_translate_init(void);
diff --git a/target/cris/translate.c b/target/cris/translate.c
index 90424abe00..fca831cd6f 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -50,7 +50,8 @@
 #define BUG() (gen_BUG(dc, __FILE__, __LINE__))
 #define BUG_ON(x) ({if (x) BUG();})
=20
-#define DISAS_SWI 5
+/* TODO: rename as DJ_* when transitioning this target to generic transl=
ation */
+#define DISAS_SWI (DISAS_TARGET + 0)
=20
 /* Used by the decoder.  */
 #define EXTRACT_FIELD(src, start, end) \
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 5fac91aec5..e75e893056 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -190,7 +190,8 @@ static void do_writebacks(DisasContext *s)
     }
 }
=20
-#define DISAS_JUMP_NEXT 4
+/* TODO: rename as DJ_* when transitioning this target to generic transl=
ation */
+#define DISAS_JUMP_NEXT (DISAS_TARGET + 0)
=20
 #if defined(CONFIG_USER_ONLY)
 #define IS_USER(s) 1
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 14abb6e6b9..49eddb061b 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -76,7 +76,8 @@ typedef struct {
     } u;
 } DisasCompare;
=20
-#define DISAS_EXCP 4
+/* TODO: rename as DJ_* when transitioning this target to generic transl=
ation */
+#define DISAS_EXCP (DISAS_TARGET + 0)
=20
 #ifdef DEBUG_INLINE_BRANCHES
 static uint64_t inline_branch_hit[CC_OP_MAX];
diff --git a/target/unicore32/translate.c b/target/unicore32/translate.c
index a7878ffd81..8bc6db61bb 100644
--- a/target/unicore32/translate.c
+++ b/target/unicore32/translate.c
@@ -45,9 +45,10 @@ typedef struct DisasContext {
 #define IS_USER(s)      1
 #endif
=20
+/* TODO: rename as DJ_* when transitioning this target to generic transl=
ation */
 /* These instructions trap after executing, so defer them until after th=
e
    conditional executions state has been updated.  */
-#define DISAS_SYSCALL 5
+#define DISAS_SYSCALL (DISAS_TARGET + 0)
=20
 static TCGv_env cpu_env;
 static TCGv_i32 cpu_R[32];
