Received: from eggs.gnu.org ([2001:4830:134:3::10]:58383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1clGeI-0006hJ-PM
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:03:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1clGeE-000692-Uu
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:03:38 -0500
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:37100)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1clGeE-00068u-N8
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:03:34 -0500
Received: by mail-wm0-x22b.google.com with SMTP id n11so7271879wma.0
	for <qemu-devel@nongnu.org>; Tue, 07 Mar 2017 07:03:34 -0800 (PST)
References: <d208c3f0-2e57-0b54-f18f-b5e27d698e28@genode-labs.com>
	<20170306155722.31315-1-alex.bennee@linaro.org>
	<5d60b86e-d57d-fbcd-fb54-d7447816244d@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <5d60b86e-d57d-fbcd-fb54-d7447816244d@twiddle.net>
Date: Tue, 07 Mar 2017 15:03:41 +0000
Message-ID: <87a88xi0xe.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Richard Henderson <rth@twiddle.net>
Cc: alexander.boettcher@genode-labs.com, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>


Richard Henderson <rth@twiddle.net> writes:

> On 03/07/2017 02:57 AM, Alex Bennée wrote:
>>      cs->exception_index = intno;
>>      env->error_code = error_code;
>>      env->exception_is_int = is_int;
>>      env->exception_next_eip = env->eip + next_eip_addend;
>> +    env->exception_retaddr = retaddr;
>>      cpu_loop_exit_restore(cs, retaddr);
>
> Since you've restored state here, I don't see that you need to save
> the retaddr at all ...
>
>> +    if (!env->exception_is_int) {
>> +        cpu_svm_check_intercept_param(env,
>> +                                      SVM_EXIT_EXCP_BASE + cs->exception_index,
>> +                                      env->error_code,
>> +                                      env->exception_retaddr);
>> +        cs->exception_index = check_exception(env, cs->exception_index,
>> +                                              &env->error_code,
>> +                                              env->exception_retaddr);
>> +    } else {
>> +        cpu_svm_check_intercept_param(env, SVM_EXIT_SWINT, 0,
>> +                                      env->exception_retaddr);
>> +    }
>
> ... simply pass zero here instead.
>
> But do I see correctly from the thread that we don't have a reproducer?

Yeah - I've nabbed Paolo's much cleaner and more informed fix and that
seems fine.

--
Alex Bennée
