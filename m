Received: from eggs.gnu.org ([2001:4830:134:3::10]:35156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1daIyI-00064F-VO
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 05:51:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1daIyE-0002h1-L0
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 05:51:15 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:35328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dmitry@daynix.com>) id 1daIyE-0002gH-8S
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 05:51:10 -0400
Received: by mail-wm0-x22f.google.com with SMTP id c184so73554193wmd.0
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 02:51:10 -0700 (PDT)
From: Dmitry Fleytman <dmitry@daynix.com>
Message-Id: <5CB0C39F-09B4-465B-BAB5-05A0DF07A4FC@daynix.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Date: Wed, 26 Jul 2017 12:51:06 +0300
In-Reply-To: <20170724182751.18261-11-f4bug@amsat.org>
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-11-f4bug@amsat.org>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 2.10 10/35] net/eth: fix incorrect
 check of iov_to_buf() return value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Eric Blake <eblake@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, Jason Wang <jasowang@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, qemu-trivial@nongnu.org


> On 24 Jul 2017, at 21:27 PM, Philippe Mathieu-Daud=C3=A9 =
<f4bug@amsat.org> wrote:
>=20
> So we have sizeof(struct in6_address) !=3D sizeof(uintptr_t)
> and Clang > Coverity on this, see 4555ca6816c :)
>=20
> net/eth.c:426:30: warning: The code calls sizeof() on a pointer type. =
This can produce an unexpected result
>        return bytes_read =3D=3D sizeof(dst_addr);
>                             ^     ~~~~~~~~~~
> net/eth.c:475:34: warning: The code calls sizeof() on a pointer type. =
This can produce an unexpected result
>            return bytes_read =3D=3D sizeof(src_addr);
>                                 ^     ~~~~~~~~~~
>=20
> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> net/eth.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/eth.c b/net/eth.c
> index 5b9ba26a56..ae5d881aae 100644
> --- a/net/eth.c
> +++ b/net/eth.c
> @@ -423,7 +423,7 @@ _eth_get_rss_ex_dst_addr(const struct iovec *pkt, =
int pkt_frags,
>                                 rthdr_offset + sizeof(*ext_hdr),
>                                 dst_addr, sizeof(*dst_addr));
>=20
> -        return bytes_read =3D=3D sizeof(dst_addr);
> +        return bytes_read =3D=3D sizeof(*dst_addr);
>     }
>=20
>     return false;
> @@ -472,7 +472,7 @@ _eth_get_rss_ex_src_addr(const struct iovec *pkt, =
int pkt_frags,
>                                     opt_offset + sizeof(opthdr),
>                                     src_addr, sizeof(*src_addr));
>=20
> -            return bytes_read =3D=3D sizeof(src_addr);
> +            return bytes_read =3D=3D sizeof(*src_addr);
>         }
>=20

Reviewed-by: Dmitry Fleytman <dmitry@daynix.com>

>         opt_offset +=3D optlen;
> --=20
> 2.13.3
>=20
