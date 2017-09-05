Received: from eggs.gnu.org ([2001:4830:134:3::10]:34535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dpDHg-0003Sp-EB
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:49:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dpDHb-0006LG-C7
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:48:52 -0400
MIME-Version: 1.0
References: <CAJ+F1C+mPu9ftXwgs4UrGTQp4f65-thhvmWoB-kuRmu0=vnFFw@mail.gmail.com>
	<54c80221-aaf8-48c3-d58d-485003f77988@amsat.org>
In-Reply-To: <54c80221-aaf8-48c3-d58d-485003f77988@amsat.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 05 Sep 2017 12:48:35 +0000
Message-ID: <CAJ+F1C+JR8QqRGXaFizqHNrmWfi7v4ZuFAsOzUeqmXW=rqnFZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] clang-tidy: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU <qemu-devel@nongnu.org>, qemu trival <qemu-trivial@nongnu.org>, Juan Quintela <quintela@redhat.com>

On Tue, Sep 5, 2017 at 2:41 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
>
wrote:

> Hi Marc-Andr=C3=A9,
>
> On 09/05/2017 09:14 AM, Marc-Andr=C3=A9 Lureau wrote:
> > Hi,
> >
> > I have a series of changes generated with clang-tidy qemu [1] pending
> > for review [2].
> >
> > It translates calloc/*malloc*/*realloc() calls to
> > g_new/g_newa/g_new0/g_renew() where the argument is a sizeof(T) [* N].
> >
> > This is the first commit to give you an idea:
> >
> > diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
> > index 98fddd7ac1..75affcb8a6 100644
> > --- a/hw/timer/arm_timer.c
> > +++ b/hw/timer/arm_timer.c
> > @@ -166,7 +166,7 @@ static arm_timer_state *arm_timer_init(uint32_t fre=
q)
> >       arm_timer_state *s;
> >       QEMUBH *bh;
> >
> > -    s =3D (arm_timer_state *)g_malloc0(sizeof(arm_timer_state));
> > +    s =3D g_new0(arm_timer_state, 1);
> >       s->freq =3D freq;
> >       s->control =3D TIMER_CTRL_IE;
> >
> > g_new() advantages (from glib doc):
> > - the returned pointer is cast to a pointer to the given type.
> > - care is taken to avoid overflow when calculating the size of the
> > allocated block.
> >
> > But it is also shorter&nicer :)
> >
> > I have not included in the first batch the opportunity to also
> > translate: alloc(sizeof(*p) * x) to g_new(typeof(*p), x), since it is
> > arguably not much nicer. But for consistency, I think it would be good
>
> "avoid overflow when calculating the size" sounds nicer.
>
> > to use g_new(). What do you think?
>
> Dunno if useful, but Juan Quintela had some issue:
>
> http://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg00085.html


Thanks for pointing this out.

It looks like the last iteration didn't change it after all:
https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg00076.html


>
> >
> > I splitted the changes amont the various MAINTAINERS entries, but it
> > is still about 70 patches (without the typeof() changes).
> >
> >
> > [1] https://github.com/elmarco/clang-tools-extra/
> > [2] https://github.com/elmarco/qemu/commits/gnew
> >
> >
>
--=20
Marc-Andr=C3=A9 Lureau
