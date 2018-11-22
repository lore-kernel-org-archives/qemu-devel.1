Received: from eggs.gnu.org ([2001:4830:134:3::10]:47362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gPjCl-0000Av-CO
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 02:15:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gPjCj-00048X-Dz
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 02:15:15 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38595)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gPjCi-00047j-LI
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 02:15:12 -0500
Received: by mail-wm1-x342.google.com with SMTP id k198so8025763wmd.3
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 23:15:12 -0800 (PST)
MIME-Version: 1.0
References: <20181121220647.18844-1-marcandre.lureau@redhat.com>
	<20181121220647.18844-2-marcandre.lureau@redhat.com>
	<20181121221035.fzzt37gdacvccelb@function>
In-Reply-To: <20181121221035.fzzt37gdacvccelb@function>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 22 Nov 2018 11:14:59 +0400
Message-ID: <CAJ+F1C+PB719zr8bbo=1v-CDHVqKkdQ2QCPuhaHok4cBqTkmjw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 for-3.2 v2 01/30] fixup! net: do not
 depend on slirp internals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>, QEMU <qemu-devel@nongnu.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>

Hi

On Thu, Nov 22, 2018 at 2:41 AM Samuel Thibault <samuel.thibault@gnu.org> w=
rote:
>
> Marc-Andr=C3=A9 Lureau, le jeu. 22 nov. 2018 02:06:18 +0400, a ecrit:
> > Somehow, I broke the build and failed to detect it. Please squash!
>
> > +#include "qemu/osdep.h"
> > +
> > +typedef uint32_t tcp_seq;
>
> I preferred to just use uint32_t instead of tcp_seq in the couple of
> places where this showed up.
>
> >  /*
> >   * Structure of an internet header, naked of options.
> > @@ -50,6 +53,29 @@ struct ip {
> >      struct in_addr ip_src, ip_dst;  /* source and dest address */
> >  } QEMU_PACKED;
> >
> > +/*
> > + * TCP header.
> > + * Per RFC 793, September, 1981.
> > + */
> > +#define tcphdr slirp_tcphdr
> > +struct tcphdr {
> > +    uint16_t th_sport;      /* source port */
> > +    uint16_t th_dport;      /* destination port */
> > +    tcp_seq th_seq;         /* sequence number */
> > +    tcp_seq th_ack;         /* acknowledgement number */
> > +#ifdef HOST_WORDS_BIGENDIAN
> > +    uint8_t th_off:4,       /* data offset */
> > +            th_x2:4;        /* (unused) */
> > +#else
> > +    uint8_t th_x2:4,        /* (unused) */
> > +            th_off:4;       /* data offset */
> > +#endif
> > +    uint8_t th_flags;
> > +    uint16_t th_win;        /* window */
> > +    uint16_t th_sum;        /* checksum */
> > +    uint16_t th_urp;        /* urgent pointer */
> > +};
> > +
>
> We already have struct tcp_hdr, in include/net/eth.h, so I used that
> instead.
>
> Too bad I have worked on that just a few minutes ago :)

Great, thank you! and I prefer your solution :)


--=20
Marc-Andr=C3=A9 Lureau
