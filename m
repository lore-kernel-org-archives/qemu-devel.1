Received: from eggs.gnu.org ([209.51.188.92]:36039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gkSHN-0000Vx-Rd
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:25:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gkSHJ-0006UX-Mr
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:25:41 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gkSHF-0006An-L1
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:25:36 -0500
Received: by mail-wm1-x343.google.com with SMTP id y185so765318wmd.1
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 03:25:20 -0800 (PST)
MIME-Version: 1.0
References: <20181226034254.17842-1-richard.henderson@linaro.org>
	<20190116235009.tl4gcv53e62npecl@function>
	<d79f1118-38ed-16fc-0233-0c41570d6d8c@redhat.com>
	<CAFEAcA9moCfRCHkivgU7Qesi3xeD=8u8+0WScM84f-dcwyYfrw@mail.gmail.com>
In-Reply-To: <CAFEAcA9moCfRCHkivgU7Qesi3xeD=8u8+0WScM84f-dcwyYfrw@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 18 Jan 2019 15:25:07 +0400
Message-ID: <CAJ+F1CK9Bkw0ULs5j2n9v_py1DRqLFgPGaHXBBvdWBb-eBDcvg@mail.gmail.com>
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

On Thu, Jan 17, 2019 at 5:56 PM Peter Maydell <peter.maydell@linaro.org> wr=
ote:
>
> On Thu, 17 Jan 2019 at 13:41, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com> wrote:
> > On 1/17/19 12:50 AM, Samuel Thibault wrote:
> > > --- a/slirp/slirp.c
> > > +++ b/slirp/slirp.c
> > > @@ -851,7 +851,7 @@ void slirp_input(Slirp *slirp, const uint8_t *pkt=
, int pkt_len)
> > >      if (pkt_len < ETH_HLEN)
> > >          return;
> > >
> > > -    proto =3D ntohs(*(uint16_t *)(pkt + 12));
> > > +    proto =3D (((uint16_t) pkt[12]) << 8) + pkt[13];
> > >      switch(proto) {
> > >      case ETH_P_ARP:
> > >          arp_input(slirp, pkt, pkt_len);
> >
> > What about using memcpy?
>
> We should use whatever the new libslirp wants to consistently
> use as its mechanism for loading unaligned data. I don't
> suppose this is the only place where it ever needs to do this.
>
> Personally I would vote for having libslirp have versions of
> the ld*_p functions, because they solve the problem in a
> clear and correct way. But that's up to Marc-Andr=C3=A9 really.

I think I would go with a copy of qemu bswap.h, unless there is an
equivalent in glib (I don't think so) or gnulib? Or other standard
compiler solution.

It's somehow surprising me that there is no goto solution :).

> (As you can see from clang build logs:
> https://travis-ci.org/qemu/qemu/jobs/480813811
> slirp/ has a lot of as-yet-unfixed "takes address of packed
> member" bugs, which suggest it's a bit slapdash with
> alignment. Running it under the clang sanitizer to look
> for runtime alignment errors might also be interesting.)
>
> thanks
> -- PMM



--=20
Marc-Andr=C3=A9 Lureau
