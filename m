Received: from eggs.gnu.org ([209.51.188.92]:55348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gwwpL-0007FB-By
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 17:28:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gwwpG-0005fd-3H
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 17:28:19 -0500
Date: Fri, 22 Feb 2019 09:18:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190221221851.GA8609@umbus.fritz.box>
References: <20190218125615.18970-1-armbru@redhat.com>
	<20190218125615.18970-6-armbru@redhat.com>
	<878sy9418l.fsf@zen.linaroharston>
	<87sgwhxfvh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
In-Reply-To: <87sgwhxfvh.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH 05/10] ppc405_boards: Don't size flash
 memory to match backing image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, qemu-ppc@nongnu.org, lersek@redhat.com


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 21, 2019 at 05:31:30PM +0100, Markus Armbruster wrote:
> Alex Benn=E9e <alex.bennee@linaro.org> writes:
>=20
> > Markus Armbruster <armbru@redhat.com> writes:
> >
> >> Machine "ref405ep" maps its flash memory at address 2^32 - image size.
> >> Image size is rounded up to the next multiple of 64KiB.  Useless,
> >> because pflash_cfi02_realize() fails with "failed to read the initial
> >> flash content" unless the rounding is a no-op.
> >>
> >> If the image size exceeds 0x80000 Bytes, we overlap first SRAM, then
> >> other stuff.  No idea how that would play out, but a useful outcomes
> >> seem unlikely.
> >>
> >> Map the flash memory at fixed address 0xFFF80000 with size 512KiB,
> >> regardless of image size, to match the physical hardware.
> >>
> >> Machine "taihu" maps its boot flash memory similarly.  The code even
> >> has a comment /* XXX: should check that size is 2MB */, followed by
> >> disabled code to adjust the size to 2MiB regardless of image size.
> >>
> >> Its code to map its application flash memory looks the same, except
> >> there the XXX comment asks for 32MiB, and the code to adjust the size
> >> isn't disabled.  Note that pflash_cfi02_realize() fails with "failed
> >> to read the initial flash content" for images smaller than 32MiB.
> >>
> >> Map the boot flash memory at fixed address 0xFFE00000 with size 2MiB,
> >> to match the physical hardware.  Delete dead code from application
> >> flash mapping, and simplify some.
> >>
> >> Cc: David Gibson <david@gibson.dropbear.id.au>
> >> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >> ---
> >>  hw/ppc/ppc405_boards.c | 53 +++++++++++++-----------------------------
> >>  1 file changed, 16 insertions(+), 37 deletions(-)
> >>
> >> diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
> >> index f47b15f10e..728154aebb 100644
> >> --- a/hw/ppc/ppc405_boards.c
> >> +++ b/hw/ppc/ppc405_boards.c
> >> @@ -158,7 +158,7 @@ static void ref405ep_init(MachineState *machine)
> >>      target_ulong kernel_base, initrd_base;
> >>      long kernel_size, initrd_size;
> >>      int linux_boot;
> >> -    int fl_idx, fl_sectors, len;
> >> +    int len;
> >>      DriveInfo *dinfo;
> >>      MemoryRegion *sysmem =3D get_system_memory();
> >>
> >> @@ -185,26 +185,19 @@ static void ref405ep_init(MachineState *machine)
> >>  #ifdef DEBUG_BOARD_INIT
> >>      printf("%s: register BIOS\n", __func__);
> >>  #endif
> >> -    fl_idx =3D 0;
> >>  #ifdef USE_FLASH_BIOS
> >> -    dinfo =3D drive_get(IF_PFLASH, 0, fl_idx);
> >> +    dinfo =3D drive_get(IF_PFLASH, 0, 0);
> >>      if (dinfo) {
> >> -        BlockBackend *blk =3D blk_by_legacy_dinfo(dinfo);
> >> -
> >> -        bios_size =3D blk_getlength(blk);
> >> -        fl_sectors =3D (bios_size + 65535) >> 16;
> >>  #ifdef DEBUG_BOARD_INIT
> >> -        printf("Register parallel flash %d size %lx"
> >> -               " at addr %lx '%s' %d\n",
> >> -               fl_idx, bios_size, -bios_size,
> >> -               blk_name(blk), fl_sectors);
> >> +        printf("Register parallel flash\n");
> >>  #endif
> >> -        pflash_cfi02_register((uint32_t)(-bios_size),
> >> +        bios_size =3D 0x80000;
> >
> >  bios_size =3D 8 * MiB?
>=20
> The next line has base address 0xFFF80000.  I picked 0x80000 to make
> 0xFFF80000 + 0x80000 =3D=3D 0 mod 2^32 more obvious.
>=20
> If I change 0x80000 to 8 * MiB, the size is more obvious, but "at end of
> 32 bit address space" less so.
>=20
> If I additionally change the base address back to ((uint32_t)-bios_size,
> "at end of 32 bit address space" is obvious again, but the actual base
> address less so.

I have a weak preference for ((uint32_t)-bios_size), with bios_size =3D
8 * MiB.

>=20
> I don't really care myself.  David, you're the maintainer, do you have a
> preference?
>=20
> >> +        pflash_cfi02_register(0xFFF80000,
> >>                                NULL, "ef405ep.bios", bios_size,
> >> -                              blk, 65536, fl_sectors, 1,
> >> +                              dinfo ? blk_by_legacy_dinfo(dinfo) : NU=
LL,
> >> +                              65536, bios_size / 65536, 1,
> >
> > 64 * KiB?
>=20
> David, same question (two additional instances below).

Here I think 64 * KiB would be nice in each of those places.  Again,
only a weak preference.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxvI8gACgkQbDjKyiDZ
s5I8vhAAsIRC7QL+sgm9P8X5NQdUDmGEnu3GVCjS5GlGFewY1dCDx9y7B84cNbet
0DRebsQgoc1KnKjRN0K+tOGSJ9joRZitB+T4oDvnQ/RG4qnf8n+oWzn+jO81aK6J
LStoGEQ5mrCAwZs1GFXrBYmRI+Ti2MADMj5wB4Yu2Jiuf3TiWI1z2WTuW1fENhDf
NPsrFyCeRCy5nv9MCo5oo3jJBAKnXSFLMP3+DthoDl7fi+Stu5i/+ESXhR/1wRR8
u9a8xuM3pu+MsaBnOLM+7ctDPmnLURUk8RPpt0NIXzWr/w2Ix3giE6saBpnmD8/7
T9TijbCab8mL3Bn/G/Dl6h1PjF7st0Q2CdasopWKztZh44XILpS+wLYByZBLNtSy
wvkRCZAN5bdVtUbNv044A31Cf/45kyytr/4mTSoZfsXbYGxw7o96mqb6apdz93fp
qFVdgXMvUqxlCzOWELjYY4cqhna369Q85z8/PtCge+laOBg+GYo7igtUyU50MqbM
jXPBG2WEiUV0dIdQQx66FLoPQF5NWKljDXjk1bFmQPz7lpVi9At8x2J89FZOlBfT
XKiUP8ZlTQ3nI0dMfXfcC3ZFEEQmr5mGwx9CIkLIHUp67WEFDwO6vNNTyhgkPrmK
lAW7JSaLYMWeHsoXD/IcNIjddiPUBy8yj6pKG9f6LVdupV1lYZk=
=tWv3
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
