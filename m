Received: from eggs.gnu.org ([2001:4830:134:3::10]:34700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f3L22-0006BW-UP
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 08:27:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f3L1x-0003Wc-TC
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 08:27:22 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:32781)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1f3L1x-0003WH-Ki
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 08:27:17 -0400
Received: by mail-wr0-x232.google.com with SMTP id z73so18558781wrb.0
	for <qemu-devel@nongnu.org>; Tue, 03 Apr 2018 05:27:17 -0700 (PDT)
Date: Tue, 3 Apr 2018 13:27:14 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180403122714.GB4467@stefanha-x1.localdomain>
References: <41b63d9b-c551-4e22-28f5-1144724dff2e@virtuozzo.com>
	<b446d661-f0f1-2fcb-ada1-b08af58a9c27@redhat.com>
	<618a6c6e-ab1a-1c55-d44d-847c0e3729f4@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Content-Disposition: inline
In-Reply-To: <618a6c6e-ab1a-1c55-d44d-847c0e3729f4@virtuozzo.com>
Subject: Re: [Qemu-devel] Some thoughts about per-queue iothreads in
 VirtIOBlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, "Denis V. Lunev" <den@openvz.org>


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 20, 2018 at 07:30:04PM +0300, Edgar Kaziakhmedov wrote:
>=20
> On 3/20/18 6:34 PM, Paolo Bonzini wrote:
> > On 20/03/2018 15:45, Edgar Kaziakhmedov wrote:
> >=20
> > > As I understood from
> > > Stefan description, it is expected to change significantly
> > > the approach we use to interact with BlockDriverState.
> > I don't think the change is very large actually, at least for on-disk
> > devices.  I haven't yet considered network devices such as libiscsi or =
ceph.
>=20
> Well, in that case, I will keep working on per-queue iothreads with an
> existing interface.
> I asked because it might be reasonable to create BlockBackend device for
> each queue context and
> use them independently to avoid some additional locks and synchronization.
> On the other hand, it can lead to multiple
> opening of the same image, but as I said it doesn't seem to be a problem =
for
> the simplest formats such as raw.

The special case for raw approach is not suitable for upstream QEMU.
It's what we started with in -device virtio-blk,x-data-plane=3Don (see the
old dataplane implementation in QEMU v1.4).

It took a lot of work to make the IOThread use the QEMU block layer
instead of a special case code path for raw.

Currently QEMU is not that far away from being able to use
BlockDriverState from multiple threads for multiqueue.

Paolo, can you share your current progress and pointers to what needs to
be done next?  Maybe Edgar can help complete the work.

Stefan

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaw3MiAAoJEJykq7OBq3PIYYoH+wSHcv2YuKMZ0KBMb4GMGIBc
lrJOmJwCMbn+Sk8zHpJxsYAiJPT4g8asIWUjL3qp0SD6TS3OAhn3cqB9H+h1GrIr
cv7+jFTzjkZVe79IioDjzX3BN4qZCIwZUvLyH884cGrk0MQqYVEyArR5DgSyzwSr
e0kApAGHuOcslKGg2FaXqMZNSe9+ZI5JsaP5GkhILV6A850By65ZlulwctNr2xZz
oE/yercNMH9W3dydglSo9uHHwCFgTFUvRs7hof/rGEjmlmtr5UgNPiloZykJTPZJ
+qldf3xzmSBCh+XMbU2jhrOrpt/7fyinH2Kj5ofjZe1g+XV8WtbdTfb3fODrDF4=
=UhYr
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
