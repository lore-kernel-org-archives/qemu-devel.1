Received: from eggs.gnu.org ([2001:4830:134:3::10]:40854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1fqhNQ-0008TZ-Mz
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:13:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1fqhKn-0004we-Se
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:10:46 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:38535)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent.desnogues@gmail.com>)
	id 1fqhKn-0004wV-OM
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:10:45 -0400
Received: by mail-qt0-x242.google.com with SMTP id x7-v6so14643qtk.5
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 09:10:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180809042206.15726-1-richard.henderson@linaro.org>
	<20180809042206.15726-8-richard.henderson@linaro.org>
	<CAFEAcA8Pb+HNsndA=8KU0+bq5jirK_0JipLR7gdspb1LstthTQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8Pb+HNsndA=8KU0+bq5jirK_0JipLR7gdspb1LstthTQ@mail.gmail.com>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Fri, 17 Aug 2018 18:10:34 +0200
Message-ID: <CABoDooMuYMEC4TnP-geVmo4PVxcMsW3vv8b+m4+D0SbwrbOikA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 07/20] target/arm: Fix is_a64 for user-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

Hello,

On Fri, Aug 17, 2018 at 6:04 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On 9 August 2018 at 05:21, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> > Saves about 8k code size in qemu-aarch64.
> >
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> >  target/arm/cpu.h | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> > index aedaf2631e..ed51a2f5aa 100644
> > --- a/target/arm/cpu.h
> > +++ b/target/arm/cpu.h
> > @@ -918,7 +918,15 @@ void aarch64_sync_64_to_32(CPUARMState *env);
> >
> >  static inline bool is_a64(CPUARMState *env)
> >  {
> > +#ifdef CONFIG_USER_ONLY
> > +# ifdef TARGET_AARCH64
> > +    return true;
> > +# else
> > +    return false;
> > +# endif
> > +#else
> >      return env->aarch64;
> > +#endif
> >  }
>
> And again. I don't want to pepper the code with ifdefs if
> we can do the right thing without them.

FWIW I find it more readable with the ifdef's (here and in the
previous patches) and I guess that helps the compiler too.

Thanks,

Laurent
