Received: from eggs.gnu.org ([2001:4830:134:3::10]:60460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cTLh0-0002Sr-ID
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 23:48:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cTLgx-0007xB-Cu
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 23:48:22 -0500
Date: Tue, 17 Jan 2017 15:37:34 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170117043734.GH15853@umbus>
References: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
	<1484288903-18807-6-git-send-email-sjitindarsingh@gmail.com>
	<20170116214030.GG15853@umbus> <1484614111.2028.14.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="svZFHVx8/dhPCe52"
Content-Disposition: inline
In-Reply-To: <1484614111.2028.14.camel@gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH 05/17] target/ppc/POWER9: Adapt LPCR
 handling for POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, agraf@suse.de, qemu-devel@nongnu.org


--svZFHVx8/dhPCe52
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 17, 2017 at 11:48:31AM +1100, Suraj Jitindar Singh wrote:
> On Tue, 2017-01-17 at 08:40 +1100, David Gibson wrote:
> > On Fri, Jan 13, 2017 at 05:28:11PM +1100, Suraj Jitindar Singh wrote:
> > >=20
> > > The logical partitioning control register controls a threads
> > > operation
> > > based on the partition it is currently executing. Add new
> > > definitions and
> > > update the mask used when writing to the LPCR based on the POWER9
> > > spec.
> > >=20
> > > Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> > > ---
> > > =A0target/ppc/cpu.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0| 20 +++++++++=
++++++++++-
> > > =A0target/ppc/mmu-hash64.c=A0=A0=A0=A0=A0|=A0=A08 ++++++++
> > > =A0target/ppc/translate_init.c | 24 ++++++++++++++++++------
> > > =A03 files changed, 45 insertions(+), 7 deletions(-)
> > >=20
> > > diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> > > index afb7ddb..0ab49b3 100644
> > > --- a/target/ppc/cpu.h
> > > +++ b/target/ppc/cpu.h
> > > @@ -379,15 +379,22 @@ struct ppc_slb_t {
> > > =A0#define LPCR_ISL=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0(1ull << (63 - 2))
> > > =A0#define LPCR_KBV=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0(1ull << (63 - 3))
> > > =A0#define LPCR_DPFD_SHIFT=A0=A0=A0(63 - 11)
> > > -#define LPCR_DPFD=A0=A0=A0=A0=A0=A0=A0=A0=A0(0x3ull << LPCR_DPFD_SHI=
FT)
> > > +#define LPCR_DPFD=A0=A0=A0=A0=A0=A0=A0=A0=A0(0x7ull << LPCR_DPFD_SHI=
FT)
> > Changing this define effectively changes the valid LPCR mask for
> > existing POWER8 and POWER7 models, which is not what you want, I
> > think.
> I should have explained this better in the commit message, this has
> always been a 3 bit field (at least in POWER7-9) so the mask has just
> always been wrong. Afaik fixing this up won't really change anything -
> it relates to data stream prefetch depth.
>=20
> I realise this should probably be a separate patch though, or atleast
> mentioned in the commit message.

Right, yes.  Please make the bugfix a separate patch with the
explanation in the commit message.

> >=20
> > >=20
> > > =A0#define LPCR_VRMASD_SHIFT (63 - 16)
> > > =A0#define LPCR_VRMASD=A0=A0=A0=A0=A0=A0=A0(0x1full << LPCR_VRMASD_SH=
IFT)
> > > +/* P9: Power-saving mode Exit Cause Enable (Upper Section) Mask */
> > > +#define LPCR_PECE_U_SHIFT (63 - 19)
> > > +#define LPCR_PECE_U_MASK=A0=A0(0x7ull << LPCR_PECE_U_SHIFT)
> > > +#define LPCR_HVEE=A0=A0=A0=A0=A0=A0=A0=A0=A0(1ull << (63 - 17)) /* H=
ypervisor Virt
> > > Exit Enable */
> > > =A0#define LPCR_RMLS_SHIFT=A0=A0=A0(63 - 37)
> > > =A0#define LPCR_RMLS=A0=A0=A0=A0=A0=A0=A0=A0=A0(0xfull << LPCR_RMLS_S=
HIFT)
> > > =A0#define LPCR_ILE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0(1ull << (63 - 38))
> > > =A0#define LPCR_AIL_SHIFT=A0=A0=A0=A0(63 - 40)=A0=A0=A0=A0=A0=A0/* Al=
ternate interrupt
> > > location */
> > > =A0#define LPCR_AIL=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0(3ull << LPCR_AIL_SH=
IFT)
> > > +#define LPCR_UPRT=A0=A0=A0=A0=A0=A0=A0=A0=A0(1ull << (63 - 41)) /* U=
se Process Table
> > > */
> > > +#define LPCR_EVIRT=A0=A0=A0=A0=A0=A0=A0=A0(1ull << (63 - 42)) /* Enh=
anced
> > > Virtualisation */
> > > =A0#define LPCR_ONL=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0(1ull << (63 - 45))
> > > +#define LPCR_LD=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0(1ull << (63 - 46)) =
/* Large Decrementer
> > > */
> > > =A0#define LPCR_P7_PECE0=A0=A0=A0=A0=A0(1ull << (63 - 49))
> > > =A0#define LPCR_P7_PECE1=A0=A0=A0=A0=A0(1ull << (63 - 50))
> > > =A0#define LPCR_P7_PECE2=A0=A0=A0=A0=A0(1ull << (63 - 51))
> > > @@ -396,11 +403,22 @@ struct ppc_slb_t {
> > > =A0#define LPCR_P8_PECE2=A0=A0=A0=A0=A0(1ull << (63 - 49))
> > > =A0#define LPCR_P8_PECE3=A0=A0=A0=A0=A0(1ull << (63 - 50))
> > > =A0#define LPCR_P8_PECE4=A0=A0=A0=A0=A0(1ull << (63 - 51))
> > > +/* P9: Power-saving mode Exit Cause Enable (Lower Section) Mask */
> > > +#define LPCR_PECE_L_SHIFT (63 - 51)
> > > +#define LPCR_PECE_L_MASK=A0=A0(0x1full << LPCR_PECE_L_SHIFT)
> > > +#define LPCR_PDEE=A0=A0=A0=A0=A0=A0=A0=A0=A0(1ull << (63 - 47)) /* P=
rivileged
> > > Doorbell Exit EN */
> > > +#define LPCR_HDEE=A0=A0=A0=A0=A0=A0=A0=A0=A0(1ull << (63 - 48)) /* H=
yperv Doorbell
> > > Exit Enable */
> > > +#define LPCR_EEE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0(1ull << (63 - 49)) /*=
 External Exit
> > > Enable=A0=A0=A0=A0=A0=A0=A0=A0*/
> > > +#define LPCR_DEE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0(1ull << (63 - 50)) /*=
 Decrementer Exit
> > > Enable=A0=A0=A0=A0=A0*/
> > > +#define LPCR_OEE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0(1ull << (63 - 51)) /*=
 Other Exit
> > > Enable=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0*/
> > > =A0#define LPCR_MER=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0(1ull << (63 - 52))
> > > +#define LPCR_GTSE=A0=A0=A0=A0=A0=A0=A0=A0=A0(1ull << (63 - 53)) /* G=
uest Translation
> > > Shootdown */
> > > =A0#define LPCR_TC=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0(1ull << (63 - 54))
> > > +#define LPCR_HEIC=A0=A0=A0=A0=A0=A0=A0=A0=A0(1ull << (63 - 59)) /* H=
V Extern
> > > Interrupt Control */
> > > =A0#define LPCR_LPES0=A0=A0=A0=A0=A0=A0=A0=A0(1ull << (63 - 60))
> > > =A0#define LPCR_LPES1=A0=A0=A0=A0=A0=A0=A0=A0(1ull << (63 - 61))
> > > =A0#define LPCR_RMI=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0(1ull << (63 - 62))
> > > +#define LPCR_HVICE=A0=A0=A0=A0=A0=A0=A0=A0(1ull << (63 - 62)) /* HV =
Virtualisation
> > > Int Enable */
> > > =A0#define LPCR_HDICE=A0=A0=A0=A0=A0=A0=A0=A0(1ull << (63 - 63))
> > > =A0
> > > =A0#define msr_sf=A0=A0=A0((env->msr >> MSR_SF)=A0=A0=A0& 1)
> > > diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> > > index fdb7a78..3a2acb8 100644
> > > --- a/target/ppc/mmu-hash64.c
> > > +++ b/target/ppc/mmu-hash64.c
> > > @@ -1050,6 +1050,14 @@ void helper_store_lpcr(CPUPPCState *env,
> > > target_ulong val)
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
LPCR_P8_PECE2 | LPCR_P8_PECE3 |
> > > LPCR_P8_PECE4 |
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
LPCR_MER | LPCR_TC | LPCR_LPES0 |
> > > LPCR_HDICE);
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0break;
> > > +=A0=A0=A0=A0case POWERPC_MMU_3_00: /* P9 */
> > > +=A0=A0=A0=A0=A0=A0=A0=A0lpcr =3D val & (LPCR_VPM1 | LPCR_ISL | LPCR_=
KBV | LPCR_DPFD
> > > |
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0(L=
PCR_PECE_U_MASK & LPCR_HVEE) | LPCR_ILE |
> > > LPCR_AIL |
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0LP=
CR_UPRT | LPCR_EVIRT | LPCR_ONL |
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0(L=
PCR_PECE_L_MASK & (LPCR_PDEE | LPCR_HDEE |
> > > LPCR_EEE |
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0LP=
CR_DEE | LPCR_OEE)) | LPCR_MER | LPCR_GTSE
> > > | LPCR_TC |
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0LP=
CR_HEIC | LPCR_LPES0 | LPCR_HVICE |
> > > LPCR_HDICE);
> > > +=A0=A0=A0=A0=A0=A0=A0=A0break;
> > > =A0=A0=A0=A0=A0default:
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0;
> > > =A0=A0=A0=A0=A0}
> > > diff --git a/target/ppc/translate_init.c
> > > b/target/ppc/translate_init.c
> > > index 2402eef..a1994d3 100644
> > > --- a/target/ppc/translate_init.c
> > > +++ b/target/ppc/translate_init.c
> > > @@ -8887,12 +8887,24 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu)
> > > =A0=A0=A0=A0=A0lpcr->default_value &=3D ~LPCR_RMLS;
> > > =A0=A0=A0=A0=A0lpcr->default_value |=3D 1ull << LPCR_RMLS_SHIFT;
> > > =A0
> > > -=A0=A0=A0=A0/* P7 and P8 has slightly different PECE bits, mostly be=
cause
> > > P8 adds
> > > -=A0=A0=A0=A0=A0* bit 47 and 48 which are reserved on P7. Here we set=
 them
> > > all, which
> > > -=A0=A0=A0=A0=A0* will work as expected for both implementations
> > > -=A0=A0=A0=A0=A0*/
> > > -=A0=A0=A0=A0lpcr->default_value |=3D LPCR_P8_PECE0 | LPCR_P8_PECE1 |
> > > LPCR_P8_PECE2 |
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0LPCR_P8_PECE3 | LPCR_P8_PECE4;
> > > +=A0=A0=A0=A0switch (env->mmu_model) {
> > I'm not sure of mmu_model is conceptually the right thing to switch
> > on, although I guess it will work in practice.
> Well we need something to indicate our default value, which is dictated
> by the cpu model, and given that a cpu model correlates to a mmu model
> I can't think of a better option.

Yeah, I guess it's probably reasonable.  We can always change it later
if we need to.

> >=20
> > >=20
> > > +=A0=A0=A0=A0case POWERPC_MMU_3_00:
> > > +=A0=A0=A0=A0=A0=A0=A0=A0/* By default we choose legacy mode and swit=
ch to new hash
> > > or radix
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0* when a register process table hcall is =
made. So disable
> > > process
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0* tables and guest translation shootdown =
by default
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0*/
> > > +=A0=A0=A0=A0=A0=A0=A0=A0lpcr->default_value &=3D ~(LPCR_UPRT | LPCR_=
GTSE);
> > > +=A0=A0=A0=A0=A0=A0=A0=A0lpcr->default_value |=3D LPCR_PDEE | LPCR_HD=
EE | LPCR_EEE |
> > > LPCR_DEE |
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0LPCR_OEE;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0break;
> > > +=A0=A0=A0=A0default:
> > > +=A0=A0=A0=A0=A0=A0=A0=A0/* P7 and P8 has slightly different PECE bit=
s, mostly
> > > because P8 adds
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0* bit 47 and 48 which are reserved on P7.=
 Here we set
> > > them all, which
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0* will work as expected for both implemen=
tations
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0*/
> > > +=A0=A0=A0=A0=A0=A0=A0=A0lpcr->default_value |=3D LPCR_P8_PECE0 | LPC=
R_P8_PECE1 |
> > > LPCR_P8_PECE2 |
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0LPCR_P8_PECE3 | LPCR_P8_PECE4;
> > > +=A0=A0=A0=A0}
> > > =A0
> > > =A0=A0=A0=A0=A0/* We should be followed by a CPU reset but update the=
 active
> > > value
> > > =A0=A0=A0=A0=A0=A0* just in case...
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--svZFHVx8/dhPCe52
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYfZ+MAAoJEGw4ysog2bOS88MP/1KRMhWHg26TNGjosLYYBcpw
nPyEo7MfxMKPIKwQTUpriDieIUsIrh+OJcQjzFbP3PIW57/ZBEIjvmQ+Givc1Lxj
OyS1EOHjjvpqXInW0frRm+V+YVjfYw5PNpbSRJliC9Uzg74E7x2/1zXHGP1zlwdD
cWpKU/bwqdE1UoN5ykD5JazEaF2w2BYeaHGp9G5e+YcQMSPm5AvAVUNOod0fGIUG
bvJWgUCQys3uNKMjT41AEQlM3Wp4B1bUkOIN7Gf+aNnrbBs+k3Z+E4C99wVwN79k
eSmMaEiSa91y7bfb9kuvkkRUImsEbGAZOAPLB7hYkbW9ADw+QCABuW+um+3n4DUK
ZlY33O7RXiAYSSc/1VIzsbUVy4POBfGHMrAO67nUEPX0tgEZwU3a9qTyE0L+bKvN
bd+VNdK/fwxcY7ss26O8Iyxg9f3qboh1NaoDjrJAoth5Bm2af/fdT0cJ5DYzxXq3
EwbjZZCBARHtfduWlzCxTI4aLlhTYdxG7KiN1IbS26wGkf26oYXLxYb7PlUw+FEc
YpqnlYtwAsbpbaJOEn4WuNzpCqVSfKMb9RjbWwwkHS+2umMHx5W7MW4Fiyo/4IEa
CtNBptQkw9G06dftcdvnW1QJhEmdVd8VEHpAHYg+wBqmE6gTKsuLZ1wH6WhggJNO
ToOyFB5695PT2jGrKYRy
=6wDZ
-----END PGP SIGNATURE-----

--svZFHVx8/dhPCe52--
