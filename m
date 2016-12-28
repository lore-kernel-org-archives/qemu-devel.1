Received: from eggs.gnu.org ([2001:4830:134:3::10]:44695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cMH5P-00016c-Mu
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 11:28:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cMH5M-00062m-00
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 11:28:19 -0500
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Wed, 28 Dec 2016 17:28:05 +0100
Message-Id: <148294248552.10801.12586775792637978152.stgit@fimbulvetr.bsc.es>
In-Reply-To: <148294246378.10801.8881527920302104439.stgit@fimbulvetr.bsc.es>
References: <148294246378.10801.8881527920302104439.stgit@fimbulvetr.bsc.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 4/6] target: [tcg] Redefine DISAS_* onto the
 generic translation framework (DJ_*)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Laurent Vivier <laurent@vivier.eu>, Alexander Graf <agraf@suse.de>, Guan Xuetao <gxt@mprc.pku.edu.cn>, "open list:ARM" <qemu-arm@nongnu.org>

Temporarily redefine DISAS_* values based on DJ_TARGET. They should
disappear as targets get ported to the generic framework.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 include/exec/exec-all.h      |   11 +++++++----
 target-arm/translate.h       |   15 ++++++++-------
 target-cris/translate.c      |    3 ++-
 target-m68k/translate.c      |    3 ++-
 target-s390x/translate.c     |    3 ++-
 target-unicore32/translate.c |    3 ++-
 6 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 0e45e1aedc..169da5ebe0 100644
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
+#include "exec/translate-all_template.h"
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
diff --git a/target-arm/translate.h b/target-arm/translate.h
index 285e96f087..3dd4c4578e 100644
--- a/target-arm/translate.h
+++ b/target-arm/translate.h
@@ -105,21 +105,22 @@ static inline int default_exception_el(DisasContext=
 *s)
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
=20
 #ifdef TARGET_AARCH64
 void a64_translate_init(void);
diff --git a/target-cris/translate.c b/target-cris/translate.c
index ebcf7863bf..001714c7c1 100644
--- a/target-cris/translate.c
+++ b/target-cris/translate.c
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
diff --git a/target-m68k/translate.c b/target-m68k/translate.c
index 6da6f2b51b..b2b0555c80 100644
--- a/target-m68k/translate.c
+++ b/target-m68k/translate.c
@@ -143,7 +143,8 @@ typedef struct DisasContext {
     int done_mac;
 } DisasContext;
=20
-#define DISAS_JUMP_NEXT 4
+/* TODO: rename as DJ_* when transitioning this target to generic transl=
ation */
+#define DISAS_JUMP_NEXT (DISAS_TARGET + 0)
=20
 #if defined(CONFIG_USER_ONLY)
 #define IS_USER(s) 1
diff --git a/target-s390x/translate.c b/target-s390x/translate.c
index a3992dae5a..75787e89e3 100644
--- a/target-s390x/translate.c
+++ b/target-s390x/translate.c
@@ -74,7 +74,8 @@ typedef struct {
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
diff --git a/target-unicore32/translate.c b/target-unicore32/translate.c
index 39eaa76b50..de0a64e1c8 100644
--- a/target-unicore32/translate.c
+++ b/target-unicore32/translate.c
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
