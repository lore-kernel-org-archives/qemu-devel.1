Received: from eggs.gnu.org ([2001:4830:134:3::10]:48381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDCEO-0004lW-Qz
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 13:37:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDCEL-000760-JA
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 13:37:08 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gDCEL-00072z-BA
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 13:37:05 -0400
Received: by mail-wm1-f67.google.com with SMTP id y144-v6so1138861wmd.4
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 10:37:05 -0700 (PDT)
References: <1539845066-31635-1-git-send-email-dayeol@berkeley.edu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <528ec11f-c043-9e97-3de9-73d8f7f16bdf@redhat.com>
Date: Thu, 18 Oct 2018 19:37:02 +0200
MIME-Version: 1.0
In-Reply-To: <1539845066-31635-1-git-send-email-dayeol@berkeley.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Dayeol Lee <dayeol@berkeley.edu>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>

Hi Lee,

On 18/10/2018 08:44, Dayeol Lee wrote:
> There is a data type demotion bug in target/riscv/pmp.c
> When the target_ulong is 8 bytes, pmpcfg_csr_read returns only lower 4
> bytes.
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

Casting 'val' seems correct, however you don't need to cast the 'i'.

Also you can remove the external parenthesis.

>      }
>  
>      PMP_DEBUG("hart " TARGET_FMT_ld ": reg%d, val: 0x" TARGET_FMT_lx,
> 

Regards,

Phil.
