Received: from eggs.gnu.org ([2001:4830:134:3::10]:41713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eK6wG-0008Em-6g
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 13:18:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eK6wB-0007uX-8D
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 13:18:28 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:42008)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eK6wB-0007tT-0g
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 13:18:23 -0500
Received: by mail-wm0-x243.google.com with SMTP id l141so8216314wmg.1
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 10:18:22 -0800 (PST)
References: <20171128203326.6062-1-david@redhat.com>
	<20171128203326.6062-15-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5b0cb24c-a92e-1109-8b3c-de76389f93dd@linaro.org>
Date: Wed, 29 Nov 2017 18:18:19 +0000
MIME-Version: 1.0
In-Reply-To: <20171128203326.6062-15-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.12 14/15] s390x/tcg: drop
 program_interrupt()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>

On 11/28/2017 08:33 PM, David Hildenbrand wrote:
> -void program_interrupt(CPUS390XState *env, uint32_t code, int ilen)
> +void program_interrupt_ra(CPUS390XState *env, uint32_t code, int ilen,
> +                          uintptr_t ra)
>  {
>      S390CPU *cpu = s390_env_get_cpu(env);
>  
>      qemu_log_mask(CPU_LOG_INT, "program interrupt at %#" PRIx64 "\n",
>                    env->psw.addr);
>  
> +#ifdef CONFIG_TCG
> +    if (tcg_enabled() && ra) {
> +        cpu_restore_state(CPU(cpu), ra);
> +    }
> +#endif

Please move this into tcg_s390_program_interrupt by using cpu_loop_exit_restore
there.


r~
