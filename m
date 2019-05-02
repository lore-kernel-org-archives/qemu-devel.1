Received: from eggs.gnu.org ([209.51.188.92]:56379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1hMEYr-0007j4-C8
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:27:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1hMEYq-0003Cz-9P
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:27:53 -0400
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144]:38275)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent.desnogues@gmail.com>)
	id 1hMEYp-00033j-UX
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:27:52 -0400
Received: by mail-it1-x144.google.com with SMTP id q19so4457633itk.3
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 09:27:29 -0700 (PDT)
MIME-Version: 1.0
References: <877eb86hcf.fsf@zen.linaroharston>
	<20190502145846.26226-1-alex.bennee@linaro.org>
	<765fa2ab-2803-1945-61ea-2e80b2da6072@vivier.eu>
In-Reply-To: <765fa2ab-2803-1945-61ea-2e80b2da6072@vivier.eu>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Thu, 2 May 2019 18:27:17 +0200
Message-ID: <CABoDooM+DtCbTTsoYdvAJOOKuybgKUAR1yYmckM1b=dGA10=NA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] linux-user: avoid treading on gprof's
 SIGPROF signals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

On Thu, May 2, 2019 at 6:17 PM Laurent Vivier <laurent@vivier.eu> wrote:
>
> On 02/05/2019 16:58, Alex Benn=C3=A9e wrote:
> > The guest tends to get confused when it receives signals it doesn't
> > know about. Given the gprof magic has also set up it's own handler we
> > would do well to avoid stomping on it as well.
> >
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > ---
> >  linux-user/signal.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/linux-user/signal.c b/linux-user/signal.c
> > index e2c0b37173..44b2d3b35a 100644
> > --- a/linux-user/signal.c
> > +++ b/linux-user/signal.c
> > @@ -508,6 +508,11 @@ void signal_init(void)
> >      act.sa_flags =3D SA_SIGINFO;
> >      act.sa_sigaction =3D host_signal_handler;
> >      for(i =3D 1; i <=3D TARGET_NSIG; i++) {
> > +#ifdef TARGET_GPROF
> > +        if (i =3D=3D SIGPROF) {
> > +            continue;
> > +        }
> > +#endif
> >          host_sig =3D target_to_host_signal(i);
> >          sigaction(host_sig, NULL, &oact);
> >          if (oact.sa_sigaction =3D=3D (void *)SIG_IGN) {
> >
>
> Perhaps merge this with the previous one and send a v2: it will ease
> bisecting.

I agree it would be better, though it should be noted that the signal
issue has existed for at least 8 years (that's when I had to add a
specific patch in my private repository).

Thanks,

Laurent
