Received: from eggs.gnu.org ([2001:4830:134:3::10]:41198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ch6ZB-0004ks-LR
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 22:29:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ch6Z7-0000MW-Ml
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 22:29:09 -0500
Received: from ozlabs.org ([103.22.144.67]:60653)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1ch6Z6-0000Hx-KW
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 22:29:05 -0500
Date: Fri, 24 Feb 2017 14:26:30 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170224032630.GO17615@umbus.fritz.box>
References: <1487659615-15820-1-git-send-email-xyjxie@linux.vnet.ibm.com>
	<5edff645-12e8-d3e0-1849-302b6986c232@ozlabs.ru>
	<fdcb2b07-aae8-69bf-ee94-a43777009c3a@redhat.com>
	<CAFEAcA--bSo7PJH0Px9ytQspaYuS55CSsM_EN6zt0djhkqKNPw@mail.gmail.com>
	<5a0773de-6bc7-474a-82ab-2edd37ce8a93@redhat.com>
	<CAFEAcA99xi4k57h2XGw2deGO24E95AS5jyGL+4GzjqNgMb9wcg@mail.gmail.com>
	<92580ca9-47fe-a943-7720-d3cb1fc6d2eb@redhat.com>
	<CAFEAcA8769a_8xwk57FS6Ko+Lioud20+70JRSafeEic6GB_RAw@mail.gmail.com>
	<3d5e7b5e-4501-86b7-093d-47fb09af585e@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4ickEXl+ukcSQ/3E"
Content-Disposition: inline
In-Reply-To: <3d5e7b5e-4501-86b7-093d-47fb09af585e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] memory: make ram device read/write endian
 sensitive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Yongji Xie <xyjxie@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, Alex Williamson <alex.williamson@redhat.com>, zhong@linux.vnet.ibm.com, Paul Mackerras <paulus@samba.org>


--4ickEXl+ukcSQ/3E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 23, 2017 at 12:43:37PM +0100, Paolo Bonzini wrote:
>=20
>=20
> On 23/02/2017 12:34, Peter Maydell wrote:
> > On 23 February 2017 at 10:33, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >>
> >>
> >> On 23/02/2017 11:23, Peter Maydell wrote:
> >>> On 23 February 2017 at 10:10, Paolo Bonzini <pbonzini@redhat.com> wro=
te:
> >>>> On 23/02/2017 11:02, Peter Maydell wrote:
> >>>>> I'm really not convinced we need DEVICE_HOST_ENDIAN. RAM
> >>>>> areas should be target-endian (you can probably define
> >>>>> "target endianness" as "the endianness that RAM areas have".)
> >>>>
> >>>> This is not RAM.  This is MMIO, backed by a MMIO area in the host.
> >>>
> >>> Hmm, I see...the naming is a bit unfortunate if it's not RAM.
> >>
> >> Yeah, it's called like that because it is backed by a RAMBlock but it
> >> returns false for memory_access_is_direct.
> >=20
> > We should probably update the doc comment to note that the
> > pointer is to host-endianness memory (and that this is not
> > like normal RAM which is target-endian)...
>=20
> I wouldn't call it host-endianness memory, and I disagree that normal
> RAM is target-endian---in both cases it's just a bunch of bytes.

Right.  Really, endianness is not a property of the device - even less
so of RAM.  It's a property of an individual multibyte value and how
it is interpreted relative to individual byte addresses.

Really the declarations in the MRs are saying: assuming the guest
(software + hardware) does (big|little|target native) accesses on this
device, do the right swaps so we get host native multi-byte values
which match the original multibyte values the guest had in mind.

What we want for memory (both RAM and VFIO MMIO) is: don't even try to
preserve multi-byte values between host and guest views, just preserve
byte address order.  Tastes may vary as to whether you call that "host
endian" or "no endian" or "bag-o'-bytesian" or whatever.

> However, the access done by the MemoryRegionOps callbacks needs to match
> the endianness declared by the MemoryRegionOps themselves.
>=20
> Paolo
>=20
> >>>> The
> >>>> MemoryRegionOps read from the MMIO area (so the data has host
> >>>> endianness) and do not do any further swap:
> >>>>
> >>>>         data =3D *(uint16_t *)(mr->ram_block->host + addr);
> >>>>
> >>>> Here, the dereference is basically the same as ldl_he_p.
> >>>>
> >>>> If you wanted to make the MemoryRegion use DEVICE_NATIVE_ENDIAN, you=
'd
> >>>> need to tswap around the access.  Or you can use ldl_le_p and
> >>>> DEVICE_LITTLE_ENDIAN (this is what Yongji's patch open codes), or
> >>>> ldl_be_p and DEVICE_BIG_ENDIAN.  They are all the same in the end.
> >>>
> >>> Using stl_p &c in a DEVICE_NATIVE_ENDIAN MR would work too, right?
> >>> (This is how all the NATIVE_ENDIAN MRs in exec.c work.)
> >>
> >> Yes, it should, as long as the memcpy(...) of {ld,st}*_he_p is compiled
> >> to a single access, which should be the case.
> >=20
> > ...and whichever of these approaches we take, we should have
> > a comment which notes that we are converting from the host
> > endianness memory to the endianness specified by the MemoryRegion
> > endianness attribute.
> >=20
> > thanks
> > -- PMM
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4ickEXl+ukcSQ/3E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYr6fkAAoJEGw4ysog2bOS81kP/A0uOIX4T6Eb7ljKZMQpXN5N
wW6L7UJKGIUrQ+o1S4Yv/K4mqMSNItx1GdaCM3K9npdWyDEYoxWWqhK3yK1KcopB
zO5AiHirWt2lMnLdOFLgA2xPyOQVsGNjs9FE7VJwZ45Lp+sSFJs5A32jF/UO+Nvs
sjidJNcSAWhuPzSIourgYCshSlDz8gnYiH/QHiF4TSLOl40rhcKa8td4l9/Oogz0
A/JwSpFzhQIHTL4smtUbPq3hx11iJEw9/8nZlzKsybRzsAmF3blVGAPpf0MRF3cn
elXvGVTr1InU2fdFe1z+eBKlmyTh0HUM2nRxxxMHeiopeugeRRuDjNueQOtOcAhM
PS9e71L4k84YWE4gFFU+08OKJDmB1CZD/YviJXNpc42Yx5o72AGzvZIS9M3ccBch
QFu87pkTq8g8LovgnObtCIE0PCxJtdioAGbpfQZLeLD9pltyC4WhCPCWIImQrtHP
vwaICe4a2iDOZzB9qg1BlIGLgqq55Z6JEJMRNdY7QnZcFQbr/a0G0dQHgDyjxcVl
MfFL90Ujmq76WTuUPsUvLUWqYwOKOHscMh0DQXvBVIL71JT5MvU7tTC01eDNZhMg
J473g3jBScljDJearVRLgf7BcYSM/dq0jTLUhsH/2wfBgshgVnGOnyBrQTTr1m86
EfzSI3DAwWQMgD51S9NK
=KX+w
-----END PGP SIGNATURE-----

--4ickEXl+ukcSQ/3E--
