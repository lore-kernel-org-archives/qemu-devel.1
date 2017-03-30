Received: from eggs.gnu.org ([2001:4830:134:3::10]:40944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ctbft-0004t6-2a
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:07:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ctbfo-0001LI-3y
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:07:45 -0400
Received: from 6.mo4.mail-out.ovh.net ([188.165.36.253]:49919)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ctbfn-0001KW-U1
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 11:07:40 -0400
Received: from player159.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 80BFF5AAED
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 17:07:37 +0200 (CEST)
Date: Thu, 30 Mar 2017 17:07:32 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170330170732.549c9dde@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <5402615e-7085-4cac-1eb9-15f1f62b8c73@redhat.com>
References: <149086238428.3338.4129463785289801461.stgit@bahia.lan>
	<5402615e-7085-4cac-1eb9-15f1f62b8c73@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/DspAF4Q.vbzVlDD2ziwULuz";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH for-2.9?] 9pfs: fix multiple flush for same
 request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Li Qiang <liqiang6-s@360.cn>

--Sig_/DspAF4Q.vbzVlDD2ziwULuz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 30 Mar 2017 08:18:34 -0500
Eric Blake <eblake@redhat.com> wrote:

> On 03/30/2017 03:26 AM, Greg Kurz wrote:
> > If a client tries to flush the same outstanding request several times, =
only
> > the first flush completes. Subsequent ones keep waiting for the request
> > completion in v9fs_flush() and, therefore, leak a PDU. This will cause =
QEMU
> > to hang when draining active PDUs the next time the device is reset. =20
>=20
> Since this fixes a hang, is it 2.9 material?
>=20

Yes, definitely, I just forgot to add the for-2.9 tag :)

> >=20
> > Let have each flush request wake up the next one if any. The last waiter
> > frees the cancelled PDU.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/9pfs/9p.c |    6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >  =20
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> > diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> > index 48babce836b6..ef47a0a5ad6f 100644
> > --- a/hw/9pfs/9p.c
> > +++ b/hw/9pfs/9p.c
> > @@ -2387,8 +2387,10 @@ static void coroutine_fn v9fs_flush(void *opaque)
> >           * Wait for pdu to complete.
> >           */
> >          qemu_co_queue_wait(&cancel_pdu->complete, NULL);
> > -        cancel_pdu->cancelled =3D 0;
> > -        pdu_free(cancel_pdu);
> > +        if (!qemu_co_queue_next(&cancel_pdu->complete)) {
> > +            cancel_pdu->cancelled =3D 0;
> > +            pdu_free(cancel_pdu);
> > +        }
> >      }
> >      pdu_complete(pdu, 7);
> >  }
> >=20
> >=20
> >  =20
>=20


--Sig_/DspAF4Q.vbzVlDD2ziwULuz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAljdHzUACgkQAvw66wEB28IluQCgiQaBfovR2WXK6SWQrVuohUN2
iyYAnjxflgJpFx+xtbwOYMOqMU+JLEjB
=Hp+l
-----END PGP SIGNATURE-----

--Sig_/DspAF4Q.vbzVlDD2ziwULuz--
