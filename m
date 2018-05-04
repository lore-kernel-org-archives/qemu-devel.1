Received: from eggs.gnu.org ([2001:4830:134:3::10]:35147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fEYJp-0006SA-13
	for qemu-devel@nongnu.org; Fri, 04 May 2018 06:52:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fEYJl-0003pQ-3C
	for qemu-devel@nongnu.org; Fri, 04 May 2018 06:52:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39376 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fEYJk-0003oP-Ug
	for qemu-devel@nongnu.org; Fri, 04 May 2018 06:52:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 100ECEB706
	for <qemu-devel@nongnu.org>; Fri,  4 May 2018 10:51:57 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  4 May 2018 12:51:47 +0200
Message-Id: <1525431107-44981-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] rename included C files to foo.inc.c,
 remove osdep.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

osdep.h is only needed for files that are compiled directly.
Remove it from included C source files, and rename them to
*.inc.c so that scripts/clean-includes knows to skip them.

Cc: Eric Blake <eblake@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/cris/translate.c                            |    2 +-
 .../cris/{translate_v10.c => translate_v10.inc.c}  |    0
 target/mips/translate.c                            |    2 +-
 .../{translate_init.c => translate_init.inc.c}     |    0
 target/ppc/int_helper.c                            |    2 +-
 target/ppc/{mfrom_table.c => mfrom_table.inc.c}    |    0
 target/ppc/translate.c                             |    2 +-
 .../ppc/{translate_init.c => translate_init.inc.c} |    1 -
 ui/vnc-enc-zrle.c                                  |   22 ++++++++++----------
 ui/{vnc-enc-zrle-template.c => vnc-enc-zrle.inc.c} |    0
 10 files changed, 15 insertions(+), 16 deletions(-)
 rename target/cris/{translate_v10.c => translate_v10.inc.c} (100%)
 rename target/mips/{translate_init.c => translate_init.inc.c} (100%)
 rename target/ppc/{mfrom_table.c => mfrom_table.inc.c} (100%)
 rename target/ppc/{translate_init.c => translate_init.inc.c} (99%)
 rename ui/{vnc-enc-zrle-template.c => vnc-enc-zrle.inc.c} (100%)

diff --git a/target/cris/translate.c b/target/cris/translate.c
index f51a731..ce1ee7a 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -3047,7 +3047,7 @@ static unsigned int crisv32_decoder(CPUCRISState *env, DisasContext *dc)
     return insn_len;
 }
 
-#include "translate_v10.c"
+#include "translate_v10.inc.c"
 
 /*
  * Delay slots on QEMU/CRIS.
diff --git a/target/cris/translate_v10.c b/target/cris/translate_v10.inc.c
similarity index 100%
rename from target/cris/translate_v10.c
rename to target/cris/translate_v10.inc.c
diff --git a/target/mips/translate.c b/target/mips/translate.c
index d05ee67..26f5404 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -20499,7 +20499,7 @@ void mips_tcg_init(void)
                                        "fcr31");
 }
 
-#include "translate_init.c"
+#include "translate_init.inc.c"
 
 void cpu_mips_realize_env(CPUMIPSState *env)
 {
diff --git a/target/mips/translate_init.c b/target/mips/translate_init.inc.c
similarity index 100%
rename from target/mips/translate_init.c
rename to target/mips/translate_init.inc.c
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 35bdf09..1607a7a 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -379,7 +379,7 @@ target_ulong helper_divso(CPUPPCState *env, target_ulong arg1,
 target_ulong helper_602_mfrom(target_ulong arg)
 {
     if (likely(arg < 602)) {
-#include "mfrom_table.c"
+#include "mfrom_table.inc.c"
         return mfrom_ROM_table[arg];
     } else {
         return 0;
diff --git a/target/ppc/mfrom_table.c b/target/ppc/mfrom_table.inc.c
similarity index 100%
rename from target/ppc/mfrom_table.c
rename to target/ppc/mfrom_table.inc.c
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 218665b..043b483 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6991,7 +6991,7 @@ GEN_HANDLER2_E(trechkpt, "trechkpt", 0x1F, 0x0E, 0x1F, 0x03FFF800, \
 };
 
 #include "helper_regs.h"
-#include "translate_init.c"
+#include "translate_init.inc.c"
 
 /*****************************************************************************/
 /* Misc PowerPC helpers */
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.inc.c
similarity index 99%
rename from target/ppc/translate_init.c
rename to target/ppc/translate_init.inc.c
index 391b94b..d92422c 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.inc.c
@@ -18,7 +18,6 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#include "qemu/osdep.h"
 #include "disas/bfd.h"
 #include "exec/gdbstub.h"
 #include "kvm_ppc.h"
diff --git a/ui/vnc-enc-zrle.c b/ui/vnc-enc-zrle.c
index fd63d4f..7493a84 100644
--- a/ui/vnc-enc-zrle.c
+++ b/ui/vnc-enc-zrle.c
@@ -199,56 +199,56 @@ static void zrle_write_u8(VncState *vs, uint8_t value)
 
 #define ZRLE_BPP 8
 #define ZYWRLE_ENDIAN ENDIAN_NO
-#include "vnc-enc-zrle-template.c"
+#include "vnc-enc-zrle.inc.c"
 #undef ZRLE_BPP
 
 #define ZRLE_BPP 15
 #undef ZYWRLE_ENDIAN
 #define ZYWRLE_ENDIAN ENDIAN_LITTLE
-#include "vnc-enc-zrle-template.c"
+#include "vnc-enc-zrle.inc.c"
 
 #undef ZYWRLE_ENDIAN
 #define ZYWRLE_ENDIAN ENDIAN_BIG
-#include "vnc-enc-zrle-template.c"
+#include "vnc-enc-zrle.inc.c"
 
 #undef ZRLE_BPP
 #define ZRLE_BPP 16
 #undef ZYWRLE_ENDIAN
 #define ZYWRLE_ENDIAN ENDIAN_LITTLE
-#include "vnc-enc-zrle-template.c"
+#include "vnc-enc-zrle.inc.c"
 
 #undef ZYWRLE_ENDIAN
 #define ZYWRLE_ENDIAN ENDIAN_BIG
-#include "vnc-enc-zrle-template.c"
+#include "vnc-enc-zrle.inc.c"
 
 #undef ZRLE_BPP
 #define ZRLE_BPP 32
 #undef ZYWRLE_ENDIAN
 #define ZYWRLE_ENDIAN ENDIAN_LITTLE
-#include "vnc-enc-zrle-template.c"
+#include "vnc-enc-zrle.inc.c"
 
 #undef ZYWRLE_ENDIAN
 #define ZYWRLE_ENDIAN ENDIAN_BIG
-#include "vnc-enc-zrle-template.c"
+#include "vnc-enc-zrle.inc.c"
 
 #define ZRLE_COMPACT_PIXEL 24a
 #undef ZYWRLE_ENDIAN
 #define ZYWRLE_ENDIAN ENDIAN_LITTLE
-#include "vnc-enc-zrle-template.c"
+#include "vnc-enc-zrle.inc.c"
 
 #undef ZYWRLE_ENDIAN
 #define ZYWRLE_ENDIAN ENDIAN_BIG
-#include "vnc-enc-zrle-template.c"
+#include "vnc-enc-zrle.inc.c"
 
 #undef ZRLE_COMPACT_PIXEL
 #define ZRLE_COMPACT_PIXEL 24b
 #undef ZYWRLE_ENDIAN
 #define ZYWRLE_ENDIAN ENDIAN_LITTLE
-#include "vnc-enc-zrle-template.c"
+#include "vnc-enc-zrle.inc.c"
 
 #undef ZYWRLE_ENDIAN
 #define ZYWRLE_ENDIAN ENDIAN_BIG
-#include "vnc-enc-zrle-template.c"
+#include "vnc-enc-zrle.inc.c"
 #undef ZRLE_COMPACT_PIXEL
 #undef ZRLE_BPP
 
diff --git a/ui/vnc-enc-zrle-template.c b/ui/vnc-enc-zrle.inc.c
similarity index 100%
rename from ui/vnc-enc-zrle-template.c
rename to ui/vnc-enc-zrle.inc.c
-- 
1.7.1
