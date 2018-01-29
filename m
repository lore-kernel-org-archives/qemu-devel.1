Received: from eggs.gnu.org ([2001:4830:134:3::10]:60578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1egBN2-0005lW-Rf
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 10:29:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1egBMx-0004cY-RK
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 10:29:20 -0500
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:39211)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1egBMx-0004c3-Jl
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 10:29:15 -0500
Received: by mail-wr0-x22f.google.com with SMTP id f6so6017142wra.6
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 07:29:15 -0800 (PST)
Date: Mon, 29 Jan 2018 15:29:12 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180129152912.GL20446@stefanha-x1.localdomain>
References: <1516003315-17878-1-git-send-email-changpeng.liu@intel.com>
	<1516003315-17878-2-git-send-email-changpeng.liu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zH41lVBEV8cLJnCl"
Content-Disposition: inline
In-Reply-To: <1516003315-17878-2-git-send-email-changpeng.liu@intel.com>
Subject: Re: [Qemu-devel] [RFC v1] block/NVMe: introduce a new vhost NVMe
 host device to QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Changpeng Liu <changpeng.liu@intel.com>
Cc: qemu-devel@nongnu.org, james.r.harris@intel.com, keith.busch@intel.com, famz@redhat.com, pbonzini@redhat.com, mst@redhat.com


--zH41lVBEV8cLJnCl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2018 at 04:01:55PM +0800, Changpeng Liu wrote:
> NVMe 1.3 specification introduces a new NVMe ADMIN command:
> doorbell buffer config, which can write shadow doorbell buffer
> instead of MMIO registers, so it can improve the Guest performance
> a lot for emulated NVMe devices inside VM.

If I understand correctly the Shadow Doorbell Buffer offers two
optimizations:

1. The guest driver only writes to the MMIO register when EventIdx has
   been reached.  This eliminates some MMIO writes.

2. The device may poll the Shadow Doorbell Buffer so that command
   processing can begin before guest driver performs an MMIO write.

Is this correct?

> Similar with existing vhost-user-scsi solution, this commit builds a
> new vhost_user_nvme host device to VM and the I/O is processed at
> the slave I/O target, so users can implement a user space NVMe driver
> in the slave I/O target.
>=20
> Users can start QEMU with: -chardev socket,id=3Dchar0,path=3D/path/vhost.=
0 \
> -device vhost-user-nvme,chardev=3Dchar0,num_io_queues=3D2.

Each new feature has a cost in terms of maintainance, testing,
documentation, and support.  Users need to be educated about the role of
each available storage controller and how to choose between them.

I'm not sure why QEMU should go in this direction since it makes the
landscape more complex and harder to support.  You've said the
performance is comparable to vhost-user-blk.  So what does NVMe offer
that makes this worthwhile?

A cool NVMe feature would be the ability to pass through invididual
queues to different guests without SR-IOV.  In other words, bind a queue
to namespace subset so that multiple guests can be isolated from each
other.  That way the data path would not require vmexits.  The control
path and device initialization would still be emulated by QEMU so the
hardware does not need to provide the full resources and state needed
for SR-IOV.  I looked into this but came to the conclusion that it would
require changes to the NVMe specification because the namespace is a
per-command field.

--zH41lVBEV8cLJnCl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJabz3IAAoJEJykq7OBq3PI+iwH/R4xfu5FJlH6zbPAOu7lKzDA
m2Hwv85+7uloSvK82fqFrpXb+CJ3WBYOXHJmZYeqqv+rqoodxaVXDx5fmjE53DaP
RYyA5zLrEgWH7lsyUNBOWasYrdMC299CjsxpDOYoSmCKS4j3GJV0x3XBFBGTW3kg
LHKXpf92cGihNyPHygeTJhLUAxVvh+4dBqiXr1LygEXnsQhoaLZqQcCr6oEB4flv
z9LYvGavNC9vxlzzEwhRsbp/0WwLeidrW8Bawky5qWE7ixJqhNz5Vi60etrMIgis
M+2Jm2TGv0kuaZltG0KUH7u9/tZjnbgbcUWPAF9A7iwZvafPT2GPt358Ak5pWnU=
=CgCv
-----END PGP SIGNATURE-----

--zH41lVBEV8cLJnCl--
