Received: from eggs.gnu.org ([2001:4830:134:3::10]:53674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dV0j5-0004gu-04
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 15:21:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dV0j0-0000J4-W8
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 15:21:38 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:35704)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dV0j0-0000Id-Pf
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 15:21:34 -0400
Received: by mail-wr0-f175.google.com with SMTP id k67so2334362wrc.2
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 12:21:34 -0700 (PDT)
References: <20170711175937.23140-1-alex.bennee@linaro.org>
	<20170711175937.23140-5-alex.bennee@linaro.org>
	<d0d0750b-127e-79e8-4307-57e187cd302f@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <d0d0750b-127e-79e8-4307-57e187cd302f@twiddle.net>
Date: Tue, 11 Jul 2017 20:20:31 +0100
Message-ID: <87fue2aigw.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 4/6] target/arm/translate: ensure
 gen_goto_tb sets exit flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: peter.maydell@linaro.org, cota@braap.org, qemu-devel@nongnu.org, "open list:ARM" <qemu-arm@nongnu.org>


Richard Henderson <rth@twiddle.net> writes:

> On 07/11/2017 07:59 AM, Alex Bennée wrote:
>>       if (use_goto_tb(s, dest)) {
>>           tcg_gen_goto_tb(n);
>>           gen_set_pc_im(s, dest);
>>           tcg_gen_exit_tb((uintptr_t)s->tb + n);
>> +        s->is_jmp = DISAS_TB_JUMP;
>>       } else {
>>           gen_set_pc_im(s, dest);
>>           gen_goto_ptr();
>> +        s->is_jmp = DISAS_JUMP;
>>       }
>
> I think DISAS_TB_JUMP is appropriate for both cases.  When not using
> goto_tb, the jump is still static and we still chain to the next TB
> via goto_ptr.

OK - I guess we need to nail down what the essential difference is
between the two. I understood DISAS_TB_JUMP as a static known PC which
can be patched in the generated code because we know the two addresses
are in the same page - whereas DISAS_JUMP is a "computed" jump although
in this case the PC is already known.

Does making a distinction between computed and non-computer inter-page
jumps make any sense anyway?

>
> Otherwise,
>
> Reviewed-by: Richard Henderson <rth@twiddle.net>
>
>
> r~


--
Alex Bennée
