Received: from eggs.gnu.org ([2001:4830:134:3::10]:47265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fcsvu-00083C-Lq
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 09:43:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fcsvp-0006B6-Hl
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 09:43:58 -0400
Received: from mail-by2nam03on0099.outbound.protection.outlook.com
	([104.47.42.99]:59021
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fcsvp-0006Ai-1l
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 09:43:53 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 10 Jul 2018 13:43:48 +0000
Message-ID: <BN7PR08MB4868A1F9B49E8804F5AA05CDC65B0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1531169431-10772-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1531169431-10772-7-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1531169431-10772-7-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 06/33] target/mips: Add emulation of
 some common nanoMIPS 32-bit instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "f4bug@amsat.org" <f4bug@amsat.org>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

Subject: [PATCH v2 06/33] target/mips: Add emulation of some common nanoMIP=
S 32-bit instructions

From: Yongbok Kim <yongbok.kim@mips.com>

Add emulation of SIGRIE, SYSCALL, BREAK, SDBBP, ADDIU, ADDIUPC,
ADDIUGP.W, LWGP, SWGP, ORI, XORI, ANDI, and other instructions.

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 285 ++++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 284 insertions(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 379b6ba..09bb9b2 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
+        case NM_SEQI:
+        {
+            TCGv t0 =3D tcg_temp_new();
+            TCGv t1 =3D tcg_temp_new();
+            TCGv t2 =3D tcg_temp_local_new();
+            TCGLabel *l1 =3D gen_new_label();
+
+            gen_load_gpr(t0, rs);
+            tcg_gen_movi_tl(t1, extract32(ctx->opcode, 0, 12));
+            tcg_gen_movi_tl(t2, 0);
+            tcg_gen_brcond_tl(TCG_COND_NE, t0, t1, l1);
+            tcg_gen_movi_tl(t2, 1);
+            gen_set_label(l1);
+            gen_store_gpr(t2, rt);
+
+            tcg_temp_free(t0);
+            tcg_temp_free(t1);
+            tcg_temp_free(t2);
+        }
+            break;
+        case NM_ADDIUNEG:
+        {
+            int16_t imm;
+            imm =3D (int16_t) extract32(ctx->opcode, 0, 12);
+            gen_arith_imm(ctx, OPC_ADDIU, rt, rs, -imm);
+        }
+            break;
+        case NM_P_SHIFT:
+        {
+            int shift =3D extract32(ctx->opcode, 0, 5);
+            switch ((ctx->opcode >> 5) & 0x0f) {
+            case NM_P_SLL:
+                if (rt =3D=3D 0 && shift =3D=3D 0) {
+                    /* NOP */
+                } else if (rt =3D=3D 0 && shift =3D=3D 3) {
+                    /* EHB treat as NOP */
+                } else if (rt =3D=3D 0 && shift =3D=3D 5) {
+                    /* PAUSE */
+                    if (ctx->hflags & MIPS_HFLAG_BMASK) {
+                        generate_exception_end(ctx, EXCP_RI);
+                    }
+                } else if (rt =3D=3D 0 && shift =3D=3D 6) {
+                    /* SYNC */
+                    check_insn(ctx, ISA_MIPS2);
+                    /* Treat as NOP. */
+                } else {
+                    /* SLL */
+                    gen_shift_imm(ctx, OPC_SLL, rt, rs,
+                                  extract32(ctx->opcode, 0, 5));
+                }
+                break;
+            case NM_SRL:
+                gen_shift_imm(ctx, OPC_SRL, rt, rs,
+                              extract32(ctx->opcode, 0, 5));
+                break;
+            case NM_SRA:
+                gen_shift_imm(ctx, OPC_SRA, rt, rs,
+                              extract32(ctx->opcode, 0, 5));
+                break;
+            case NM_ROTR:
+                gen_shift_imm(ctx, OPC_ROTR, rt, rs,
+                              extract32(ctx->opcode, 0, 5));
+                break;
+            }
+        }
+            break;

Indentation is wrong for these "cases".

Otherwise:

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
