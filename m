Received: from eggs.gnu.org ([2001:4830:134:3::10]:56559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dLApH-0002d8-Fc
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 12:07:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dLApE-0006Tr-05
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 12:07:23 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:34756)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dLApD-0006TC-Ob
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 12:07:19 -0400
Received: by mail-wr0-x233.google.com with SMTP id 77so6912139wrb.1
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 09:07:19 -0700 (PDT)
References: <20170614140209.29847-1-alex.bennee@linaro.org>
	<20170614140209.29847-3-alex.bennee@linaro.org>
	<9db5e18a-8d0c-4083-ecab-e8a5fa2da67a@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <9db5e18a-8d0c-4083-ecab-e8a5fa2da67a@twiddle.net>
Date: Wed, 14 Jun 2017 17:07:53 +0100
Message-ID: <8737b2o8me.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 2/3] tcg-runtime: light re-factor of
 lookup_tb_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: peter.maydell@linaro.org, pbonzini@redhat.com, cota@braap.org, qemu-devel@nongnu.org


Richard Henderson <rth@twiddle.net> writes:

> On 06/14/2017 07:02 AM, Alex Bennée wrote:
>> Just a little precursor re-factoring before I was going to add a trace
>> point:
>>
>>    - single return point, defaulting to tcg_ctx.code_gen_epilogue
>
> Why?  Any if you're going to do that, why not init ret = epilogue and
> avoid the null test at the end?

That would be better. I think the NULL is left over from my originall
debugging when I had added a trace point and wanted to see when the
lookup had failed.

>
>>    - move cs_base, pc and flags inside the jump cache hit scope
>
> Funny story.  While looking at this again, I notice that there's no
> reason to avoid, and every reason not to avoid, calling
> tb_htable_lookup when tb_jmp_cache is empty.  So I'm now doing
>
>     tb = atomic_rcu_read(...);
>     cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
>
>     if (!(tb && tb->pc == addr && ...)) {
>         tb = tb_htable_lookup(...);
>         ...

OK I can fix on the next iteration.

>>    - calculate the tb_jmp_cache hash once
>
> I did look once and the compiler is doing the CSE.  But it does look cleaner.
>
>
> r~


--
Alex Bennée
