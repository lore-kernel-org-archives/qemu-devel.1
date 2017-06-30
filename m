Received: from eggs.gnu.org ([2001:4830:134:3::10]:52618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dQpSc-0007ru-Az
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 02:31:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dQpSZ-0000TZ-7s
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 02:31:22 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:33893)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dQpSZ-0000Sy-2Y
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 02:31:19 -0400
Received: by mail-qk0-x243.google.com with SMTP id 91so14370484qkq.1
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 23:31:18 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1498768109-4092-1-git-send-email-cota@braap.org>
	<1498768109-4092-3-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <ad8b61e4-ecdd-9bb9-1d86-6ca628040225@twiddle.net>
Date: Thu, 29 Jun 2017 23:31:15 -0700
MIME-Version: 1.0
In-Reply-To: <1498768109-4092-3-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 2/7] translate-all: add out_size field to
 TranslationBlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 06/29/2017 01:28 PM, Emilio G. Cota wrote:
> Note that due to the cacheline padding we are using, for
> hosts with 64-byte cache lines this will not waste any
> additional memory. Using a s16 would be ideal, since that
> would plug an existing hole in the struct, but I see no
> guarantee that a TB won't overflow it.
> 
> Signed-off-by: Emilio G. Cota<cota@braap.org>
> ---
>   include/exec/exec-all.h   |  1 +
>   accel/tcg/translate-all.c | 16 ++++++++--------
>   2 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index 35a75f1..df12338 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -363,6 +363,7 @@ struct TranslationBlock {
>        */
>       uintptr_t jmp_list_next[2];
>       uintptr_t jmp_list_first;
> +    int32_t out_size; /* size of host code for this block */

unsigned probably better.

I do wonder about putting it in the hole after invalid.
Which itself could be shrunk to bool.

I don't believe there's much chance of an overflow of uint16_t.  The limit of 
OPC_BUF_SIZE = 640 fairly well limits the practical size.  And, honestly, it 
doesn't matter if we saturate to 0xffff, so long as you retain the full-size 
gen_code_size local variable.


r~
