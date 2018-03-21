Received: from eggs.gnu.org ([2001:4830:134:3::10]:43804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eyURX-0007s0-As
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 23:29:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eyURU-0005Jc-4X
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 23:29:39 -0400
Date: Wed, 21 Mar 2018 14:17:18 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180321031718.GN3905@umbus.fritz.box>
References: <20180315133402.13470-1-clg@kaod.org>
	<20180315133402.13470-2-clg@kaod.org>
	<20180317041504.GF4525@umbus.fritz.box>
	<94790f82-e8d4-0d9d-ec4c-cf80f7afbace@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="N/GrjenRD+RJfyz+"
Content-Disposition: inline
In-Reply-To: <94790f82-e8d4-0d9d-ec4c-cf80f7afbace@kaod.org>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3 1/4] target/ppc: export
 external HPT via virtual hypervisor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>


--N/GrjenRD+RJfyz+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 17, 2018 at 09:55:28AM +0100, C=E9dric Le Goater wrote:
> On 03/17/2018 05:15 AM, David Gibson wrote:
> > On Thu, Mar 15, 2018 at 01:33:59PM +0000, C=E9dric Le Goater wrote:
> >> commit e57ca75ce3b2 ("target/ppc: Manage external HPT via virtual
> >> hypervisor") exported a set of methods to manipulate the HPT from the
> >> core hash MMU but the base address of the HPT was not part of them and
> >> SPR_SDR1 is still used under some circumstances, which is incorrect
> >> for the sPAPR machines.
> >>
> >> This is not a major change as only the logging should be impacted but
> >> nevertheless, it will help to introduce support for the hash MMU on
> >> POWER9 PowerNV machines.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >=20
> > This doesn't make sense.  The whole point of the "virtual hypervisor"
> > is that the hash table doesn't live within the guest address space,
> > and therefore it *has* no meaningful base address.  Basically
> > ppc_hash64_hpt_base() should never be called if vhyp is set.  If it
> > is, that's a bug.
>=20
>=20
> ppc_hash64_hpt_base() is being called in a couple of places but the
> returned value is only used if the machines is not a pseries :
>=20
>   static inline hwaddr ppc_hash64_hpt_mask(PowerPCCPU *cpu)
>   {
>       if (cpu->vhyp) {
>           PPCVirtualHypervisorClass *vhc =3D
>               PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
>           return vhc->hpt_mask(cpu->vhyp);
>       }
>       ....
>=20
>   const ppc_hash_pte64_t *ppc_hash64_map_hptes(PowerPCCPU *cpu,
>                                                hwaddr ptex, int n)
>   {
>       hwaddr pte_offset =3D ptex * HASH_PTE_SIZE_64;
>       hwaddr base =3D ppc_hash64_hpt_base(cpu);
>       hwaddr plen =3D n * HASH_PTE_SIZE_64;
>       const ppc_hash_pte64_t *hptes;
>  =20
>       if (cpu->vhyp) {
>           PPCVirtualHypervisorClass *vhc =3D
>               PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
>           return vhc->map_hptes(cpu->vhyp, ptex, n);
>       } =20
>       ....
>  =20
> and also :
>  =20
>   void ppc_hash64_store_hpte(PowerPCCPU *cpu, hwaddr ptex,
>                              uint64_t pte0, uint64_t pte1)
>   {
>       hwaddr base =3D ppc_hash64_hpt_base(cpu);
>       hwaddr offset =3D ptex * HASH_PTE_SIZE_64;
>  =20
>       if (cpu->vhyp) {
>           PPCVirtualHypervisorClass *vhc =3D
>               PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
>           vhc->store_hpte(cpu->vhyp, ptex, pte0, pte1);
>           return;
>       }
>       ....

Right.. so called, but not really used.  A little ugly, but we get
away with it for now.

> And, in ppc_hash64_htab_lookup(), the HPT base is logged so we need
> some value returned (today, this is SPR_SDR1 which equals zero but=20
> that's confusing I think).
>=20
>=20
> If you don't agree with the hpt_base() op, we can change it to
> something like :

I certainly don't agree with the definition proposed - that can return
either a guest address or a host userspace address depending on
various factors.  That's definitely not a sensible interface.

>   static inline hwaddr ppc_hash64_hpt_base(PowerPCCPU *cpu)
>   {
>       if (cpu->vhyp) {
>           /* Unused on sPAPR machines */
>           return 0;
>       }
>       return ppc_hash64_hpt_reg(cpu) & SDR_64_HTABORG;
>   }
>=20
> to be consistent with the other routines. I would like to make sure we
> don't reach ppc_hash64_hpt_reg() on pseries machines. see patch 3/4.

We could do that, since this routine is basically only used for
logging / debugging, the 0 acts as just a placeholder.

The more strictly correct (but a bit more work) option would be to put
an assert(!cpu->vhyp) in there, and fix the code so that we
really don't call ppc_hash64_hpt_base() in the vhyp cases.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--N/GrjenRD+RJfyz+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqxzrwACgkQbDjKyiDZ
s5LmFhAAtgc2ZuJSFAUDN716mfqRfCwNSwhWRYIsKfJd8eiR2z/7wAtX0UvH9qK9
z2c8eaEVoZSBYR4tGvy5ZGn4fKBGmntgpy2RJnHqFAaKeoleCTL2F7OoK7leGzzf
2vhAmG09UykZM+OCBSifsPAgUDoBCp1Bs09948wJeua6Z/MY3cCO9MeKc1JWtMX8
3iT9D69S3RN3GsuCKpb2YOYaneBs/NL13G2id2P05hG4iZgICeenaHJCFgfQkjj+
iV8BHFNYQrwOKfYGY7ZrqHmN4sjTi0wL9uXujcn2emq+e/kIeyu9lTTjpfmOvFOb
/kPjC6I67fLyd62AEAPSsaaVrjg7rtsAnHyjIlLurYCtnbE5movgM85pPzu+kyjH
C7JfuGfQKGg/8iBEWcyDs90VJTvtvLMdFOLtHylLGjyT81MtCaMjPlQSaPnbWkvt
s3HE89+WzRThBNNHb5PlvOqwzeNPj13zXPOFiSfXt5TS74CyG4V4la1lY9/cHngf
CGVkpMxi71xAfwnyLoAmqy3FzQH7ciKuLzPxZ0T9mbfoPxP+38oThkVcIkviZwfT
n9OqljgFcuoRViuwdsgzpIJe8yqDtUNS8N87kcuNJjpx2oQ5v03mG7AOZy9A16g7
tjkSEXKFK8NY53kxdsEi0IQW3IIFE2OmrJIIkPMtte595mvcyT0=
=vjf8
-----END PGP SIGNATURE-----

--N/GrjenRD+RJfyz+--
