Received: from eggs.gnu.org ([2001:4830:134:3::10]:49429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1djzwp-0005l3-K5
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 23:33:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1djzwm-0003gk-Eh
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 23:33:47 -0400
Date: Tue, 22 Aug 2017 13:33:23 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170822033323.GA12356@umbus.fritz.box>
References: <150287457293.9760.17827532208744487789.stgit@aravinda>
	<150287473305.9760.9007559736340136424.stgit@aravinda>
	<20170817013426.GB5509@umbus.fritz.box>
	<60f3692d-f56a-7183-7b52-3581ec881f8c@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6pbY/KU4ayLo+qis"
Content-Disposition: inline
In-Reply-To: <60f3692d-f56a-7183-7b52-3581ec881f8c@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/5] ppc: spapr: Register and handle
 HCALL to receive updated RTAS region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: "Nikunj A. Dadhania" <nikunj@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru, mahesh@linux.vnet.ibm.com, benh@au1.ibm.com, paulus@samba.org, sam.bobroff@au1.ibm.com


--6pbY/KU4ayLo+qis
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 21, 2017 at 03:12:49PM +0530, Aravinda Prasad wrote:
>=20
>=20
> On Thursday 17 August 2017 07:04 AM, David Gibson wrote:
> > On Wed, Aug 16, 2017 at 02:42:13PM +0530, Aravinda Prasad wrote:
> >> Receive updates from SLOF about the updated rtas-base.
> >> A separate patch for SLOF [1] adds functionality to invoke
> >> a private HCALL whenever OS issues instantiate-rtas with
> >> a new rtas-base.
> >>
> >> This is required as QEMU needs to know the updated rtas-base
> >> as it allocates error reporting structure in RTAS space upon
> >> a machine check exception.
> >>
> >> [1] https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-August/120386=
=2Ehtml
> >>
> >> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> >> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> >=20
> > Actually, I take back this R-b, see below.
> >=20
> > In any case I'm not willing to apply the patches which depend on this
> > until the corresponding SLOF update is merged as well.
>=20
> As Nikunj mentioned, SLOF updates are already merged.

In qemu as well as SLOF master, ok, good.  Commit message could do
with updating to reflect that.

> >>  hw/ppc/spapr_hcall.c   |    8 ++++++++
> >>  include/hw/ppc/spapr.h |    4 +++-
> >>  2 files changed, 11 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> >> index 72ea5a8..e66c72e 100644
> >> --- a/hw/ppc/spapr_hcall.c
> >> +++ b/hw/ppc/spapr_hcall.c
> >> @@ -1062,6 +1062,13 @@ static target_ulong h_rtas(PowerPCCPU *cpu, sPA=
PRMachineState *spapr,
> >>                             nret, rtas_r3 + 12 + 4*nargs);
> >>  }
> >> =20
> >> +static target_ulong h_rtas_update(PowerPCCPU *cpu, sPAPRMachineState =
*spapr,
> >> +                                  target_ulong opcode, target_ulong *=
args)
> >> +{
> >> +    spapr->rtas_addr =3D args[0];
> >> +    return 0;
> >> +}
> >> +
> >>  static target_ulong h_logical_load(PowerPCCPU *cpu, sPAPRMachineState=
 *spapr,
> >>                                     target_ulong opcode, target_ulong =
*args)
> >>  {
> >> @@ -1717,6 +1724,7 @@ static void hypercall_register_types(void)
> >> =20
> >>      /* qemu/KVM-PPC specific hcalls */
> >>      spapr_register_hypercall(KVMPPC_H_RTAS, h_rtas);
> >> +    spapr_register_hypercall(KVMPPC_H_RTAS_UPDATE, h_rtas_update);
> >> =20
> >>      /* ibm,client-architecture-support support */
> >>      spapr_register_hypercall(KVMPPC_H_CAS, h_client_architecture_supp=
ort);
> >> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> >> index 2a303a7..46012b3 100644
> >> --- a/include/hw/ppc/spapr.h
> >> +++ b/include/hw/ppc/spapr.h
> >> @@ -90,6 +90,7 @@ struct sPAPRMachineState {
> >> =20
> >>      hwaddr rma_size;
> >>      int vrma_adjust;
> >> +    hwaddr rtas_addr;
> >=20
> > This can now change at runtime, which means it needs to be migrated -
> > that's not happening in your patches yet.
>=20
> Yes. Need a bit of help in understanding the migration process.
>=20
> As rtas_addr is updated by SLOF, I think we need to modify SLOF to issue
> KVMPPC_H_RTAS_UPDATE HCALL with the new rtas_addr during migration. But
> I am not sure if SLOF is notified of migrations.

Uh.. no.  By the time you're migrating chances are SLOF isn't even
running any more, and it wouldn't make sense for it to be aware of
migration anyway.

Instead we need to add the rtas_addr field to the vmstate information
for the spapr machine object.  However, we can't just add it plain,
because that would break backwards migration.  Instead we'll need to
add another sub-vmstate which will migrate rtas_addr if it differs
=66rom the default value.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6pbY/KU4ayLo+qis
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmbpgEACgkQbDjKyiDZ
s5LEsRAA1MKhdwap5yNgP4N5X2WrSP8fzGUrfC/BtlWxUSggjiqYEbMbM9LyPfk5
9iqOf94FhcKXqMWKwnguSrk2LaXMRx1mCtqsrJW9LzlPbxlyCFoU4RD7yO0DpmeE
ARodpD9Siq3eLBYO17Cna3rSk5zEqnuk+ZP1+hs/Jm3XbO6AcE2i9STJ6QFr1mAy
LyMvIyDH16oK4LpxRRKnVi9xDlvIib2fcIi+hz8by5/a5Jl4LXxyER7NP9BT9/lA
I/8+5F+vdQgXzNyADmLkqV7tbP5ghiuW7C/cvIgzUoBatKSuZ+K7MiWECj+Cy/d9
9+0Xp1jM+5ZvE3RxQab3SDNLNS1/8qg9xKqBo0++4jDI8uFbN9ZDf2TfZXy1PDGg
gsP1/AtmijGq0H7/2hWvUwGqpRP5H/qojoOmExt/GFZOgbDMEjPhY/bmY7ktinyM
d14F1kOBwlc1rOW5fk6S2OnYwxODSse9ANetDHgHoFzw9mEz1LLLvoCcmsjQXzQm
fgDVhE9GnHhzp5vk2wM8GJprDH0kFdz50gHJdJBdWXWRZ+T0cEVPBYHYuWuaa4b0
KxaWeV5GX0hhLU/ydu8l1l6gNLgljvpde0jXgZ0fGlD8kWyFcn0X55hRz2Zz0yN2
wdJU7jmG2SzOVxX6VEeVzq3B3gT8jKFDVznRkf4oguU1hUFTUkc=
=2lp2
-----END PGP SIGNATURE-----

--6pbY/KU4ayLo+qis--
