Received: from eggs.gnu.org ([2001:4830:134:3::10]:47584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1citDc-0003XN-8Y
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 20:38:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1citDb-0001XO-5t
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 20:38:16 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:57317)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1citDa-0001TK-1h
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 20:38:15 -0500
Date: Wed, 1 Mar 2017 11:35:49 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170301003549.GD12571@umbus.fritz.box>
References: <1488171164-28319-1-git-send-email-xyjxie@linux.vnet.ibm.com>
	<20170228004101.GG17615@umbus.fritz.box>
	<ba290b8f-5967-eb50-3ba5-514a28bd0dda@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="T7mxYSe680VjQnyC"
Content-Disposition: inline
In-Reply-To: <ba290b8f-5967-eb50-3ba5-514a28bd0dda@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2] memory: Introduce DEVICE_HOST_ENDIAN
 for ram device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Cc: pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, qemu-devel@nongnu.org, alex.williamson@redhat.com, aik@ozlabs.ru, peter.maydell@linaro.org, paulus@samba.org, mdroth@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com


--T7mxYSe680VjQnyC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 28, 2017 at 06:12:56PM +0800, Yongji Xie wrote:
> on 2017/2/28 8:41, David Gibson wrote:
>=20
> > On Mon, Feb 27, 2017 at 12:52:44PM +0800, Yongji Xie wrote:
> > > At the moment ram device's memory regions are DEVICE_NATIVE_ENDIAN. I=
t's
> > > incorrect. This memory region is backed by a MMIO area in host, so the
> > > uint64_t data that MemoryRegionOps read from/write to this area shoul=
d be
> > > host-endian rather than target-endian. Hence, current code does not w=
ork
> > > when target and host endianness are different which is the most commo=
n case
> > > on PPC64. To fix it, this introduces DEVICE_HOST_ENDIAN for the ram d=
evice.
> > >=20
> > > This has been tested on PPC64 BE/LE host/guest in all possible combin=
ations
> > > including TCG.
> > >=20
> > > Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> > > Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
> > Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> >=20
> > The effect of the patch is certainly correct.  I remain a little
> > concerned that the name "host endian" might cause more confusion than
> > it resolves, but a better term isn't immediately obvious to me.
>=20
> If the memory region's endianness indicates the endianness of multi-byte
> value that
> MemoryRegionOps read from/write to this memory region, should "host endia=
n"
> be reasonable?
>=20
> For a mmio store, QEMU just get a bunch of bytes in the memory at the
> beginning.
> Then we use ldX_p to load a target-endian multi-byte value from the memor=
y.
> Then
> adjust_endianness() change the endianness of the multi-byte value from
> target-endian
> to memory region's endianness.
>=20
> For the mmap MMIO area, we should use host-endian multi-byte value to acc=
ess
> it.
>=20
> *(uint32_t *)(mr->ram_block->host + addr) =3D (uint32_t)data;
>=20
> Here it is the same as stl_he_p().
>=20
> The "host-endian" means we load a bunch of bytes as a host-endian value, =
and
> write the
> value to the mmap MMIO area. That's my understanding. Not sure if it's
> correct.

That's correct.  The difficulty is that generally the endian flag
describes the device's endianness as it appears to the guest.  The
guest doesn't (and shouldn't) know the host's endianness, so
describing something as "host endian" is pretty weird from that point
of view.  Basically the only way this can work is if the qemu device
is treating all data from the guest as pieces of a bytestream and
never interpreting things as multibyte values.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--T7mxYSe680VjQnyC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYthdiAAoJEGw4ysog2bOSXR4P/jR36hsLRqsw2qgNsRAbUz62
0Mf/VpECTHPEI7vS7nR1gkLwXdXxEt+YP30iT11yjNijiNF/mCAv0hlL22j2AZdt
Coq6hjPf7OSkiLvXjnxyu8Q+riudFI/3Ik4Zqjkx4GP3X+eGMHc5kzKfIM1uG2rJ
OhiwxNemCBN27JTGwRIb0NnTzfudrcEEJTkgl+x5hc1G0PUzd0Wc+GB+gfLoHE8P
vcWbk16NJP+q12N9oav5bKYqO8UfhZoN43JTVMYQTmPlQEogwutFizt71QTf9m1c
Y9CYHh7rsF1sLbfQtNYaoQwZRUTZdttgS45HbzXQ3lIePl5fFDhUapKpStIGcY2j
7Ca8BHCH91Si9byK7AS3NKMIk/litZI4KVIvAIo41ze02war4NpjUfIfx7dFVOxt
kJ4QDrzeDMZGb2OZL1/NqhgqDoBaU0RiupFMevmV7ls4jkAGXlsf2nkH3Ndqt5G9
5/RdVGOkKfx14Wl6RM0bNi0ASsLyuPIYeErdbYyxD/+b/91XnFOZvA72/LvHrUvJ
yBRmJU/cVEDo4ztJdOwv/53PjkWxgnL3+08rcxpw5fC2Eb7ebsLj8tZnwneMpdY6
jKcu7ECvawsoPUgSEzmsrwKElz9EfXi7MWUW6X8L/3BO8sOLDWjBLBtSWRCHwLPE
UA0IpkTylxBNB8zxjFUY
=xrer
-----END PGP SIGNATURE-----

--T7mxYSe680VjQnyC--
