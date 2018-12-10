Received: from eggs.gnu.org ([2001:4830:134:3::10]:50775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gWEx0-0003XB-1F
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 01:21:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gWEww-0002vO-TC
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 01:21:54 -0500
Date: Mon, 10 Dec 2018 17:20:43 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181210062043.GS4261@umbus.fritz.box>
References: <20181108014406.29818-1-aik@ozlabs.ru>
	<20181111191047.7af39551@bahia.lan>
	<efc67974-4118-7877-6f8d-ce0a09cb9999@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wxNrNKeE/ptr8Zbn"
Content-Disposition: inline
In-Reply-To: <efc67974-4118-7877-6f8d-ce0a09cb9999@ozlabs.ru>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH qemu] ppc/spapr: Receive and
 store device tree blob from SLOF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--wxNrNKeE/ptr8Zbn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 12, 2018 at 03:12:26PM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 12/11/2018 05:10, Greg Kurz wrote:
> > Hi Alexey,
> >=20
> > Just a few remarks. See below.
> >=20
> > On Thu,  8 Nov 2018 12:44:06 +1100
> > Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >=20
> >> SLOF receives a device tree and updates it with various properties
> >> before switching to the guest kernel and QEMU is not aware of any chan=
ges
> >> made by SLOF. Since there is no real RTAS (QEMU implements it), it mak=
es
> >> sense to pass the SLOF final device tree to QEMU to let it implement
> >> RTAS related tasks better, such as PCI host bus adapter hotplug.
> >>
> >> Specifially, now QEMU can find out the actual XICS phandle (for PHB
> >> hotplug) and the RTAS linux,rtas-entry/base properties (for firmware
> >> assisted NMI - FWNMI).
> >>
> >> This stores the initial DT blob in the sPAPR machine and replaces it
> >> in the KVMPPC_H_UPDATE_DT (new private hypercall) handler.
> >>
> >> This adds an @update_dt_enabled machine property to allow backward
> >> migration.
> >>
> >> SLOF already has a hypercall since
> >> https://github.com/aik/SLOF/commit/e6fc84652c9c0073f9183
> >>
> >> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >> ---
> >>  include/hw/ppc/spapr.h |  7 ++++++-
> >>  hw/ppc/spapr.c         | 29 ++++++++++++++++++++++++++++-
> >>  hw/ppc/spapr_hcall.c   | 32 ++++++++++++++++++++++++++++++++
> >>  hw/ppc/trace-events    |  2 ++
> >>  4 files changed, 68 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> >> index ad4d7cfd97..f5dcaf44cb 100644
> >> --- a/include/hw/ppc/spapr.h
> >> +++ b/include/hw/ppc/spapr.h
> >> @@ -100,6 +100,7 @@ struct sPAPRMachineClass {
> >> =20
> >>      /*< public >*/
> >>      bool dr_lmb_enabled;       /* enable dynamic-reconfig/hotplug of =
LMBs */
> >> +    bool update_dt_enabled;    /* enable KVMPPC_H_UPDATE_DT */
> >>      bool use_ohci_by_default;  /* use USB-OHCI instead of XHCI */
> >>      bool pre_2_10_has_unused_icps;
> >>      bool legacy_irq_allocation;
> >> @@ -136,6 +137,9 @@ struct sPAPRMachineState {
> >>      int vrma_adjust;
> >>      ssize_t rtas_size;
> >>      void *rtas_blob;
> >> +    uint32_t fdt_size;
> >> +    uint32_t fdt_initial_size;
> >=20
> > I don't quite see the purpose of fdt_initial_size... it seems to be only
> > used to print a trace.
>=20
>=20
> Ah, lost in rebase. The purpose was to test if the new device tree has
> not grown too much.
>=20
>=20
>=20
> >=20
> >> +    void *fdt_blob;
> >>      long kernel_size;
> >>      bool kernel_le;
> >>      uint32_t initrd_base;
> >> @@ -462,7 +466,8 @@ struct sPAPRMachineState {
> >>  #define KVMPPC_H_LOGICAL_MEMOP  (KVMPPC_HCALL_BASE + 0x1)
> >>  /* Client Architecture support */
> >>  #define KVMPPC_H_CAS            (KVMPPC_HCALL_BASE + 0x2)
> >> -#define KVMPPC_HCALL_MAX        KVMPPC_H_CAS
> >> +#define KVMPPC_H_UPDATE_DT      (KVMPPC_HCALL_BASE + 0x3)
> >> +#define KVMPPC_HCALL_MAX        KVMPPC_H_UPDATE_DT
> >> =20
> >>  typedef struct sPAPRDeviceTreeUpdateHeader {
> >>      uint32_t version_id;
> >> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >> index c08130facb..5e2d4d211c 100644
> >> --- a/hw/ppc/spapr.c
> >> +++ b/hw/ppc/spapr.c
> >> @@ -1633,7 +1633,10 @@ static void spapr_machine_reset(void)
> >>      /* Load the fdt */
> >>      qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
> >>      cpu_physical_memory_write(fdt_addr, fdt, fdt_totalsize(fdt));
> >> -    g_free(fdt);
> >> +    g_free(spapr->fdt_blob);
> >> +    spapr->fdt_size =3D fdt_totalsize(fdt);
> >> +    spapr->fdt_initial_size =3D spapr->fdt_size;
> >> +    spapr->fdt_blob =3D fdt;
> >=20
> > Hmm... It looks weird to store state in a reset handler. I'd rather zer=
oe
> > both fdt_blob and fdt_size here.
>=20
> The device tree is built from the reset handler and the idea is that we
> want to always have some tree in the machine.

Yes, I think the approach here is fine.  Otherwise when we want to
look up the current fdt state in RTAS calls or whatever we'd always
have to do
	if (fdt_blob)
		look up that
	else
		look up qemu created fdt.

Incidentally 'fdt' and 'fdt_blob' names do a terrible job of
distinguishing what the difference is.  Renaming fdt to fdt_initial
(to match fdt_initial_size) and fdt_blob to fdt should make that
clearer.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--wxNrNKeE/ptr8Zbn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwOBbgACgkQbDjKyiDZ
s5I5cQ/9F0YS03o2XRjavMgeXN8wXRJB7u6wEjEKUOmXygn/UYvHLNiknr2USW+J
i1XpGus0M0fzlA9X8FK575/Lp3i8L8lX9YbnYB0OUFMhXz/bbjQEk0BDMAuMI6cO
77QzoJU53hkHBsy0ABPD52VqCBixpMrqmL+Enq8tofSOzCfyh6Ab70EWGSA8q9Fb
L76SHzgXb57SdwSALcKAInZO3vlGbSpNtZp+63GstJ3vQXduSN+h3oihlWcL4q1Z
ZfIkxBq9kwND/9UzqAv7hvhxwUCsEqx6//kuNXr4jnst/Wo3/ekQtIS9Po8xgjPc
gYvejKBj4Awpbbcz49U/T3aJynH7lPRbILun8evFtlpU3G97xRF8FmCKUt4EpLvr
t//mb1+K6sWNzpbA2zYs9b35urI0CbuybEvjg+hxP79WkctrOMYUWsHDGX2CcbSz
W0+HBHSW4TaizCrAOisdvCfAZwE9vvXv497ac5y9+PpXsk4piaXcyIF64tlATYgY
IxPa7Arh1C4HqJ1D1xVhc/02AURW0I/FpicfXROgAb6Jm7yqJ4pVYhKKrfWEJAiH
WJd8KFbm+0WPi5iHnsTL+YlBLMQt/OYZMEpRCkNmE0/HzftKwIPBrdyJNBawLcl7
MJxWZukpAqfEoTVYRsXFjYz2bodL4eWsNlgPxArjZe+WBYqgjiU=
=FaqK
-----END PGP SIGNATURE-----

--wxNrNKeE/ptr8Zbn--
