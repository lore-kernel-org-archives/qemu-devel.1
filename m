Received: from eggs.gnu.org ([2001:4830:134:3::10]:57863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dwTFa-0004df-4e
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:16:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dwTFV-0001re-3k
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:16:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dwTFU-0001rG-TE
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:16:37 -0400
References: <20170918160012.4317-1-david@redhat.com>
	<20170918160012.4317-7-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <1551a7b0-de0b-ab57-0ac7-1d0cb9eed6af@redhat.com>
Date: Mon, 25 Sep 2017 15:16:31 +0200
MIME-Version: 1.0
In-Reply-To: <20170918160012.4317-7-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 06/27] s390x/tcg: injection of emergency
 signals and extarnal calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>


> @@ -248,6 +249,19 @@ static void do_ext_interrupt(CPUS390XState *env)
>          lowcore->ext_int_code = cpu_to_be16(EXT_CPU_TIMER);
>          lowcore->cpu_addr = 0;
>          env->pending_int &= ~INTERRUPT_EXT_CPU_TIMER;
> +    } else if (env->pending_int & INTERRUPT_EMERGENCY_SIGNAL) {
> +        lowcore->ext_int_code = cpu_to_be16(EXT_EMERGENCY);
> +        cpu_addr = find_first_bit(env->emergency_signals, S390_MAX_CPUS);
> +        g_assert(cpu_addr < S390_MAX_CPUS);
> +        lowcore->cpu_addr = cpu_to_be16(cpu_addr);
> +        clear_bit(cpu_addr, env->emergency_signals);
> +        if (bitmap_empty(env->emergency_signals, max_cpus)) {
> +            env->pending_int &= ~INTERRUPT_EMERGENCY_SIGNAL;
> +        }
> +    } else if (env->pending_int & INTERRUPT_EXTERNAL_CALL) {
> +        lowcore->ext_int_code = cpu_to_be16(EXT_EXTERNAL_CALL);
> +        lowcore->cpu_addr = cpu_to_be16(env->external_call_addr);
> +        env->pending_int &= ~INTERRUPT_EXTERNAL_CALL;

The priority of the interrupts is still wrong and we don't check for the
subclass-mask bits. Will fix this.

-- 

Thanks,

David
