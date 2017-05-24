Received: from eggs.gnu.org ([2001:4830:134:3::10]:50287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDe69-0004KN-BQ
	for qemu-devel@nongnu.org; Wed, 24 May 2017 17:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDe68-0003xF-Gk
	for qemu-devel@nongnu.org; Wed, 24 May 2017 17:45:41 -0400
Received: from mail-qk0-x235.google.com ([2607:f8b0:400d:c09::235]:33919)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dDe68-0003x9-AZ
	for qemu-devel@nongnu.org; Wed, 24 May 2017 17:45:40 -0400
Received: by mail-qk0-x235.google.com with SMTP id k74so165088343qke.1
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 14:45:39 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170523030312.6360-1-rth@twiddle.net>
	<20170523030312.6360-3-rth@twiddle.net>
	<20170523104851.37tseiq5zlpwevr6@aurel32.net>
	<d059a3b3-ac6c-27d2-5270-b6d5b32cc41d@twiddle.net>
	<20170523172858.aqvgqlrwrwu6jk2o@aurel32.net>
	<d9b3afcc-2def-ee43-9865-ab82c3361b3c@twiddle.net>
	<20170524175409.oi5vzjvvpp3hcsfj@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <7f8643b2-5bcf-fc65-e111-d885d958f340@twiddle.net>
Date: Wed, 24 May 2017 14:45:35 -0700
MIME-Version: 1.0
In-Reply-To: <20170524175409.oi5vzjvvpp3hcsfj@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/31] target/s390x: Implement EXECUTE via
 new TranslationBlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: qemu-devel@nongnu.org

On 05/24/2017 10:54 AM, Aurelien Jarno wrote:
> It seems the problem arise if an interrupt happens when the TB
> containing the EXECUTE instruction is being executed. In that case at
> the end of the TB, the interruption code is translated with the ex_value
> set, which means with the wrong PC, wrong permissions and wrong return
> address.
> 
> This is the same kind of issue I identified on SH4 recently:
> https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg03880.html
> 
> The same king of solution also works, that is disabling the interrupts
> when the ex_value is set:
> 
> diff --git a/target/s390x/helper.c b/target/s390x/helper.c
> index 6f81b1a16c..a33abdef16 100644
> --- a/target/s390x/helper.c
> +++ b/target/s390x/helper.c
> @@ -655,6 +657,10 @@ bool s390_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>           S390CPU *cpu = S390_CPU(cs);
>           CPUS390XState *env = &cpu->env;
>   
> +        if (env->ex_value) {
> +            return false;
> +        }
> +
>           if (env->psw.mask & PSW_MASK_EXT) {
>               s390_cpu_do_interrupt(cs);
>               return true;
> 

Thanks for the research.  I've incorporated this into my patch set.


r~
