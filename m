Received: from eggs.gnu.org ([2001:4830:134:3::10]:48167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkRNT-0001TA-IU
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 04:51:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkRNN-0005DT-Hz
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 04:51:07 -0400
Date: Wed, 23 Aug 2017 18:39:23 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170823083923.GR5379@umbus.fritz.box>
References: <150287457293.9760.17827532208744487789.stgit@aravinda>
	<150287475974.9760.13295593936611613542.stgit@aravinda>
	<20170817015735.GD5509@umbus.fritz.box>
	<f7f837f6-9ce9-3eb3-8083-31878c851267@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zj18g9eElA7rRQh+"
Content-Disposition: inline
In-Reply-To: <f7f837f6-9ce9-3eb3-8083-31878c851267@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 4/5] target/ppc: Handle NMI guest exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru, mahesh@linux.vnet.ibm.com, benh@au1.ibm.com, paulus@samba.org, sam.bobroff@au1.ibm.com


--zj18g9eElA7rRQh+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 21, 2017 at 06:00:52PM +0530, Aravinda Prasad wrote:
>=20
>=20
> On Thursday 17 August 2017 07:27 AM, David Gibson wrote:
> > On Wed, Aug 16, 2017 at 02:42:39PM +0530, Aravinda Prasad wrote:
> >> Memory error such as bit flips that cannot be corrected
> >> by hardware are passed on to the kernel for handling.
> >> If the memory address in error belongs to guest then
> >> guest kernel is responsible for taking suitable action.
> >> Patch [1] enhances KVM to exit guest with exit reason
> >> set to KVM_EXIT_NMI in such cases.
> >>
> >> This patch handles KVM_EXIT_NMI exit. If the guest OS
> >> has registered the machine check handling routine by
> >> calling "ibm,nmi-register", then the handler builds
> >> the error log and invokes the registered handler else
> >> invokes the handler at 0x200.
> >>
> >> [1] https://www.spinics.net/lists/kvm-ppc/msg12637.html
> >> 	(e20bbd3d and related commits)
> >>
> >> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> >> ---
> >>  hw/ppc/spapr.c       |    4 ++
> >>  target/ppc/kvm.c     |   86 +++++++++++++++++++++++++++++++++++++++++=
+++++++++
> >>  target/ppc/kvm_ppc.h |   81 +++++++++++++++++++++++++++++++++++++++++=
++++++
> >>  3 files changed, 171 insertions(+)
> >>
> >> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >> index 0bb2c4a..6cc3f69 100644
> >> --- a/hw/ppc/spapr.c
> >> +++ b/hw/ppc/spapr.c
> >> @@ -2346,6 +2346,10 @@ static void ppc_spapr_init(MachineState *machin=
e)
> >>          error_report("Could not get size of LPAR rtas '%s'", filename=
);
> >>          exit(1);
> >>      }
> >> +
> >> +    /* Resize blob to accommodate error log. */
> >> +    spapr->rtas_size =3D RTAS_ERRLOG_OFFSET + sizeof(struct RtasMCELo=
g);
> >> +
> >>      spapr->rtas_blob =3D g_malloc(spapr->rtas_size);
> >>      if (load_image_size(filename, spapr->rtas_blob, spapr->rtas_size)=
 < 0) {
> >>          error_report("Could not load LPAR rtas '%s'", filename);
> >> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> >> index 8571379..73f64ed 100644
> >> --- a/target/ppc/kvm.c
> >> +++ b/target/ppc/kvm.c
> >> @@ -1782,6 +1782,11 @@ int kvm_arch_handle_exit(CPUState *cs, struct k=
vm_run *run)
> >>          ret =3D 0;
> >>          break;
> >> =20
> >> +    case KVM_EXIT_NMI:
> >> +        DPRINTF("handle NMI exception\n");
> >> +        ret =3D kvm_handle_nmi(cpu);
> >> +        break;
> >> +
> >>      default:
> >>          fprintf(stderr, "KVM: unknown exit reason %d\n", run->exit_re=
ason);
> >>          ret =3D -1;
> >> @@ -2704,6 +2709,87 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
> >>      return data & 0xffff;
> >>  }
> >> =20
> >> +int kvm_handle_nmi(PowerPCCPU *cpu)
> >=20
> > So you only handle NMIs with KVM.  Wouldn't it make sense to also
> > handle them for TCG (where they can be triggered with the "nmi"
> > command on the monitor).
>=20
> For TCG it is already handled in spapr_nmi() which ultimately branches
> to guest's 0x200 vector. Even with KVM when KVM_CAP_PPC_FWNMI is not
> enabled we branch to guest's 0x200 vector. Should TCG behave as if
> KVM_CAP_PPC_FWNMI is not enabled?

No, we should implement the FWNMI feature for TCG, which means it
needs to respect the address given by nmi-register.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zj18g9eElA7rRQh+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmdPzkACgkQbDjKyiDZ
s5Jd7g/9FvJTAzUvGOSKs2c3/cs0dsii3rvPTvimNBoc5LD2FYdkXu+qPmU7P92v
I9tGh8tcKZxSDLxHKtW+2Xt7K5FWWCBCrw2PFyjSncpDCQc6VuA30zKD8JAw/ymZ
4M0e73rRyQoPU+z19MtsOvM/jj4EPWXl9HxqfxPTlDcZZ5Lhfwvdqf/5EamprdU1
cd9U6h0111sJh4B6iG8f6oxrQg7dSPmeo1/QaGKDhLd1Fa5tGGQacBFZKY5KuFFv
1C7jcJuw1wogNUU7MgG1Y68hqL/4FphGkuoShrHU3W90u8juHp9okKhJX7S9F1za
7JFUt0oUivVQIOTldX+cZvB0nexz7acYJnuHpKU8sk5gduVss7uZwbAYU6czSvzP
2HdU/CSEn6Cg+Y3P2WC8r2s328V7IIfw79H2kmPHgV4gLIqET4z3tu6pUjTepaju
O3hddzDmgerYjYSbZwAqBIT32LIHrjSuZSknTPO2sIGcmzULIdNK/gtriLURUaom
tWBMopsETaZZ2wsUO1zl8gU+9ok0Qj6QoM7YhhwrtKXlW7k/jlaRiUzREXrOQR+u
5x3vOuGh5XLKEne++H3lJKY+wFgkkIBAoV6JW8yXGRze8XZco+WJmFPi/JKolEEE
P4EfStzO2IdWwGN2JLdlu4DsuM2R7r/xYyiM6LF8tZYyOD7f7XY=
=Eeh5
-----END PGP SIGNATURE-----

--zj18g9eElA7rRQh+--
