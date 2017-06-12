Received: from eggs.gnu.org ([2001:4830:134:3::10]:50903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dKQKG-00077P-Nj
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 10:28:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dKQKD-0008HC-Ho
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 10:28:16 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:35706)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dKQKD-0008Go-A6
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 10:28:13 -0400
Received: by mail-wr0-x244.google.com with SMTP id g76so22405316wrd.2
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 07:28:13 -0700 (PDT)
Date: Mon, 12 Jun 2017 15:27:55 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170612142755.GF17075@stefanha-x1.localdomain>
References: <20170611123714.31292-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5CUMAwwhRxlRszMD"
Content-Disposition: inline
In-Reply-To: <20170611123714.31292-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-nbd: Ignore SIGPIPE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>


--5CUMAwwhRxlRszMD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 11, 2017 at 02:37:14PM +0200, Max Reitz wrote:
> qemu proper has done so for 13 years
> (8a7ddc38a60648257dc0645ab4a05b33d6040063), qemu-img and qemu-io have
> done so for four years (526eda14a68d5b3596be715505289b541288ef2a).
> Ignoring this signal is especially important in qemu-nbd because
> otherwise a client can easily take down the qemu-nbd server by dropping
> the connection when the server wants to send something, for example:
>=20
> $ qemu-nbd -x foo -f raw -t null-co:// &
> [1] 12726
> $ qemu-io -c quit nbd://localhost/bar
> can't open device nbd://localhost/bar: No export with name 'bar' available
> [1]  + 12726 broken pipe  qemu-nbd -x foo -f raw -t null-co://
>=20
> In this case, the client sends an NBD_OPT_ABORT and closes the
> connection (because it is not required to wait for a reply), but the
> server replies with an NBD_REP_ACK (because it is required to reply).
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> I tried to find some other reproducer instead of using a qemu client
> (e.g. nping -c 1 --tcp-connect localhost -p 10809, which gives the same
> pattern of <FIN-ACK, >PSH-ACK, <RST as qemu-io) but to no avail. This
> only results in the write being successful and the next read failing;
> interestingly, sendmsg()'s man page states that EPIPE is only returned
> when the local end is closed. However, I have not found the NBD server
> to close that local end anywhere.
>=20
> In any case, ignoring SIGPIPE is the right thing to do. We get an EPIPE
> anyway, and this is fully sufficient to let us know that the connection
> is dead.
> ---
>  qemu-nbd.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--5CUMAwwhRxlRszMD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZPqTrAAoJEJykq7OBq3PIfRgH/39HG/agChtNxzs3N+TQeM9T
NxVquK+psPYDBv9r5fbustLYS+vvw4OJq9vblk3s0uK8UDGUGFOp3mnhip42dDHs
Lbca72CpkyYuLg8N+W8AduDHeqOotsigFwmqHjfXeTzk1fg0Y77DIgIxiwhPxnKe
C6Uoe6eoZUGooQ/gl7wHOLeq6IiBxVL0HRki3uNA7n/kJSyw6ap1HMnEarrc/CXN
KqIAZf+KuSTP7A6S7H9CERVHLqHcRsJN10x5pxRsaYQXISR7o4P9nzUjdLgNbUPN
/G/KObmfrYR/EIG1dholO7UV8dIrRZm4eVtngpkzczsq+71cfgdKFEtDvn3ZGsQ=
=ekSL
-----END PGP SIGNATURE-----

--5CUMAwwhRxlRszMD--
