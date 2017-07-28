Received: from eggs.gnu.org ([2001:4830:134:3::10]:51842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1db4ck-00026N-GK
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:44:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1db4ci-0001yy-VH
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:44:10 -0400
References: <20170728123127.27921-1-olaf@aepfle.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d8aca223-4007-6524-9876-fe32fd81e893@redhat.com>
Date: Fri, 28 Jul 2017 07:43:59 -0500
MIME-Version: 1.0
In-Reply-To: <20170728123127.27921-1-olaf@aepfle.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WaaktNbJxuOfPjEoUTMfoCtnsx2m6nAOV"
Subject: Re: [Qemu-devel] [PATCH] xen-disk: use g_malloc0 to fix build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Olaf Hering <olaf@aepfle.de>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:X86" <xen-devel@lists.xenproject.org>, "open list:Block layer core" <qemu-block@nongnu.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WaaktNbJxuOfPjEoUTMfoCtnsx2m6nAOV
From: Eric Blake <eblake@redhat.com>
To: Olaf Hering <olaf@aepfle.de>, Stefano Stabellini
 <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "open list:X86" <xen-devel@lists.xenproject.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Message-ID: <d8aca223-4007-6524-9876-fe32fd81e893@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] xen-disk: use g_malloc0 to fix build
References: <20170728123127.27921-1-olaf@aepfle.de>
In-Reply-To: <20170728123127.27921-1-olaf@aepfle.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/28/2017 07:31 AM, Olaf Hering wrote:
> g_malloc0_n is available since glib-2.24. To allow build with older gli=
b
> versions use the generic g_malloc0, which is already used in many other=

> places in the code.
>=20
> Fixes commit 3284fad728 ("xen-disk: add support for multi-page shared r=
ings")
>=20
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> ---
>  hw/block/xen_disk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
> index d42ed7070d..71deec17b0 100644
> --- a/hw/block/xen_disk.c
> +++ b/hw/block/xen_disk.c
> @@ -1232,7 +1232,7 @@ static int blk_connect(struct XenDevice *xendev)
>          return -1;
>      }
> =20
> -    domids =3D g_malloc0_n(blkdev->nr_ring_ref, sizeof(uint32_t));
> +    domids =3D g_malloc0(blkdev->nr_ring_ref * sizeof(uint32_t));

This version is prone to multiplication overflow (well, maybe not, but
you have to audit for that).  Wouldn't it be better to use:

domids =3D g_new0(blkdev->nr_ring_ref, uint32_t)

which preserves the safety of g_malloc0_n?


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--WaaktNbJxuOfPjEoUTMfoCtnsx2m6nAOV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll7MY8ACgkQp6FrSiUn
Q2pFBAf+J2Kjw9u1vblnf+cwlD30cZAsh55WbfKScq+ZobQaIWFhihCyRewu28F5
2IOusRGdJX48SQLJ8BcdRBwxwHLF7IGeWzuQR6F4oyfG+XGVR/ym5jqIK7QCz652
M8gCfsHFBhAn8Ukrx5Rz9u/dUndt7YJCG+duD4xLBgVLKNXd5CMhXfc0OOKHjgI/
qOYM7Rl8aIZOgHz9KPUfL/rowjuhVi8o/HUCzYxagNluQ5OFbh+fpj042jr1hexk
oQdgH7PZ+uGbns7DdDAs/f9K3NXmJ0OEjPYTrUnLeSRqguIHFCl0u0E620ju4lbF
4C0n5WLeXYVhrrR6Iqsh06fWzakUNQ==
=pAog
-----END PGP SIGNATURE-----

--WaaktNbJxuOfPjEoUTMfoCtnsx2m6nAOV--
