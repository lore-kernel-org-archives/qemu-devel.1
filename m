Received: from eggs.gnu.org ([209.51.188.92]:52794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gwTwI-0002Lb-JB
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:37:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gwTw8-0006Dr-1k
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:37:35 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35612)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gwTvs-0005Wg-NH
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:37:17 -0500
Received: by mail-wm1-x344.google.com with SMTP id y15so6918221wma.0
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 07:36:38 -0800 (PST)
Date: Wed, 20 Feb 2019 15:36:35 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190220153635.GC30403@stefanha-x1.localdomain>
References: <729515484.1572396.1550250571940.ref@mail.yahoo.com>
	<729515484.1572396.1550250571940@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2/5bycvrmDh4d1IB"
Content-Disposition: inline
In-Reply-To: <729515484.1572396.1550250571940@mail.yahoo.com>
Subject: Re: [Qemu-devel] Why only devdax guarantees guest data persistence ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "bipin.tomar@yahoo.com" <bipin.tomar@yahoo.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Dan Williams <dan.j.williams@intel.com>, Ross Zwisler <zwisler@kernel.org>, Jeff Moyer <jmoyer@redhat.com>, Pankaj Gupta <pagupta@redhat.com>


--2/5bycvrmDh4d1IB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 05:09:31PM +0000, bipin.tomar--- via Qemu-devel wro=
te:
> Text from "docs/nvdimm.txt" says:
> Guest Data Persistence
> ----------------------
>=20
> Though QEMU supports multiple types of vNVDIMM backends on Linux,
> currently the only one that can guarantee the guest write persistence
> is the device DAX on the real NVDIMM device (e.g., /dev/dax0.0), to
> which all guest access do not involve any host-side kernel cache.
>=20
> I think here "host-side kernel cache" imply "page cache". Why does fsdax =
NOT have the same persistence guarantees as devdax for vNVDIMM?
> Both the modes avoid using page cache then why is devdax explicitly calle=
d out?

File systems may require msync(2)/fsync(2) to guarantee persistence even
with DAX (just a cache flush instruction may not be enough!).  Emulated
NVDIMM devices lack an fsync interface so guests are unable to fsync the
host file system.

This is not an issue with devdax since there is no host file system.

virtio-pmem is an effort to add a paravirtualized fsync-style interface
and should solve this problem in the future:
https://lkml.org/lkml/2019/1/9/541

Stefan

--2/5bycvrmDh4d1IB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcbXQDAAoJEJykq7OBq3PIqDkIAIQFuPf7jjftjLTLk8/1O2KB
uXqlWeIIXJJSkmmp9XKT1ZL6H5bc3go28d7GDOy9YmeVLT8nCUOr3uZSPWDJaZn9
qiZL9BFtdiaKQpjorbYUVYq8P5MRtEKVh417khl9WrGUqpJ2OSRH4kCXAHAHr5yj
O3E/jvLntA5o7f1rp8WTYQNeTJOcXXbr4gtZ3BRHN+2PlwLEpwf+sIZmRIdmORTQ
O2FDrPqGIPvY13bHTDOTUNAgjgX+m6co7Kbxb8De5vV4SIJNu3QjYwXTMvKjg2a2
PcVQon/+RajR87OyXuw3HOMSBZY0N69/jJ8cyUahD/3cMRvx998GjTpKDA0jeVk=
=9NFD
-----END PGP SIGNATURE-----

--2/5bycvrmDh4d1IB--
