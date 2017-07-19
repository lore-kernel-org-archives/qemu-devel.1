Received: from eggs.gnu.org ([2001:4830:134:3::10]:47689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXtLv-0004qJ-1G
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 14:05:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXtLr-0003O4-TE
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 14:05:39 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:36839)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXtLr-0003Nq-Mq
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 14:05:35 -0400
Received: by mail-qt0-x244.google.com with SMTP id l55so1131152qtl.3
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 11:05:35 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500468850-15571-1-git-send-email-thuth@redhat.com>
	<1500468850-15571-2-git-send-email-thuth@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <e7c0777c-dcf4-5bff-408d-83ef516d4260@twiddle.net>
Date: Wed, 19 Jul 2017 08:05:26 -1000
MIME-Version: 1.0
In-Reply-To: <1500468850-15571-2-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/5] target/s390x: Move program_interrupt()
 & trigger_pgm_exception() to interrupt.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On 07/19/2017 02:54 AM, Thomas Huth wrote:
> +void program_interrupt(CPUS390XState *env, uint32_t code, int ilen)
> +{
> +    S390CPU *cpu = s390_env_get_cpu(env);
> +
> +    qemu_log_mask(CPU_LOG_INT, "program interrupt at %#" PRIx64 "\n",
> +                  env->psw.addr);
> +
> +    if (kvm_enabled()) {
> +#ifdef CONFIG_KVM
> +        struct kvm_s390_irq irq = {
> +            .type = KVM_S390_PROGRAM_INT,
> +            .u.pgm.code = code,
> +        };
> +
> +        kvm_s390_vcpu_interrupt(cpu, &irq);
> +#endif
> +    } else {
> +        trigger_pgm_exception(env, code, ilen);
> +#ifdef CONFIG_TCG
> +        cpu_loop_exit(CPU(cpu));
> +#endif
> +    }
> +}

I would like to take the opportunity to split the kvm and tcg versions apart. 
Primarily because the tcg half is noreturn, and I keep having to add 
g_assert_not_reached after calling it to avoid other Werrors.

That might also help with the ifdeffing a little so you can write

   if (kvm_enabled()) {
     kvm_program_interrupt(...);
   } else if (tcg_enabled()) {
     tcg_program_interrupt(...);
   } else {
     g_assert_not_reached();
   }


r~
