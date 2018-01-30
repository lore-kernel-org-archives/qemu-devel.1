Received: from eggs.gnu.org ([2001:4830:134:3::10]:34095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1egREf-0003Kg-FY
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 03:25:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1egREb-0002yg-IN
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 03:25:45 -0500
Received: from 10.mo4.mail-out.ovh.net ([188.165.33.109]:37605)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1egREb-0002xn-Al
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 03:25:41 -0500
Received: from player798.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 7164A140F63
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 09:25:38 +0100 (CET)
Date: Tue, 30 Jan 2018 09:25:31 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180130092531.52c4eb37@bahia.lan>
In-Reply-To: <20180129211431.GA1640@stefanha-x1.localdomain>
References: <151675071042.29381.16225631028845063799.stgit@bahia.lan>
	<151675076332.29381.6289851186190918274.stgit@bahia.lan>
	<20180129211431.GA1640@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/G6E.19/myIf6TP5_hAtKx.2";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 5/7] tests: virtio-9p: add WRITE operation
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

--Sig_/G6E.19/myIf6TP5_hAtKx.2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 29 Jan 2018 21:14:31 +0000
Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Wed, Jan 24, 2018 at 12:39:23AM +0100, Greg Kurz wrote:
> > +/* size[4] Twrite tag[2] fid[4] offset[8] count[4] data[count] */
> > +static P9Req *v9fs_twrite(QVirtIO9P *v9p, uint32_t fid, uint64_t offse=
t,
> > +                          uint32_t count, const void *data, uint16_t t=
ag)
> > +{
> > +    P9Req *req;
> > +
> > +    req =3D v9fs_req_init(v9p,  4 + 8 + 4 + count, P9_TWRITE, tag); =20
>=20
> (uint32_t)(4 + 8 + 4 + (uint32_t)count) can overflow.  I didn't look
> closely at the code and it's just a test case, but it seems safer to use
> types that avoid overflows or to handle them explicitly.
>=20
> It may not be an issue in a test case, but if someone copy pastes this
> code it could become a security issue.

You're right. I'll add something like:

    uint32_t body_size =3D 4 + 8 + 4;

    g_assert_cmpint(body_size, <=3D, UINT32_MAX - count);

and I now realize that several other places in this file need
a similar change.

--Sig_/G6E.19/myIf6TP5_hAtKx.2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlpwK/sACgkQcdTV5YIv
c9Yg5xAAitN0pA0LC1SELyXN8rS47zlRSAxsHFgFxrJq81BtABGXk/oKa896lxFT
1/CcfqK9/6OQ89JRxmYOAFBwNxpSi+NUFxmemEQmyTmMl35WrCAN//qUrPY6akVh
hDRZFc4UJ2en50zeh4Cho+VvbZq2f9PCTCKqsf4G1sRp6eqGDvH0/wSUmdobMkFV
N0v4kbNcUE5b3v9KJEm5dbBaSZd28KYzoqaVUDk1GLACiM33YQtWuBq7FLBAGEOd
AePhdyJMos+6+1U0ZtlwnOl7YFNGfxoqk7AUzyp1bYFQxYf9nRgC/1v/5acBTElp
ESVBfhBxU7qftesHP04NL1awfbferNP6Dzyj3IAdBAmkuBJxOacUayTeSvMfvdw0
y5/8sFBJSjx7a1ULAzL8PPYrgnCrQtNeceWH3wuV3SPNK82LlVurpxGLAwBMuA+w
uIeLMlV+GYAoHH7OEo/teapBuTZIhntsYKo6C3vcPoiRi46rQ7S4YZZbcXxlOlkv
NwYPTf9IJ9OzvLi4KRReWazbRsdOEDKMUjoPemDnITryLmkenm2i5dEZyyb0V5Mr
vNUiVRIlaioCJN/EebZO/mltox9EZUwLfJDgkKkkZmbtBWb68NiIIlrziZwo8O8i
abJtETnYyXBp+k4tZthFtmhN1imDAhWtPxd3HddCitRZQEijZ5I=
=ulVN
-----END PGP SIGNATURE-----

--Sig_/G6E.19/myIf6TP5_hAtKx.2--
