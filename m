Received: from eggs.gnu.org ([2001:4830:134:3::10]:34986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dg7Yn-0008Hn-Fu
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 06:52:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dg7Ym-0008Az-De
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 06:52:57 -0400
Date: Fri, 11 Aug 2017 13:52:07 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170811105207.kasyjsigumk2jucu@postretch>
References: <20170809100734.17540-1-el13635@mail.ntua.gr>
	<20170809100734.17540-6-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a3fvp4ouvpayx7kp"
Content-Disposition: inline
In-Reply-To: <20170809100734.17540-6-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH v4 5/7] block: add throttle block filter
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>


--a3fvp4ouvpayx7kp
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline

On Wed, Aug 09, 2017 at 01:07:32PM +0300, Manos Pitsidianakis wrote:
>+static int coroutine_fn throttle_co_preadv(BlockDriverState *bs,
>+                                           uint64_t offset, uint64_t bytes,
>+                                           QEMUIOVector *qiov, int flags)
>+{
>+
>+    ThrottleGroupMember *tgm = bs->opaque;
>+    throttle_group_co_io_limits_intercept(tgm, bytes, false);
>+
>+    return bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
>+}
>+
>+static int coroutine_fn throttle_co_pwritev(BlockDriverState *bs,
>+                                            uint64_t offset, uint64_t bytes,
>+                                            QEMUIOVector *qiov, int flags)
>+{
>+    ThrottleGroupMember *tgm = bs->opaque;
>+    throttle_group_co_io_limits_intercept(tgm, bytes, true);
>+
>+    return bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
--------------------^
Tried some write throttling testing, noticed this. If anyone wants to
test this iteration, change this to bdrv_co_pwritev(), I will correct
this in the next version. (let's pretend this never happened!)

--a3fvp4ouvpayx7kp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlmNjFcACgkQc2J8L2kN
9xCAFhAApexk90ct2xDUUzJxAuyf8g95ykBQv6u1ar/qykvdWJG1b2t0vIrs6WUJ
FWsLqshfPMopoTtHi/yLRv4nSTasMh2Ffr/5VqDCgb1VC0YDdPtURtexNs0n3gXF
H0/sJnqROTxWeb2qWJyaSn1zCZYlfiFs41ibi8lzweyly1g4YTi2zjDJT7+pSTgg
Jk6QewUEx7+cQLTuROFdIoDtSbog7o2OHIXJCFScinpQzBoQqrtsFEVMc8ixHTLo
eIY0dNg/sXGRxQEmJwPW+1LmZB5J/Bjdv140spJx+dRS4gO8hBI3jjQf0MXsdpQl
qOdz2ayx3Y7/MKn7qPQJnLLnNGjO25aZqtSVo6GhKievMPCA1BsLuFr6R3bKMEIn
06rdyHWZUsr4bCg1sjyigSZpTR5RraIqLvHNMcVT1rhdUHAIrpsCH4mzm+iUtvO8
TdGhdNR60vABrYUXcujMNu+qsW18qE8PyPTw+i9c1ueeKhtyW/KjwwRLWMuz+Pm8
9g5mkRQc5C4Qs7mFc998TrHZSFd3Ye1glpT+WtfnQxSQ4miRtIZG8T9XsVSAwZGI
CD+WjbBRQilaSqtU7FCo3BUf1ogBGSmXgKBJPW5sKQ1WudUMF8utagqSxsyyRKuI
vmRLpmoSFmedIuHffcTKBnyU7uzDjMwgb4iUb1JHvSAY66sfSvQ=
=2Htu
-----END PGP SIGNATURE-----

--a3fvp4ouvpayx7kp--
