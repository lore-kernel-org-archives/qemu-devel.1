Received: from eggs.gnu.org ([2001:4830:134:3::10]:50615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHtWN-0003iP-3S
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:39:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHtWH-0007V4-PF
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:39:07 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37643)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gHtWH-0007Uh-HT
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:39:01 -0400
Received: by mail-wr1-x442.google.com with SMTP id g9-v6so17217945wrq.4
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 09:39:01 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-18-cota@braap.org>
	<878t2e8bnd.fsf@linaro.org> <20181031162658.GB15881@flamenco>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181031162658.GB15881@flamenco>
Date: Wed, 31 Oct 2018 16:38:58 +0000
Message-ID: <87bm7a6pgd.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 18/71] sh4: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>


Emilio G. Cota <cota@braap.org> writes:

> On Wed, Oct 31, 2018 at 13:54:14 +0000, Alex Benn=C3=A9e wrote:
>>
>> Emilio G. Cota <cota@braap.org> writes:
>>
>> > Cc: Aurelien Jarno <aurelien@aurel32.net>
>> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> > Signed-off-by: Emilio G. Cota <cota@braap.org>
>> > ---
>> >  target/sh4/op_helper.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
>> > index 4f825bae5a..57cc363ccc 100644
>> > --- a/target/sh4/op_helper.c
>> > +++ b/target/sh4/op_helper.c
>> > @@ -105,7 +105,7 @@ void helper_sleep(CPUSH4State *env)
>> >  {
>> >      CPUState *cs =3D CPU(sh_env_get_cpu(env));
>> >
>> > -    cs->halted =3D 1;
>> > +    cpu_halted_set(cs, 1);
>>
>> Looks good:
>>
>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> Thanks!
>
>> >      env->in_sleep =3D 1;
>>
>> I wonder if you could drop env->in_sleep from CPUSH4State?
>> The test in superh_cpu_do_interrupt:
>>
>>         if (do_irq && !env->in_sleep) {
>>             return; /* masked */
>>         }
>>     }
>>     env->in_sleep =3D 0;
>>
>> maybe be simplified is we cpu_set_halted(cs, 0) when servicing a
>> delivered irq?
>
> I don't know this target well, but on a quick look I'd worry about
> that change interfering with other (generic) setters of
> cpu->halted, e.g. cpu_common_reset, as well as the CPU loop
> where cpu->halted is read.
>
> In any case I'd leave additional cleanups out of this series,
> which is already so long that git rebase is choking a bit
> every time I add an R-b tag :D

No worries, it was more a general query thrown in the direction of the
sh4 maintainers ;-)

--
Alex Benn=C3=A9e
