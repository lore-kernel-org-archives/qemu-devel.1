Received: from eggs.gnu.org ([209.51.188.92]:39952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gkSSw-0001n6-B2
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:37:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gkSSu-0008HN-Ty
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:37:38 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33207)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gkSSu-00088J-6K
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:37:36 -0500
Received: by mail-wm1-x344.google.com with SMTP id r24so788658wmh.0
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 03:37:30 -0800 (PST)
MIME-Version: 1.0
References: <20181226034254.17842-1-richard.henderson@linaro.org>
	<20190116235009.tl4gcv53e62npecl@function>
	<d79f1118-38ed-16fc-0233-0c41570d6d8c@redhat.com>
	<CAFEAcA9moCfRCHkivgU7Qesi3xeD=8u8+0WScM84f-dcwyYfrw@mail.gmail.com>
	<CAJ+F1CK9Bkw0ULs5j2n9v_py1DRqLFgPGaHXBBvdWBb-eBDcvg@mail.gmail.com>
In-Reply-To: <CAJ+F1CK9Bkw0ULs5j2n9v_py1DRqLFgPGaHXBBvdWBb-eBDcvg@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 18 Jan 2019 15:37:17 +0400
Message-ID: <CAJ+F1C+PX8d+py3q=CZAND+TkgatXjAQPNP-NXZkz+NBChmZXQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] slirp: Use lduw_be_p in slirp_input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Samuel Thibault <samuel.thibault@gnu.org>, Richard Henderson <richard.henderson@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>, QEMU Developers <qemu-devel@nongnu.org>

Hi

On Fri, Jan 18, 2019 at 3:25 PM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Thu, Jan 17, 2019 at 5:56 PM Peter Maydell <peter.maydell@linaro.org> =
wrote:
> >
> > On Thu, 17 Jan 2019 at 13:41, Philippe Mathieu-Daud=C3=A9 <philmd@redha=
t.com> wrote:
> > > On 1/17/19 12:50 AM, Samuel Thibault wrote:
> > > > --- a/slirp/slirp.c
> > > > +++ b/slirp/slirp.c
> > > > @@ -851,7 +851,7 @@ void slirp_input(Slirp *slirp, const uint8_t *p=
kt, int pkt_len)
> > > >      if (pkt_len < ETH_HLEN)
> > > >          return;
> > > >
> > > > -    proto =3D ntohs(*(uint16_t *)(pkt + 12));
> > > > +    proto =3D (((uint16_t) pkt[12]) << 8) + pkt[13];
> > > >      switch(proto) {
> > > >      case ETH_P_ARP:
> > > >          arp_input(slirp, pkt, pkt_len);
> > >
> > > What about using memcpy?
> >
> > We should use whatever the new libslirp wants to consistently
> > use as its mechanism for loading unaligned data. I don't
> > suppose this is the only place where it ever needs to do this.
> >
> > Personally I would vote for having libslirp have versions of
> > the ld*_p functions, because they solve the problem in a
> > clear and correct way. But that's up to Marc-Andr=C3=A9 really.
>
> I think I would go with a copy of qemu bswap.h, unless there is an
> equivalent in glib (I don't think so) or gnulib? Or other standard
> compiler solution.
>

The GStreamer solution is also quite readable.
https://gitlab.freedesktop.org/gstreamer/gstreamer/blob/master/gst/gstutils=
.h#L165


--=20
Marc-Andr=C3=A9 Lureau
