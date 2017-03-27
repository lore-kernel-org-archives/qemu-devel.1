Received: from eggs.gnu.org ([2001:4830:134:3::10]:47449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1csTsP-0006MO-HU
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 08:36:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1csTsM-0003xl-EM
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 08:36:01 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:36352)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1csTsM-0003xQ-3b
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 08:35:58 -0400
Received: by mail-wr0-x235.google.com with SMTP id w11so41137458wrc.3
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 05:35:57 -0700 (PDT)
Date: Mon, 27 Mar 2017 13:35:53 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170327123553.GB28620@stefanha-x1.localdomain>
References: <87mvccaqhb.fsf@dusky.pond.sub.org>
	<20170324154710.GC5849@stefanha-x1.localdomain>
	<20170324174844.GC3823@noname.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Content-Disposition: inline
In-Reply-To: <20170324174844.GC3823@noname.redhat.com>
Subject: Re: [Qemu-devel] Question nbd_refresh_filename()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 24, 2017 at 06:48:44PM +0100, Kevin Wolf wrote:
> Am 24.03.2017 um 16:47 hat Stefan Hajnoczi geschrieben:
> > On Thu, Mar 23, 2017 at 05:48:48PM +0100, Markus Armbruster wrote:
> > > BlockdevOptionsNbd has a member SocketAddress, and nbd_config() doesn=
't
> > > restrict variants.  Thus, all four SOCKET_ADDRESS_KIND_ can occur.
> > >=20
> > > Now have a look at nbd_refresh_filename().  s->saddr->type is If
> > > SOCKET_ADDRESS_KIND_VSOCK or SOCKET_ADDRESS_KIND_FD, then @host, @port
> > > and @path all remain null, and bs->exact_filename[] is not touched.
> > >=20
> > > Does this work as intended?
> >=20
> > NDB over AF_VSOCK has not been tested.  I would expect it to fail
> > earlier than nbd_refresh_filename().
>=20
> Why would that be? Do the socket creation helper functions not support
> vsock yet?

You are right.  The following creates an AF_VSOCK connection:

  -drive if=3Dvirtio,file.driver=3Dnbd,file.server.type=3Dvsock,file.server=
=2Edata.cid=3D3,file.server.data.port=3D1234

There is no pretty filename or URL representation that block/nbd.c
parses today.  The user must specify the full file.server
VsockSocketAddress options.

I think nbd_refresh_filename() is fine from a vsock point of view.  If
we'd like to encourage NBD-over-vsock in the future we could add code to
for nbd+vsock:// but in the meantime we don't need to fill in
bs->exact_filename[].

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY2QcpAAoJEJykq7OBq3PIUvcH/jZ7nEI434tdE+H48kFTV0H6
WhQwaUcZR8FN0yO+rmFZvOAFyPFh+t3TZjeM3qIOtAqCwArtw2MyYVrABthxI5L+
8iWEckrp7vIfT1M4yvHFz+H17G/KmnI04Gkp/IrlSfmbzLgIKlSm3jC8c8opBP03
mOT5K1jplsKb6PstKqdnuADWhP8XY2QbeC9jC7CaWT2JtMFtZvif9P/ZEeb1JOvd
LjIi8nIhzMILByddUjytCRSqAlBetJD0XhvdvsXNYfkGvLADsW6ZwaSlixTBhjqO
puidDTJa6IVgmEnXel+1goQpsAsmrb/dg6wGYal/B7nc8ChJoNMOgbP2yxkl6as=
=82IX
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--
