Received: from eggs.gnu.org ([2001:4830:134:3::10]:39742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cqKzg-000366-4T
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 10:42:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cqKzb-0006vN-4j
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 10:42:40 -0400
Received: from 12.mo5.mail-out.ovh.net ([46.105.39.65]:52444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cqKza-0006uF-U5
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 10:42:35 -0400
Received: from player695.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 10682E0E72
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 15:42:33 +0100 (CET)
Date: Tue, 21 Mar 2017 15:42:29 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170321154229.1084c0e7@bahia.lan>
In-Reply-To: <2deb61ba-f800-8774-6dfa-aa4e7c605e55@redhat.com>
References: <148968198512.5555.1880820193606077571.stgit@bahia>
	<2deb61ba-f800-8774-6dfa-aa4e7c605e55@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/98au35qj2Dsg+z8saGKYvaq";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] 9pfs: don't try to flush self and avoid
 QEMU hang on reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org

--Sig_/98au35qj2Dsg+z8saGKYvaq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 21 Mar 2017 09:01:50 -0500
Eric Blake <eblake@redhat.com> wrote:

> On 03/16/2017 11:33 AM, Greg Kurz wrote:
> > According to the 9P spec [*], when a client wants to cancel a pending I=
/O
> > request identified by a given tag (uint16), it must send a Tflush messa=
ge
> > and wait for the server to respond with a Rflush message before reusing=
 this
> > tag for another I/O. The server may still send a completion message for=
 the
> > I/O if it wasn't actually cancelled but the Rflush message must arrive =
after
> > that.
> >=20
> > QEMU hence waits for the flushed PDU to complete before sending the Rfl=
ush
> > message back to the client.
> >=20
> > If a client sends 'Tflush tag oldtag' and tag =3D=3D oldtag, QEMU will =
then
> > allocate a PDU identified by tag, find it in the PDU list and wait for
> > this same PDU to complete... i.e. wait for a completion that will never
> > happen. This causes a tag and ring slot leak in the guest, and a PDU
> > leak in QEMU, all of them limited by the maximal number of PDUs (128).
> > But, worse, this causes QEMU to hang on device reset since v9fs_reset()
> > wants to drain all pending I/O.
> >=20
> > This insane behavior is likely to denote a bug in the client, and it wo=
uld
> > deserve an Rerror message to be sent back. Unfortunately, the protocol
> > allows it and requires all flush requests to suceed (only a Tflush resp=
onse =20
>=20
> s/suceed/succeed/
>=20
> > is expected).
> >=20
> > The only option is to detect when we have to handle a self-referencing
> > flush request and report success to the client right away.
> >=20
> > [*] http://man.cat-v.org/plan_9/5/flush
> >=20
> > Reported-by: Al Viro <viro@ZenIV.linux.org.uk>
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/9pfs/9p.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >  =20
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20

Oh, I've sent a v2 for this patch (error_report() a warning) and it is
actually part of the pull request I've sent earlier today... dunno how
to have your Reviewed-by: added there.

Thanks.

--
Greg

--Sig_/98au35qj2Dsg+z8saGKYvaq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAljRO9YACgkQAvw66wEB28JjnwCfeZSibRYgnQuZV+mhRx3hZD4w
9k0AoKI0XKnxcjeE9lVtaTsW2FOLgYfb
=+uKr
-----END PGP SIGNATURE-----

--Sig_/98au35qj2Dsg+z8saGKYvaq--
