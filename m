Received: from eggs.gnu.org ([2001:4830:134:3::10]:41914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dUrKe-0007wW-L3
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:19:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dUrKb-0002qS-Hp
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:19:48 -0400
Received: from mail-lf0-f52.google.com ([209.85.215.52]:35792)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dUrKb-0002qA-Ab
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:19:45 -0400
Received: by mail-lf0-f52.google.com with SMTP id b207so79171495lfg.2
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 02:19:45 -0700 (PDT)
Date: Tue, 11 Jul 2017 10:18:41 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170711091841.GE17792@stefanha-x1.localdomain>
References: <AT5PR84MB01644325A091571A2841C65EA0A90@AT5PR84MB0164.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lteA1dqeVaWQ9QQl"
Content-Disposition: inline
In-Reply-To: <AT5PR84MB01644325A091571A2841C65EA0A90@AT5PR84MB0164.NAMPRD84.PROD.OUTLOOK.COM>
Subject: Re: [Qemu-devel] Disparity between host and guest CPU utilization
 during disk IO benchmark
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Nagarajan, Padhu (HPE Storage)" <padhu@hpe.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>


--lteA1dqeVaWQ9QQl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2017 at 05:27:15PM +0000, Nagarajan, Padhu (HPE Storage) wr=
ote:
> Posted this in qemu-discuss and did not get a response. Hoping that someo=
ne here might be able to offer insights.
>=20
> I was running an 8K random-read fio benchmark inside the guest with iodep=
th=3D32. The device used inside the guest for the test was a virtio-blk dev=
ice with iothread enabled, mapped on to a raw block device on the host. Whi=
le this workload was running, I took a snapshot of the CPU utilization repo=
rted by the host and the guest. The guest had 4 cores. top inside guest sho=
ws 3 idle cores and one core being 74% utilized by fio (active on core 3). =
The host had 12 cores and three cores were completely consumed by three qem=
u threads. top inside host shows three qemu threads, each utilizing the CPU=
 core to a near 100%. These threads are "CPU 1/KVM", "CPU 3/KVM" and "IO io=
thread1". The CPU utilization story on the host side is the same, even if I=
 run a light fio workload inside the guest (for ex. iodepth=3D1).=20
>=20
> Why do I see two "CPU/KVM" threads occupying 100% CPU, even though only o=
ne core inside the guest is being utilized ? Note that I had 'accel=3Dkvm' =
turned on for the guest.

fio might be submitting I/O requests on one vcpu and the completion
interrupts are processed on another vcpu.

To discuss further, please post:
1. Full QEMU command-line
2. Full fio command-line and job file (if applicable)
3. Output of cat /proc/interrupts inside the guest after running the
   benchmark

--lteA1dqeVaWQ9QQl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZZJfxAAoJEJykq7OBq3PIilkIAIaHXw4TD0A16fLzc2o33i2j
SRibCt8t0nIZvRGvTTx1jPmWzeQGc7Iohg25t8IhmaglX09erS7dGt++Ebblh3cY
orjBAW+0xTPNESo/XjpS/BLm4veOWYAYulDexxYr9ZGMO2BoFBuBcHs5BS41hG0M
QBUI6pXwM/IOwXEvMTHEzRHa6T7nAPPTxqPnbUI2rYHaB34BMF3xj5xBkB72TzJH
MGBfOZKyR/TkB5sRDr/77uS4KxbRFSkpUyPRQCv2o2pdOS+vDimTiOlv0NZVBwbP
ZY+iDALLkloP6nrqA69szMfNuO9UmPDSImglNHZD2j/HuzWErajEcbALQOScxTw=
=+ogl
-----END PGP SIGNATURE-----

--lteA1dqeVaWQ9QQl--
