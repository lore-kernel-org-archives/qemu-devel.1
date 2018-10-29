Received: from eggs.gnu.org ([2001:4830:134:3::10]:48566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gH5gY-0007xJ-2e
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:26:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gH5gT-0002pF-SM
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:26:17 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:60840 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gH5gT-0002ol-Bq
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:26:13 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 29 Oct 2018 12:25:11 +0100
Message-Id: <1540812328-16163-4-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540812328-16163-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540812328-16163-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 03/20] target/mips: Amend MXU instruction
 opcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, richard.henderson@linaro.org, jancraig@amazon.com, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Amend MXU instruction opcodes. Pool04 is actually only instruction
OPC_MXU_S16MAD. Two cases within S16MAD are recognized by 1-bit
subfield 'aptn1'.

Reviewed-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 160 +++++++++++++++++++++---------------------=
------
 1 file changed, 69 insertions(+), 91 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 36727c3..9f6200a 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -1486,7 +1486,7 @@ enum {
  *  S32OR XRa, XRb, XRc               D32SARW XRa, XRb, XRc, Rb
  *                                    Q16SLL XRa, XRb, XRc, XRd, sft4
  *                                    Q16SLR XRa, XRb, XRc, XRd, sft4
- * Miscelaneous instructions          Q16SAR XRa, XRb, XRc, XRd, sft4
+ * Miscellaneous instructions         Q16SAR XRa, XRb, XRc, XRd, sft4
  * -------------------------          Q16SLLV XRa, XRb, Rb
  *                                    Q16SLRV XRa, XRb, Rb
  *  S32SFL XRa, XRb, XRc, XRd, optn2  Q16SARV XRa, XRb, Rb
@@ -1504,7 +1504,8 @@ enum {
  *
  *          =E2=94=8C=E2=94=80 000000 =E2=94=80 OPC_MXU_S32MADD
  *          =E2=94=9C=E2=94=80 000001 =E2=94=80 OPC_MXU_S32MADDU
- *          =E2=94=9C=E2=94=80 000010 =E2=94=80 <not assigned>
+ *          =E2=94=9C=E2=94=80 000010 =E2=94=80 <not assigned>   (non-MX=
U OPC_MUL)
+ *          =E2=94=82
  *          =E2=94=82                               20..18
  *          =E2=94=9C=E2=94=80 000011 =E2=94=80 OPC_MXU__POOL00 =E2=94=80=
=E2=94=AC=E2=94=80 000 =E2=94=80 OPC_MXU_S32MAX
  *          =E2=94=82                            =E2=94=9C=E2=94=80 001 =
=E2=94=80 OPC_MXU_S32MIN
@@ -1536,73 +1537,67 @@ enum {
  *          =E2=94=9C=E2=94=80 001010 =E2=94=80 OPC_MXU_D16MAC
  *          =E2=94=9C=E2=94=80 001011 =E2=94=80 OPC_MXU_D16MACF
  *          =E2=94=9C=E2=94=80 001100 =E2=94=80 OPC_MXU_D16MADL
- *          =E2=94=82                               25..24
- *          =E2=94=9C=E2=94=80 001101 =E2=94=80 OPC_MXU__POOL04 =E2=94=80=
=E2=94=AC=E2=94=80 00 =E2=94=80 OPC_MXU_S16MAD
- *          =E2=94=82                            =E2=94=94=E2=94=80 01 =E2=
=94=80 OPC_MXU_S16MAD_1
+ *          =E2=94=9C=E2=94=80 001101 =E2=94=80 OPC_MXU_S16MAD
  *          =E2=94=9C=E2=94=80 001110 =E2=94=80 OPC_MXU_Q16ADD
- *          =E2=94=9C=E2=94=80 001111 =E2=94=80 OPC_MXU_D16MACE
- *          =E2=94=82                               23
- *          =E2=94=9C=E2=94=80 010000 =E2=94=80 OPC_MXU__POOL05 =E2=94=80=
=E2=94=AC=E2=94=80 0 =E2=94=80 OPC_MXU_S32LDD
- *          =E2=94=82                            =E2=94=94=E2=94=80 1 =E2=
=94=80 OPC_MXU_S32LDDR
+ *          =E2=94=9C=E2=94=80 001111 =E2=94=80 OPC_MXU_D16MACE     23
+ *          =E2=94=82                            =E2=94=8C=E2=94=80 0 =E2=
=94=80 OPC_MXU_S32LDD
+ *          =E2=94=9C=E2=94=80 010000 =E2=94=80 OPC_MXU__POOL04 =E2=94=80=
=E2=94=B4=E2=94=80 1 =E2=94=80 OPC_MXU_S32LDDR
  *          =E2=94=82
  *          =E2=94=82                               23
- *          =E2=94=9C=E2=94=80 010001 =E2=94=80 OPC_MXU__POOL06 =E2=94=80=
=E2=94=AC=E2=94=80 0 =E2=94=80 OPC_MXU_S32STD
+ *          =E2=94=9C=E2=94=80 010001 =E2=94=80 OPC_MXU__POOL05 =E2=94=80=
=E2=94=AC=E2=94=80 0 =E2=94=80 OPC_MXU_S32STD
  *          =E2=94=82                            =E2=94=94=E2=94=80 1 =E2=
=94=80 OPC_MXU_S32STDR
  *          =E2=94=82
  *          =E2=94=82                               13..10
- *          =E2=94=9C=E2=94=80 010010 =E2=94=80 OPC_MXU__POOL07 =E2=94=80=
=E2=94=AC=E2=94=80 0000 =E2=94=80 OPC_MXU_S32LDDV
+ *          =E2=94=9C=E2=94=80 010010 =E2=94=80 OPC_MXU__POOL06 =E2=94=80=
=E2=94=AC=E2=94=80 0000 =E2=94=80 OPC_MXU_S32LDDV
  *          =E2=94=82                            =E2=94=94=E2=94=80 0001=
 =E2=94=80 OPC_MXU_S32LDDVR
  *          =E2=94=82
  *          =E2=94=82                               13..10
- *          =E2=94=9C=E2=94=80 010011 =E2=94=80 OPC_MXU__POOL08 =E2=94=80=
=E2=94=AC=E2=94=80 0000 =E2=94=80 OPC_MXU_S32STDV
+ *          =E2=94=9C=E2=94=80 010011 =E2=94=80 OPC_MXU__POOL07 =E2=94=80=
=E2=94=AC=E2=94=80 0000 =E2=94=80 OPC_MXU_S32STDV
  *          =E2=94=82                            =E2=94=94=E2=94=80 0001=
 =E2=94=80 OPC_MXU_S32STDVR
  *          =E2=94=82
  *          =E2=94=82                               23
- *          =E2=94=9C=E2=94=80 010100 =E2=94=80 OPC_MXU__POOL09 =E2=94=80=
=E2=94=AC=E2=94=80 0 =E2=94=80 OPC_MXU_S32LDI
+ *          =E2=94=9C=E2=94=80 010100 =E2=94=80 OPC_MXU__POOL08 =E2=94=80=
=E2=94=AC=E2=94=80 0 =E2=94=80 OPC_MXU_S32LDI
  *          =E2=94=82                            =E2=94=94=E2=94=80 1 =E2=
=94=80 OPC_MXU_S32LDIR
  *          =E2=94=82
  *          =E2=94=82                               23
- *          =E2=94=9C=E2=94=80 010101 =E2=94=80 OPC_MXU__POOL10 =E2=94=80=
=E2=94=AC=E2=94=80 0 =E2=94=80 OPC_MXU_S32SDI
+ *          =E2=94=9C=E2=94=80 010101 =E2=94=80 OPC_MXU__POOL09 =E2=94=80=
=E2=94=AC=E2=94=80 0 =E2=94=80 OPC_MXU_S32SDI
  *          =E2=94=82                            =E2=94=94=E2=94=80 1 =E2=
=94=80 OPC_MXU_S32SDIR
  *          =E2=94=82
  *          =E2=94=82                               13..10
- *          =E2=94=9C=E2=94=80 010110 =E2=94=80 OPC_MXU__POOL11 =E2=94=80=
=E2=94=AC=E2=94=80 0000 =E2=94=80 OPC_MXU_S32LDIV
+ *          =E2=94=9C=E2=94=80 010110 =E2=94=80 OPC_MXU__POOL10 =E2=94=80=
=E2=94=AC=E2=94=80 0000 =E2=94=80 OPC_MXU_S32LDIV
  *          =E2=94=82                            =E2=94=94=E2=94=80 0001=
 =E2=94=80 OPC_MXU_S32LDIVR
  *          =E2=94=82
  *          =E2=94=82                               13..10
- *          =E2=94=9C=E2=94=80 010111 =E2=94=80 OPC_MXU__POOL12 =E2=94=80=
=E2=94=AC=E2=94=80 0000 =E2=94=80 OPC_MXU_S32SDIV
+ *          =E2=94=9C=E2=94=80 010111 =E2=94=80 OPC_MXU__POOL11 =E2=94=80=
=E2=94=AC=E2=94=80 0000 =E2=94=80 OPC_MXU_S32SDIV
  *          =E2=94=82                            =E2=94=94=E2=94=80 0001=
 =E2=94=80 OPC_MXU_S32SDIVR
  *          =E2=94=9C=E2=94=80 011000 =E2=94=80 OPC_MXU_D32ADD
  *          =E2=94=82                               23..22
- *   MXU    =E2=94=9C=E2=94=80 011001 =E2=94=80 OPC_MXU__POOL13 =E2=94=80=
=E2=94=AC=E2=94=80 00 =E2=94=80 OPC_MXU_D32ACC
+ *   MXU    =E2=94=9C=E2=94=80 011001 =E2=94=80 OPC_MXU__POOL12 =E2=94=80=
=E2=94=AC=E2=94=80 00 =E2=94=80 OPC_MXU_D32ACC
  * opcodes =E2=94=80=E2=94=A4                            =E2=94=9C=E2=94=
=80 01 =E2=94=80 OPC_MXU_D32ACCM
  *          =E2=94=82                            =E2=94=94=E2=94=80 10 =E2=
=94=80 OPC_MXU_D32ASUM
  *          =E2=94=9C=E2=94=80 011010 =E2=94=80 <not assigned>
  *          =E2=94=82                               23..22
- *          =E2=94=9C=E2=94=80 011011 =E2=94=80 OPC_MXU__POOL14 =E2=94=80=
=E2=94=AC=E2=94=80 00 =E2=94=80 OPC_MXU_Q16ACC
+ *          =E2=94=9C=E2=94=80 011011 =E2=94=80 OPC_MXU__POOL13 =E2=94=80=
=E2=94=AC=E2=94=80 00 =E2=94=80 OPC_MXU_Q16ACC
  *          =E2=94=82                            =E2=94=9C=E2=94=80 01 =E2=
=94=80 OPC_MXU_Q16ACCM
  *          =E2=94=82                            =E2=94=94=E2=94=80 10 =E2=
=94=80 OPC_MXU_Q16ASUM
  *          =E2=94=82
  *          =E2=94=82                               23..22
- *          =E2=94=9C=E2=94=80 011100 =E2=94=80 OPC_MXU__POOL15 =E2=94=80=
=E2=94=AC=E2=94=80 00 =E2=94=80 OPC_MXU_Q8ADDE
+ *          =E2=94=9C=E2=94=80 011100 =E2=94=80 OPC_MXU__POOL14 =E2=94=80=
=E2=94=AC=E2=94=80 00 =E2=94=80 OPC_MXU_Q8ADDE
  *          =E2=94=82                            =E2=94=9C=E2=94=80 01 =E2=
=94=80 OPC_MXU_D8SUM
  *          =E2=94=9C=E2=94=80 011101 =E2=94=80 OPC_MXU_Q8ACCE   =E2=94=94=
=E2=94=80 10 =E2=94=80 OPC_MXU_D8SUMC
  *          =E2=94=9C=E2=94=80 011110 =E2=94=80 <not assigned>
  *          =E2=94=9C=E2=94=80 011111 =E2=94=80 <not assigned>
- *          =E2=94=9C=E2=94=80 100000 =E2=94=80 <not assigned>
- *          =E2=94=9C=E2=94=80 100001 =E2=94=80 <not assigned>
+ *          =E2=94=9C=E2=94=80 100000 =E2=94=80 <not assigned>   (overla=
ps with CLZ)
+ *          =E2=94=9C=E2=94=80 100001 =E2=94=80 <not assigned>   (overla=
ps with CLO)
  *          =E2=94=9C=E2=94=80 100010 =E2=94=80 OPC_MXU_S8LDD
- *          =E2=94=9C=E2=94=80 100011 =E2=94=80 OPC_MXU_S8STD
- *          =E2=94=9C=E2=94=80 100100 =E2=94=80 OPC_MXU_S8LDI
- *          =E2=94=9C=E2=94=80 100101 =E2=94=80 OPC_MXU_S8SDI
- *          =E2=94=82                               15..14
- *          =E2=94=9C=E2=94=80 100110 =E2=94=80 OPC_MXU__POOL16 =E2=94=80=
=E2=94=AC=E2=94=80 00 =E2=94=80 OPC_MXU_S32MUL
- *          =E2=94=82                            =E2=94=9C=E2=94=80 00 =E2=
=94=80 OPC_MXU_S32MULU
+ *          =E2=94=9C=E2=94=80 100011 =E2=94=80 OPC_MXU_S8STD       15..=
14
+ *          =E2=94=9C=E2=94=80 100100 =E2=94=80 OPC_MXU_S8LDI    =E2=94=8C=
=E2=94=80 00 =E2=94=80 OPC_MXU_S32MUL
+ *          =E2=94=9C=E2=94=80 100101 =E2=94=80 OPC_MXU_S8SDI    =E2=94=9C=
=E2=94=80 00 =E2=94=80 OPC_MXU_S32MULU
  *          =E2=94=82                            =E2=94=9C=E2=94=80 00 =E2=
=94=80 OPC_MXU_S32EXTR
- *          =E2=94=82                            =E2=94=94=E2=94=80 00 =E2=
=94=80 OPC_MXU_S32EXTRV
+ *          =E2=94=9C=E2=94=80 100110 =E2=94=80 OPC_MXU__POOL15 =E2=94=80=
=E2=94=B4=E2=94=80 00 =E2=94=80 OPC_MXU_S32EXTRV
  *          =E2=94=82
  *          =E2=94=82                               20..18
- *          =E2=94=9C=E2=94=80 100111 =E2=94=80 OPC_MXU__POOL17 =E2=94=80=
=E2=94=AC=E2=94=80 000 =E2=94=80 OPC_MXU_D32SARW
+ *          =E2=94=9C=E2=94=80 100111 =E2=94=80 OPC_MXU__POOL16 =E2=94=80=
=E2=94=AC=E2=94=80 000 =E2=94=80 OPC_MXU_D32SARW
  *          =E2=94=82                            =E2=94=9C=E2=94=80 001 =
=E2=94=80 OPC_MXU_S32ALN
  *          =E2=94=9C=E2=94=80 101000 =E2=94=80 OPC_MXU_LXB      =E2=94=9C=
=E2=94=80 010 =E2=94=80 OPC_MXU_S32ALNI
  *          =E2=94=9C=E2=94=80 101001 =E2=94=80 <not assigned>   =E2=94=9C=
=E2=94=80 011 =E2=94=80 OPC_MXU_S32NOR
@@ -1610,33 +1605,24 @@ enum {
  *          =E2=94=9C=E2=94=80 101011 =E2=94=80 OPC_MXU_S16STD   =E2=94=9C=
=E2=94=80 101 =E2=94=80 OPC_MXU_S32OR
  *          =E2=94=9C=E2=94=80 101100 =E2=94=80 OPC_MXU_S16LDI   =E2=94=9C=
=E2=94=80 110 =E2=94=80 OPC_MXU_S32XOR
  *          =E2=94=9C=E2=94=80 101101 =E2=94=80 OPC_MXU_S16SDI   =E2=94=94=
=E2=94=80 111 =E2=94=80 OPC_MXU_S32LUI
- *          =E2=94=9C=E2=94=80 101000 =E2=94=80 <not assigned>
- *          =E2=94=9C=E2=94=80 101001 =E2=94=80 <not assigned>
- *          =E2=94=9C=E2=94=80 101010 =E2=94=80 <not assigned>
- *          =E2=94=9C=E2=94=80 101011 =E2=94=80 <not assigned>
- *          =E2=94=9C=E2=94=80 101100 =E2=94=80 <not assigned>
- *          =E2=94=9C=E2=94=80 101101 =E2=94=80 <not assigned>
  *          =E2=94=9C=E2=94=80 101110 =E2=94=80 OPC_MXU_S32M2I
  *          =E2=94=9C=E2=94=80 101111 =E2=94=80 OPC_MXU_S32I2M
  *          =E2=94=9C=E2=94=80 110000 =E2=94=80 OPC_MXU_D32SLL
- *          =E2=94=9C=E2=94=80 110001 =E2=94=80 OPC_MXU_D32SLR
- *          =E2=94=9C=E2=94=80 110010 =E2=94=80 OPC_MXU_D32SARL
- *          =E2=94=9C=E2=94=80 110011 =E2=94=80 OPC_MXU_D32SAR
- *          =E2=94=9C=E2=94=80 110100 =E2=94=80 OPC_MXU_Q16SLL
- *          =E2=94=9C=E2=94=80 110101 =E2=94=80 OPC_MXU_Q16SLR      20..=
18
- *          =E2=94=9C=E2=94=80 110110 =E2=94=80 OPC_MXU__POOL18 =E2=94=80=
=E2=94=AC=E2=94=80 000 =E2=94=80 OPC_MXU_D32SLLV
- *          =E2=94=82                            =E2=94=9C=E2=94=80 001 =
=E2=94=80 OPC_MXU_D32SLRV
- *          =E2=94=82                            =E2=94=9C=E2=94=80 010 =
=E2=94=80 OPC_MXU_D32SARV
- *          =E2=94=82                            =E2=94=9C=E2=94=80 011 =
=E2=94=80 OPC_MXU_Q16SLLV
+ *          =E2=94=9C=E2=94=80 110001 =E2=94=80 OPC_MXU_D32SLR      20..=
18
+ *          =E2=94=9C=E2=94=80 110010 =E2=94=80 OPC_MXU_D32SARL  =E2=94=8C=
=E2=94=80 000 =E2=94=80 OPC_MXU_D32SLLV
+ *          =E2=94=9C=E2=94=80 110011 =E2=94=80 OPC_MXU_D32SAR   =E2=94=9C=
=E2=94=80 001 =E2=94=80 OPC_MXU_D32SLRV
+ *          =E2=94=9C=E2=94=80 110100 =E2=94=80 OPC_MXU_Q16SLL   =E2=94=9C=
=E2=94=80 010 =E2=94=80 OPC_MXU_D32SARV
+ *          =E2=94=9C=E2=94=80 110101 =E2=94=80 OPC_MXU_Q16SLR   =E2=94=9C=
=E2=94=80 011 =E2=94=80 OPC_MXU_Q16SLLV
  *          =E2=94=82                            =E2=94=9C=E2=94=80 100 =
=E2=94=80 OPC_MXU_Q16SLRV
- *          =E2=94=82                            =E2=94=94=E2=94=80 101 =
=E2=94=80 OPC_MXU_Q16SARV
+ *          =E2=94=9C=E2=94=80 110110 =E2=94=80 OPC_MXU__POOL17 =E2=94=80=
=E2=94=B4=E2=94=80 101 =E2=94=80 OPC_MXU_Q16SARV
+ *          =E2=94=82
  *          =E2=94=9C=E2=94=80 110111 =E2=94=80 OPC_MXU_Q16SAR
  *          =E2=94=82                               23..22
- *          =E2=94=9C=E2=94=80 111000 =E2=94=80 OPC_MXU__POOL19 =E2=94=80=
=E2=94=AC=E2=94=80 00 =E2=94=80 OPC_MXU_Q8MUL
+ *          =E2=94=9C=E2=94=80 111000 =E2=94=80 OPC_MXU__POOL18 =E2=94=80=
=E2=94=AC=E2=94=80 00 =E2=94=80 OPC_MXU_Q8MUL
  *          =E2=94=82                            =E2=94=94=E2=94=80 01 =E2=
=94=80 OPC_MXU_Q8MULSU
  *          =E2=94=82
  *          =E2=94=82                               20..18
- *          =E2=94=9C=E2=94=80 111001 =E2=94=80 OPC_MXU__POOL20 =E2=94=80=
=E2=94=AC=E2=94=80 000 =E2=94=80 OPC_MXU_Q8MOVZ
+ *          =E2=94=9C=E2=94=80 111001 =E2=94=80 OPC_MXU__POOL19 =E2=94=80=
=E2=94=AC=E2=94=80 000 =E2=94=80 OPC_MXU_Q8MOVZ
  *          =E2=94=82                            =E2=94=9C=E2=94=80 001 =
=E2=94=80 OPC_MXU_Q8MOVN
  *          =E2=94=82                            =E2=94=9C=E2=94=80 010 =
=E2=94=80 OPC_MXU_D16MOVZ
  *          =E2=94=82                            =E2=94=9C=E2=94=80 011 =
=E2=94=80 OPC_MXU_D16MOVN
@@ -1644,13 +1630,13 @@ enum {
  *          =E2=94=82                            =E2=94=94=E2=94=80 101 =
=E2=94=80 OPC_MXU_S32MOV
  *          =E2=94=82
  *          =E2=94=82                               23..22
- *          =E2=94=9C=E2=94=80 111010 =E2=94=80 OPC_MXU__POOL21 =E2=94=80=
=E2=94=AC=E2=94=80 00 =E2=94=80 OPC_MXU_Q8MAC
+ *          =E2=94=9C=E2=94=80 111010 =E2=94=80 OPC_MXU__POOL20 =E2=94=80=
=E2=94=AC=E2=94=80 00 =E2=94=80 OPC_MXU_Q8MAC
  *          =E2=94=82                            =E2=94=94=E2=94=80 10 =E2=
=94=80 OPC_MXU_Q8MACSU
  *          =E2=94=9C=E2=94=80 111011 =E2=94=80 OPC_MXU_Q16SCOP
  *          =E2=94=9C=E2=94=80 111100 =E2=94=80 OPC_MXU_Q8MADL
  *          =E2=94=9C=E2=94=80 111101 =E2=94=80 OPC_MXU_S32SFL
  *          =E2=94=9C=E2=94=80 111110 =E2=94=80 OPC_MXU_Q8SAD
- *          =E2=94=94=E2=94=80 111111 =E2=94=80 <not assigned>
+ *          =E2=94=94=E2=94=80 111111 =E2=94=80 <not assigned>   (overla=
ps with SDBBP)
  *
  *
  *   Compiled after:
@@ -1673,22 +1659,22 @@ enum {
     OPC_MXU_D16MAC   =3D 0x0A,
     OPC_MXU_D16MACF  =3D 0x0B,
     OPC_MXU_D16MADL  =3D 0x0C,
-    OPC_MXU__POOL04  =3D 0x0D,
+    OPC_MXU_S16MAD   =3D 0x0D,
     OPC_MXU_Q16ADD   =3D 0x0E,
     OPC_MXU_D16MACE  =3D 0x0F,
-    OPC_MXU__POOL05  =3D 0x10,
-    OPC_MXU__POOL06  =3D 0x11,
-    OPC_MXU__POOL07  =3D 0x12,
-    OPC_MXU__POOL08  =3D 0x13,
-    OPC_MXU__POOL09  =3D 0x14,
-    OPC_MXU__POOL10  =3D 0x15,
-    OPC_MXU__POOL11  =3D 0x16,
-    OPC_MXU__POOL12  =3D 0x17,
+    OPC_MXU__POOL04  =3D 0x10,
+    OPC_MXU__POOL05  =3D 0x11,
+    OPC_MXU__POOL06  =3D 0x12,
+    OPC_MXU__POOL07  =3D 0x13,
+    OPC_MXU__POOL08  =3D 0x14,
+    OPC_MXU__POOL09  =3D 0x15,
+    OPC_MXU__POOL10  =3D 0x16,
+    OPC_MXU__POOL11  =3D 0x17,
     OPC_MXU_D32ADD   =3D 0x18,
-    OPC_MXU__POOL13  =3D 0x19,
+    OPC_MXU__POOL12  =3D 0x19,
     /* not assigned 0x1A */
-    OPC_MXU__POOL14  =3D 0x1B,
-    OPC_MXU__POOL15  =3D 0x1C,
+    OPC_MXU__POOL13  =3D 0x1B,
+    OPC_MXU__POOL14  =3D 0x1C,
     OPC_MXU_Q8ACCE   =3D 0x1D,
     /* not assigned 0x1E */
     /* not assigned 0x1F */
@@ -1698,8 +1684,8 @@ enum {
     OPC_MXU_S8STD    =3D 0x23,
     OPC_MXU_S8LDI    =3D 0x24,
     OPC_MXU_S8SDI    =3D 0x25,
-    OPC_MXU__POOL16  =3D 0x26,
-    OPC_MXU__POOL17  =3D 0x27,
+    OPC_MXU__POOL15  =3D 0x26,
+    OPC_MXU__POOL16  =3D 0x27,
     OPC_MXU_LXB      =3D 0x28,
     /* not assigned 0x29 */
     OPC_MXU_S16LDD   =3D 0x2A,
@@ -1714,11 +1700,11 @@ enum {
     OPC_MXU_D32SAR   =3D 0x33,
     OPC_MXU_Q16SLL   =3D 0x34,
     OPC_MXU_Q16SLR   =3D 0x35,
-    OPC_MXU__POOL18  =3D 0x36,
+    OPC_MXU__POOL17  =3D 0x36,
     OPC_MXU_Q16SAR   =3D 0x37,
-    OPC_MXU__POOL19  =3D 0x38,
-    OPC_MXU__POOL20  =3D 0x39,
-    OPC_MXU__POOL21  =3D 0x3A,
+    OPC_MXU__POOL18  =3D 0x38,
+    OPC_MXU__POOL19  =3D 0x39,
+    OPC_MXU__POOL20  =3D 0x3A,
     OPC_MXU_Q16SCOP  =3D 0x3B,
     OPC_MXU_Q8MADL   =3D 0x3C,
     OPC_MXU_S32SFL   =3D 0x3D,
@@ -1776,20 +1762,12 @@ enum {
  * MXU pool 04
  */
 enum {
-    OPC_MXU_S16MAD   =3D 0x00,
-    OPC_MXU_S16MAD_1 =3D 0x01,
-};
-
-/*
- * MXU pool 05
- */
-enum {
     OPC_MXU_S32LDD   =3D 0x00,
     OPC_MXU_S32LDDR  =3D 0x01,
 };
=20
 /*
- * MXU pool 06
+ * MXU pool 05
  */
 enum {
     OPC_MXU_S32STD   =3D 0x00,
@@ -1797,7 +1775,7 @@ enum {
 };
=20
 /*
- * MXU pool 07
+ * MXU pool 06
  */
 enum {
     OPC_MXU_S32LDDV  =3D 0x00,
@@ -1805,7 +1783,7 @@ enum {
 };
=20
 /*
- * MXU pool 08
+ * MXU pool 07
  */
 enum {
     OPC_MXU_S32STDV  =3D 0x00,
@@ -1813,7 +1791,7 @@ enum {
 };
=20
 /*
- * MXU pool 09
+ * MXU pool 08
  */
 enum {
     OPC_MXU_S32LDI   =3D 0x00,
@@ -1821,7 +1799,7 @@ enum {
 };
=20
 /*
- * MXU pool 10
+ * MXU pool 09
  */
 enum {
     OPC_MXU_S32SDI   =3D 0x00,
@@ -1829,7 +1807,7 @@ enum {
 };
=20
 /*
- * MXU pool 11
+ * MXU pool 10
  */
 enum {
     OPC_MXU_S32LDIV  =3D 0x00,
@@ -1837,7 +1815,7 @@ enum {
 };
=20
 /*
- * MXU pool 12
+ * MXU pool 11
  */
 enum {
     OPC_MXU_S32SDIV  =3D 0x00,
@@ -1845,7 +1823,7 @@ enum {
 };
=20
 /*
- * MXU pool 13
+ * MXU pool 12
  */
 enum {
     OPC_MXU_D32ACC   =3D 0x00,
@@ -1854,7 +1832,7 @@ enum {
 };
=20
 /*
- * MXU pool 14
+ * MXU pool 13
  */
 enum {
     OPC_MXU_Q16ACC   =3D 0x00,
@@ -1863,7 +1841,7 @@ enum {
 };
=20
 /*
- * MXU pool 15
+ * MXU pool 14
  */
 enum {
     OPC_MXU_Q8ADDE   =3D 0x00,
@@ -1872,7 +1850,7 @@ enum {
 };
=20
 /*
- * MXU pool 16
+ * MXU pool 15
  */
 enum {
     OPC_MXU_S32MUL   =3D 0x00,
@@ -1882,7 +1860,7 @@ enum {
 };
=20
 /*
- * MXU pool 17
+ * MXU pool 16
  */
 enum {
     OPC_MXU_D32SARW  =3D 0x00,
@@ -1896,7 +1874,7 @@ enum {
 };
=20
 /*
- * MXU pool 18
+ * MXU pool 17
  */
 enum {
     OPC_MXU_D32SLLV  =3D 0x00,
@@ -1908,7 +1886,7 @@ enum {
 };
=20
 /*
- * MXU pool 19
+ * MXU pool 18
  */
 enum {
     OPC_MXU_Q8MUL    =3D 0x00,
@@ -1916,7 +1894,7 @@ enum {
 };
=20
 /*
- * MXU pool 20
+ * MXU pool 19
  */
 enum {
     OPC_MXU_Q8MOVZ   =3D 0x00,
@@ -1928,7 +1906,7 @@ enum {
 };
=20
 /*
- * MXU pool 21
+ * MXU pool 20
  */
 enum {
     OPC_MXU_Q8MAC    =3D 0x00,
--=20
2.7.4
