Received: from eggs.gnu.org ([2001:4830:134:3::10]:44592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eLfw3-0006VU-DR
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 20:52:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eLfw2-0000d5-3c
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 20:52:43 -0500
Date: Mon, 4 Dec 2017 12:44:22 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171204014422.GJ2130@umbus.fritz.box>
References: <1512143347-20128-1-git-send-email-richard.purdie@linuxfoundation.org>
	<20171204010040.GF2130@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zOcTNEe3AzgCmdo9"
Content-Disposition: inline
In-Reply-To: <20171204010040.GF2130@umbus.fritz.box>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2] target/ppc: Fix system
 lockups caused by interrupt_request state corruption
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--zOcTNEe3AzgCmdo9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 04, 2017 at 12:00:40PM +1100, David Gibson wrote:
> On Fri, Dec 01, 2017 at 03:49:07PM +0000, Richard Purdie wrote:
> > Occasionally in Linux guests on x86_64 we're seeing logs like:
> >=20
> > ppc_set_irq: 0x55b4e0d562f0 n_IRQ 8 level 1 =3D> pending 00000100req 00=
000004
> >=20
> > when they should read:
> >=20
> > ppc_set_irq: 0x55b4e0d562f0 n_IRQ 8 level 1 =3D> pending 00000100req 00=
000002
> >=20
> > The "00000004" is CPU_INTERRUPT_EXITTB yet the code calls
> > cpu_interrupt(cs, CPU_INTERRUPT_HARD) ("00000002") in this function
> > just before the log message. Something is causing the HARD bit setting
> > to get lost.
> >=20
> > The knock on effect of losing that bit is the decrementer timer interru=
pts
> > don't get delivered which causes the guest to sit idle in its idle hand=
ler
> > and 'hang'.
> >=20
> > The issue occurs due to races from code which sets CPU_INTERRUPT_EXITTB.
> >=20
> > Rather than poking directly into cs->interrupt_request, that code needs=
 to:
> >=20
> > a) hold BQL
> > b) use the cpu_interrupt() helper
> >=20
> > This patch fixes the call sites to do this, fixing the hang.
> >=20
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>=20
> I strongly suspect there's a better way to do this long term - a lot
> of that old ppc TCG code is really crufty.  But as best I can tell,
> this is certainly a fix over what we had.  So, applied to
> ppc-for-2.11.

I take that back.  Running make check with this patch results in:

  GTESTER check-qtest-ppc64
**
ERROR:/home/dwg/src/qemu/cpus.c:1582:qemu_mutex_lock_iothread: assertion fa=
iled: (!qemu_mutex_iothread_locked())
Broken pipe
qemu-system-ppc64: RP: Received invalid message 0x0000 length 0x0000
GTester: last random seed: R02S895b0f4813776bf68c147bf987e73f7b
make: *** [/home/dwg/src/qemu/tests/Makefile.include:852: check-qtest-ppc64=
] Error 1

So, I've reverted it.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zOcTNEe3AzgCmdo9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlokqHQACgkQbDjKyiDZ
s5KQzQ/9HPeFoOGb24YXTc0LPt65fipGOHKs0twTuHFmEt3uNK1NXSBpGpiQZVzr
qKy9QM3C3zeZoSRT6Y3ZcUIxVSPoEvNCeI77r8uE5htEEw04+yWrY256/HkowXnx
Bw2PNb4H3RxcV/2xaQ4qKHanyTDZtdmFpT+tFhpFeVWtT1LqkDTygAs4WapiaalT
d9PrhpW0wPlv638jyZt8e7W3FF9REd9vrtCdWMYqAkMVmgbmPyH2fep0CCZ8Zxyw
B/VPu8JB5f4kysDM/TLXGpBBLuat8BnjPCgx1VzbodTpiBVuZgjh6wbkhfXzH5/k
lsiGe5E5SNVrEQpurAKu+FZ0TsUkOkiEAqlymL4e4N339IGdMQ7FZy8pckajN672
KHji3bRiXCtNIOiuYEMxvIBbbGOpTQfvL/MjU+SDW1klGneP64Dk1cwnNv9HwNk+
jPSdLMMlhX6OUZ4UEMUwuBZ095LW+5NhxxqIqXqsg0ySb0dCSbOdwubWEzrQNdjt
A2SHQuONr4KzZq0jZRAfP0LnMcStBTXONDo/vaW2m02WClu4EOqwjhp83xJ+Y+S0
64yx05FvOYU+aeNNJxtlxT77DgjPWxT17mPtHTMiOgGzKxCbr1YMR4WOzH8BVfzY
R3dpGvCLebINmu6bbdv/D9fv94cQkup3ChC1t9OmE5L2PTGy5Z4=
=93x1
-----END PGP SIGNATURE-----

--zOcTNEe3AzgCmdo9--
