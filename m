Received: from eggs.gnu.org ([209.51.188.92]:40763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gk89Y-0003t6-Q1
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 08:56:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gk89X-0005yZ-Q8
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 08:56:16 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39664)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gk89X-0005xF-KC
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 08:56:15 -0500
Received: by mail-ot1-x343.google.com with SMTP id n8so11148916otl.6
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 05:56:15 -0800 (PST)
MIME-Version: 1.0
References: <20181226034254.17842-1-richard.henderson@linaro.org>
	<20190116235009.tl4gcv53e62npecl@function>
	<d79f1118-38ed-16fc-0233-0c41570d6d8c@redhat.com>
In-Reply-To: <d79f1118-38ed-16fc-0233-0c41570d6d8c@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Jan 2019 13:56:03 +0000
Message-ID: <CAFEAcA9moCfRCHkivgU7Qesi3xeD=8u8+0WScM84f-dcwyYfrw@mail.gmail.com>
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
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Samuel Thibault <samuel.thibault@gnu.org>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, Jan Kiszka <jan.kiszka@siemens.com>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, 17 Jan 2019 at 13:41, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
> On 1/17/19 12:50 AM, Samuel Thibault wrote:
> > --- a/slirp/slirp.c
> > +++ b/slirp/slirp.c
> > @@ -851,7 +851,7 @@ void slirp_input(Slirp *slirp, const uint8_t *pkt, =
int pkt_len)
> >      if (pkt_len < ETH_HLEN)
> >          return;
> >
> > -    proto =3D ntohs(*(uint16_t *)(pkt + 12));
> > +    proto =3D (((uint16_t) pkt[12]) << 8) + pkt[13];
> >      switch(proto) {
> >      case ETH_P_ARP:
> >          arp_input(slirp, pkt, pkt_len);
>
> What about using memcpy?

We should use whatever the new libslirp wants to consistently
use as its mechanism for loading unaligned data. I don't
suppose this is the only place where it ever needs to do this.

Personally I would vote for having libslirp have versions of
the ld*_p functions, because they solve the problem in a
clear and correct way. But that's up to Marc-Andr=C3=A9 really.

(As you can see from clang build logs:
https://travis-ci.org/qemu/qemu/jobs/480813811
slirp/ has a lot of as-yet-unfixed "takes address of packed
member" bugs, which suggest it's a bit slapdash with
alignment. Running it under the clang sanitizer to look
for runtime alignment errors might also be interesting.)

thanks
-- PMM
