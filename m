Received: from eggs.gnu.org ([2001:4830:134:3::10]:45829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gDC6d-0003PF-9A
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 13:29:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gDC6a-0002Y2-0q
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 13:29:07 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:42592)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gDC6Z-0002W4-Il
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 13:29:03 -0400
Received: by mail-pl1-x641.google.com with SMTP id c8-v6so14604249plo.9
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 10:29:03 -0700 (PDT)
Date: Thu, 18 Oct 2018 10:29:01 -0700 (PDT)
In-Reply-To: <1539845066-31635-1-git-send-email-dayeol@berkeley.edu>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-e4efcda9-fcf0-4cee-9ed0-8d40cd93f874@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] [PATCH] target/riscv/pmp.c:
 pmpcfg_csr_read return type demotion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, dayeol@berkeley.edu, Michael Clark <mjc@sifive.com>, sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de

On Wed, 17 Oct 2018 23:44:26 PDT (-0700), dayeol@berkeley.edu wrote:
> There is a data type demotion bug in target/riscv/pmp.c
> When the target_ulong is 8 bytes, pmpcfg_csr_read returns only lower 4
> bytes.

This is missing at least the first requirement from 
https://wiki.qemu.org/Contribute/SubmitAPatch -- that's as far as I checked :).  
I can't take this one, please submit a v2.

> ---
>  target/riscv/pmp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index c828950..4b6c20e 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -337,7 +337,7 @@ target_ulong pmpcfg_csr_read(CPURISCVState *env, uint32_t reg_index)
>
>      for (i = 0; i < sizeof(target_ulong); i++) {
>          val = pmp_read_cfg(env, (reg_index * sizeof(target_ulong)) + i);
> -        cfg_val |= (val << (i * 8));
> +        cfg_val |= ((target_ulong)val << ((target_ulong)i * 8));
>      }
>
>      PMP_DEBUG("hart " TARGET_FMT_ld ": reg%d, val: 0x" TARGET_FMT_lx,

I believe this is correct: pmp_read_cfg() gives us the 8-bit PMP value, which 
then needs to be mixed together to form a single CSR value.  The default 
promotion rules will result in an integer here ("i*8" is integer, which flows 
through) resulting in a 32-bit signed value on most hosts.  That's obviously 
bogus on RV64I, with the high bits of the CSR being wrong.

Aside from the metadata

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

Thanks!
