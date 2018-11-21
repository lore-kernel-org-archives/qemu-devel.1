Received: from eggs.gnu.org ([2001:4830:134:3::10]:52302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gPai9-0007W3-IA
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:11:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gPai5-00077m-Gb
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:11:05 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:44552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gPai4-00074P-Cw
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:11:01 -0500
Date: Wed, 21 Nov 2018 23:10:35 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20181121221035.fzzt37gdacvccelb@function>
References: <20181121220647.18844-1-marcandre.lureau@redhat.com>
	<20181121220647.18844-2-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181121220647.18844-2-marcandre.lureau@redhat.com>
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>

Marc-Andr=C3=A9 Lureau, le jeu. 22 nov. 2018 02:06:18 +0400, a ecrit:
> Somehow, I broke the build and failed to detect it. Please squash!

> +#include "qemu/osdep.h"
> +
> +typedef uint32_t tcp_seq;

I preferred to just use uint32_t instead of tcp_seq in the couple of
places where this showed up.

>  /*
>   * Structure of an internet header, naked of options.
> @@ -50,6 +53,29 @@ struct ip {
>      struct in_addr ip_src, ip_dst;  /* source and dest address */
>  } QEMU_PACKED;
> =20
> +/*
> + * TCP header.
> + * Per RFC 793, September, 1981.
> + */
> +#define tcphdr slirp_tcphdr
> +struct tcphdr {
> +    uint16_t th_sport;      /* source port */
> +    uint16_t th_dport;      /* destination port */
> +    tcp_seq th_seq;         /* sequence number */
> +    tcp_seq th_ack;         /* acknowledgement number */
> +#ifdef HOST_WORDS_BIGENDIAN
> +    uint8_t th_off:4,       /* data offset */
> +            th_x2:4;        /* (unused) */
> +#else
> +    uint8_t th_x2:4,        /* (unused) */
> +            th_off:4;       /* data offset */
> +#endif
> +    uint8_t th_flags;
> +    uint16_t th_win;        /* window */
> +    uint16_t th_sum;        /* checksum */
> +    uint16_t th_urp;        /* urgent pointer */
> +};
> +

We already have struct tcp_hdr, in include/net/eth.h, so I used that
instead.

Too bad I have worked on that just a few minutes ago :)

Samuel
