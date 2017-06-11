Received: from eggs.gnu.org ([2001:4830:134:3::10]:40742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dJrix-00051z-Mi
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 21:31:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dJriw-0006dO-V0
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 21:31:27 -0400
Date: Sun, 11 Jun 2017 04:31:14 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170611013114.okggmteznc3ittnx@postretch>
References: <1497078250-19505-1-git-send-email-lizhengui@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lcpcceomutpvtenk"
Content-Disposition: inline
In-Reply-To: <1497078250-19505-1-git-send-email-lizhengui@huawei.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] bdrv_inc_in_flight and
 bdrv_dec_in_flight:
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhengui Li <lizhengui@huawei.com>
Cc: armbru@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org


--lcpcceomutpvtenk
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 10, 2017 at 03:04:10PM +0800, Zhengui Li wrote:
>Avoid empty pointer access if the bs is NULL.

Looks like most (if not all) of the places these are called dereference=20
bs anyway. Can it ever be NULL? Perhaps a check for each of those case=20
(if any) would be a better idea.

>Signed-off-by: Zhengui Li <lizhengui@huawei.com>
>---
> block/io.c | 10 +++++++---
> 1 file changed, 7 insertions(+), 3 deletions(-)
>
>diff --git a/block/io.c b/block/io.c
>index ed31810..b12d7cf 100644
>--- a/block/io.c
>+++ b/block/io.c
>@@ -492,7 +492,9 @@ static bool tracked_request_overlaps(BdrvTrackedReques=
t *req,
>
> void bdrv_inc_in_flight(BlockDriverState *bs)
> {
>-    atomic_inc(&bs->in_flight);
>+    if (bs) {
>+        atomic_inc(&bs->in_flight);
>+    }
> }
>
> static void dummy_bh_cb(void *opaque)
>@@ -508,8 +510,10 @@ void bdrv_wakeup(BlockDriverState *bs)
>
> void bdrv_dec_in_flight(BlockDriverState *bs)
> {
>-    atomic_dec(&bs->in_flight);
>-    bdrv_wakeup(bs);
>+    if (bs) {
>+        atomic_dec(&bs->in_flight);
>+        bdrv_wakeup(bs);
>+    }
> }
>
> static bool coroutine_fn wait_serialising_requests(BdrvTrackedRequest *se=
lf)
>--=20
>1.8.3.1
>
>
>

--lcpcceomutpvtenk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlk8nWEACgkQc2J8L2kN
9xDrgBAAuPvWTguHDkFN3fp/5tKGvHFq2IRtPeILeMTSz3Wew7GlDu0LiFWkzEfk
avBGsAoE+vYTUtQbH0LFI7jnhtpSR1l0jlC6lH89TRA+dM15U+WBoM5g3TaGtT3Y
OKEZ3PpIIH+3UaaVUpAPzbbP5i82ibdBBBlWQHogDDoBtFTlDwX5lqwpAWQs9aJS
DB2/mrZRc6mXk4zseJXNTYmn0Cp32u6g/KjVty02r35bHywP8B6t2gPLuOe204hc
2qi3bNahef7/qLZ6+FYcSJw/d74sZ9SdpW24QmtFvqntfQtgEyVtTck+BRtaQkY5
dp3EP7bDRIkRQ8nCgrfUsStfMINOIAUVZXB5TFA28zB8c4zhn8iWpg9CXetR0cnu
MLwATJrDJit2GyI0xO83eCJyKNiffln/xWj+LTm3RGElLNtdvlqQdbARrlZbdW2M
q+Ewikd9VUmDO69gWjApu4SLdBc/waaK4ZsY16HtJ7PJhejvoeARPybqM5lS1Ikl
E1qD/NrwpdjYkcz0wKBjOFM967b/KPynFO/5vh/woVE55zngnobH1ltwXRvQIcIV
v2jZTTNTPRLs4DAxdZRNTra1QkcOYEElChdUf7XMBngXO/FjK0jKZDZAQj2n9kKF
m1lZfblVn0rDDni3wd7dU9gqBgQ3eFc+YDw6UZcWc2TLCrGNRjE=
=90Eh
-----END PGP SIGNATURE-----

--lcpcceomutpvtenk--
