Received: from eggs.gnu.org ([2001:4830:134:3::10]:40407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cEJdd-0005zC-UR
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 12:34:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cEJdZ-0001d1-0m
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 12:34:45 -0500
Received: from mail-wj0-f195.google.com ([209.85.210.195]:32871)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cEJdY-0001cQ-P6
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 12:34:40 -0500
Received: by mail-wj0-f195.google.com with SMTP id kp2so45185585wjc.0
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 09:34:40 -0800 (PST)
Date: Tue, 6 Dec 2016 17:33:37 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20161206173337.GB30363@stefanha-x1.localdomain>
References: <1481016553-69252-1-git-send-email-arei.gonglei@huawei.com>
	<20161206153945-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NDin8bjvE/0mNLFQ"
Content-Disposition: inline
In-Reply-To: <20161206153945-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH for-2.8] virtio-crypto: zeroize the key
 material before free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gonglei <arei.gonglei@huawei.com>, qemu-devel@nongnu.org


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 06, 2016 at 03:40:49PM +0200, Michael S. Tsirkin wrote:
> On Tue, Dec 06, 2016 at 05:29:13PM +0800, Gonglei wrote:
> > Zeroize the memory of CryptoDevBackendSymOpInfo structure pointed
> > for key material security.
> >=20
> > Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> > ---
> >  hw/virtio/virtio-crypto.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
> > index 2f2467e..ecb19b6 100644
> > --- a/hw/virtio/virtio-crypto.c
> > +++ b/hw/virtio/virtio-crypto.c
> > @@ -337,7 +337,18 @@ static void virtio_crypto_free_request(VirtIOCrypt=
oReq *req)
> >  {
> >      if (req) {
> >          if (req->flags =3D=3D CRYPTODEV_BACKEND_ALG_SYM) {
> > -            g_free(req->u.sym_op_info);
> > +            size_t max_len;
> > +            CryptoDevBackendSymOpInfo *op_info =3D req->u.sym_op_info;
> > +
> > +            max_len =3D op_info->iv_len +
> > +                      op_info->aad_len +
> > +                      op_info->src_len +
> > +                      op_info->dst_len +
> > +                      op_info->digest_result_len;
> > +
> > +            /* Zeroize and free request data structure */
> > +            memset(op_info, 0, sizeof(*op_info) + max_len);
> > +            g_free(op_info);
>=20
> Write into memory, then free it?  This looks rather strange. Why are we
> doing this?

Common practice with sensitive information (key material, passwords,
etc).

Prevents sensitive information from being exposed by accident later in
coredumps, memory disclosure bugs when heap memory is reused, etc.

Sensitive information is sometimes also held in mlocked pages to prevent
it being swapped to disk but that's not being done here.

Perhaps the comment should be more explicit but this patch seems
reasonable.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYRvZxAAoJEJykq7OBq3PIDtgH/1kFUNuB8dEQHXEfWjdX1waP
tCFQkYV3Ueo19xYbT/Z+ds5coOl9p8UKcxyhwRftwPbSO623yDNVZeCStvA87O4z
3tWt2XMPeW+FkyzlgNBifFPrOwZU14GAXbSLhCJTWngq7tf0GC1gL81+bPiagtGg
+bQwPkg2z+16wEI59M0zr7smET4Jd+EA0/J+tsEAsunvMyAWJKRMMJlaZVxpRF6Z
VwafEazbeJaIdxlsxzcJNDS12B5n9mrphLapavd5HdPKv7QKGr7nWS7RKY5ym6XC
j2p/tgr0vuhzQqVveH+w7hETMCda4B816PdEoY6HiAAGa2zrPx8IHhftzU44LSQ=
=fU0b
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--
