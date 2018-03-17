Received: from eggs.gnu.org ([2001:4830:134:3::10]:51851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ex7cw-00008X-8a
	for qemu-devel@nongnu.org; Sat, 17 Mar 2018 04:55:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ex7ct-0002u2-5j
	for qemu-devel@nongnu.org; Sat, 17 Mar 2018 04:55:46 -0400
Received: from 15.mo4.mail-out.ovh.net ([91.121.62.11]:45549)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ex7cs-0002rz-UT
	for qemu-devel@nongnu.org; Sat, 17 Mar 2018 04:55:43 -0400
Received: from player762.ha.ovh.net (unknown [10.109.120.174])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 1A09815493C
	for <qemu-devel@nongnu.org>; Sat, 17 Mar 2018 09:55:39 +0100 (CET)
References: <20180315133402.13470-1-clg@kaod.org>
	<20180315133402.13470-2-clg@kaod.org>
	<20180317041504.GF4525@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <94790f82-e8d4-0d9d-ec4c-cf80f7afbace@kaod.org>
Date: Sat, 17 Mar 2018 09:55:28 +0100
MIME-Version: 1.0
In-Reply-To: <20180317041504.GF4525@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

On 03/17/2018 05:15 AM, David Gibson wrote:
> On Thu, Mar 15, 2018 at 01:33:59PM +0000, C=E9dric Le Goater wrote:
>> commit e57ca75ce3b2 ("target/ppc: Manage external HPT via virtual
>> hypervisor") exported a set of methods to manipulate the HPT from the
>> core hash MMU but the base address of the HPT was not part of them and
>> SPR_SDR1 is still used under some circumstances, which is incorrect
>> for the sPAPR machines.
>>
>> This is not a major change as only the logging should be impacted but
>> nevertheless, it will help to introduce support for the hash MMU on
>> POWER9 PowerNV machines.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> This doesn't make sense.  The whole point of the "virtual hypervisor"
> is that the hash table doesn't live within the guest address space,
> and therefore it *has* no meaningful base address.  Basically
> ppc_hash64_hpt_base() should never be called if vhyp is set.  If it
> is, that's a bug.


ppc_hash64_hpt_base() is being called in a couple of places but the
returned value is only used if the machines is not a pseries :

  static inline hwaddr ppc_hash64_hpt_mask(PowerPCCPU *cpu)
  {
      if (cpu->vhyp) {
          PPCVirtualHypervisorClass *vhc =3D
              PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
          return vhc->hpt_mask(cpu->vhyp);
      }
      ....

  const ppc_hash_pte64_t *ppc_hash64_map_hptes(PowerPCCPU *cpu,
                                               hwaddr ptex, int n)
  {
      hwaddr pte_offset =3D ptex * HASH_PTE_SIZE_64;
      hwaddr base =3D ppc_hash64_hpt_base(cpu);
      hwaddr plen =3D n * HASH_PTE_SIZE_64;
      const ppc_hash_pte64_t *hptes;
 =20
      if (cpu->vhyp) {
          PPCVirtualHypervisorClass *vhc =3D
              PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
          return vhc->map_hptes(cpu->vhyp, ptex, n);
      } =20
      ....
 =20
and also :
 =20
  void ppc_hash64_store_hpte(PowerPCCPU *cpu, hwaddr ptex,
                             uint64_t pte0, uint64_t pte1)
  {
      hwaddr base =3D ppc_hash64_hpt_base(cpu);
      hwaddr offset =3D ptex * HASH_PTE_SIZE_64;
 =20
      if (cpu->vhyp) {
          PPCVirtualHypervisorClass *vhc =3D
              PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
          vhc->store_hpte(cpu->vhyp, ptex, pte0, pte1);
          return;
      }
      ....

And, in ppc_hash64_htab_lookup(), the HPT base is logged so we need
some value returned (today, this is SPR_SDR1 which equals zero but=20
that's confusing I think).


If you don't agree with the hpt_base() op, we can change it to
something like :

  static inline hwaddr ppc_hash64_hpt_base(PowerPCCPU *cpu)
  {
      if (cpu->vhyp) {
          /* Unused on sPAPR machines */
          return 0;
      }
      return ppc_hash64_hpt_reg(cpu) & SDR_64_HTABORG;
  }

to be consistent with the other routines. I would like to make sure we
don't reach ppc_hash64_hpt_reg() on pseries machines. see patch 3/4.


Thanks,

C.
