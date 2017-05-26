Received: from eggs.gnu.org ([2001:4830:134:3::10]:49979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEHEX-0007A3-SH
	for qemu-devel@nongnu.org; Fri, 26 May 2017 11:32:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEHEX-0005gx-0B
	for qemu-devel@nongnu.org; Fri, 26 May 2017 11:32:57 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:36368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dEHEW-0005gr-RQ
	for qemu-devel@nongnu.org; Fri, 26 May 2017 11:32:56 -0400
Received: by mail-qt0-x241.google.com with SMTP id j13so1708977qta.3
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 08:32:56 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170525210508.4910-1-aurelien@aurel32.net>
	<20170525210508.4910-17-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <4c5d7238-d681-61a6-f793-0c8929b85ce0@twiddle.net>
Date: Fri, 26 May 2017 08:32:53 -0700
MIME-Version: 1.0
In-Reply-To: <20170525210508.4910-17-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 16/26] target/s390x: implement COMPARE
 LOGICAL LONG
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
> -        if (srclen) {
> -            v1 = cpu_ldub_data_ra(env, src, ra);
> +        if (*srclen) {
> +            v1 = cpu_ldub_data_ra(env, *src, ra);
>           }
> -        if (destlen) {
> -            v2 = cpu_ldub_data_ra(env, dest, ra);
> +        if (*destlen) {
> +            v2 = cpu_ldub_data_ra(env, *dest, ra);
>           }
>   
>           if (v1 != v2) {
> @@ -746,16 +743,55 @@ uint32_t HELPER(clcle)(CPUS390XState *env, uint32_t r1, uint64_t a2,
>               break;
>           }
>   
> -        if (srclen) {
> -            src++;
> -            srclen--;
> +        if (*srclen) {
> +            *src += 1;
> +            *srclen -= 1;
>           }
> -        if (destlen) {
> -            dest++;
> -            destlen--;
> +        if (*destlen) {
> +            *dest += 1;
> +            *destlen -= 1;
>           }
>       }

If you don't access these as pointers in the inner loop like this, the compiler 
will give you better code without needing to force the function to be inlined.

Naming convention comment still applies.

Otherwise,
Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
