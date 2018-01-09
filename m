Received: from eggs.gnu.org ([2001:4830:134:3::10]:39456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eYvwH-00074C-GP
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 10:35:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eYvwE-0002SV-Dp
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 10:35:45 -0500
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:40451)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eYvwE-0002S6-6W
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 10:35:42 -0500
Received: by mail-wr0-x22a.google.com with SMTP id p17so14541191wre.7
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 07:35:42 -0800 (PST)
Date: Tue, 9 Jan 2018 15:35:38 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180109153538.GC1197@stefanha-x1.localdomain>
References: <EC8A4E314CF1574AB62C80421BD9833933FEE069@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OBd5C1Lgu00Gd/Tn"
Content-Disposition: inline
In-Reply-To: <EC8A4E314CF1574AB62C80421BD9833933FEE069@SHSMSX104.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] Some question about savem/qcow2 incremental
 snapshot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "He, Junyan" <junyan.he@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, John Snow <jsnow@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>


--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 25, 2017 at 07:54:00AM +0000, He, Junyan wrote:
> I am now focusing on snapshot optimization for Intel NVDimm kind memory. =
Different from the normal memory, the NVDimm may be 128G, 256G or even more=
 for just one guest, and its speed is slower than the normal memory. So som=
etimes it may take several minutes to complete just one snapshot saving. Ev=
en with compression enabled, the=A0snapshot point may consume more than 30G=
 disk space. We decide to add incremental kind snapshot saving to resolve t=
his. Just store difference between snapshot points to save time and disk sp=
ace.
> But the current snapshot/save_vm framework seems not to support this.
> We need to add snapshot dependency and extra operations when we LOAD and =
DELETE the snapshot point.
> Is that possible to modify the savevm framework and add some incremental =
snapshot support to QCOW2 format?

It sounds like you'd like to save incremental guest RAM snapshots based
on the contents of earlier snapshots.  QEMU has no way of doing this at
the moment.

In order to do this QEMU needs to keep dirty memory logging enabled at
all times so it knows which pages have been written since the last
snapshot.  This will affect guest performance.

Certain guest operations like rebooting or zeroing memory will defeat
the incremental guest RAM snapshot feature.  It's worth thinking about
these cases to make sure this feature would be worth it in real use
cases.

What you're proposing isn't specific to NVDIMM.  Regular RAM use cases
also benefit from incremental snapshots because less disk space is
required for the savevm data.

Some questions about your use case:

1. Does the guest have -device nvdimm?

2. Is the qcow2 file on NVDIMM?

Stefan

--OBd5C1Lgu00Gd/Tn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaVOFKAAoJEJykq7OBq3PI2SAIAJii+fmhCPk9O3RfqWt/jBOL
fk4B/p4U9E2Wmd5UoYi7MMxv1fgRDnp7jlNF1yERc9ygeeWhs+pOMabPb0774Lnt
oqLgtkLjslCsUhHgD/P/2OLwNGqNRZ4wJizKAIlTfkgeOL6xTAxKWjNyiIAZRiY1
9iovMnFfC+JWSSLAIx0e4RKzArp/ervYZmpcdHDXNW2cr/vp9JVUemZyNfga3LIz
GaaS+qMk76q+MBmlXw0L74FrGf+Ok2W9KAGdARjMTknby0FjEnE3w8mBke9AQaKm
z8d4qEKTG6a2+2+GN9GjFmIIlm4q+MnkLrI2ne517fAXm5pU/TuCDKFys2RzuuU=
=8Xi/
-----END PGP SIGNATURE-----

--OBd5C1Lgu00Gd/Tn--
