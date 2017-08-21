Received: from eggs.gnu.org ([2001:4830:134:3::10]:59369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1djePD-0004td-8R
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 00:33:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1djePC-0005IF-1i
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 00:33:39 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:51759)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1djePB-0005FL-Jn
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 00:33:37 -0400
Date: Mon, 21 Aug 2017 14:31:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170821043125.GH12356@umbus.fritz.box>
References: <283a2a27-7fb5-5fa7-4921-60ba91f13666@ozlabs.ru>
	<20170818131853.GB17654@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qM81t570OJUP5TU/"
Content-Disposition: inline
In-Reply-To: <20170818131853.GB17654@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] Memory use with >100 virtio devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>


--qM81t570OJUP5TU/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 18, 2017 at 02:18:53PM +0100, Stefan Hajnoczi wrote:
> On Fri, Aug 18, 2017 at 03:39:20PM +1000, Alexey Kardashevskiy wrote:
> > =3D=3D94451=3D=3D -------------------- 4 of 10 --------------------
> > =3D=3D94451=3D=3D max-live:    314,649,600 in 150 blocks
> > =3D=3D94451=3D=3D tot-alloc:   314,649,600 in 150 blocks (avg size 2097=
664.00)
> > =3D=3D94451=3D=3D deaths:      none (none of these blocks were freed)
> > =3D=3D94451=3D=3D acc-ratios:  0.00 rd, 0.00 wr  (0 b-read, 0 b-written)
> > =3D=3D94451=3D=3D    at 0x4895600: memalign (in
> > /usr/lib/valgrind/vgpreload_exp-dhat-ppc64le-linux.so)
> > =3D=3D94451=3D=3D    by 0x48957E7: posix_memalign (in
> > /usr/lib/valgrind/vgpreload_exp-dhat-ppc64le-linux.so)
> > =3D=3D94451=3D=3D    by 0xB744AB: qemu_try_memalign (oslib-posix.c:106)
> > =3D=3D94451=3D=3D    by 0xA92053: qemu_try_blockalign (io.c:2493)
> > =3D=3D94451=3D=3D    by 0xA34DDF: qcow2_do_open (qcow2.c:1365)
> > =3D=3D94451=3D=3D    by 0xA35627: qcow2_open (qcow2.c:1526)
> > =3D=3D94451=3D=3D    by 0x9FB94F: bdrv_open_driver (block.c:1109)
> > =3D=3D94451=3D=3D    by 0x9FC413: bdrv_open_common (block.c:1365)
> > =3D=3D94451=3D=3D    by 0x9FF823: bdrv_open_inherit (block.c:2542)
> > =3D=3D94451=3D=3D    by 0x9FFC17: bdrv_open (block.c:2626)
> > =3D=3D94451=3D=3D    by 0xA71027: blk_new_open (block-backend.c:267)
> > =3D=3D94451=3D=3D    by 0x6D3E6B: blockdev_init (blockdev.c:588)
>=20
> This allocation is unnecessary.  Most qcow2 files are not encrypted so
> s->cluster_data does not need to be allocated upfront.
>=20
> I'll send a patch.

Is that sufficient to explain the problem, I can't quickly see how big
that unnecessary allocation is - but would it account for the 10s of
gigabytes usage we're seeing here?

I'm suspecting we accidentally have a O(n^2) or worse space complexity
going on here.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qM81t570OJUP5TU/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmaYhsACgkQbDjKyiDZ
s5KGHBAAsyTxjArAOyDVlo3dPihwABDv0pyFEHM+vcmwtzR+0FDOkCUu/C9bdwAP
ZvGPXDMABiI3J1Et++I1xrwI4NlQO8AKMmuF+6BCHQ4jrGjERly/dxx2OdUQiZwr
yZdXJg+uTEoS7JW4YUpVdu7kcmvzV6WauKHCU4wKSAxJskk05ekcBdTrdM2tjmBI
MwGE8hJeicArV6LWXtc4PTHozCV9U4ci2+oVSxDIFtsc8OT9LLG4c04irFhToLMd
cLr+w9XRkDbJZ+DorCXdkUm9Anjr7GiVmwJbDeWe48YNBMlvyLrAO41MJHDMqEjp
U/XTrDeGGXytfzX+sJyO3Isbf/u/YCRfDaUPJl+u+ymiwB5Atw/w0vPrjMGHxHlg
85KvuS5HRbzQGMuVIIVEu7BZHxMSkRfQUUhb65Gznjqr1LIl4YZ5mZdMfyQLUb6N
hbYOMBe06idqSlp0sgSObDRLUKks/Du1k+egyM2rhP9/CQaREiXDRHuuz8nCW3bB
5lUyk32GeVFdanedcsV3AvZAf9Qf/D4kCcigC9RN1g1rcBADZxsstwcK29YYjqz9
90SWjjfBFBPDTeAnmzdPRnHnsyfzFVyX0psh+dG+DJKcjbSPY2ErcOkcRz1ieCfY
Q46lCDlq7AaPIWLdFVpjIxhEqrSti0LOf7+I0iJ8LVerDv5jYtY=
=V1Kf
-----END PGP SIGNATURE-----

--qM81t570OJUP5TU/--
