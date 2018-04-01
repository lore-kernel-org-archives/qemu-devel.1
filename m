Received: from eggs.gnu.org ([2001:4830:134:3::10]:59093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alexandro@phi.nz>) id 1f2imF-0004kQ-P7
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 15:36:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alexandro@phi.nz>) id 1f2imC-0004qW-K4
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 15:36:31 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:51753)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alexandro@phi.nz>) id 1f2imC-0004oN-Cd
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 15:36:28 -0400
From: "Alexandro Sanchez Bach" <alexandro@phi.nz>
Date: Sun, 1 Apr 2018 21:36:22 +0200
Message-ID: <000901d3c9f0$b7c08d60$2741a820$@phi.nz>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_000A_01D3CA01.7B498470"
Content-Language: en-us
Subject: [Qemu-devel] [PATCH] target/i386: Fix andn instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: 'Paolo Bonzini' <pbonzini@redhat.com>

This is a multipart message in MIME format.

------=_NextPart_000_000A_01D3CA01.7B498470
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

In commit 7073fbada733c8d10992f00772c9b9299d740e9b, the `andn` instruction
was implemented via `tcg_gen_andc` but passes the operands in the wrong
order:
- X86 defines `andn dest,src1,src2` as: dest = ~src1 & src2
- TCG defines `andc dest,src1,src2` as: dest = src1 & ~src2
 
I have also attached a simple test which shows the issue:

> user@ubuntu:~/Software$ ./a.out 
> 0000F000
> user@ubuntu:~/Software$ qemu/x86_64-linux-user/qemu-x86_64 -cpu max a.out 
> 0000000F

This patch fixes the problem by simply swapping the order of the two last
arguments in `tcg_gen_andc_tl`.

Signed-off-by: Alexandro Sanchez Bach <alexandro@phi.nz>
Cc: qemu-stable@nongnu.org
Reported-by: Alexandro Sanchez Bach <alexandro@phi.nz>
diff --git a/target/i386/translate.c b/target/i386/translate.c
index 0135415d92..3b7ce9232e 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -3802,7 +3802,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s,
int b,
                 }
                 ot = mo_64_32(s->dflag);
                 gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
-                tcg_gen_andc_tl(cpu_T0, cpu_regs[s->vex_v], cpu_T0);
+                tcg_gen_andc_tl(cpu_T0, cpu_T0, cpu_regs[s->vex_v]);
                 gen_op_mov_reg_v(ot, reg, cpu_T0);
                 gen_op_update1_cc();
                 set_cc_op(s, CC_OP_LOGICB + ot);


------=_NextPart_000_000A_01D3CA01.7B498470
Content-Type: text/plain;
	name="test-andn.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="test-andn.c"

#include <stdio.h>=0A=
#include <stdint.h>=0A=
 =0A=
int main(void) {=0A=
    uint32_t ret =3D 0;=0A=
    __asm (=0A=
        "mov $0xFF00, %%ecx\n"=0A=
        "mov $0x0F0F, %%eax\n"=0A=
        "andn %%ecx, %%eax, %%ecx\n"=0A=
        "mov %%ecx, %0\n"=0A=
      : "=3Dr" (ret));=0A=
    printf("%08X\n", ret);=0A=
    return 0;=0A=
}=0A=
=0A=

------=_NextPart_000_000A_01D3CA01.7B498470--
