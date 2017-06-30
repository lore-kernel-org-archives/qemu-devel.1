Received: from eggs.gnu.org ([2001:4830:134:3::10]:57871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dQt95-0000uZ-RP
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:27:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dQt94-0005iS-Ku
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:27:27 -0400
Date: Fri, 30 Jun 2017 11:27:16 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170630102716.GB24009@stefanha-x1.localdomain>
References: <20170628184724.21378-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Content-Disposition: inline
In-Reply-To: <20170628184724.21378-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/6] virtio: use ioeventfd in TCG and qtest
 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 28, 2017 at 07:47:18PM +0100, Stefan Hajnoczi wrote:
> This patch series fixes qemu-iotests 068.  Since commit
> ea4f3cebc4e0224605ab9dd9724aa4e7768fe372 ("qemu-iotests: 068: test iothre=
ad
> mode") the test case has attempted to use dataplane without -M accel=3Dkv=
m.
> Although QEMU is capable of running TCG or qtest with emulated ioeventfd/=
irqfd
> we haven't enabled it yet.
>=20
> Unfortunately the virtio test cases fail when ioeventfd is enabled in qte=
st
> mode.  This is because they make assumptions about virtqueue ISR signalli=
ng.
> They assume that a request is completed when ISR becomes 1.  However, the=
 ISR
> can be set to 1 even though no new request has completed since commit
> 83d768b5640946b7da55ce8335509df297e2c7cd "virtio: set ISR on dataplane
> notifications".
>=20
> This issue is solved by introducing a proper qvirtqueue_get_buf() API (si=
milar
> to the Linux guest drivers) instead of making assumptions about the ISR. =
 Most
> of the patches update the test cases to use the new API.
>=20
> Stefan Hajnoczi (6):
>   libqos: fix typo in virtio.h QVirtQueue->used comment
>   libqos: add virtio used ring support
>   tests: fix virtio-scsi-test ISR dependence
>   tests: fix virtio-blk-test ISR dependence
>   tests: fix virtio-net-test ISR dependence
>   virtio-pci: use ioeventfd even when KVM is disabled
>=20
>  tests/libqos/virtio.h    |  8 ++++++-
>  hw/virtio/virtio-pci.c   |  2 +-
>  tests/libqos/virtio.c    | 60 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  tests/virtio-blk-test.c  | 27 ++++++++++++++--------
>  tests/virtio-net-test.c  |  6 ++---
>  tests/virtio-scsi-test.c |  2 +-
>  6 files changed, 89 insertions(+), 16 deletions(-)
>=20
> --=20
> 2.9.4
>=20

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZVieEAAoJEJykq7OBq3PI87AH/jWQVpC6w/GFE2yv62gyaRKE
A4kuIDIM7NKW8gGcbj88qCNfEs+hA5dDzWaWRsJqsdD+egPs2U5R3I94DMfd7aoa
xeuemJc0ThKGh0FeDJQQZR7wcg6MK6C2chVIWn3omQlK+xpVd5/bVb17My/wcHwI
uI2oytfM9+iM5qpWj8tHJbmiVqkNeihl5DJQuubqWLzyHBHlu32w1CSjwDwTVdCa
fgxJOZ4MVAT3Bw/d7I0wMkiQKvzsRlmUAdk7eo+98sSd4s6dTdq0vv5JO9O78qp1
qN8TkJN1kiLIOT7ENwz8vZyPwSlwLFvyc0PsNKynqBVxHn3JhV4bFgMAQrueyCE=
=YfPf
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
