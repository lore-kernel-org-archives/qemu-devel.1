Received: from eggs.gnu.org ([2001:4830:134:3::10]:40459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1duKSl-0006Xj-R2
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:29:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1duKSh-0006HZ-E7
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:29:27 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:37413)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1duKSh-0006H8-9w
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:29:23 -0400
Received: by mail-qt0-x244.google.com with SMTP id u48so2537885qtc.4
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 08:29:23 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170919142654.16369-1-david@redhat.com>
	<20170919142654.16369-3-david@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <cd288673-8b2a-c112-2cab-61347181f94c@amsat.org>
Date: Tue, 19 Sep 2017 12:29:18 -0300
MIME-Version: 1.0
In-Reply-To: <20170919142654.16369-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/3] s390x/tcg: move wrap_address() to
 internal.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>, Aurelien Jarno <aurelien@aurel32.net>

On 09/19/2017 11:26 AM, David Hildenbrand wrote:
> We want to use it in another file.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   target/s390x/internal.h   | 14 ++++++++++++++
>   target/s390x/mem_helper.c | 14 --------------
>   2 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/target/s390x/internal.h b/target/s390x/internal.h
> index bc8f83129a..70d2b87e55 100644
> --- a/target/s390x/internal.h
> +++ b/target/s390x/internal.h
> @@ -162,6 +162,20 @@ static inline uint8_t get_per_atmid(CPUS390XState *env)
>              ((env->psw.mask & PSW_ASC_ACCREG) ?    (1 << 2) : 0);
>   }
>   
> +static inline uint64_t wrap_address(CPUS390XState *env, uint64_t a)
> +{
> +    if (!(env->psw.mask & PSW_MASK_64)) {
> +        if (!(env->psw.mask & PSW_MASK_32)) {
> +            /* 24-Bit mode */
> +            a &= 0x00ffffff;
> +        } else {
> +            /* 31-Bit mode */
> +            a &= 0x7fffffff;
> +        }
> +    }
> +    return a;
> +}
> +
>   /* CC optimization */
>   
>   /* Instead of computing the condition codes after each x86 instruction,
> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index ec4760e390..a254613dc2 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -122,20 +122,6 @@ static inline void cpu_stsize_data_ra(CPUS390XState *env, uint64_t addr,
>       }
>   }
>   
> -static inline uint64_t wrap_address(CPUS390XState *env, uint64_t a)
> -{
> -    if (!(env->psw.mask & PSW_MASK_64)) {
> -        if (!(env->psw.mask & PSW_MASK_32)) {
> -            /* 24-Bit mode */
> -            a &= 0x00ffffff;
> -        } else {
> -            /* 31-Bit mode */
> -            a &= 0x7fffffff;
> -        }
> -    }
> -    return a;
> -}
> -
>   static void fast_memset(CPUS390XState *env, uint64_t dest, uint8_t byte,
>                           uint32_t l, uintptr_t ra)
>   {
> 
