Received: from eggs.gnu.org ([209.51.188.92]:43130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gtpUS-0006VW-Ug
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 03:01:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gtpUN-0000xt-4F
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 03:01:56 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:44943)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gtpUM-0000tf-Q9
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 03:01:50 -0500
Received: by mail-pl1-x642.google.com with SMTP id p4so792602plq.11
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 00:01:48 -0800 (PST)
Date: Wed, 13 Feb 2019 16:01:43 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190213080143.GE26332@stefanha-x1.localdomain>
References: <1550022537-27565-1-git-send-email-changpeng.liu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2hMgfIw2X+zgXrFs"
Content-Disposition: inline
In-Reply-To: <1550022537-27565-1-git-send-email-changpeng.liu@intel.com>
Subject: Re: [Qemu-devel] [PATCH v4] virtio-blk: set correct config size for
 the host driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Changpeng Liu <changpeng.liu@intel.com>
Cc: qemu-devel@nongnu.org, ldoktor@redhat.com, mst@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, sgarzare@redhat.com


--2hMgfIw2X+zgXrFs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 13, 2019 at 09:48:57AM +0800, Changpeng Liu wrote:
> Commit caa1ee43 "vhost-user-blk: add discard/write zeroes features
> support" added fields to struct virtio_blk_config. This changes
> the size of the config space and breaks migration from QEMU 3.1
> and older:
>=20
> qemu-system-ppc64: get_pci_config_device: Bad config data: i=3D0x10 read:=
 41 device: 1 cmask: ff wmask: 80 w1cmask:0
> qemu-system-ppc64: Failed to load PCIDevice:config
> qemu-system-ppc64: Failed to load virtio-blk:virtio
> qemu-system-ppc64: error while loading state for instance 0x0 of device '=
pci@800000020000000:01.0/virtio-blk'
> qemu-system-ppc64: load of migration failed: Invalid argument
>=20
> Since virtio-blk doesn't support the "discard" and "write zeroes"
> features, it shouldn't even expose the associated fields in the
> config space actually. Just include all fields up to num_queues to
> match QEMU 3.1 and older.
>=20
> Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
> ---
>  hw/block/virtio-blk.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

Stefano: Please rebase your DISCARD/WRITE_ZEROES series onto this and
check that the config space is correctly sized.  Machine types before
4.0 shouldn't have these fields so that the config space size remains
unchanged.

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--2hMgfIw2X+zgXrFs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcY87nAAoJEJykq7OBq3PILZYIAIbmgcrfZQQjKOx6My7jcma3
MKL++Z4j80AVKv5evZ+mRc+HY6SEpB6ugwU+sbrMq3vS+9zUBdKMyj9T9C2q9XNQ
2G/FexRCd8oVU5KG+uDpjUil4Q1EN1vYd2JuY/mkgm8k59eWE+HmH6kPvSa5OdME
QDkMMwVIVQjSBGp7xarcCE48aTxB3Xaj55my69avrg8hqB96bKqoIXWFjA65lahO
vwcQwE/+OkSeYMXAVKRDtGg52/iC5M3LSHfI7Cix4hdomrLORlLCbwyFNHmjqrhn
H9ax4k076nvx1Y8IxAJdMStP2XYZoQLMZWEgHoeGjYFhTPjlLWLzhmkU1aKTQ/4=
=VJR9
-----END PGP SIGNATURE-----

--2hMgfIw2X+zgXrFs--
