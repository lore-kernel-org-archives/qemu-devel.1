Received: from eggs.gnu.org ([2001:4830:134:3::10]:41280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dO2mh-000108-3v
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 10:08:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dO2md-0001Pi-5T
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 10:08:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40275)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dO2mc-0001O2-Uo
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 10:08:31 -0400
Date: Thu, 22 Jun 2017 15:08:27 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170622140827.GA29936@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
Subject: [Qemu-devel] NVDIMM live migration broken?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: haozhong.zhang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I tried live migrating a guest with NVDIMM on qemu.git/master (edf8bc984):

  $ qemu -M accel=kvm,nvdimm=on -m 1G,slots=4,maxmem=8G -cpu host \
         -object memory-backend-file,id=mem1,share=on,mem-path=nvdimm.dat,size=1G \
	 -device nvdimm,id=nvdimm1,memdev=mem1 \
	 -drive if=virtio,file=test.img,format=raw

  $ qemu -M accel=kvm,nvdimm=on -m 1G,slots=4,maxmem=8G -cpu host \
         -object memory-backend-file,id=mem1,share=on,mem-path=nvdimm.dat,size=1G \
	 -device nvdimm,id=nvdimm1,memdev=mem1 \
	 -drive if=virtio,file=test.img,format=raw \
	 -incoming tcp::1234

  (qemu) migrate tcp:127.0.0.1:1234

The guest kernel panics or hangs every time on the destination.  It
happens as long as the nvdimm device is present - I didn't even mount it
inside the guest.

Is migration expected to work?

If not we need a migration blocker so that users get a graceful error
message.

Stefan

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZS89bAAoJEJykq7OBq3PI9WkIAK0L0XDPYWlehBXi3FJCs3y9
38S1YZNl9ei61UTDVYs7kfWL6zzYvu7hbF7BVQSvh0Fap5X7hZmmX5mq3eJesmo1
Fx/Ff2y6vupNQ1HJyuEfLHOG2fPRaqqDSwFpMfX4GOaPsxn0u8MAMvHHlan6HSFe
0BkXvtFqMzcv8pJWpl1PcN+YWP4n4ETIdGURMw2/CCmiMyZf8B2dlsOhOKTNo/vx
tXhZlX5y/5v9nr8DCau5koniTXrOFI1v/uCPiEc76gimdbIjEPA6ZM4nwae6I/yb
HOoX7B6uCea1tLyYB7NutxzxnU0/QgdoT+9louwaNt63LVlNb/WqDnSAAPGM5M4=
=c558
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
