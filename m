Received: from eggs.gnu.org ([2001:4830:134:3::10]:32866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dgUnS-0000Z7-2n
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 07:41:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dgUnO-0003ZO-36
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 07:41:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dgUnN-0003Yt-Pa
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 07:41:34 -0400
References: <35BC0F0B-7CB0-424C-86EA-2B5D8E219634@gmail.com>
	<20170811215845.n667iobglz5cef3z@var.youpi.perso.aquilenet.fr>
	<CAFEAcA_XrnDxZLhX5FGFBh+Mh-_80z3Z6b+0LkmQuoWzrWK0tA@mail.gmail.com>
	<20170812110410.rosk6yhkj22w346s@var.youpi.perso.aquilenet.fr>
	<CAFEAcA-N5pAM+3PXvjaJ-LMPFswAtmkAXA6yn151CCtfn+=JQA@mail.gmail.com>
	<20170812112925.mpi2mmewt46wna7j@var.youpi.perso.aquilenet.fr>
From: Eric Blake <eblake@redhat.com>
Message-ID: <60ba7c95-8989-13bb-3aaf-ac9a8389320f@redhat.com>
Date: Sat, 12 Aug 2017 06:41:30 -0500
MIME-Version: 1.0
In-Reply-To: <20170812112925.mpi2mmewt46wna7j@var.youpi.perso.aquilenet.fr>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AvQdGMoMmDshHVdS5Uf42drLvrmfVq2FD"
Subject: Re: [Qemu-devel] SLIRP warning messages displayed while compiling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: Programmingkid <programmingkidx@gmail.com>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Jan Kiszka <jan.kiszka@siemens.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AvQdGMoMmDshHVdS5Uf42drLvrmfVq2FD
From: Eric Blake <eblake@redhat.com>
To: Samuel Thibault <samuel.thibault@gnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Programmingkid <programmingkidx@gmail.com>,
 "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>,
 Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <60ba7c95-8989-13bb-3aaf-ac9a8389320f@redhat.com>
Subject: Re: [Qemu-devel] SLIRP warning messages displayed while compiling
References: <35BC0F0B-7CB0-424C-86EA-2B5D8E219634@gmail.com>
 <20170811215845.n667iobglz5cef3z@var.youpi.perso.aquilenet.fr>
 <CAFEAcA_XrnDxZLhX5FGFBh+Mh-_80z3Z6b+0LkmQuoWzrWK0tA@mail.gmail.com>
 <20170812110410.rosk6yhkj22w346s@var.youpi.perso.aquilenet.fr>
 <CAFEAcA-N5pAM+3PXvjaJ-LMPFswAtmkAXA6yn151CCtfn+=JQA@mail.gmail.com>
 <20170812112925.mpi2mmewt46wna7j@var.youpi.perso.aquilenet.fr>
In-Reply-To: <20170812112925.mpi2mmewt46wna7j@var.youpi.perso.aquilenet.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/12/2017 06:29 AM, Samuel Thibault wrote:
>>
>> Alignment is architecture-dependent, and the compiler
>> can't know the alignment requirements for every
>> architecture.
>=20
> Sure.

True, but we can at least guess alignments that don't require padding,
and then be told by the compiler if our guess was wrong when porting to
a new system, and update our guess accordingly with more ifdefs (struct
ip6 is already using ifdef HOST_WORDS_BIGENDIAN for that reason).

>=20
>> There's no rule in C that says that uint16_t only needs 2 byte
>> alignment and not 4 on some hosts.
>=20
> Are there really systems where that happens?  Such systems would have t=
o
> pad uint16_t arrays then, really?

uint16_least_t occupies only 2 bytes, but C and POSIX allow systems
where uint16_t is larger than 16 bits (most likely, 32 bits).  I don't
personally know of such a system; and it's most-likely to be a non-POSIX
system (perhaps one where sizeof(int) =3D=3D 1 because the smallest
addressable integer is 32 bits).

>=20
>> (Also I just noticed 'struct ip6' uses bitfields:
>> that's badly non-portable if it's trying to
>> match an on-the-wire layout.)
>=20
> struct ip has been doing so for so long too.
>=20
> I'm not saying the code is perfectly portable, I'm just saying it's
> portable enough for being both practical and readable.

Here's an idea:  Instead of using struct ip6 { ... } QEMU_PACKED, use

struct ip6 {
=2E..
};
QEMU_BUG_ON(sizeof(struct ip6) !=3D 32);

so that the compiler explicitly chokes if it introduced any padding, and
then we know all our accesses are naturally aligned which shuts up the
warning.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--AvQdGMoMmDshHVdS5Uf42drLvrmfVq2FD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmO6WoACgkQp6FrSiUn
Q2oXJAf/Tv5CS0wiz8jHhzP66vkP5e8nfN+X3WMc8m/kNYALsK7UZwFDGqzY0Tvt
OLnrmNlLsS6zDsBQh0oMEDlwEB8zzp/8Oe4fhY1CYn1hMEpMC9nnCUJZ3BocLLZZ
Ze8FxNNMlNasEFDafpdANPSADJBcahiXhoPEQonymZakk9Yfr1BZlN5nmnzcIAwe
99YoEJyE4yul69svtZ6SMSYKE//DJUSosEzIcKqlVHutwdqdVvJpa+y5MVdYSgyj
ICiK0vra3HWuo3enG3uA6wFABz5wAPDKamDd78PELopTqwdpPgtxR5tz87IOcokq
XckuIr/EBgVOrAGi8BtJj8+dEDybCA==
=VW3V
-----END PGP SIGNATURE-----

--AvQdGMoMmDshHVdS5Uf42drLvrmfVq2FD--
