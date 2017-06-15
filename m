Received: from eggs.gnu.org ([2001:4830:134:3::10]:52380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dLJGw-0005ns-4u
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 21:08:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dLJGs-0005IA-VT
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 21:08:30 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:33632)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dLJGs-0005He-RF
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 21:08:26 -0400
Received: by mail-ot0-x242.google.com with SMTP id k4so18652otd.0
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 18:08:26 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170614203905.19657-1-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <ea505b9e-5234-04b0-d844-0213f60c5ea3@twiddle.net>
Date: Wed, 14 Jun 2017 18:08:22 -0700
MIME-Version: 1.0
In-Reply-To: <20170614203905.19657-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/m68k: fix V flag for CC_OP_SUBx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org

On 06/14/2017 01:39 PM, Laurent Vivier wrote:
> V flag for subtraction is:
> 
>     v = (res ^ src1) & (src1 ^ src2)
> 
> (see COMPUTE_CCR() in target/m68k/helper.c)
> 
> But gen_flush_flags() uses:
> 
>     v = (res ^ src2) & (src1 ^ src2)
> 
> The problem has been found with the following program:
> 
>          .global _start
> _start:
>          move.l  #-2147483648,%d0
>          subq.l  #1,%d0
>          jvc     1f
>          move.l #1,%d1
>          move.l #1,%d0
>          trap #0
> 1:
>          move.l #0,%d1
>          move.l #1,%d0
>          trap #0
> 
> It works fine (exit(1)) on real hardware, and with "-singlestep".
> 
> "-singlestep" uses gen_helper_flush_flags(), whereas
> without "-singlestep", V flag is computed directly in
> gen_flush_flags().
> 
> This patch updates gen_flush_flags() to have the same result
> as with gen_helper_flush_flags().
> 
> Signed-off-by: Laurent Vivier<laurent@vivier.eu>
> ---
>   target/m68k/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
