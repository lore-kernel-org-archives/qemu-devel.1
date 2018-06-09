Received: from eggs.gnu.org ([2001:4830:134:3::10]:43572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fRceL-00032X-E6
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 08:07:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fRceI-0007rf-91
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 08:07:17 -0400
Date: Sat, 9 Jun 2018 14:07:11 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <alpine.BSF.2.21.1806021437320.49196@zero.eik.bme.hu>
Message-ID: <alpine.BSF.2.21.1806091401570.68275@zero.eik.bme.hu>
References: <alpine.BSF.2.21.1806021437320.49196@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [Qemu-ppc] icbt on PPC440 after commit 01662f3e
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org

On Sat, 2 Jun 2018, BALATON Zoltan wrote:
> I get an invalid instruction exception for the icbt instruction on the 
> sam460ex machine (PPC440 core 460EX CPU) but I think this should not raise 
> exception as it's valid on BookE that this CPU should support. Commit 
> 01662f3e PPC: Implement e500 (FSL) MMU has introduced an extended instruction 
> type (type2) in PPC opcodes and changed taget/ppc/translate_init.c as:
>
> @@ -9437,7 +9492,8 @@ static int create_ppc_opcodes (CPUPPCState *env, const 
> ppc_def_t *def)
>
>     fill_new_table(env->opcodes, 0x40);
>     for (opc = opcodes; opc < &opcodes[ARRAY_SIZE(opcodes)]; opc++) {
> -        if ((opc->handler.type & def->insns_flags) != 0) {
> +        if (((opc->handler.type & def->insns_flags) != 0) ||
> +            ((opc->handler.type2 & def->insns_flags2) != 0)) {
>             if (register_insn(env->opcodes, opc) < 0) {
>                 printf("*** ERROR initializing PowerPC instruction "
>                        "0x%02x 0x%02x 0x%02x\n", opc->opc1, opc->opc2,
>
>
> it also made this change in target/ppc/translate.c:
>
> -GEN_HANDLER(mbar, 0x1F, 0x16, 0x1a, 0x001FF801, PPC_BOOKE),
> -GEN_HANDLER(msync, 0x1F, 0x16, 0x12, 0x03FFF801, PPC_BOOKE),
> -GEN_HANDLER2(icbt_440, "icbt", 0x1F, 0x16, 0x00, 0x03E00001, PPC_BOOKE),
> +GEN_HANDLER_E(mbar, 0x1F, 0x16, 0x1a, 0x001FF801,
> +              PPC_BOOKE, PPC2_BOOKE206),
> +GEN_HANDLER_E(msync, 0x1F, 0x16, 0x12, 0x03FFF801,
> +              PPC_BOOKE, PPC2_BOOKE206),
> +GEN_HANDLER2_E(icbt_440, "icbt", 0x1F, 0x16, 0x00, 0x03E00001,
> +               PPC_BOOKE, PPC2_BOOKE206),
>
> If I revert this change to icbt_440 it works without exception but according 
> to the above it should also work for either type == BOOKE _or_ type2 == 
> BOOKE206 but I still get exception in that case. Any idea why is this not 
> working as expected?

This has gone for a while but then happened again and this time I've found 
that icbt seems to have two opcodes on PPC440 and got invalid instruction 
exception for 7c063a0c (1f-06-08-06) now. Not sure why I got it for other 
opcode or I was decoding it wrong that time but the problem I saw now 
could be fixed by

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index b28e8b9..40bc02d 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6699,6 +6699,8 @@ GEN_HANDLER_E(mbar, 0x1F, 0x16, 0x1a, 0x001FF801,
  GEN_HANDLER(msync_4xx, 0x1F, 0x16, 0x12, 0x03FFF801, PPC_BOOKE),
  GEN_HANDLER2_E(icbt_440, "icbt", 0x1F, 0x16, 0x00, 0x03E00001,
                 PPC_BOOKE, PPC2_BOOKE206),
+GEN_HANDLER2(icbt_440, "icbt", 0x1F, 0x06, 0x08, 0x03E00001,
+               PPC_440_SPEC),
  GEN_HANDLER(lvsl, 0x1f, 0x06, 0x00, 0x00000001, PPC_ALTIVEC),
  GEN_HANDLER(lvsr, 0x1f, 0x06, 0x01, 0x00000001, PPC_ALTIVEC),
  GEN_HANDLER(mfvscr, 0x04, 0x2, 0x18, 0x001ff800, PPC_ALTIVEC),

Can anyone confirm that's correct? If so I'll include in my next series.

Regards,
BALATON Zoltan
