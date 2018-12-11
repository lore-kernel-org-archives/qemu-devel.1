Received: from eggs.gnu.org ([2001:4830:134:3::10]:60930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1gWjzt-0004pp-PW
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:30:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1gWjzp-0003Lu-2A
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:30:57 -0500
Received: from mo6-p00-ob.smtp.rzone.de ([2a01:238:20a:202:5300::7]:17558)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1gWjzo-0003Jh-FI
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:30:52 -0500
Date: Tue, 11 Dec 2018 16:30:47 +0100
From: Olaf Hering <olaf@aepfle.de>
Message-ID: <20181211153047.GB18447@aepfle.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R3G7APHDIzY6R/pk"
Content-Disposition: inline
Subject: [Qemu-devel] memory leak in block/xen_disk in qemu-3.x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

What are the live time rules of ioreq->buf?

In my testing the memory usage of qemu is constantly growing from about
250MB to several GB after a few days.

Some debugging shows that ioreq_runio_qemu_aio() overwrites ioreq->buf,
which contributes to the leak. In addition, ioreq_reset() also just
globbers iorew->buf. While this was observed with a backport of xen_disk
changes to qemu-2.9, the code in xen_disk.c did not change in this
regard. I changed the code to call qemu_vfree(ioreq->buf) in the few
places that globber the pointer, that fixes the leak for me.

Right now neither qemu-3.0 nor 3.1 for me, so I can not test
qemu.git#master if it eventually behaves different than
qemu.git#stable-2.9+backport.

Olaf

--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCXA/YJQAKCRBdQqD6ppg2
flJmAKCgJg3Pwe/+iJOGnJ+k7JBe/ZRmTACeIqEF7lhpQ2PtBti0q4o6q0XRVMA=
=ds9E
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--
