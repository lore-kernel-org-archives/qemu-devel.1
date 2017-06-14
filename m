Received: from eggs.gnu.org ([2001:4830:134:3::10]:40833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dL4Tt-0007Qy-8d
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 05:20:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dL4Tp-0003MS-84
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 05:20:53 -0400
Received: from mail-lf0-x233.google.com ([2a00:1450:4010:c07::233]:34594)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dL4To-0003Ll-RM
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 05:20:49 -0400
Received: by mail-lf0-x233.google.com with SMTP id v20so87556697lfa.1
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 02:20:48 -0700 (PDT)
Date: Wed, 14 Jun 2017 10:20:44 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170614092044.GB27294@stefanha-x1.localdomain>
References: <1497350121-15256-1-git-send-email-gi-oh.kim@profitbricks.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Content-Disposition: inline
In-Reply-To: <1497350121-15256-1-git-send-email-gi-oh.kim@profitbricks.com>
Subject: Re: [Qemu-devel] [PATCH v2] virtio-blk: drain block before cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gioh Kim <gi-oh.kim@profitbricks.com>
Cc: pbonzini@redhat.com, mst@redhat.com, qemu-devel@nongnu.org


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 13, 2017 at 12:35:21PM +0200, Gioh Kim wrote:
> I'd like to report one use-after-free problem which is found by AddressSanitizer.
> My company provides virtualization server with Qemu-2.7.

I have tried the following but was unable to reproduce a segfault.
Please reproduce this issue with qemu.git/master and post the steps:

  $ qemu -M accel=kvm -cpu host -m 1G \
         -drive if=none,id=drive0,file=test.img,format=raw \
	 -device virtio-blk-pci,drive=drive0,id=virtio-blk-pci0 \
	 -drive if=none,id=drive1,file.driver=null-co,file.read-zeroes=on,file.latency-ns=5000000000,format=raw \
	 -device virtio-blk-pci,drive=drive1,id=virtio-blk-pci1 \
	 -d trace:virtio_blk_\*

First I just wanted to see what happens when system_reset is invoked
while a request is in flight:

  guest$ dd if=/dev/vdb of=/dev/null iflag=direct bs=512 count=1
  (qemu) system_reset
  9491@1497430655.149154:virtio_blk_handle_read vdev 0x62d00006c910 req 0x611000b07880 sector 0 nsectors 1
  > virtio_pci_reset vdev 0x62d00006c910
  9491@1497430656.061027:virtio_blk_data_plane_stop dataplane 0x606000096c80
  9491@1497430660.152620:virtio_blk_rw_complete vdev 0x62d00006c910 req 0x611000b07880 ret 0
  9491@1497430660.152665:virtio_blk_req_complete vdev 0x62d00006c910 req 0x611000b07880 status 0
  > virtio_blk_reset vdev 0x62d00006c910

Requests are drained in virtio_blk_data_plane_stop() and again in
virtio_blk_reset() so in-flight requests will exist across system_reset.

Next I tried what you suggested:

  guest$ dd if=/dev/vdb of=/dev/null iflag=direct bs=512 count=1
  (qemu) device_del virtio-blk-pci1
  (qemu) system_reset
  9491@1497431041.871223:virtio_blk_handle_read vdev 0x62d00006c910 req 0x611001464040 sector 0 nsectors 1
  9491@1497431044.094051:virtio_blk_data_plane_stop dataplane 0x606000096c80
  9491@1497431046.874215:virtio_blk_rw_complete vdev 0x62d00006c910 req 0x611001464040 ret 0
  9491@1497431046.874256:virtio_blk_req_complete vdev 0x62d00006c910 req 0x611001464040 status 0

The request was also drained by virtio_blk_data_plane_stop().

(I added the vdev parameter to the trace events to make it easy to
identify the virtio-blk device that a request belongs to.  I will send a
patch to qemu-devel.)

Stefan

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZQP/sAAoJEJykq7OBq3PImY4IALyhxXUonR+z5tFb9Jp9EVQu
jB7OTB7h/1aVDODLdCVIYjbfdJxbPlo9DaVfL9wNVv9YXy50cFPRoK+YkeX4ZDXW
9NnvI1BWsqmIXaODiHKaLExn/mNI6sDhYaMGzzM+YSgC3IbXHZPqjNn/yKFtxaGC
FdeqENH8UZP5Dpr3BgJr7J754D/KkZVWplF8fleI0Y+GRp8sEscsFFveFjcoRnMM
W4XutM66drqJKYmmgrcDrY70kGG3NS0KpIC7oPq+rPLvXTWVqbvj2QX9KQX8I5pY
5PpCU3kAPVmJ8Fp2/apvaDQtP0eplqkyrCKqmsxQbXJK4eifnVaO/hPiExZSGY4=
=1oet
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--
