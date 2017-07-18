Received: from eggs.gnu.org ([2001:4830:134:3::10]:53025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dXOjS-0004F8-AH
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 05:23:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dXOjR-0000zm-E9
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 05:23:54 -0400
Date: Tue, 18 Jul 2017 12:21:01 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170718092101.vskdqunxuo4ysjpw@postretch>
References: <20170714094521.4909-1-el13635@mail.ntua.gr>
	<20170714094521.4909-6-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v4klhuiq3otfgruw"
Content-Disposition: inline
In-Reply-To: <20170714094521.4909-6-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 5/7] block: add throttle block
 filter driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>


--v4klhuiq3otfgruw
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 14, 2017 at 12:45:19PM +0300, Manos Pitsidianakis wrote:
>+static BlockDriver bdrv_throttle =3D {
>+    .format_name                        =3D   "throttle",
>+    .protocol_name                      =3D   "throttle",
>+    .instance_size                      =3D   sizeof(ThrottleGroupMember),
>+
>+    .bdrv_file_open                     =3D   throttle_open,
>+    .bdrv_close                         =3D   throttle_close,
>+    .bdrv_co_flush                      =3D   throttle_co_flush,
>+
>+    .bdrv_child_perm                    =3D   bdrv_filter_default_perms,
>+
>+    .bdrv_getlength                     =3D   throttle_getlength,
>+
>+    .bdrv_co_preadv                     =3D   throttle_co_preadv,
>+    .bdrv_co_pwritev                    =3D   throttle_co_pwritev,
>+
>+    .bdrv_co_pwrite_zeroes              =3D   throttle_co_pwrite_zeroes,
>+    .bdrv_co_pdiscard                   =3D   throttle_co_pdiscard,
>+
>+    .bdrv_recurse_is_first_non_filter   =3D   bdrv_recurse_is_first_non_f=
ilter,

This is wrong! There should be a separate function to pass=20
bdrv_recurse_is_first_non_filter to bs->file->bs.


>+    .bdrv_attach_aio_context            =3D   throttle_attach_aio_context,
>+    .bdrv_detach_aio_context            =3D   throttle_detach_aio_context,
>+
>+    .bdrv_reopen_prepare                =3D   throttle_reopen_prepare,
>+    .bdrv_reopen_commit                 =3D   throttle_reopen_commit,
>+    .bdrv_reopen_abort                  =3D   throttle_reopen_abort,
>+
>+    .is_filter                          =3D   true,
>+};
>+
>+static void bdrv_throttle_init(void)
>+{
>+    bdrv_register(&bdrv_throttle);
>+}
>+
>+block_init(bdrv_throttle_init);
>diff --git a/include/qemu/throttle-options.h b/include/qemu/throttle-optio=
ns.h
>index 182b7896e1..508ee72625 100644
>--- a/include/qemu/throttle-options.h
>+++ b/include/qemu/throttle-options.h
>@@ -29,6 +29,7 @@
> #define QEMU_OPT_BPS_WRITE_MAX "bps-write-max"
> #define QEMU_OPT_BPS_WRITE_MAX_LENGTH "bps-write-max-length"
> #define QEMU_OPT_IOPS_SIZE "iops-size"
>+#define QEMU_OPT_THROTTLE_GROUP_NAME "throttling-group"
>
> #define THROTTLE_OPT_PREFIX "throttling."
> #define THROTTLE_OPTS \
>--=20
>2.11.0
>
>
>

--v4klhuiq3otfgruw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAllt0v0ACgkQc2J8L2kN
9xCbJg//SRtx3+C/zWqbc9Yxi6rR1H0PVUKcWCl0L/06GBWCSR+lHM2KkVpv7nDZ
jfePrjGCLkRPN5llRclfKxMyqcSwqbt0QFq+BlqwoUsnR5rBMsfPnnIlqxH2u4Yj
uyNN0Fga9viN6nu4gVyOeCU0o3uq/jh1ExVpLkbCGfF7kRllzNG7Hp66Szr5myUD
MyUIHw2+MPPIPhNxq8bTWAETyrrvAVobzaxuMJRl5kiceUDGC8XHN772Z0qQIzRv
dzM31XmV9XaoAoSqjiEvG+VO9wbS+An3foq4osGSMfUh+TYLjswfTwBY9tV4jUaW
rnwVw6DvUhhGfjgI7AyZksRHfqOyE2NvZFC24FoGzyQgVK3I07FEc4rDhTwMxx+U
0LvgmnIhxOYrj8/lyFysiAViaYTdHIt1iZ1e+B0dPAl6QdYapggx2IjW3iz87PLP
OYo2zCPxveh7bAPHD7LB6HHk9S6Dmd5VMQZ7Ajan4SJktsILJoQdxcBHEBqi3U1e
6G2bUHPuWy4CLZT0riOGk9AFkyoQ4EM56OkWPZ8kNMfvPntWR3+A53iMlXvUAbcO
QNqqZX42VqvSpfShRQJeCGcTS5761wJ5vWGdJk8648OQMOYp2KG6um0p/NRodX0k
IlVg+HGvVvfT68RLhOHMecXl867TpgyHY3B2ABagSNTk6QmvNB4=
=+gOj
-----END PGP SIGNATURE-----

--v4klhuiq3otfgruw--
