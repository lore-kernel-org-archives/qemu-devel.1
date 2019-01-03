Received: from eggs.gnu.org ([208.118.235.92]:56140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gf4Sd-0006Py-EC
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 09:59:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gf4Sc-0005AT-FJ
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 09:59:03 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
	<2175cdb6-bc52-5c0a-f767-23a08ae4384f@ilande.co.uk>
Message-ID: <0bad51a5-21ab-d613-44f2-b6b7f7d4e688@ilande.co.uk>
Date: Thu, 3 Jan 2019 14:58:37 +0000
MIME-Version: 1.0
In-Reply-To: <2175cdb6-bc52-5c0a-f767-23a08ae4384f@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 00/34] tcg, target/ppc vector improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 18/12/2018 09:49, Mark Cave-Ayland wrote:

> Following on from this, the next patch "target/ppc: convert vsplt[bhw] to use vector
> operations" causes corruption of the OS X splash screen
> (https://www.ilande.co.uk/tmp/qemu/badapple2.png) in a way that suggests there may be
> an endian issue.

After some more digging I've found out what's going on here by dumping out the AVR
registers before and after:

Before the patch:

BEFORE:
uimm: 0  size: 2
sreg: 99 @ 0x7f54fd7157a0 - 1 6a 1 d9 1 15 fd 63 0 0 0 0 0 0 0 0
dreg: 99 @ 0x7f54fd715870 - 7f ff de ad 7f ff de ad 7f ff de ad 7f ff de ad
AFTER:
dreg: 99 @ 0x7f54fd715870 - 1 6a 1 6a 1 6a 1 6a 1 6a 1 6a 1 6a 1 6a

BEFORE:
uimm: 1  size: 2
sreg: 99 @ 0x7f54fd7157a0 - 1 6a 1 d9 1 15 fd 63 0 0 0 0 0 0 0 0
dreg: 99 @ 0x7f54fd715870 - 1 6a 1 6a 1 6a 1 6a 1 6a 1 6a 1 6a 1 6a
AFTER:
dreg: 99 @ 0x7f54fd715870 - 1 d9 1 d9 1 d9 1 d9 1 d9 1 d9 1 d9 1 d9


After the patch:

BEFORE:
uimm: 0  size: 2
sreg: 5 @ 0x7fe5a0c4a7a0 - 1 6a 1 d9 1 15 fd 63 0 0 0 0 0 0 0 0
dreg: 18 @ 0x7fe5a0c4a870 - 7f ff de ad 7f ff de ad 7f ff de ad 7f ff de ad
AFTER:
dreg: 18 @ 0x7fe5a0c4a870 - 5d 1 5d 1 5d 1 5d 1 5d 1 5d 1 5d 1 5d 1

BEFORE:
uimm: 1  size: 2
sreg: 5 @ 0x7fe5a0c4a7a0 - 1 6a 1 d9 1 15 fd 63 0 0 0 0 0 0 0 0
dreg: 18 @ 0x7fe5a0c4a870 - 5d 1 5d 1 5d 1 5d 1 5d 1 5d 1 5d 1 5d 1
AFTER:
dreg: 18 @ 0x7fe5a0c4a870 - 6a 1 6a 1 6a 1 6a 1 6a 1 6a 1 6a 1 6a 1


As you can see vsplth splat is one byte off with this patch applied and the cause is
the xor in the #ifndef HOST_WORDS_BIGENDIAN block: before the xor is applied, bofs is
aligned to 2 bytes and with bofs ^ 15 the LSB is set to 1 again, introducing the 1
byte error.

Applying the following patch to mask bofs based upon the size of vece seems to fix
the issue here for me on little-endian Intel:

diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index 59d3bc6e02..41ddbd879f 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -815,6 +815,7 @@ static void gen_vsplt(DisasContext *ctx, int vece)
     bofs += (uimm << vece) & 15;
 #ifndef HOST_WORDS_BIGENDIAN
     bofs ^= 15;
+    bofs &= ~((1 << vece) - 1);
 #endif

     tcg_gen_gvec_dup_mem(vece, dofs, bofs, 16, 16);


ATB,

Mark.
