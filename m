Received: from eggs.gnu.org ([2001:4830:134:3::10]:37681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gWsXJ-0005Cl-0Z
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 19:38:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gWsXF-0002fk-Mx
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 19:38:00 -0500
Date: Wed, 12 Dec 2018 11:29:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181212002955.GD2719@umbus.fritz.box>
References: <20181108014406.29818-1-aik@ozlabs.ru>
	<20181111191047.7af39551@bahia.lan>
	<efc67974-4118-7877-6f8d-ce0a09cb9999@ozlabs.ru>
	<20181210062043.GS4261@umbus.fritz.box>
	<20181210103032.088de905@bahia.lab.toulouse-stg.fr.ibm.com>
	<d363fae5-d968-0bfb-0c27-adbbe427f642@ozlabs.ru>
	<20181211105559.76040a70@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pQhZXvAqiZgbeUkD"
Content-Disposition: inline
In-Reply-To: <20181211105559.76040a70@bahia.lab.toulouse-stg.fr.ibm.com>
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
To: Greg Kurz <groug@kaod.org>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--pQhZXvAqiZgbeUkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2018 at 10:55:59AM +0100, Greg Kurz wrote:
> On Tue, 11 Dec 2018 14:53:32 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>=20
> > On 10/12/2018 20:30, Greg Kurz wrote:
> > > On Mon, 10 Dec 2018 17:20:43 +1100
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >  =20
> > >> On Mon, Nov 12, 2018 at 03:12:26PM +1100, Alexey Kardashevskiy wrote=
: =20
> > >>>
> > >>>
> > >>> On 12/11/2018 05:10, Greg Kurz wrote:   =20
> > >>>> Hi Alexey,
> > >>>>
> > >>>> Just a few remarks. See below.
> > >>>>
> > >>>> On Thu,  8 Nov 2018 12:44:06 +1100
> > >>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> > >>>>    =20
> > >>>>> SLOF receives a device tree and updates it with various properties
> > >>>>> before switching to the guest kernel and QEMU is not aware of any=
 changes
> > >>>>> made by SLOF. Since there is no real RTAS (QEMU implements it), i=
t makes
> > >>>>> sense to pass the SLOF final device tree to QEMU to let it implem=
ent
> > >>>>> RTAS related tasks better, such as PCI host bus adapter hotplug.
> > >>>>>
> > >>>>> Specifially, now QEMU can find out the actual XICS phandle (for P=
HB
> > >>>>> hotplug) and the RTAS linux,rtas-entry/base properties (for firmw=
are
> > >>>>> assisted NMI - FWNMI).
> > >>>>>
> > >>>>> This stores the initial DT blob in the sPAPR machine and replaces=
 it
> > >>>>> in the KVMPPC_H_UPDATE_DT (new private hypercall) handler.
> > >>>>>
> > >>>>> This adds an @update_dt_enabled machine property to allow backward
> > >>>>> migration.
> > >>>>>
> > >>>>> SLOF already has a hypercall since
> > >>>>> https://github.com/aik/SLOF/commit/e6fc84652c9c0073f9183
> > >>>>>
> > >>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > >>>>> ---
> > >>>>>  include/hw/ppc/spapr.h |  7 ++++++-
> > >>>>>  hw/ppc/spapr.c         | 29 ++++++++++++++++++++++++++++-
> > >>>>>  hw/ppc/spapr_hcall.c   | 32 ++++++++++++++++++++++++++++++++
> > >>>>>  hw/ppc/trace-events    |  2 ++
> > >>>>>  4 files changed, 68 insertions(+), 2 deletions(-)
> > >>>>>
> > >>>>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > >>>>> index ad4d7cfd97..f5dcaf44cb 100644
> > >>>>> --- a/include/hw/ppc/spapr.h
> > >>>>> +++ b/include/hw/ppc/spapr.h
> > >>>>> @@ -100,6 +100,7 @@ struct sPAPRMachineClass {
> > >>>>> =20
> > >>>>>      /*< public >*/
> > >>>>>      bool dr_lmb_enabled;       /* enable dynamic-reconfig/hotplu=
g of LMBs */
> > >>>>> +    bool update_dt_enabled;    /* enable KVMPPC_H_UPDATE_DT */
> > >>>>>      bool use_ohci_by_default;  /* use USB-OHCI instead of XHCI */
> > >>>>>      bool pre_2_10_has_unused_icps;
> > >>>>>      bool legacy_irq_allocation;
> > >>>>> @@ -136,6 +137,9 @@ struct sPAPRMachineState {
> > >>>>>      int vrma_adjust;
> > >>>>>      ssize_t rtas_size;
> > >>>>>      void *rtas_blob;
> > >>>>> +    uint32_t fdt_size;
> > >>>>> +    uint32_t fdt_initial_size;   =20
> > >>>>
> > >>>> I don't quite see the purpose of fdt_initial_size... it seems to b=
e only
> > >>>> used to print a trace.   =20
> > >>>
> > >>>
> > >>> Ah, lost in rebase. The purpose was to test if the new device tree =
has
> > >>> not grown too much.
> > >>>
> > >>>
> > >>>    =20
> > >>>>    =20
> > >>>>> +    void *fdt_blob;
> > >>>>>      long kernel_size;
> > >>>>>      bool kernel_le;
> > >>>>>      uint32_t initrd_base;
> > >>>>> @@ -462,7 +466,8 @@ struct sPAPRMachineState {
> > >>>>>  #define KVMPPC_H_LOGICAL_MEMOP  (KVMPPC_HCALL_BASE + 0x1)
> > >>>>>  /* Client Architecture support */
> > >>>>>  #define KVMPPC_H_CAS            (KVMPPC_HCALL_BASE + 0x2)
> > >>>>> -#define KVMPPC_HCALL_MAX        KVMPPC_H_CAS
> > >>>>> +#define KVMPPC_H_UPDATE_DT      (KVMPPC_HCALL_BASE + 0x3)
> > >>>>> +#define KVMPPC_HCALL_MAX        KVMPPC_H_UPDATE_DT
> > >>>>> =20
> > >>>>>  typedef struct sPAPRDeviceTreeUpdateHeader {
> > >>>>>      uint32_t version_id;
> > >>>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > >>>>> index c08130facb..5e2d4d211c 100644
> > >>>>> --- a/hw/ppc/spapr.c
> > >>>>> +++ b/hw/ppc/spapr.c
> > >>>>> @@ -1633,7 +1633,10 @@ static void spapr_machine_reset(void)
> > >>>>>      /* Load the fdt */
> > >>>>>      qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
> > >>>>>      cpu_physical_memory_write(fdt_addr, fdt, fdt_totalsize(fdt));
> > >>>>> -    g_free(fdt);
> > >>>>> +    g_free(spapr->fdt_blob);
> > >>>>> +    spapr->fdt_size =3D fdt_totalsize(fdt);
> > >>>>> +    spapr->fdt_initial_size =3D spapr->fdt_size;
> > >>>>> +    spapr->fdt_blob =3D fdt;   =20
> > >>>>
> > >>>> Hmm... It looks weird to store state in a reset handler. I'd rathe=
r zeroe
> > >>>> both fdt_blob and fdt_size here.   =20
> > >>>
> > >>> The device tree is built from the reset handler and the idea is tha=
t we
> > >>> want to always have some tree in the machine.   =20
> > >>
> > >> Yes, I think the approach here is fine.  Otherwise when we want to
> > >> look up the current fdt state in RTAS calls or whatever we'd always
> > >> have to do
> > >> 	if (fdt_blob)
> > >> 		look up that
> > >> 	else
> > >> 		look up qemu created fdt.
> > >> =20
> > >=20
> > > No. We only have one fdt blob: the initial one, I'd rather
> > > call reset time one, or the updated one. =20
> >=20
> > There is one fdt in the machine, always. Either initial or from cas.
>=20
> Yeah, reset time fdt is either the initial one, either cas... and I'm now
> wandering what happens if migration occurs between cas that sets cas_rebo=
ot
> and the corresponding reset. With the current code base, I have the impre=
ssion
> that the destination will redo the full cas+cas_reboot cycle after restar=
t or
> am I missing something ?

Yes, I believe that's correct.  It's kind of an edge case and that CAS
cycle should still complete ok, it'll just take a little longer to
boot, so I thought that was preferable to the complexity of migrating
the CAS state.

> > >> Incidentally 'fdt' and 'fdt_blob' names do a terrible job of
> > >> distinguishing what the difference is.  Renaming fdt to fdt_initial
> > >> (to match fdt_initial_size) and fdt_blob to fdt should make that
> > >> clearer.
> > >> =20
> > >=20
> > > As mentioned earlier in this thread, spapr->fdt_initial_size is only =
used
> > > for tracing if the received fdt blob fails fdt_check_full()...
> > >=20
> > > $ git grep -H fdt_initial_size
> > > hw/ppc/spapr.c:    spapr->fdt_initial_size =3D spapr->fdt_size;
> > > hw/ppc/spapr.c:        VMSTATE_UINT32(fdt_initial_size, sPAPRMachineS=
tate),
> > > hw/ppc/spapr_hcall.c:        trace_spapr_update_dt_failed(spapr->fdt_=
initial_size, cb,
> > > include/hw/ppc/spapr.h:    uint32_t fdt_initial_size;
> > >=20
> > > Not sure it is helpful, and anyway, it is expected to be the same in =
source
> > > and destination, so why put it in the migration stream ? =20
> >=20
> >=20
> > Well, we do build the fdt anyway even when receive migration but we do
> > not have to and yes we can expect the fdt on the destination to be of
> > the same size since it is the same command line, it is just guessing and
> > expecting vs. knowing and I prefer the latter as the reset time fdt and
> > migration source fdt might have different size because of
> > host-model/host-serial/slot-label/similar properties.
>=20
> Right but I still don't see the usefulness of fdt_initial_size...

So, it's there to address exactly the problem you pointed out elswhere
in the thread: the idea was to disallow the guest resubmitting an fdt
which is "too much" bigger than the original one, thereby consuming a
bunch of qemu memory.  The thought was that this is a bit more robust
that just checking against a fixed max size, especially if we need to
increase that fixed size in future to handle really big partitions.

> > > The only case where we want to migrate something is when h_update_dt(=
) has
> > > succeeded, ie, the guest passed a valid DT blob. This implies that its
> > > size isn't 0, otherwise fdt_check_full() would return -FDT_ERR_TRUNCA=
TED.
> > >=20
> > > I would suggest rather to:
> > >=20
> > > - completely drop spapr->fdt_initial_size
> > > - clear spapr->fdt_size at machine reset
> > > - migrate if spapr->fdt_size is not zero
> > >=20
> > > Also, I've just realized another problem... nothing prevents a malici=
ous
> > > guest to pass an insanely great size to h_update_dt, which would cause
> > > g_malloc0() to abort... The passed size should be checked against
> > > FDT_MAX_SIZE. =20
> >=20
> > Good point. Just noticed - as posted, the checker actually checks the
> > reset time tree, not the updated one, my bad :)
> >=20
> >=20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--pQhZXvAqiZgbeUkD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwQVoIACgkQbDjKyiDZ
s5L5zg/9FlAjh4VGx7Wd74t4WvHf0Tmn89qShEQAcv7bEl3dDO6X18DXzdXf/tx/
TzM6arGM89c5bVZfKHT6HqvcEf2zGEzlxBDFvFKK/7AEwPQcIC8o4ciY32gPA1xK
OQsPQ5yxLm1yc8hgiNT/yqeYVDbe4kVYItRAPe/Faqa8Si0yttw95TaIe1aIQ83j
6tdBZDxr80uRGZAxj6O6mbLtLREDS2KkTcLVZVxHP9zJDZMbVJygyF+WhFzh5YQE
biXuDLaxjIUJQLxADgPD+XP2U1sd1aJ09fazAum/pmS2dkHdLihQfkr6vf1zCTws
2KFeHZFP7SY3BEkOhnTcIbBpSGpZL4awVR2voSgJ1OKOlu7ol+unM9T0kGiTwK9p
1q3X8WGaUZiXWrrQ96r4PUJg4weRlK8Fzjj2a++T1fLewVmfxqyegTDEYSYNef0h
wwwBdkFJHF9Hbdv8o8TxfA+v1osBdRnLmATjfQSTIfd+d1HZPJxuVHnrm4EwRucI
6kJ+thCxClhDj6DuW8YHTVdKrAVZMx9H6i7F72anpCELyyh0d0CZYh36whU2iSoG
sQ0cm9JksTDZ4JA4VP6S8OvJ9ZrIbDrGRyZB+AMpOKuwVGStP4sOPIm/xipLPU2x
TFOy7bbz6H6+W3VD3tzsE6505XPYuZaa1WwNLwDXOgpqOhnvg4Q=
=YBIK
-----END PGP SIGNATURE-----

--pQhZXvAqiZgbeUkD--
