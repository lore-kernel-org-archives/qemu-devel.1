Received: from eggs.gnu.org ([2001:4830:134:3::10]:46441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e867B-0006IF-Fh
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 11:00:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e8677-0004eM-Kq
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 11:00:05 -0400
References: <150910197146.135.17776883444899005130@bafd83ae6430>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b42deeae-9ec5-0c2f-f14b-33dc99229ec2@redhat.com>
Date: Fri, 27 Oct 2017 16:59:47 +0200
MIME-Version: 1.0
In-Reply-To: <150910197146.135.17776883444899005130@bafd83ae6430>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qRqOMi4RFiJuiTbDV6jMKmJmFIBrDVABx"
Subject: Re: [Qemu-devel] [PATCH v6 00/12] nbd minimal structured read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, pbonzini@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qRqOMi4RFiJuiTbDV6jMKmJmFIBrDVABx
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, pbonzini@redhat.com, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org
Message-ID: <b42deeae-9ec5-0c2f-f14b-33dc99229ec2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 00/12] nbd minimal structured read
References: <150910197146.135.17776883444899005130@bafd83ae6430>
In-Reply-To: <150910197146.135.17776883444899005130@bafd83ae6430>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/27/2017 12:59 PM, no-reply@patchew.org wrote:
> Hi,
>=20
> This series failed build test on ppc host. Please find the details belo=
w.
>=20

> /var/tmp/patchew-tester-tmp-xb4sc6ly/src/nbd/server.c: In function =E2=80=
=98nbd_co_client_start=E2=80=99:
> /var/tmp/patchew-tester-tmp-xb4sc6ly/src/nbd/server.c:819:12: error: =E2=
=80=98ret=E2=80=99 may be used uninitialized in this function [-Werror=3D=
maybe-uninitialized]
>          if (ret < 0) {
>             ^
> /var/tmp/patchew-tester-tmp-xb4sc6ly/src/nbd/server.c:647:13: note: =E2=
=80=98ret=E2=80=99 was declared here
>          int ret;
>              ^

Real bug when reporting success on NBD_OPT_STARTTLS.

This should fix it; I'll squash it into the right place in the series.

diff --git i/nbd/server.c w/nbd/server.c
index ea9fe9970f..2b617f3cd1 100644
--- i/nbd/server.c
+++ w/nbd/server.c
@@ -693,6 +693,7 @@ static int nbd_negotiate_options(NBDClient *client,
uint16_t myflags,
                 if (!tioc) {
                     return -EIO;
                 }
+                ret =3D 0;
                 object_unref(OBJECT(client->ioc));
                 client->ioc =3D QIO_CHANNEL(tioc);
                 break;

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--qRqOMi4RFiJuiTbDV6jMKmJmFIBrDVABx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnzSeMACgkQp6FrSiUn
Q2oyPQf+J0DxF4PPvEyfK/oy0EIC8C1TqeLd2MJAyyPe2P8UN9oz4tRXKJTEBaVy
AJYAi51w3yHzSRWff66Tg39MAsxq3McxofTHILiWIYKBI0urg5Ix19qMoa0pR9sR
vSPaP2pGVGFxPT+QUDyOAm/5MEYepYeU+t3pmFOMtCg5CItLXcX5gxscXWUzJyq/
sd/c78zJ4boC79vzl03T7G0rwbqcPIlPU9dPwgBLDpq0CCJBghZU5r2CS+n2v+D3
w8j50wjIopz/CLFe9mOzgWn2PCNCbTLwimOKlEKC829dT+MhxQKOf71if6fXNQGV
WeOJGwJckDgJI1+cqEkhaC+SBY8vQA==
=nCMy
-----END PGP SIGNATURE-----

--qRqOMi4RFiJuiTbDV6jMKmJmFIBrDVABx--
