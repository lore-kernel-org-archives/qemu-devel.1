Received: from eggs.gnu.org ([2001:4830:134:3::10]:54603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d86j6-0007hj-Dz
	for qemu-devel@nongnu.org; Tue, 09 May 2017 11:07:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d86j0-0008Rf-Pc
	for qemu-devel@nongnu.org; Tue, 09 May 2017 11:07:00 -0400
Date: Tue, 9 May 2017 11:06:45 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170509150645.GG16825@stefanha-x1.localdomain>
References: <20170508180705.20609-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f5QefDQHtn8hx44O"
Content-Disposition: inline
In-Reply-To: <20170508180705.20609-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] aio: add missing aio_notify() to
 aio_enable_external()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>


--f5QefDQHtn8hx44O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 08, 2017 at 02:07:05PM -0400, Stefan Hajnoczi wrote:
> The main loop uses aio_disable_external()/aio_enable_external() to
> temporarily disable processing of external AioContext clients like
> device emulation.
>=20
> This allows monitor commands to quiesce I/O and prevent the guest from
> submitting new requests while a monitor command is in progress.
>=20
> The aio_enable_external() API is currently broken when an IOThread is in
> aio_poll() waiting for fd activity when the main loop re-enables
> external clients.  Incrementing ctx->external_disable_cnt does not wake
> the IOThread from ppoll(2) so fd processing remains suspended and leads
> to unresponsive emulated devices.
>=20
> This patch adds an aio_notify() call to aio_enable_external() so the
> IOThread is kicked out of ppoll(2) and will re-arm the file descriptors.
>=20
> The bug can be reproduced as follows:
>=20
>   $ qemu -M accel=3Dkvm -m 1024 \
>          -object iothread,id=3Diothread0 \
>          -device virtio-scsi-pci,iothread=3Diothread0,id=3Dvirtio-scsi-pc=
i0 \
>          -drive if=3Dnone,id=3Ddrive0,aio=3Dnative,cache=3Dnone,format=3D=
raw,file=3Dtest.img \
>          -device scsi-hd,id=3Dscsi-hd0,drive=3Ddrive0 \
>          -qmp tcp::5555,server,nowait
>=20
>   $ scripts/qmp/qmp-shell localhost:5555
>   (qemu) blockdev-snapshot-sync device=3Ddrive0 snapshot-file=3Dsn1.qcow2
>          mode=3Dabsolute-paths format=3Dqcow2
>=20
> After blockdev-snapshot-sync completes the SCSI disk will be
> unresponsive.  This leads to request timeouts inside the guest.
>=20
> Reported-by: Qianqian Zhu <qizhu@redhat.com>
> Suggested-by: Fam Zheng <famz@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v3:
>  * s/dec_fetch/fetch_dec/ [Fam]
> ---
>  include/block/aio.h | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--f5QefDQHtn8hx44O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZEdsFAAoJEJykq7OBq3PIyMQH/REGMPf5DwTtJZN1n01gc4K7
Kccmt3WSk7Iy2v1whJyqwawJ5WYHiWuQvih65ShdkcwIAJDibETPFUWnlq2SIFT8
O+qIcLZ+QeivqNz0GgTLGiRwecVe/rxFXfdgGIfotigJtHVaEh2l43L8kReTSImP
5HJNh+pLr+/eelI1iPyZm8MnGolbKeEMgUcCcB1/ckzwb8OFwSGQvcWA2+8MAsOs
ha/3rGyC8fieAr6Xpw2M+EPgGegTv4qdXsnTI43d4IKQnoDwii4GN9PYe61p+/vM
PdtX59kjuUNA6GzypJbez0M6uHki7GkeaqoqexbPJA/1bEYUicEZGz5IozKrYPA=
=qwah
-----END PGP SIGNATURE-----

--f5QefDQHtn8hx44O--
