Received: from eggs.gnu.org ([2001:4830:134:3::10]:47787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d94R2-0005eu-2v
	for qemu-devel@nongnu.org; Fri, 12 May 2017 02:52:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d94R0-0006nZ-Ie
	for qemu-devel@nongnu.org; Fri, 12 May 2017 02:52:20 -0400
Date: Fri, 12 May 2017 16:04:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170512060409.GE12908@umbus.fritz.box>
References: <20170505204746.14116-1-danielhb@linux.vnet.ibm.com>
	<20170505204746.14116-2-danielhb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="r7U+bLA8boMOj+mD"
Content-Disposition: inline
In-Reply-To: <20170505204746.14116-2-danielhb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v9 1/6] hw/ppc/spapr.c: adding
 pending_dimm_unplugs to sPAPRMachineState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com


--r7U+bLA8boMOj+mD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 05, 2017 at 05:47:41PM -0300, Daniel Henrique Barboza wrote:
> The LMB DRC release callback, spapr_lmb_release(), uses an opaque
> parameter, a sPAPRDIMMState struct that stores the current LMBs that
> are allocated to a DIMM (nr_lmbs). After each call to this callback,
> the nr_lmbs is decremented by one and, when it reaches zero, the callback
> proceeds with the qdev calls to hot unplug the LMB.
>=20
> Using drc->detach_cb_opaque is problematic because it can't be migrated in
> the future DRC migration work. This patch makes the following changes to
> eliminate the usage of this opaque callback inside spapr_lmb_release:
>=20
> - sPAPRDIMMState was moved from spapr.c and added to spapr.h. A new
> attribute called 'addr' was added to it. This is used as an unique
> identifier to associate a sPAPRDIMMState to a PCDIMM element.
>=20
> - sPAPRMachineState now hosts a new QTAILQ called 'pending_dimm_unplugs'.
> This queue of sPAPRDIMMState elements will store the DIMM state of DIMMs
> that are currently going under an unplug process.
>=20
> - spapr_lmb_release() will now retrieve the nr_lmbs value by getting the
> correspondent sPAPRDIMMState. A helper function called spapr_dimm_get_add=
ress
> was created to fetch the address of a PCDIMM device inside spapr_lmb_rele=
ase.
> When nr_lmbs reaches zero and the callback proceeds with the qdev hot unp=
lug
> calls, the sPAPRDIMMState struct is removed from spapr->pending_dimm_unpl=
ugs.
>=20
> After these changes, the opaque argument for spapr_lmb_release is now
> unused and is passed as NULL inside spapr_del_lmbs. This and the other
> opaque arguments can now be safely removed from the code.
>=20
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

Urgh.  Moving this into the machine is really ugly.  Unfortunately, I
can't quickly see a better way to accomplish what you need.  So I
guess this approach is ok, with the hope that we can find a better way
in future.

There are a few more superficial problems to address, though.

> ---
>  hw/ppc/spapr.c         | 54 ++++++++++++++++++++++++++++++++++++++++++++=
------
>  include/hw/ppc/spapr.h | 17 ++++++++++++++++
>  2 files changed, 65 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 80d12d0..346c827 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2043,6 +2043,7 @@ static void ppc_spapr_init(MachineState *machine)
>      msi_nonbroken =3D true;
> =20
>      QLIST_INIT(&spapr->phbs);
> +    QTAILQ_INIT(&spapr->pending_dimm_unplugs);
> =20
>      /* Allocate RMA if necessary */
>      rma_alloc_size =3D kvmppc_alloc_rma(&rma);
> @@ -2596,20 +2597,32 @@ out:
>      error_propagate(errp, local_err);
>  }
> =20
> -typedef struct sPAPRDIMMState {
> -    uint32_t nr_lmbs;
> -} sPAPRDIMMState;
> +static uint64_t spapr_dimm_get_address(PCDIMMDevice *dimm)
> +{
> +    Error *local_err =3D NULL;
> +    uint64_t addr;
> +    addr =3D object_property_get_int(OBJECT(dimm), PC_DIMM_ADDR_PROP,
> +                                   &local_err);
> +    if (local_err) {
> +        error_propagate(&error_abort, local_err);
> +        return 0;
> +    }
> +    return addr;
> +}
> =20
>  static void spapr_lmb_release(DeviceState *dev, void *opaque)
>  {
> -    sPAPRDIMMState *ds =3D (sPAPRDIMMState *)opaque;
>      HotplugHandler *hotplug_ctrl;
> =20

No need for this blank line in the middle of declarations.

> +    uint64_t addr =3D spapr_dimm_get_address(PC_DIMM(dev));
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> +    sPAPRDIMMState *ds =3D spapr_pending_dimm_unplugs_find(spapr, addr);
> +
>      if (--ds->nr_lmbs) {
>          return;
>      }
> =20
> -    g_free(ds);
> +    spapr_pending_dimm_unplugs_remove(spapr, ds);
> =20
>      /*
>       * Now that all the LMBs have been removed by the guest, call the
> @@ -2626,17 +2639,20 @@ static void spapr_del_lmbs(DeviceState *dev, uint=
64_t addr_start, uint64_t size,
>      sPAPRDRConnectorClass *drck;
>      uint32_t nr_lmbs =3D size / SPAPR_MEMORY_BLOCK_SIZE;
>      int i;
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
>      sPAPRDIMMState *ds =3D g_malloc0(sizeof(sPAPRDIMMState));
>      uint64_t addr =3D addr_start;
> =20
>      ds->nr_lmbs =3D nr_lmbs;
> +    ds->addr =3D addr_start;
> +    spapr_pending_dimm_unplugs_add(spapr, ds);
>      for (i =3D 0; i < nr_lmbs; i++) {
>          drc =3D spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_LMB,
>                  addr / SPAPR_MEMORY_BLOCK_SIZE);
>          g_assert(drc);
> =20
>          drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> -        drck->detach(drc, dev, spapr_lmb_release, ds, errp);
> +        drck->detach(drc, dev, spapr_lmb_release, NULL, errp);
>          addr +=3D SPAPR_MEMORY_BLOCK_SIZE;
>      }
> =20
> @@ -3515,3 +3531,29 @@ static void spapr_machine_register_types(void)
>  }
> =20
>  type_init(spapr_machine_register_types)
> +
> +sPAPRDIMMState *spapr_pending_dimm_unplugs_find(sPAPRMachineState *spapr,
> +                                                uint64_t addr)
> +{
> +    sPAPRDIMMState *dimm_state =3D NULL;
> +    QTAILQ_FOREACH(dimm_state, &spapr->pending_dimm_unplugs, next) {
> +        if (dimm_state->addr =3D=3D addr) {
> +            break;
> +        }
> +    }
> +    return dimm_state;
> +}
> +
> +void spapr_pending_dimm_unplugs_add(sPAPRMachineState *spapr,
> +                                   sPAPRDIMMState *dimm_state)
> +{
> +    g_assert(!spapr_pending_dimm_unplugs_find(spapr, dimm_state->addr));
> +    QTAILQ_INSERT_HEAD(&spapr->pending_dimm_unplugs, dimm_state, next);
> +}
> +
> +void spapr_pending_dimm_unplugs_remove(sPAPRMachineState *spapr,
> +                                      sPAPRDIMMState *dimm_state)
> +{
> +    QTAILQ_REMOVE(&spapr->pending_dimm_unplugs, dimm_state, next);
> +    g_free(dimm_state);
> +}
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 5802f88..3e2b5ab 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -32,6 +32,7 @@ struct sPAPRRTCState {
>      int64_t ns_offset;
>  };
> =20
> +typedef struct sPAPRDIMMState sPAPRDIMMState;
>  typedef struct sPAPRMachineClass sPAPRMachineClass;
> =20
>  #define TYPE_SPAPR_MACHINE      "spapr-machine"
> @@ -104,6 +105,9 @@ struct sPAPRMachineState {
>      /* RTAS state */
>      QTAILQ_HEAD(, sPAPRConfigureConnectorState) ccs_list;
> =20
> +    /* pending DIMM unplug queue */
> +    QTAILQ_HEAD(, sPAPRDIMMState) pending_dimm_unplugs;
> +
>      /*< public >*/
>      char *kvm_type;
>      MemoryHotplugState hotplug_memory;
> @@ -646,6 +650,19 @@ struct sPAPRConfigureConnectorState {
> =20
>  void spapr_ccs_reset_hook(void *opaque);
> =20
> +struct sPAPRDIMMState {
> +    uint64_t addr;
> +    uint32_t nr_lmbs;
> +    QTAILQ_ENTRY(sPAPRDIMMState) next;
> +};
> +
> +sPAPRDIMMState *spapr_pending_dimm_unplugs_find(sPAPRMachineState *spapr,
> +                                               uint64_t addr);
> +void spapr_pending_dimm_unplugs_add(sPAPRMachineState *spapr,
> +                                   sPAPRDIMMState *dimm_state);
> +void spapr_pending_dimm_unplugs_remove(sPAPRMachineState *spapr,
> +                                      sPAPRDIMMState *dimm_state);
> +

AFAICT all these new functions are only used in spapr.c, even in the
rest of the series.  So they should be static, and not in the header
file.  Likewise the structure definition.

>  void spapr_rtc_read(sPAPRRTCState *rtc, struct tm *tm, uint32_t *ns);
>  int spapr_rtc_import_offset(sPAPRRTCState *rtc, int64_t legacy_offset);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--r7U+bLA8boMOj+mD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZFVBTAAoJEGw4ysog2bOS7qEP+wVAlBj+OG/RSEE0EwEfgp9f
4nFfzct85CMx2bdbrTfI9p45QkdyiKlNbTJ2HzZMGxRe6D9DcA1j/823fN4hWzE5
rn8JLmADMFhm8HfadfIuJqYuX6k3scgP5qY3eONiVa2p23++7EUrBHkSVzWwHXUW
YKJIghUPoNeJ+g0ytKp8TNGkA5roHdeHd6KF+JUBHzinm7+sSxKGNdoP/KUZtf9M
mSSqmlxAbODRo7P6yyWqe+s3ccdKpSb7WH18s+t9ilDMQgyjVxD1gXs9hC6lyM8x
0bkHsi4r759cq+inFufJ9ziNe4WnTKe4Ee70dKIsx6jCHykf99Vct4L5d0NsJfcd
Yl5/MADsWHJ1+bGbzwvxvh3h3Vqh0GKYK9xJlVa+AcWz2IkixrXjI/Va9cKBuM+n
8cBMughfWlR/Am+9azFt97P4za/JDVAVphp5j/h9kgOk1TXDeNfMWqZuNLub5au6
+mSlwfnR+KWytK+NuybHklBWuhE+NKUJtoAfpGu2l2+ESW19k8gdmVXZlLPQJcxJ
WbCRD/NmZuwFbEEx1TXytU+7ZqSCbl5vIYVUHBJhy8mwefDo9xvceTrUx1G2kw3C
/d+l+OOXIn0EfcM6YG3uUrppnS7mizkGz+676gLEk7izLKLnN3zKEtiG9WVgu7i5
EbzzT/MA22UqXcgD9HeR
=cSqn
-----END PGP SIGNATURE-----

--r7U+bLA8boMOj+mD--
