Received: from eggs.gnu.org ([2001:4830:134:3::10]:50925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgkXe-0006ZB-FR
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 22:58:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgkXd-0001T2-BB
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 22:58:06 -0500
Date: Thu, 23 Feb 2017 14:47:10 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170223034710.GJ12577@umbus.fritz.box>
References: <1487563478-22265-1-git-send-email-sjitindarsingh@gmail.com>
	<1487563478-22265-4-git-send-email-sjitindarsingh@gmail.com>
	<20170220073146.GC661@balbir.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Bsy/rPjPw3Zgz4JZ"
Content-Disposition: inline
In-Reply-To: <20170220073146.GC661@balbir.ozlabs.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [QEMU-PPC] [PATCH V3 03/10]
 target/ppc/POWER9: Adapt LPCR handling for POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Balbir Singh <bsingharora@gmail.com>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, sam.bobroff@au1.ibm.com


--Bsy/rPjPw3Zgz4JZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2017 at 06:31:46PM +1100, Balbir Singh wrote:
> On Mon, Feb 20, 2017 at 03:04:31PM +1100, Suraj Jitindar Singh wrote:
> > The logical partitioning control register controls a threads operation
> > based on the partition it is currently executing. Add new definitions a=
nd
> > update the mask used when writing to the LPCR based on the POWER9 spec.
> >=20
> > Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> > ---
> >  target/ppc/cpu.h            | 18 ++++++++++++++++++
> >  target/ppc/mmu-hash64.c     |  8 ++++++++
> >  target/ppc/translate_init.c | 24 ++++++++++++++++++------
> >  3 files changed, 44 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> > index bb96dd5..425e79d 100644
> > --- a/target/ppc/cpu.h
> > +++ b/target/ppc/cpu.h
> > @@ -384,12 +384,19 @@ struct ppc_slb_t {
> >  #define LPCR_DPFD         (0x7ull << LPCR_DPFD_SHIFT)
> >  #define LPCR_VRMASD_SHIFT (63 - 16)
> >  #define LPCR_VRMASD       (0x1full << LPCR_VRMASD_SHIFT)
> > +/* P9: Power-saving mode Exit Cause Enable (Upper Section) Mask */
> > +#define LPCR_PECE_U_SHIFT (63 - 19)
> > +#define LPCR_PECE_U_MASK  (0x7ull << LPCR_PECE_U_SHIFT)
> > +#define LPCR_HVEE         (1ull << (63 - 17)) /* Hypervisor Virt Exit =
Enable */
> >  #define LPCR_RMLS_SHIFT   (63 - 37)
> >  #define LPCR_RMLS         (0xfull << LPCR_RMLS_SHIFT)
> >  #define LPCR_ILE          (1ull << (63 - 38))
> >  #define LPCR_AIL_SHIFT    (63 - 40)      /* Alternate interrupt locati=
on */
> >  #define LPCR_AIL          (3ull << LPCR_AIL_SHIFT)
> > +#define LPCR_UPRT         (1ull << (63 - 41)) /* Use Process Table */
> > +#define LPCR_EVIRT        (1ull << (63 - 42)) /* Enhanced Virtualisati=
on */
> >  #define LPCR_ONL          (1ull << (63 - 45))
> > +#define LPCR_LD           (1ull << (63 - 46)) /* Large Decrementer */
> >  #define LPCR_P7_PECE0     (1ull << (63 - 49))
> >  #define LPCR_P7_PECE1     (1ull << (63 - 50))
> >  #define LPCR_P7_PECE2     (1ull << (63 - 51))
> > @@ -398,11 +405,22 @@ struct ppc_slb_t {
> >  #define LPCR_P8_PECE2     (1ull << (63 - 49))
> >  #define LPCR_P8_PECE3     (1ull << (63 - 50))
> >  #define LPCR_P8_PECE4     (1ull << (63 - 51))
> > +/* P9: Power-saving mode Exit Cause Enable (Lower Section) Mask */
> > +#define LPCR_PECE_L_SHIFT (63 - 51)
> > +#define LPCR_PECE_L_MASK  (0x1full << LPCR_PECE_L_SHIFT)
> > +#define LPCR_PDEE         (1ull << (63 - 47)) /* Privileged Doorbell E=
xit EN */
> > +#define LPCR_HDEE         (1ull << (63 - 48)) /* Hyperv Doorbell Exit =
Enable */
> > +#define LPCR_EEE          (1ull << (63 - 49)) /* External Exit Enable =
       */
> > +#define LPCR_DEE          (1ull << (63 - 50)) /* Decrementer Exit Enab=
le     */
> > +#define LPCR_OEE          (1ull << (63 - 51)) /* Other Exit Enable    =
       */
> >  #define LPCR_MER          (1ull << (63 - 52))
> > +#define LPCR_GTSE         (1ull << (63 - 53)) /* Guest Translation Sho=
otdown */
> >  #define LPCR_TC           (1ull << (63 - 54))
> > +#define LPCR_HEIC         (1ull << (63 - 59)) /* HV Extern Interrupt C=
ontrol */
> >  #define LPCR_LPES0        (1ull << (63 - 60))
> >  #define LPCR_LPES1        (1ull << (63 - 61))
> >  #define LPCR_RMI          (1ull << (63 - 62))
> > +#define LPCR_HVICE        (1ull << (63 - 62)) /* HV Virtualisation Int=
 Enable */
> >  #define LPCR_HDICE        (1ull << (63 - 63))
>=20
> This patch is missing
>=20
> #define LPCR_HR	(1ull << (63 - 43))	/* HV uses Radix Tree Translation */
>=20
> See arch/powerpc/include/asm/reg.h in the Linux kernel.=20

Suraj, if you're resending anyway, add this.  It doesn't matter for
non-powernv, of course, but we might as well put the #define in to
document it.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Bsy/rPjPw3Zgz4JZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYrls+AAoJEGw4ysog2bOS3PIP/irBK1iytmA2QnJGYWhUOPJu
Ej0lR4Ev+lc/i66TBzgnO9Ttp6qNN8Xy2v7X4XYoJD1EpTMxfJSR6uVBIRYBWOwG
nreuboGOqGncDg5Be2CfewDFUtuIiTiF4sDCX+5ygpTgjXctbjunwcRyxBNWNy5N
Ss/yIJwieaW0ZDfwjzf8zlIA0QvYeZ01qjt3aWmH4pyn0THMaXrGMDfBL+F0UNNG
EQcFEcXWy8ueejukOSkRA6A6V8/mbndmji29iEouQd89IDWr5iMOCw+C5QUwFnBj
LM5AnVL3xwS6nNAHq4/URu4J1tJQhDznZ2VDnJii+vOYOU5W/clugKJAbRWBIT/v
F78lAnIPp5wbOY98tcm/BZQxd607MVxBoYeMZexnoQCYazPwDvEf0HITk1LPeVCI
BNsaJ3r3XCUPKefQ2/3dV1H8sYpgok9mhELQ5K+dURs+DO9dsB2FmEvne6F1KOkz
vV/KD5fiP3pExtR1Irj+7jgth5PmuNa5pMiUa0ENrYHEwLDgr4FYK+YvMBu4II0j
WlRz/jDNEd8OeA3psElMnf0hQJeW9c7AGtqBzUfQN5wbsr9l9kGvBjfdt9s1tIF4
7fV8MT+zHLNU4LEywZLT74MwR76FdAu2+xA8ytDWyrX8gR6gLY9XouLGPEJVusxm
tlZUKx33Ndmi3O2hFFuO
=muTQ
-----END PGP SIGNATURE-----

--Bsy/rPjPw3Zgz4JZ--
