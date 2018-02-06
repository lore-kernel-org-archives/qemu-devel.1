Received: from eggs.gnu.org ([2001:4830:134:3::10]:42297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1ej0H9-0002e7-BS
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 05:14:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1ej0H5-0004CN-8d
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 05:14:55 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35480)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1ej0H5-0004C7-1f
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 05:14:51 -0500
Received: by mail-wr0-f195.google.com with SMTP id w50so1276152wrc.2
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 02:14:50 -0800 (PST)
References: <20180206095603.26500.5959.stgit@pasha-VirtualBox>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <bf2aa02a-7f18-686c-4890-5c433f4b1acd@tuxfamily.org>
Date: Tue, 6 Feb 2018 11:14:47 +0100
MIME-Version: 1.0
In-Reply-To: <20180206095603.26500.5959.stgit@pasha-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] m68k: implement movep instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: dovgaluk@ispras.ru, laurent@vivier.eu

On 06.02.2018 10:56, Pavel Dovgalyuk wrote:
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
> ---
[...]
> @@ -5579,9 +5628,13 @@ void register_m68k_insns (CPUM68KState *env)
>      INSN(chk2,      00c0, f9c0, CHK2);
>      INSN(bitrev,    00c0, fff8, CF_ISA_APLUSC);
>      BASE(bitop_reg, 0100, f1c0);
> +    BASE(movep,     0108, f1f8);
>      BASE(bitop_reg, 0140, f1c0);
> +    BASE(movep,     0148, f1f8);
>      BASE(bitop_reg, 0180, f1c0);
> +    BASE(movep,     0188, f1f8);
>      BASE(bitop_reg, 01c0, f1c0);
> +    BASE(movep,     01c8, f1f8);
>      INSN(arith_im,  0280, fff8, CF_ISA_A);
>      INSN(arith_im,  0200, ff00, M68000);
>      INSN(undef,     02c0, ffc0, M68000);

 Hi,

movep is only available on 68000 - 68040. The function is illegal on
68060 and Coldfire. So I think you should introduce a M68K_FEATURE_MOVEP
for this and then register the function here with INSN(movep ... ,
MOVEP) instead of using BASE().

 Thomas
