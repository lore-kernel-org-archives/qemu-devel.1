Received: from eggs.gnu.org ([2001:4830:134:3::10]:37508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkh2G-0003Eh-NK
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 21:34:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkh2F-0005cE-Co
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 21:34:16 -0400
Date: Thu, 24 Aug 2017 11:34:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170824013402.GU5379@umbus.fritz.box>
References: <20170821200036.15036-1-bauerman@linux.vnet.ibm.com>
	<20170822020258.GX12356@umbus.fritz.box>
	<87y3q9q3l3.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jllsgs4PL/sXFNaa"
Content-Disposition: inline
In-Reply-To: <87y3q9q3l3.fsf@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] spapr: Add ibm,
 processor-storage-keys property to CPU DT node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Ram Pai <linuxram@us.ibm.com>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>


--jllsgs4PL/sXFNaa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2017 at 08:14:32PM -0300, Thiago Jung Bauermann wrote:
>=20
> Hello David,
>=20
> Thank you for your input.
>=20
> David Gibson <david@gibson.dropbear.id.au> writes:
>=20
> > On Mon, Aug 21, 2017 at 05:00:36PM -0300, Thiago Jung Bauermann wrote:
> >> LoPAPR says:
> >>=20
> >>     =E2=80=9Cibm,processor-storage-keys=E2=80=9D
> >>=20
> >>     property name indicating the number of virtual storage keys suppor=
ted
> >>     by the processor described by this node.
> >>=20
> >>     prop-encoded-array: Consists of two cells encoded as with encode-i=
nt.
> >>     The first cell represents the number of virtual storage keys suppo=
rted
> >>     for data accesses while the second cell represents the number of
> >>     virtual storage keys supported for instruction accesses. The cell =
value
> >>     of zero indicates that no storage keys are supported for the access
> >>     type.
> >>=20
> >> pHyp provides the property above but there's a bug in P8 firmware wher=
e the
> >> second cell is zero even though POWER8 supports instruction access key=
s.
> >> This bug will be fixed for P9.
> >>=20
> >> Tested with KVM on POWER8 Firenze machine and with TCG on x86_64 machi=
ne.
> >>=20
> >> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> >
> > Regardless of anything else, this clearly won't go in until 2.11 opens.
>=20
> Ok, not a problem.
>=20
> >> --- a/hw/ppc/spapr.c
> >> +++ b/hw/ppc/spapr.c
> >> @@ -605,6 +605,80 @@ static void spapr_populate_cpu_dt(CPUState *cs, v=
oid *fdt, int offset,
> >>                            pcc->radix_page_info->count *
> >>                            sizeof(radix_AP_encodings[0]))));
> >>      }
> >> +
> >> +    if (spapr->storage_keys) {
> >> +        uint32_t val[2];
> >> +
> >> +        val[0] =3D cpu_to_be32(spapr->storage_keys);
> >> +        val[1] =3D spapr->insn_keys ? val[0] : 0;
> >> +
> >> +        _FDT(fdt_setprop(fdt, offset, "ibm,processor-storage-keys",
> >> +                         val, sizeof(val)));
> >> +    }
> >> +}
> >> +
> >> +#define SYSFS_PROT_KEYS_PATH "/sys/kernel/mm/protection_keys/"
> >> +#define SYSFS_USABLE_STORAGE_KEYS SYSFS_PROT_KEYS_PATH "usable_keys"
> >> +#define SYSFS_DISABLE_EXEC_KEYS SYSFS_PROT_KEYS_PATH "disable_execute=
_supported"
> >> +
> >> +static void setup_storage_keys(CPUPPCState *env, sPAPRMachineState *s=
papr)
> >> +{
> >> +    if (!(env->mmu_model & POWERPC_MMU_AMR))
> >> +        return;
> >> +
> >> +    if (kvm_enabled()) {
> >> +        char buf[sizeof("false\n")];
> >> +        uint32_t keys;
> >> +        FILE *fd;
> >
> > For starters, reasonably complex kvm-only code like this should go
> > into target/ppc/kvm.c.
>=20
> Ok, will move the code there.
>=20
> > But, there's a more fundamental problem.  Automatically adjusting
> > guest visible parameters based on the host's capabilities is really
> > problematic: if you migrate to a host with different capabilities
> > what's usable suddenly changes, but the guest can't know.
> >
> > The usual way to deal with this is instead to have explicit machine
> > parameters to control the value, and check if those are possible on
> > the host.  It's then up to the user and/or management layer to set the
> > parameters suitable to allow migration between all machines that they
> > care about.
>=20
> Good point, I hadn't thought of it. I will add the machine parameter
> then and send a v2. Can the default value of the parameter be what is
> supported by the host?=20

That's probably ok, although it's not entirely unproblematic.  For
safety I think we'd also need to migrate the value and on the
destination check that the migrated value is supportable.  Presumably
it's ok if the new host supports more storage keys than the former
one, just not the other way around.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--jllsgs4PL/sXFNaa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmeLQoACgkQbDjKyiDZ
s5KPPhAAuOyxx9QmVeJRPwXbgAFAWdwx+OPnkDi2zSI/kHD3jmDtPMmL1tWnlkg8
N2MdL2VbYLPztOold70LV5MwYKKzgclJI3DMRbBksiq1yXecGTpe2iaebI9lnT9/
dXCxCHkt88WvW+SUVXFMKxuwxMMeeNqgEXsULpuhOAScmAu7+OmGgnrnq1oWJvJc
jGm74ya5gFfW8qYKPfaQi9LOvV5dtrP8733By0H9qaHUC7pOE8KA48vnSRZc80Ed
Cfo57yFA3B99dtoqggxqH+HpHNy8KAu18zk/wFL1mqnCE1V6C0w1ymKifThdlkLl
C08U4xJsxer8vKGptMhhbVo/wvDakqsTMikLtN6+vTFZADD+6Zgly0VAXilTD4ZG
W3CrCPzdULNvng1JY4LI531Fongp/p9/0uOKVvyaKLbRKisAQA+RMjK7KsnJspAZ
z6squtt8rOmKrMXqwnpVTrU6yFF89l9gb+Hhe0a/0fQfaSwKwZG4W0t3kGKS2toa
qT3cUDj44uq9mm3P5SVCjFzNSFtHptos2dtHC20uiYYza4UQm6FhdyE+FPFlrr8O
YYCWQ2luwxGNdnRP7z9nKJc20acHclWgxzoNKE3/RbcUrqcFG4AC2+pHT3mXnR1J
0DvaLYPEOZPKDyrVsi3VTgbW2ys4ibAv8lKSU5uq8FjzlJH51Is=
=ovvp
-----END PGP SIGNATURE-----

--jllsgs4PL/sXFNaa--
