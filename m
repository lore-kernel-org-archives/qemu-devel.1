Received: from eggs.gnu.org ([2001:4830:134:3::10]:51616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fpdtW-0003TE-9S
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:19:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fpdss-0005vS-54
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:18:14 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:52255 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fpdsr-0005u9-LT
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 14:17:34 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 14 Aug 2018 20:16:55 +0200
Message-Id: <1534270621-27332-14-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534270621-27332-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534270621-27332-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 13/19] target/mips: Check ELPA flag only in some
 cases of MFHC0 and MTHC0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

From: Yongbok Kim <yongbok.kim@mips.com>

MFHC0 and MTHC0 used to handle EntryLo0 and EntryLo1 registers only,
and placing ELPA flag checks before switch statement were technically
correct. However, after adding handling more registers, these checks
should be moved to act only in cases of handling EntryLo0 and
EntryLo1.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 6f4bdc9..420f1df 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -4938,12 +4938,11 @@ static void gen_mfhc0(DisasContext *ctx, TCGv arg=
, int reg, int sel)
 {
     const char *rn =3D "invalid";
=20
-    CP0_CHECK(ctx->hflags & MIPS_HFLAG_ELPA);
-
     switch (reg) {
     case 2:
         switch (sel) {
         case 0:
+            CP0_CHECK(ctx->hflags & MIPS_HFLAG_ELPA);
             gen_mfhc0_entrylo(arg, offsetof(CPUMIPSState, CP0_EntryLo0))=
;
             rn =3D "EntryLo0";
             break;
@@ -4954,6 +4953,7 @@ static void gen_mfhc0(DisasContext *ctx, TCGv arg, =
int reg, int sel)
     case 3:
         switch (sel) {
         case 0:
+            CP0_CHECK(ctx->hflags & MIPS_HFLAG_ELPA);
             gen_mfhc0_entrylo(arg, offsetof(CPUMIPSState, CP0_EntryLo1))=
;
             rn =3D "EntryLo1";
             break;
@@ -5006,12 +5006,11 @@ static void gen_mthc0(DisasContext *ctx, TCGv arg=
, int reg, int sel)
     const char *rn =3D "invalid";
     uint64_t mask =3D ctx->PAMask >> 36;
=20
-    CP0_CHECK(ctx->hflags & MIPS_HFLAG_ELPA);
-
     switch (reg) {
     case 2:
         switch (sel) {
         case 0:
+            CP0_CHECK(ctx->hflags & MIPS_HFLAG_ELPA);
             tcg_gen_andi_tl(arg, arg, mask);
             gen_mthc0_entrylo(arg, offsetof(CPUMIPSState, CP0_EntryLo0))=
;
             rn =3D "EntryLo0";
@@ -5023,6 +5022,7 @@ static void gen_mthc0(DisasContext *ctx, TCGv arg, =
int reg, int sel)
     case 3:
         switch (sel) {
         case 0:
+            CP0_CHECK(ctx->hflags & MIPS_HFLAG_ELPA);
             tcg_gen_andi_tl(arg, arg, mask);
             gen_mthc0_entrylo(arg, offsetof(CPUMIPSState, CP0_EntryLo1))=
;
             rn =3D "EntryLo1";
--=20
2.7.4
