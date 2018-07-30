Received: from eggs.gnu.org ([2001:4830:134:3::10]:34305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fkAo3-0000Ih-Hp
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:14:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fkAo0-00047G-P5
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:13:59 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:48523 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fkAo0-00046y-Df
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 12:13:56 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 30 Jul 2018 18:11:37 +0200
Message-Id: <1532967169-22265-5-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 04/76] target/mips: Add CP0 BadInstrX
 register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Stefan Markovic <smarkovic@wavecomp.com>

Add CP0 BadInstrX register. This register will be used in nanoMIPS.

Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/cpu.h       |  1 +
 target/mips/machine.c   |  5 +++--
 target/mips/translate.c | 22 +++++++++++++++++++++-
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 77c638c..009202c 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -323,6 +323,7 @@ struct CPUMIPSState {
     target_ulong CP0_BadVAddr;
     uint32_t CP0_BadInstr;
     uint32_t CP0_BadInstrP;
+    uint32_t CP0_BadInstrX;
     int32_t CP0_Count;
     target_ulong CP0_EntryHi;
 #define CP0EnHi_EHINV 10
diff --git a/target/mips/machine.c b/target/mips/machine.c
index 20100d5..5ba78ac 100644
--- a/target/mips/machine.c
+++ b/target/mips/machine.c
@@ -212,8 +212,8 @@ const VMStateDescription vmstate_tlb =3D {
=20
 const VMStateDescription vmstate_mips_cpu =3D {
     .name =3D "cpu",
-    .version_id =3D 10,
-    .minimum_version_id =3D 10,
+    .version_id =3D 11,
+    .minimum_version_id =3D 11,
     .post_load =3D cpu_post_load,
     .fields =3D (VMStateField[]) {
         /* Active TC */
@@ -266,6 +266,7 @@ const VMStateDescription vmstate_mips_cpu =3D {
         VMSTATE_UINTTL(env.CP0_BadVAddr, MIPSCPU),
         VMSTATE_UINT32(env.CP0_BadInstr, MIPSCPU),
         VMSTATE_UINT32(env.CP0_BadInstrP, MIPSCPU),
+        VMSTATE_UINT32(env.CP0_BadInstrX, MIPSCPU),
         VMSTATE_INT32(env.CP0_Count, MIPSCPU),
         VMSTATE_UINTTL(env.CP0_EntryHi, MIPSCPU),
         VMSTATE_INT32(env.CP0_Compare, MIPSCPU),
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 051dda5..9871182 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -5315,7 +5315,13 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, =
int reg, int sel)
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_BadInstrP));
             rn =3D "BadInstrP";
             break;
-        default:
+        case 3:
+            CP0_CHECK(ctx->bi);
+            gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_BadInstrX));
+            tcg_gen_andi_tl(arg, arg, ~0xffff);
+            rn =3D "BadInstrX";
+            break;
+       default:
             goto cp0_unimplemented;
         }
         break;
@@ -6006,6 +6012,10 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, =
int reg, int sel)
             /* ignored */
             rn =3D "BadInstrP";
             break;
+        case 3:
+            /* ignored */
+            rn =3D "BadInstrX";
+            break;
         default:
             goto cp0_unimplemented;
         }
@@ -6711,6 +6721,12 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg,=
 int reg, int sel)
             gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_BadInstrP));
             rn =3D "BadInstrP";
             break;
+        case 3:
+            CP0_CHECK(ctx->bi);
+            gen_mfc0_load32(arg, offsetof(CPUMIPSState, CP0_BadInstrX));
+            tcg_gen_andi_tl(arg, arg, ~0xffff);
+            rn =3D "BadInstrX";
+            break;
         default:
             goto cp0_unimplemented;
         }
@@ -7385,6 +7401,10 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg,=
 int reg, int sel)
             /* ignored */
             rn =3D "BadInstrP";
             break;
+        case 3:
+            /* ignored */
+            rn =3D "BadInstrX";
+            break;
         default:
             goto cp0_unimplemented;
         }
--=20
2.7.4
