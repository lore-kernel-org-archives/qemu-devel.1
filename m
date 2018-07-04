Received: from eggs.gnu.org ([2001:4830:134:3::10]:53863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fanVV-0002q0-Jr
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 15:32:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fanVU-0001L7-LC
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 15:32:05 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:47973 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fanVU-0001Kv-Cc
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 15:32:04 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed,  4 Jul 2018 21:30:37 +0200
Message-Id: <1530732637-28606-9-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1530732637-28606-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1530732637-28606-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v3 8/8] target/mips: Check ELPA flag only in
 some cases of MFHC0 and MTHC0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Yongbok Kim <yongbok.kim@mips.com>

MFHC0 and MTHC0 used to handle EntryLo0 and EntryLo1 registers only,
and placing ELPA flag checks befor switch statement were technically
correct. However, after adding handling more registers, these checks
should be moved to act only in cases of handling EntryLo0 and
EntryLo1.

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index fa1da7e..c01cafe 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -4885,12 +4885,11 @@ static void gen_mfhc0(DisasContext *ctx, TCGv arg, int reg, int sel)
 {
     const char *rn = "invalid";
 
-    CP0_CHECK(ctx->hflags & MIPS_HFLAG_ELPA);
-
     switch (reg) {
     case 2:
         switch (sel) {
         case 0:
+            CP0_CHECK(ctx->hflags & MIPS_HFLAG_ELPA);
             gen_mfhc0_entrylo(arg, offsetof(CPUMIPSState, CP0_EntryLo0));
             rn = "EntryLo0";
             break;
@@ -4901,6 +4900,7 @@ static void gen_mfhc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     case 3:
         switch (sel) {
         case 0:
+            CP0_CHECK(ctx->hflags & MIPS_HFLAG_ELPA);
             gen_mfhc0_entrylo(arg, offsetof(CPUMIPSState, CP0_EntryLo1));
             rn = "EntryLo1";
             break;
@@ -4965,12 +4965,11 @@ static void gen_mthc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     const char *rn = "invalid";
     uint64_t mask = ctx->PAMask >> 36;
 
-    CP0_CHECK(ctx->hflags & MIPS_HFLAG_ELPA);
-
     switch (reg) {
     case 2:
         switch (sel) {
         case 0:
+            CP0_CHECK(ctx->hflags & MIPS_HFLAG_ELPA);
             tcg_gen_andi_tl(arg, arg, mask);
             gen_mthc0_entrylo(arg, offsetof(CPUMIPSState, CP0_EntryLo0));
             rn = "EntryLo0";
@@ -4982,6 +4981,7 @@ static void gen_mthc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     case 3:
         switch (sel) {
         case 0:
+            CP0_CHECK(ctx->hflags & MIPS_HFLAG_ELPA);
             tcg_gen_andi_tl(arg, arg, mask);
             gen_mthc0_entrylo(arg, offsetof(CPUMIPSState, CP0_EntryLo1));
             rn = "EntryLo1";
-- 
2.7.4
