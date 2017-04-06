Received: from eggs.gnu.org ([2001:4830:134:3::10]:33625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cw4ms-0008HO-C4
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 06:37:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cw4mo-0002Ed-Er
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 06:37:10 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:36546)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cw4mo-0002EO-8H
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 06:37:06 -0400
Received: by mail-wr0-x243.google.com with SMTP id o21so4979760wrb.3
	for <qemu-devel@nongnu.org>; Thu, 06 Apr 2017 03:37:06 -0700 (PDT)
Date: Thu, 6 Apr 2017 11:37:03 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170406103703.GC21895@stefanha-x1.localdomain>
References: <tencent_626816280E6377073CCDAC4F@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NU0Ex4SbNnrxsi6C"
Content-Disposition: inline
In-Reply-To: <tencent_626816280E6377073CCDAC4F@qq.com>
Subject: Re: [Qemu-devel] how to create threads like dataplane in qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: PERSIST <1554706732@qq.com>
Cc: qemu-devel <qemu-devel@nongnu.org>


--NU0Ex4SbNnrxsi6C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 01, 2017 at 11:54:35AM +0800, PERSIST wrote:
>   I want to create a specific thread for each process in VM so that virtio block requests from each process can be sumbitted in the thread related to the process.
>   I tried to implement it by referring to dataplane,but I can not understand the source about dataplane.
>   What should I do?

It sounds like QEMU can already do what you want:

1. Define -object iothread for each guest process that needs a
   dedicated dataplane thread.
2. Define -device virtio-blk-pci,iothread=iothread for each block
   device.  It wasn't clear from your email but I'm assuming here that
   every guest process operates on its own disk image file.  QEMU does
   not support true multiqueue disk I/O to a single image file yet.

You should also bind the iothreads to host logical CPUs, bind vcpu
threads to host logical CPUs, and bind the guest processes to vcpus.
That way each guest process has a dedicated host CPU and iothread.

Stefan

--NU0Ex4SbNnrxsi6C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY5hpPAAoJEJykq7OBq3PICcAH/3C32CxvpUoX/tFdGW6ahpmp
g1ijFth6eVpm7PTdEU4g3qOv7982/gXMyip3tOE7me9Rigl+/ilHraBEo/T/xCcq
xEaNoG0yUmZTZxaRo8Wlby5DHpz/QBVjEK7P2fI1G7TIflOCnLTVWkZUzWw8hFqt
5B32OaeJ0BONGHxJsB36mnVddNsMXDaWSJTsNIMnMABh40cmsJmAiuxkfjfmc7aa
xTJFctILewdnPDFgr3nhUwbk7XNOgdOQlHbPOplnxdn0+HgVjCQKU6egihL0YMYR
QXTJzO7RnDyc3sFxjyMDd54tJYNXEgYBlTQu9OH9VKwknsw9bZrVfgmC2Gzn5Vo=
=YGZ8
-----END PGP SIGNATURE-----

--NU0Ex4SbNnrxsi6C--
