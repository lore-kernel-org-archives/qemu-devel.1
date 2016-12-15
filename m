Received: from eggs.gnu.org ([2001:4830:134:3::10]:47973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cHRLw-0005ys-R4
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 03:25:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cHRLr-0007NP-T0
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 03:25:24 -0500
Received: from mail-wj0-f193.google.com ([209.85.210.193]:36239)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cHRLr-0007N3-Lx
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 03:25:19 -0500
Received: by mail-wj0-f193.google.com with SMTP id j10so8393884wjb.3
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 00:25:19 -0800 (PST)
Date: Thu, 15 Dec 2016 08:24:16 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20161215082416.GG26169@stefanha-x1.localdomain>
References: <b1ac8aec-e9cc-99f8-0881-bef03acc2954@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yQbNiKLmgenwUfTN"
Content-Disposition: inline
In-Reply-To: <b1ac8aec-e9cc-99f8-0881-bef03acc2954@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] commit virtio: recalculate vq->inuse after
 migration might cause last_avail_idx vs. used_idx failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>


--yQbNiKLmgenwUfTN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 14, 2016 at 08:12:17PM +0100, Halil Pasic wrote:
> We have a migration problem, which is in my opinion caused by a
> deficiency in how vq->inuse is calculated after the migration (commit
> bccdef6b  "virtio: recalculate vq->inuse after migration" to
> blame).
>=20
>=20
> We got a bugreport with this log for a live migration target.=20
>=20
> 2016-12-13T18:59:03.647309Z qemu-system-s390x: VQ 1 size 0x100 < last_ava=
il_idx 0x2f76 - used_idx 0x762f

Thanks for spotting the signedness bug described below.  Regardless of
the bug last_avail_idx 0x2f76 - used_idx 0x762f is still an invalid
state and should be treated as an error.  The virtqueue only has 256
elements so there's no way these descriptor indices can be valid.  I
wanted to point that out since there must be another problem remaining
somewhere.

> 2016-12-13T18:59:03.647385Z qemu-system-s390x: error while loading state =
for instance 0x0 of device '/fe.0.0001/virtio-net'
> 2016-12-13T18:59:03.647540Z qemu-system-s390x: load of migration failed: =
Operation not permitted
> 2016-12-13 18:59:03.796+0000: shutting down, reason=3Dfailed
>=20
> They use QEMU version 2.7 but looking at the current git master
> I think this did not get fixed in the meanwhile.
>=20
> So here goes the argument. The recalculation is done like this:
>=20
> +            vdev->vq[i].inuse =3D vdev->vq[i].last_avail_idx -
> +                                vdev->vq[i].used_idx;
>=20
> This does not seem correct when last_avail_idx has already
> wrapped around but used_idx not yet. We see from the log that
> last_avail_idx  (0x2f76) less that used_idx (0x762f) thus
> inuse (of type int) ends up being negative.

Good catch.  This works:

vdev->vq[i].inuse =3D (uint16_t)(vdev->vq[i].last_avail_idx - vdev->vq[i].u=
sed_idx);

> Do we want to try to fix this for 2.8? I already have a small patch prepa=
red.

Please send the fix for 2.8.1 (-stable).  2.8.0-rc4 is currently being
tagged and build tested, it's too late to change it.

Stefan

--yQbNiKLmgenwUfTN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYUlMwAAoJEJykq7OBq3PIr8gIAKCnHP0c/fT6Vb8UEqYf3hTP
9An1tGWCoVAhg2QapcYpqwb8dou7egVANWmT9fXJ9TKPnqLIs39KkKW4GThg32ss
Sjpbn8gFMVY6PKIoeBOBoPq5jGhK+w68ExQqY3YkDMU2beHHGeSsdnbEYKnlXwp0
aG86uYKXknr/TxfcMCNy6kXvl1OAhsM2BBYIDEFUB+9O036OL2F4aDYRt3gWV0SF
mLF6zCsvdgU4//dURY81VGfJBoGdx7BHs5BAzmb1VaN4Xa/GizwHfw4gJvNalMgq
iCtHZlNZKwwEKWd3akxjMfrAHemQm/DHLCsNWZAcIdq2bPCw55i+aa9hAcbQdkI=
=nUhj
-----END PGP SIGNATURE-----

--yQbNiKLmgenwUfTN--
