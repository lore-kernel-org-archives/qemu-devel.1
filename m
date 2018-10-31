Received: from eggs.gnu.org ([2001:4830:134:3::10]:45817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gHtKh-0001JA-M2
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:27:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gHtKe-0007zb-Fy
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:27:03 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:51343)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gHtKe-0007zL-8V
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:27:00 -0400
Date: Wed, 31 Oct 2018 12:26:58 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181031162658.GB15881@flamenco>
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-18-cota@braap.org>
	<878t2e8bnd.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878t2e8bnd.fsf@linaro.org>
Subject: Re: [Qemu-devel] [RFC v4 18/71] sh4: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

On Wed, Oct 31, 2018 at 13:54:14 +0000, Alex Bennée wrote:
> 
> Emilio G. Cota <cota@braap.org> writes:
> 
> > Cc: Aurelien Jarno <aurelien@aurel32.net>
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Emilio G. Cota <cota@braap.org>
> > ---
> >  target/sh4/op_helper.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
> > index 4f825bae5a..57cc363ccc 100644
> > --- a/target/sh4/op_helper.c
> > +++ b/target/sh4/op_helper.c
> > @@ -105,7 +105,7 @@ void helper_sleep(CPUSH4State *env)
> >  {
> >      CPUState *cs = CPU(sh_env_get_cpu(env));
> >
> > -    cs->halted = 1;
> > +    cpu_halted_set(cs, 1);
> 
> Looks good:
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

Thanks!

> >      env->in_sleep = 1;
> 
> I wonder if you could drop env->in_sleep from CPUSH4State?
> The test in superh_cpu_do_interrupt:
> 
>         if (do_irq && !env->in_sleep) {
>             return; /* masked */
>         }
>     }
>     env->in_sleep = 0;
> 
> maybe be simplified is we cpu_set_halted(cs, 0) when servicing a
> delivered irq?

I don't know this target well, but on a quick look I'd worry about
that change interfering with other (generic) setters of
cpu->halted, e.g. cpu_common_reset, as well as the CPU loop
where cpu->halted is read.

In any case I'd leave additional cleanups out of this series,
which is already so long that git rebase is choking a bit
every time I add an R-b tag :D

Thanks,

		Emilio
