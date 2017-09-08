Received: from eggs.gnu.org ([2001:4830:134:3::10]:50032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dqLTw-0001fP-8k
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 11:46:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dqLTv-0006dI-Bg
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 11:46:12 -0400
Date: Fri, 8 Sep 2017 18:44:59 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170908154459.5xpyczgpvim75o62@postretch>
References: <20170825132332.6734-1-el13635@mail.ntua.gr>
	<20170825132332.6734-5-el13635@mail.ntua.gr>
	<20170907132611.GG4461@dhcp-200-186.str.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zzjnzsvmhd2x2xjm"
Content-Disposition: inline
In-Reply-To: <20170907132611.GG4461@dhcp-200-186.str.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 4/7] block: remove legacy I/O throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>


--zzjnzsvmhd2x2xjm
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 07, 2017 at 03:26:11PM +0200, Kevin Wolf wrote:
>We shouldn't really need any throttling code in
>blk_root_drained_begin/end any more now because the throttle node will
>be drained. If this code is necessary, a bdrv_drain() on an explicit
>throttle node will work differently from one on an implicit one.
>
>Unfortunately, this seems to be true about the throttle node. Implicit
>throttle nodes will keep ignoring the throttle limit in order to
>complete the drain request quickly, where as explicit throttle nodes
>will process their requests at the configured speed before the drain
>request can be completed.
>
>This doesn't feel right to me, both should behave the same.
>
>Kevin
>

I suppose we can implement bdrv_co_drain and increase io_limits_disabled=20
=66rom inside the driver. And then remove the implicit filter logic from=20
blk_root_drained_begin. But there's no _end callback equivalent so we=20
can't decrease io_limits_disabled at the end of the drain. So I think=20
there are two options:

- make a bdrv_co_drain_end cb and recurse in blk_root_drain_end for all=20
  children to call it. Old behavior of I/O bursts (?) during a drain is=20
  kept.
- remove io_limits_disabled and let throttled requests obey limits=20
  during a drain

--zzjnzsvmhd2x2xjm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlmyuvsACgkQc2J8L2kN
9xDX4RAA1M/s6vm3tK37Wj1ok9MKOyzDkvBjq+ZfMj8QHATzCFAtAbzLZbsi1xv+
7fGknzrMKV4FnZKx+9XxKpJs79yt+G3/YUXawwWM47rLndhPw2uKSN1u4zCpMqoY
SQjQGw+wgfM5nDEhaUnk2FojEl7v02vFazzn8jwKGoidDhTsXKx6uFX4TIWCfM7U
Plph4CSgnh+ijElxMGQuczruDr4PfT7kUnDcqWZSZFMr91P7FJ7bbxruVopEjRrl
c7fCxmUzq4moLDvFZWI/PR0WaZo/vWF4iaQcj/XyuUlcK0cGne2KVZkuy2sjbmja
+BenXCAt80+FwGXeoP5fhvgaqJVl1W0q3O1kRHvxgAZLtFzmuwd76BGC1fqN68gY
+kTnB16kY6bDqQK1TvTzTrDqW5MEWTBWCvfqfaeZA5Z3FcCX1fffRhBSKQFkITT2
CXAE+WBXeCM0sVAJOHfhNpxBGl2VX5zEAyxvUIJO4cor72aXsq99Wp0jl1lVBz4G
RPDdKDx2PAc5kGtTpZCTInNFfrczPA54px1/ba2Nb69+oGgqznOjMtPp3Dy1VV/W
yEyrC1iGyd4LnECW3ojP8X2s0/eDxWCTzP7xWUeKv8XI8fMmHALnfjdFvgaNM90u
af4s4DGVeJxYMKyYZz79zwbPy5q+dhipUCjK/CNXryGQwePGTSc=
=m/Xp
-----END PGP SIGNATURE-----

--zzjnzsvmhd2x2xjm--
