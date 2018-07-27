Received: from eggs.gnu.org ([2001:4830:134:3::10]:36642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fj23Z-00039M-Ni
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 08:41:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fj23W-0006gD-Kd
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 08:41:17 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:52600)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fj23W-0006fb-DG
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 08:41:14 -0400
Received: by mail-wm0-x241.google.com with SMTP id o11-v6so5106870wmh.2
	for <qemu-devel@nongnu.org>; Fri, 27 Jul 2018 05:41:14 -0700 (PDT)
Date: Fri, 27 Jul 2018 11:18:26 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180727101826.GA28555@stefanha-x1.localdomain>
References: <1531468107-1579-1-git-send-email-felix.yzg@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <1531468107-1579-1-git-send-email-felix.yzg@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] util/thread-pool: add parameter to
 limit maximum threads in thread pool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: FelixYao <felix.yzg@gmail.com>
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, yaozhenguo@jd.com, qemu-devel@nongnu.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 13, 2018 at 03:48:27PM +0800, FelixYao wrote:
> Hi all:
>=20
> Max threads in thread pool is fixed at 64 before which is not
> propriate in some situations. For public cloud environment,
> there are lots of VMs in one host machine. We should limit the worker thr=
ead
> numbers for each machine alone based on its ability to prevent impacting
> each other. Although we can use iotune to limit bandwidth or IOPS of block
> device. That is not enough. Lots of worker threads still impact other VMs.
> I think the ability to limit maximum threads in thread pool is necessary.
>=20
> What's your opinion about this patch? please review it.

I haven't seen any discussion so here are some thoughts:

It sounds like you are trying to control I/O resources so that guests do
not affect each other.  The threads are an implementation detail and not
the root of the problem.

For example, if you use -drive aio=3Dnative then reads and writes will not
use the thread pool and you will setting the thread pool size won't
solve the problem.

Have you tried QEMU's I/O throttling feature?  You can set bandwidth
(bps) and IOPS limits, including bursts if you wish to allow temporary
spikes.  The basic parameters are -drive bps=3DBYTES_PER_SECOND,iops=3DIOPS.
See the QEMU or libvirt documentation for details.

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbWvFyAAoJEJykq7OBq3PIMuwH/AoroPsbdmQnVkoVGY6Bm60L
Jew29VNe1h3RsDPrayl7K2WY8IHkZZPEoYlwWtq6VfsGPS97zwnt+NS6gNL6618H
B7VIQumWcPoFNkVu/N5EKLZMqC/9VkvQVxPfXitraLe5f75BNMgZNm3LZmUaJj9g
qOx9dAHQN6T4fmdUO8a7/3zsRVHuyegmYnSWJMkZTOUtxq7xXNAp8AczuI5S2BAz
+8cgTKNSwSINhZAMnmvPgmAztAeozUkYviKHkcbHWSwCVBItQQ5VwiHyPQzch/Gs
19QVM/9vsDoVqg40Spuqkh5hVEkViWw67TFhoVBsWxcMh1UqBEl+T4ESkQojUFo=
=NsuC
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
