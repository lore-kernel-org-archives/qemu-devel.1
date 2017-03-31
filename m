Received: from eggs.gnu.org ([2001:4830:134:3::10]:33054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ctoJT-0003ai-Vq
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 00:37:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ctoJS-0003H6-PR
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 00:37:28 -0400
Date: Fri, 31 Mar 2017 14:23:08 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170331032308.GH22163@umbus>
References: <cover.1490763676.git.sam.bobroff@au1.ibm.com>
	<fe96334e261ed8da1c03202ea88a139b479c0c23.1490763676.git.sam.bobroff@au1.ibm.com>
	<20170329053928.56B1FAE03B@b01ledav005.gho.pok.ibm.com>
	<20170330022836.GA4044@tungsten.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/9ZOS6odDaRI+0hI"
Content-Disposition: inline
In-Reply-To: <20170330022836.GA4044@tungsten.ozlabs.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] target/ppc: Improve accuracy of guest
 HTM availability on P8s
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--/9ZOS6odDaRI+0hI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 30, 2017 at 01:28:36PM +1100, Sam Bobroff wrote:
> On Wed, Mar 29, 2017 at 07:39:25AM +0200, Thomas Huth wrote:
> > On 29.03.2017 07:01, Sam Bobroff wrote:
> > > On Power8 hosts it is currently theoretically possible for QEMU/KVM-H=
V guests
> > > to receive a ibm,pa-features property indicating that HTM support is =
available
> > > when it is not.  The situation would occur if the platform firmware of
> > > a Power8 host cleared the HTM bit of the ibm,pa-features property.
> >=20
> > Out of curiosity: Is there a machine out there where this happens?
>=20
> Not that I know of... just the one who's firmware I broke on purpose for
> testing ;-)

Ok, given that, I'm moving this fix from ppc-for-2.9 to ppc-for-2.10.

>=20
> > > QEMU would query KVM for the availability of HTM, which will return no
> > > support, but workaround code in kvm_arch_init_vcpu() would then
> > > re-enable it because KVM_HV is in use and the processor is P8.
> > >=20
> > > This patch adjusts the workaround in kvm_arch_init_vcpu() so that it =
does not
> > > enable HTM (in the above case) unless the host kernel indicates to th=
e QEMU
> > > process, via the auxiliary vector, that userspace can use HTM (via th=
e HWCAP2
> > > bit KVM_FEATURE2_HTM).
> > >=20
> > > The reason to use the value from the auxiliary vector is that it is
> > > set based only on what the host kernel found in the ibm,pa-features
> > > HTM bit at boot time.
> > >=20
> > > Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> > > ---
> > >  target/ppc/kvm.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> > > index 9f1f132cef..8a54709ae4 100644
> > > --- a/target/ppc/kvm.c
> > > +++ b/target/ppc/kvm.c
> > > @@ -49,6 +49,7 @@
> > >  #if defined(TARGET_PPC64)
> > >  #include "hw/ppc/spapr_cpu_core.h"
> > >  #endif
> > > +#include "elf.h"
> > > =20
> > >  //#define DEBUG_KVM
> > > =20
> > > @@ -509,8 +510,11 @@ int kvm_arch_init_vcpu(CPUState *cs)
> > >      case POWERPC_MMU_2_07:
> > >          if (!cap_htm && !kvmppc_is_pr(cs->kvm_state)) {
> > >              /* KVM-HV has transactional memory on POWER8 also withou=
t the
> > > -             * KVM_CAP_PPC_HTM extension, so enable it here instead.=
 */
> > > -            cap_htm =3D true;
> > > +             * KVM_CAP_PPC_HTM extension, so enable it here instead =
as
> > > +             * long as it's availble to userspace on the host. */
> > > +            if (qemu_getauxval(AT_HWCAP2) & PPC_FEATURE2_HAS_HTM) {
> > > +                cap_htm =3D true;
> > > +            }
> >=20
> > That's a very good idea! ... but I think you could also merge the two
> > if-statements into one to save one level of indentation.
> >=20
> >  Thomas
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/9ZOS6odDaRI+0hI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY3cuaAAoJEGw4ysog2bOS5WAQAIQRtSv88A4Sw5FCnVnRVbOf
SBh58VZzgX/+KP2wQUyuhi4WiemOjDpf8BGoM2oHDDcX6iybOYIeRmeHyXnOMBhn
Uccw/qgz5AxKZus8G7WxGGyTCRolTu6eVhrCKGp5I/F/Nx0rRqWLeZ7lTGg0ZidZ
YC1zcTY/4z1IOVerbPwLELl2A6sXwVLOM00ikqKWW/4hlvQEEse3yJtcv9M0hpPu
1w6WfS3Y+1elcaaPXrv1+28LYlOeOO/9RETmMUuv7dp7f3csS9+L8O2pwPnKdDJG
WJ3z0x9poc0z68q3WmdV1j2rXeCgzW7NPWgJpIQFl2tNyLwM+9SwlojLCP5geFkS
/Z0ltPAB1k/vAmR4hNiR/HGVSbnz/F1bX3mXe7iqCUoe77uxXugeiRVUoQP82+pO
Sc+EVyJVoXa6XlyLWa3qmOvXw4wZNX4xMg1FzO96rGbYi/8qEfnyt0ZON5xvBFmr
qFd8MsxDVJqRIudVKD/CAzIYif2tts+i/H30yzl9eBw9umGLJJ/4nm2TNreVeOhR
db7/+ofTO728HEAiqb+SqETDJSVrJruiAQZkLXFxJ0ksgaWshqPgvzMIO3iwMBC8
afiBdBVTk5/jJurDKEZBhn9WGRu2Rz+fKJM6tZdXTHLtwR0AAhO1spbIKxSEXfDA
rnwbn2d4lgcAZJ4oePTB
=HuH+
-----END PGP SIGNATURE-----

--/9ZOS6odDaRI+0hI--
