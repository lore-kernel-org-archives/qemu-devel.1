Received: from eggs.gnu.org ([2001:4830:134:3::10]:46041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEH5C-00016O-Ks
	for qemu-devel@nongnu.org; Fri, 26 May 2017 11:23:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEH5B-0000sV-EN
	for qemu-devel@nongnu.org; Fri, 26 May 2017 11:23:18 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:36352)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dEH5B-0000sD-9h
	for qemu-devel@nongnu.org; Fri, 26 May 2017 11:23:17 -0400
Received: by mail-qt0-x241.google.com with SMTP id j13so1673569qta.3
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 08:23:17 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170525210508.4910-1-aurelien@aurel32.net>
	<20170525210508.4910-16-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <1e6ecda9-cecd-bc08-8a01-5a20798b6acb@twiddle.net>
Date: Fri, 26 May 2017 08:23:13 -0700
MIME-Version: 1.0
In-Reply-To: <20170525210508.4910-16-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 15/26] target/s390x: fix COMPARE LOGICAL
 LONG EXTENDED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>

On 05/25/2017 02:04 PM, Aurelien Jarno wrote:
> There are multiple issues with the COMPARE LOGICAL LONG EXTENDED
> instruction:
> - The test between the two operands is inverted, leading to an inversion
>    of the cc values 1 and 2.
> - The address and length of an operand continue to be decreased after
>    reaching the end of this operand. These values are then wrong write
>    back to the registers.
> - We should limit the amount of bytes to process, so that interrupts can
>    be served correctly.
> 
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> ---
>   target/s390x/mem_helper.c | 36 ++++++++++++++++++++++++++++--------
>   1 file changed, 28 insertions(+), 8 deletions(-)
> 
> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index 1dc71fe5f0..bd3bce3623 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -716,28 +716,48 @@ uint32_t HELPER(clcle)(CPUS390XState *env, uint32_t r1, uint64_t a2,
>       uint64_t srclen = get_length(env, r3 + 1);
>       uint64_t src = get_address(env, r3);
>       uint8_t pad = a2 & 0xff;
> +    uint64_t len = MAX(srclen, destlen);
>       uint32_t cc = 0;
>   
>       if (!(destlen || srclen)) {

Might as well replace this with len == 0 now.

>           if (v1 != v2) {
> -            cc = (v1 < v2) ? 1 : 2;
> +            cc = (v1 > v2) ? 1 : 2;

This would have been less confusing, perhaps, if we'd not used "src" and "dest" 
-- and doubly so since they are two sources -- but rather "src1" and "src3", 
which corresponds better to the PoO text.

That said,

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
