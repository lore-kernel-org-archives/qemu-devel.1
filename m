Received: from eggs.gnu.org ([208.118.235.92]:47546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1geXXi-0004ja-Lq
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 22:50:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1geXXh-00063J-CQ
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 22:50:06 -0500
Date: Wed, 2 Jan 2019 13:31:44 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190102023144.GB27457@umbus.fritz.box>
References: <20181223111525.581-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hQiwHBbRI9kgIhsi"
Content-Disposition: inline
In-Reply-To: <20181223111525.581-1-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH v4 0/9] target/ppc: prepare for conversion
 to TCG vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, richard.henderson@linaro.org


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 23, 2018 at 11:15:16AM +0000, Mark Cave-Ayland wrote:
> This patchset is an attempt at trying to improve the VMX (Altivec) instru=
ction
> performance by laying the groundwork for use of the new TCG vector operat=
ions.
>=20
> Patches 1 and 2 fix a sign-extension error discovered in EXTRACT_SHELPER =
and an
> associated typo in the SIMM5 macro which were discovered whilst testing R=
ichard's
> follow-on TCG vector improvements patchset.
>=20
> In order to use TCG vector operations, the registers must be accessible f=
rom cpu_env
> whilst currently they are accessed via arrays of static TCG globals. Patc=
hes 3-5
> are therefore mechanical patches which introduce access helpers for FPR, =
AVR and VSR
> registers using the supplied TCGv_i64 parameter.
>=20
> Once this is done, patch 6 enables us to remove the static TCG global arr=
ays and updates
> the access helpers to read/write to the relevant fields in cpu_env direct=
ly.
>=20
> Patches 7 and 8 perform the legwork required to enable VSX instructions t=
o be converted
> to use TCG vector operations in future by rearranging the FP, VMX and VSX=
 registers into
> a single aligned VSR register array (the scope of this patchset is VMX on=
ly).
>=20
> Patch 9 removes the AVR* macros and replaces them with the corresponding =
Vsr* macros
> since they are equivalent.
>=20
> Finally thanks to Richard for taking the time to answer some of my (mostl=
y beginner)
> questions related to TCG.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied to ppc-for-4.0, thanks.

>=20
>=20
> v4:
> - Rebase onto master
> - Add extra R-B tags from Richard
> - Leave HI_IDX/LO_IDX in int_helper.c in patch 9 (similarly named macros =
are also
>   used in other files so let's ensure there is no confusion)
> - Add cpu_fpr_ptr(), cpu_vsrl_ptr() and cpu_avr_ptr() as suggested by Ric=
hard in
>   patch 8
>=20
> v3:
> - Rebase onto master, drop RFC prefix, alter subject line
> - Add A-B tags from David
> - Add SIMM5/EXTRACT_HELPER macro fix patches to the start of the series
> - Drop patch 4 from previous patchset (delay AVR register writeback) as i=
t should
>   not be required.
> - Remove extra get_fpr() accidentally added to GEN_FLOAT macros in patch 3
> - Fix temporary leak when VMX/VSX not enabled in patches 4 and 5
> - Add patch to remove AVR* macros, replacing them with Vsr* macros
> - Drop patches converting logical, add and sub instructions to TCG vector=
 ops (let
>   Richard incorporate this into his TCG vector improvements patchset)
>=20
> v2:
> - Rebase onto master
> - Add comment explaining rationale for FPR helpers in description for pat=
ch 1
> - Add R-B tags from Richard
> - Add patch 3 to delay AVR register writeback as spotted by Richard
> - Add patches 6 and 7 to merge FPR, VMX and VSX registers into the vsr ar=
ray
>   to facilitate conversion of VSX instructions to vector operations later
> - Fix accidental bug whereby the conversion of get_vsr()/set_vsr() to acc=
ess
>   data from cpu_env was incorrectly squashed into patch 3
> - Move set_fpr() further down in gen_fsqrts() and gen_frsqrtes() in patch=
 1
>=20
> Mark Cave-Ayland (9):
>   target/ppc: fix typo in SIMM5 extraction helper
>   target/ppc: switch EXTRACT_HELPER macros over to use
>     sextract32/extract32
>   target/ppc: introduce get_fpr() and set_fpr() helpers for FP register
>     access
>   target/ppc: introduce get_avr64() and set_avr64() helpers for VMX
>     register access
>   target/ppc: introduce get_cpu_vsr{l,h}() and set_cpu_vsr{l,h}()
>     helpers for VSR register access
>   target/ppc: switch FPR, VMX and VSX helpers to access data directly
>     from cpu_env
>   target/ppc: merge ppc_vsr_t and ppc_avr_t union types
>   target/ppc: move FP and VMX registers into aligned vsr register array
>   target/ppc: replace AVR* macros with Vsr* macros
>=20
>  linux-user/ppc/signal.c             |  28 +-
>  target/ppc/arch_dump.c              |  15 +-
>  target/ppc/cpu.h                    |  42 +-
>  target/ppc/gdbstub.c                |   8 +-
>  target/ppc/int_helper.c             |  86 ++--
>  target/ppc/internal.h               |  39 +-
>  target/ppc/machine.c                |  72 ++-
>  target/ppc/monitor.c                |   4 +-
>  target/ppc/translate.c              |  73 ++-
>  target/ppc/translate/dfp-impl.inc.c |   2 +-
>  target/ppc/translate/fp-impl.inc.c  | 486 +++++++++++++++-----
>  target/ppc/translate/vmx-impl.inc.c | 154 +++++--
>  target/ppc/translate/vsx-impl.inc.c | 862 ++++++++++++++++++++++++++----=
------
>  target/ppc/translate_init.inc.c     |  26 +-
>  14 files changed, 1360 insertions(+), 537 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--hQiwHBbRI9kgIhsi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwsIpAACgkQbDjKyiDZ
s5L+kw/9Fmexm8+7ItVNo1uFTsA30q1vjHuT/81qJb24E14sXXXREC3ntSOxtTNK
GyAKd0PEn6Vw3d944ByyN/SgxMtIZNZYTMeyCv8GSJ8/bvW5/taTlbVkAvXhKDtd
HpCD6EEr1Awj0WuNl9DgnVNKyfWQXvkNBKRUQVahqYgj/SwAGAZQT14B0BK6Us/D
++F0DFlayvXD21BZLo6iYutxe4CO9/03z/Em+P/MpTjFF8dhmrCr8KKR9ddCXExA
+JQvbr/oaZK23f8F2GfBbATinPlr/wA69qjhNAPPezW05CNL6RQxu+294NzgeUuI
7TmO5fl9Uy85ucrCGl9Zps6zMsz7MMtGfM44Y1fLkw/3hiiJyzyQQt/9+DG5OtTK
eLEI5jNLI0/yMuIYS/+RqajLI3qG0tF2ysfCRPmIKlzIKFYVpdRLmzrES1dPhd61
BJ6MEg0Vv5Og9Gdr90f15+HCLcIB8O05xp5dDTdrrpAhoBrGmHykZF99n4IOnhWN
84kOTZyGUTkoiZiN9co4lp/JrsZC62TV+Hjg7e/5+MhLRk7UFeaDN7+dRAn+Scd0
PGN7/f3+7Nb7uPgCNuyP4xORR39UJYIJVJVfVBHCY0kj66WQ80yfDvEhGjO83dJB
mNSl6w3rYWGR8P/3d0De4HIPzCIJzUDV96k6mWBTEFlIQzJ5ykQ=
=fuoS
-----END PGP SIGNATURE-----

--hQiwHBbRI9kgIhsi--
