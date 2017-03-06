Received: from eggs.gnu.org ([2001:4830:134:3::10]:53942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ckyEu-00005I-SY
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 14:24:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ckyEu-0003ay-3m
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 14:24:12 -0500
Received: from mail-yw0-x22c.google.com ([2607:f8b0:4002:c05::22c]:33081)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ckyEt-0003ae-W3
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 14:24:12 -0500
Received: by mail-yw0-x22c.google.com with SMTP id v76so29612959ywg.0
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 11:24:11 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <d208c3f0-2e57-0b54-f18f-b5e27d698e28@genode-labs.com>
	<20170306155722.31315-1-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <5d60b86e-d57d-fbcd-fb54-d7447816244d@twiddle.net>
Date: Tue, 7 Mar 2017 06:24:05 +1100
MIME-Version: 1.0
In-Reply-To: <20170306155722.31315-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] target/i386: move nested exception check
 to x86_cpu_exec_interrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, alexander.boettcher@genode-labs.com
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 03/07/2017 02:57 AM, Alex Bennée wrote:
>      cs->exception_index = intno;
>      env->error_code = error_code;
>      env->exception_is_int = is_int;
>      env->exception_next_eip = env->eip + next_eip_addend;
> +    env->exception_retaddr = retaddr;
>      cpu_loop_exit_restore(cs, retaddr);

Since you've restored state here, I don't see that you need to save the retaddr 
at all ...

> +    if (!env->exception_is_int) {
> +        cpu_svm_check_intercept_param(env,
> +                                      SVM_EXIT_EXCP_BASE + cs->exception_index,
> +                                      env->error_code,
> +                                      env->exception_retaddr);
> +        cs->exception_index = check_exception(env, cs->exception_index,
> +                                              &env->error_code,
> +                                              env->exception_retaddr);
> +    } else {
> +        cpu_svm_check_intercept_param(env, SVM_EXIT_SWINT, 0,
> +                                      env->exception_retaddr);
> +    }

... simply pass zero here instead.

But do I see correctly from the thread that we don't have a reproducer?


r~
