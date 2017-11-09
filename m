Received: from eggs.gnu.org ([2001:4830:134:3::10]:40306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lepton@google.com>) id 1eCrsP-0002N7-7y
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 13:48:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lepton@google.com>) id 1eCrsM-0007DG-CB
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 13:48:31 -0500
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:55911)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lepton@google.com>) id 1eCrsM-0007CV-1r
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 13:48:30 -0500
Received: by mail-wm0-x231.google.com with SMTP id b189so4879892wmd.4
	for <qemu-devel@nongnu.org>; Thu, 09 Nov 2017 10:48:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CK53wNxwixP8M4JgbG4kKgpgu_EdJ6-RyNnevNGQsXmJw@mail.gmail.com>
References: <20170508195404.j33kcmqncrb7fziv@var.youpi.perso.aquilenet.fr>
	<20171108225340.10194-1-lepton@google.com>
	<CAJ+F1CK53wNxwixP8M4JgbG4kKgpgu_EdJ6-RyNnevNGQsXmJw@mail.gmail.com>
From: =?UTF-8?B?VGFvIFd1KOWQtOa2m0BFbmcp?= <lepton@google.com>
Date: Thu, 9 Nov 2017 10:48:27 -0800
Message-ID: <CAOvqHj6Sw6_a90WRsLd3YgVu-rRL5k9cgRy1vbgEfCucf_7dXQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] slirp: don't zero ti_i since we access it
 later.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Samuel Thibault <samuel.thibault@gnu.org>, maethor@subiron.org

Thanks. Actually this is a follow up with my previous effort to fix this
bug.
I was busy on something else and then got lost in that old thread. Now I
just checked some my local patch
to see if they've merged to upstream and then found it out.

This is old thread about this:
http://lists.nongnu.org/archive/html/qemu-devel/2017-04/msg05544.html


On Thu, Nov 9, 2017 at 2:50 AM, Marc-Andr=C3=A9 Lureau <
marcandre.lureau@gmail.com> wrote:

> Hi
>
> Adding Guillaume in CC, who wrote that line in commit 98c63057d2144
>
> On Wed, Nov 8, 2017 at 11:53 PM, Tao Wu via Qemu-devel
> <qemu-devel@nongnu.org> wrote:
> > The current code looks buggy, we zero ti_i while we access
> > ti_dst/ti_src later.
>
> Could you described the symptoms and why you fixed it that way?
>
> thanks
>
> >
> > Signed-off-by: Tao Wu <lepton@google.com>
> > ---
> >  slirp/tcp_subr.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
> > index dc8b4bbb50..da0d53743f 100644
> > --- a/slirp/tcp_subr.c
> > +++ b/slirp/tcp_subr.c
> > @@ -148,7 +148,16 @@ tcp_respond(struct tcpcb *tp, struct tcpiphdr *ti,
> struct mbuf *m,
> >                 m->m_data +=3D IF_MAXLINKHDR;
> >                 *mtod(m, struct tcpiphdr *) =3D *ti;
> >                 ti =3D mtod(m, struct tcpiphdr *);
> > -               memset(&ti->ti, 0, sizeof(ti->ti));
> > +               switch (af) {
> > +               case AF_INET:
> > +                   ti->ti.ti_i4.ih_x1 =3D 0;
> > +                   break;
> > +               case AF_INET6:
> > +                   ti->ti.ti_i6.ih_x1 =3D 0;
> > +                   break;
> > +               default:
> > +                   g_assert_not_reached();
> > +               }
> >                 flags =3D TH_ACK;
> >         } else {
> >                 /*
> > --
> > 2.15.0.448.gf294e3d99a-goog
> >
> >
>
>
>
> --
> Marc-Andr=C3=A9 Lureau
>
