Received: from eggs.gnu.org ([2001:4830:134:3::10]:49427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1cjpba-0001XS-67
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 10:58:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1cjpbW-0006yx-BV
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 10:58:54 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:34230)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1cjpbW-0006yq-3t
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 10:58:50 -0500
Received: by mail-lf0-x244.google.com with SMTP id y193so7087100lfd.1
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 07:58:49 -0800 (PST)
Date: Fri, 3 Mar 2017 16:58:47 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20170303155847.GY9606@toto>
References: <1488556233-31246-1-git-send-email-peter.maydell@linaro.org>
	<1488556233-31246-5-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488556233-31246-5-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH for-2.9 4/6] disas/microblaze: Avoid
 unintended sign extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <laurent@vivier.eu>

On Fri, Mar 03, 2017 at 03:50:31PM +0000, Peter Maydell wrote:
> In read_insn_microblaze() we assemble 4 bytes into an 'unsigned
> long'.  If 'unsigned long' is 64 bits and the high byte has its top
> bit set, then C's implicit conversion from 'unsigned char' to 'int'
> for the shift will result in an unintended sign extension which sets
> the top 32 bits in 'inst'.  Add casts to prevent this.  (Spotted by
> Coverity, CID 1005401.)

I'm OK with this but perhaps it would have been more readable to
change inst to uint32_t ? (All microblaze insns are 32bit).

Anyway:
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Thanks,
Edgar


> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  disas/microblaze.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/disas/microblaze.c b/disas/microblaze.c
> index 91b30ac..407c0a3 100644
> --- a/disas/microblaze.c
> +++ b/disas/microblaze.c
> @@ -748,9 +748,11 @@ read_insn_microblaze (bfd_vma memaddr,
>      }
>  
>    if (info->endian == BFD_ENDIAN_BIG)
> -    inst = (ibytes[0] << 24) | (ibytes[1] << 16) | (ibytes[2] << 8) | ibytes[3];
> +    inst = ((unsigned)ibytes[0] << 24) | (ibytes[1] << 16)
> +      | (ibytes[2] << 8) | ibytes[3];
>    else if (info->endian == BFD_ENDIAN_LITTLE)
> -    inst = (ibytes[3] << 24) | (ibytes[2] << 16) | (ibytes[1] << 8) | ibytes[0];
> +    inst = ((unsigned)ibytes[3] << 24) | (ibytes[2] << 16)
> +      | (ibytes[1] << 8) | ibytes[0];
>    else
>      abort ();
>  
> -- 
> 2.7.4
> 
