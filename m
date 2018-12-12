Received: from eggs.gnu.org ([2001:4830:134:3::10]:37642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gWsXH-0005CV-2R
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 19:38:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gWsXF-0002fw-Ne
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 19:37:59 -0500
Date: Wed, 12 Dec 2018 11:20:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181212002009.GB2719@umbus.fritz.box>
References: <20181108014406.29818-1-aik@ozlabs.ru>
	<20181111191047.7af39551@bahia.lan>
	<efc67974-4118-7877-6f8d-ce0a09cb9999@ozlabs.ru>
	<20181210062043.GS4261@umbus.fritz.box>
	<60956124-2f86-0aa6-0dca-ffe0abe26d14@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="St7VIuEGZ6dlpu13"
Content-Disposition: inline
In-Reply-To: <60956124-2f86-0aa6-0dca-ffe0abe26d14@ozlabs.ru>
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


--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2018 at 02:36:09PM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 10/12/2018 17:20, David Gibson wrote:
> > On Mon, Nov 12, 2018 at 03:12:26PM +1100, Alexey Kardashevskiy wrote:
> >>
> >>
> >> On 12/11/2018 05:10, Greg Kurz wrote:
> >>> Hi Alexey,
> >>>
> >>> Just a few remarks. See below.
> >>>
> >>> On Thu,  8 Nov 2018 12:44:06 +1100
> >>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >>>
> >>>> SLOF receives a device tree and updates it with various properties
> >>>> before switching to the guest kernel and QEMU is not aware of any ch=
anges
> >>>> made by SLOF. Since there is no real RTAS (QEMU implements it), it m=
akes
> >>>> sense to pass the SLOF final device tree to QEMU to let it implement
> >>>> RTAS related tasks better, such as PCI host bus adapter hotplug.
> >>>>
> >>>> Specifially, now QEMU can find out the actual XICS phandle (for PHB
> >>>> hotplug) and the RTAS linux,rtas-entry/base properties (for firmware
> >>>> assisted NMI - FWNMI).
> >>>>
> >>>> This stores the initial DT blob in the sPAPR machine and replaces it
> >>>> in the KVMPPC_H_UPDATE_DT (new private hypercall) handler.
> >>>>
> >>>> This adds an @update_dt_enabled machine property to allow backward
> >>>> migration.
> >>>>
> >>>> SLOF already has a hypercall since
> >>>> https://github.com/aik/SLOF/commit/e6fc84652c9c0073f9183
> >>>>
> >>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>>> ---
> >>>>  include/hw/ppc/spapr.h |  7 ++++++-
> >>>>  hw/ppc/spapr.c         | 29 ++++++++++++++++++++++++++++-
> >>>>  hw/ppc/spapr_hcall.c   | 32 ++++++++++++++++++++++++++++++++
> >>>>  hw/ppc/trace-events    |  2 ++
> >>>>  4 files changed, 68 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> >>>> index ad4d7cfd97..f5dcaf44cb 100644
> >>>> --- a/include/hw/ppc/spapr.h
> >>>> +++ b/include/hw/ppc/spapr.h
> >>>> @@ -100,6 +100,7 @@ struct sPAPRMachineClass {
> >>>> =20
> >>>>      /*< public >*/
> >>>>      bool dr_lmb_enabled;       /* enable dynamic-reconfig/hotplug o=
f LMBs */
> >>>> +    bool update_dt_enabled;    /* enable KVMPPC_H_UPDATE_DT */
> >>>>      bool use_ohci_by_default;  /* use USB-OHCI instead of XHCI */
> >>>>      bool pre_2_10_has_unused_icps;
> >>>>      bool legacy_irq_allocation;
> >>>> @@ -136,6 +137,9 @@ struct sPAPRMachineState {
> >>>>      int vrma_adjust;
> >>>>      ssize_t rtas_size;
> >>>>      void *rtas_blob;
> >>>> +    uint32_t fdt_size;
> >>>> +    uint32_t fdt_initial_size;
> >>>
> >>> I don't quite see the purpose of fdt_initial_size... it seems to be o=
nly
> >>> used to print a trace.
> >>
> >>
> >> Ah, lost in rebase. The purpose was to test if the new device tree has
> >> not grown too much.
> >>
> >>
> >>
> >>>
> >>>> +    void *fdt_blob;
> >>>>      long kernel_size;
> >>>>      bool kernel_le;
> >>>>      uint32_t initrd_base;
> >>>> @@ -462,7 +466,8 @@ struct sPAPRMachineState {
> >>>>  #define KVMPPC_H_LOGICAL_MEMOP  (KVMPPC_HCALL_BASE + 0x1)
> >>>>  /* Client Architecture support */
> >>>>  #define KVMPPC_H_CAS            (KVMPPC_HCALL_BASE + 0x2)
> >>>> -#define KVMPPC_HCALL_MAX        KVMPPC_H_CAS
> >>>> +#define KVMPPC_H_UPDATE_DT      (KVMPPC_HCALL_BASE + 0x3)
> >>>> +#define KVMPPC_HCALL_MAX        KVMPPC_H_UPDATE_DT
> >>>> =20
> >>>>  typedef struct sPAPRDeviceTreeUpdateHeader {
> >>>>      uint32_t version_id;
> >>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >>>> index c08130facb..5e2d4d211c 100644
> >>>> --- a/hw/ppc/spapr.c
> >>>> +++ b/hw/ppc/spapr.c
> >>>> @@ -1633,7 +1633,10 @@ static void spapr_machine_reset(void)
> >>>>      /* Load the fdt */
> >>>>      qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
> >>>>      cpu_physical_memory_write(fdt_addr, fdt, fdt_totalsize(fdt));
> >>>> -    g_free(fdt);
> >>>> +    g_free(spapr->fdt_blob);
> >>>> +    spapr->fdt_size =3D fdt_totalsize(fdt);
> >>>> +    spapr->fdt_initial_size =3D spapr->fdt_size;
> >>>> +    spapr->fdt_blob =3D fdt;
> >>>
> >>> Hmm... It looks weird to store state in a reset handler. I'd rather z=
eroe
> >>> both fdt_blob and fdt_size here.
> >>
> >> The device tree is built from the reset handler and the idea is that we
> >> want to always have some tree in the machine.
> >=20
> > Yes, I think the approach here is fine.  Otherwise when we want to
> > look up the current fdt state in RTAS calls or whatever we'd always
> > have to do
> > 	if (fdt_blob)
> > 		look up that
> > 	else
> > 		look up qemu created fdt.
> >=20
> > Incidentally 'fdt' and 'fdt_blob' names do a terrible job of
> > distinguishing what the difference is.  Renaming fdt to fdt_initial
> > (to match fdt_initial_size) and fdt_blob to fdt should make that
> > clearer.
>=20
> There is just one fdt in sPAPRMachineState - it is fdt_blob as it is
> flattened. The "fdt" symbol above is local to spapr_machine_reset() and
> when the tree is built - it is stored in fdt_blob.

Uh, sorry, I misread.  I'll look more carefully at the next spin.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwQVDkACgkQbDjKyiDZ
s5JspQ/9HulbfW4JoTQCHBaSrV4LUmxPn6IuAd04PYdVg5zsNTnGUE/umPEA4rFj
CqWNJCnOCHwMxc8zjjwZKOsdNDSFLguCS4of3tlf4hQlyjaQws65Ssow1Ca+OzBI
zSfCwMZWb1GexAVbZXruWax70JVZ/1t+K4sVdDfq83pQTwzI11zqYgTG/yMJPy/i
n5NQzAPM/oREPPT+vSRija6M60fMQRQy7Dk9EKDrUUKJCXGUkJfcfdDIZH1MXzD3
0bC6EazWGz7Sfe8MQ8yOoX4AEcly5gHQXl099cwdI9lPhNXSXIzlsqxXaamepvDY
k08F1rKycrfMsyWkx15Lb+uu3p2NVYIFrdOv2ppNNS29fCBSQrvVwO5mJ55X4qFK
URaGqR2sR2L4GLcLQrcp1o4vXlutdil2DiNHa+cfyuKQUN7OR+KRL8c5UOOg2r2O
I2T6FY8Y0of+K8Lw6BGggW4mjcG37xipR+sP+818uPaIDrz1koY0e3+3mGKlosei
rY2U8VgaplI+A0O1iUEMzIXb9RUfR4wvvAg4vczqZyEXZqCMeB6TmCETzsJg6Rkw
zG3M1mGG8jb5qZOX3eepaO//KHyPb5wQAQty3xP4i8rqqtrQQDMZQN1Vkmu86Oxz
FxJQyr90BbsVjIYMbrjv6dMzlhgwmc8Ovc58TkKOoZpSSpNqz4c=
=EUiL
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--
