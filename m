Received: from eggs.gnu.org ([2001:4830:134:3::10]:49466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1dT6JM-0004CS-K1
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 08:55:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1dT6JH-0001EO-Ov
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 08:55:12 -0400
Received: from outpost5.zedat.fu-berlin.de ([130.133.4.89]:39737)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <glaubitz@physik.fu-berlin.de>)
	id 1dT6JH-0001CC-IB
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 08:55:07 -0400
Date: Thu, 6 Jul 2017 14:55:02 +0200
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <20170706125502.GI23904@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: [Qemu-devel] [PATCH 05/11] linux-user/sh4: Notice gUSA regions
 during signal delivery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org

Le 06/07/2017 à 02:23, Richard Henderson a écrit :
> kernel also checks PC < gUSA region end point,
> try this:
>
> diff --git a/linux-user/signal.c b/linux-user/signal.c
> index 1e716a9..4e1e4f0 100644
> --- a/linux-user/signal.c
> +++ b/linux-user/signal.c
> @@ -3477,7 +3477,8 @@ static abi_ulong get_sigframe(struct
> target_sigaction *ka,
>  static void unwind_gusa(CPUSH4State *regs)
>  {
>      /* If the stack pointer is sufficiently negative... */
> -    if ((regs->gregs[15] & 0xc0000000u) == 0xc0000000u) {
> +    if ((regs->gregs[15] & 0xc0000000u) == 0xc0000000u &&
> +        regs->pc < regs->gregs[0]) {
>          /* Reset the PC to before the gUSA region, as computed from
>             R0 = region end, SP = -(region size), plus one more insn
>             that actually sets SP to the region size.  */

This fixes the segfaults for me with newer chroots.

So, just in case:

Tested-By: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Thanks,
Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
