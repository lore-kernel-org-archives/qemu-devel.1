Received: from eggs.gnu.org ([2001:4830:134:3::10]:43546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ej25K-00034h-N6
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 07:10:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ej25F-0000R9-OX
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 07:10:50 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:52793)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ej25F-0000Qp-F8
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 07:10:45 -0500
References: <20180206114343.13816.78250.stgit@pasha-VirtualBox>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <dc1539ef-12c5-3c60-6655-7b7a587607ad@vivier.eu>
Date: Tue, 6 Feb 2018 13:10:40 +0100
MIME-Version: 1.0
In-Reply-To: <20180206114343.13816.78250.stgit@pasha-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3] m68k: implement movep instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: huth@tuxfamily.org, dovgaluk@ispras.ru

Le 06/02/2018 à 12:43, Pavel Dovgalyuk a écrit :
> This patch implements movep instruction. It moves data between a data register
> and alternate bytes within the address space starting at the location
> specified and incrementing by two.
> 
> It was designed for the original 68000 and used in firmwares for
> interfacing the 8-bit peripherals through the 16-bit data bus.
> Without this patch opcode for this instruction is recognized as some bitop.
> 
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
> 
> --
> 
> v3: - simplified movep function code
>     - joined movep masks
> 
> v2: - disabled movep for Coldfire
>     - fixed gen_store/load usage
> ---
>  target/m68k/cpu.c       |    2 ++
>  target/m68k/cpu.h       |    1 +
>  target/m68k/translate.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 49 insertions(+)
...
> +    if (insn & 0x40) {
> +        i = 4;
> +    } else {
> +        i = 2;
> +    }
> +
> +    if (insn & 0x80) {
> +        for ( ; i > 0 ; i--) {
> +            tcg_gen_shri_i32(dbuf, reg, (i - 1) * 8);
> +            tcg_gen_qemu_st8(dbuf, abuf, IS_USER(s));
> +            if (i > 1) {
> +                tcg_gen_addi_i32(abuf, abuf, 2);
> +            }
> +        }
> +    } else {
> +        for ( ; i > 0 ; i--) {
> +            tcg_gen_qemu_ld8u(dbuf, abuf, IS_USER(s));
> +            tcg_gen_deposit_i32(reg, reg, dbuf, i * 8, 8);

it should be (i - 1).

Thanks,
Laurent
