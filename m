Received: from eggs.gnu.org ([2001:4830:134:3::10]:55687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d6Iag-0000uy-JK
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:22:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d6Iae-0007L1-IC
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:22:50 -0400
Date: Thu, 4 May 2017 17:20:50 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170504072050.GB14413@umbus.fritz.box>
References: <20170430172547.13415-1-danielhb@linux.vnet.ibm.com>
	<20170430172547.13415-3-danielhb@linux.vnet.ibm.com>
	<CAGZKiBok2=HRT9BjMiDx+c20YeKhknJ0ZD_GV1Zx=BrbFSmxwA@mail.gmail.com>
	<c890eaba-6d61-4e82-c771-1476cd3df0f2@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline
In-Reply-To: <c890eaba-6d61-4e82-c771-1476cd3df0f2@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 2/5] hw/ppc: removing
 spapr_drc_detach_cb opaques
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: Bharata B Rao <bharata.rao@gmail.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 02, 2017 at 04:43:51AM -0300, Daniel Henrique Barboza wrote:
>=20
>=20
> On 05/02/2017 12:40 AM, Bharata B Rao wrote:
> > On Sun, Apr 30, 2017 at 10:55 PM, Daniel Henrique Barboza
> > <danielhb@linux.vnet.ibm.com <mailto:danielhb@linux.vnet.ibm.com>>
> > wrote:
> >=20
> >     Following up the previous detach_cb change, this patch removes the
> >     detach_cb_opaque entirely from the code.
> >=20
> >     The reason is that the drc->detach_cb_opaque object can't be
> >     restored in the post load of the upcoming DRC migration and no deta=
ch
> >     callbacks actually need this opaque. 'spapr_core_release' is
> >     receiving it as NULL, 'spapr_phb_remove_pci_device_cb' is receiving
> >     a phb object as opaque but is't using it. These were trivial removal
> >     cases.
> >=20
> >     However, the LM removal callback 'spapr_lmb_release' is receiving
> >     and using the opaque object, a 'sPAPRDIMMState' struct. This struct
> >     holds the number of LMBs the DIMM object contains and the callback
> >     was using this counter as a countdown to check if all LMB DRCs were
> >     release before proceeding to the DIMM unplug. To remove the need of
> >     this callback we have choices such as:
> >=20
> >     - migrate the 'sPAPRDIMMState' struct. This would require creating a
> >     QTAILQ to store all DIMMStates and an additional 'dimm_id' field to
> >     associate the DIMMState with the DIMM object. We could attach this
> >     QTAILQ to the 'sPAPRPHBState' and retrieve it later in the callback.
> >=20
> >     - fetch the state of the LMB DRCs directly by scanning the state of
> >     them and, if all of them are released, proceed with the DIMM unplug.
> >=20
> >     The second approach was chosen. The new 'spapr_all_lmbs_drcs_releas=
ed'
> >     function scans all LMBs of a given DIMM device to see if their DRC
> >     state are inactive. If all of them are inactive return 'true', 'fal=
se'
> >     otherwise. This function is being called inside the
> >     'spapr_lmb_release'
> >     callback, replacing the role of the 'sPAPRDIMMState' opaque. The
> >     'sPAPRDIMMState' struct was removed from the code given that there =
are
> >     no more uses for it.
> >=20
> >     After all these changes, there are no roles left for the
> >     'detach_cb_opaque'
> >     attribute of the 'sPAPRDRConnector' as well, so we can safely remove
> >     it from the code too.
> >=20
> >     Signed-off-by: Daniel Henrique Barboza
> >     <danielhb@linux.vnet.ibm.com <mailto:danielhb@linux.vnet.ibm.com>>
> >     ---
> >      hw/ppc/spapr.c             | 46
> >     +++++++++++++++++++++++++++++++++-------------
> >      hw/ppc/spapr_drc.c         | 16 +++++-----------
> >      hw/ppc/spapr_pci.c         |  4 ++--
> >      include/hw/ppc/spapr_drc.h |  6 ++----
> >      4 files changed, 42 insertions(+), 30 deletions(-)
> >=20
> >     diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >     index bc11757..8b9a6cf 100644
> >     --- a/hw/ppc/spapr.c
> >     +++ b/hw/ppc/spapr.c
> >     @@ -1887,21 +1887,43 @@ static void spapr_drc_reset(void *opaque)
> >          }
> >      }
> >=20
> >     -typedef struct sPAPRDIMMState {
> >     -    uint32_t nr_lmbs;
> >     -} sPAPRDIMMState;
> >     +static bool spapr_all_lmbs_drcs_released(PCDIMMDevice *dimm)
> >     +{
> >     +    Error *local_err =3D NULL;
> >     +    PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(dimm);
> >     +    MemoryRegion *mr =3D ddc->get_memory_region(dimm);
> >     +    uint64_t size =3D memory_region_size(mr);
> >     +
> >     +    uint64_t addr;
> >     +    addr =3D object_property_get_int(OBJECT(dimm),
> >     PC_DIMM_ADDR_PROP, &local_err);
> >     +    if (local_err) {
> >     +        error_propagate(&error_abort, local_err);
> >     +        return false;
> >     +    }
> >     +    uint32_t nr_lmbs =3D size / SPAPR_MEMORY_BLOCK_SIZE;
> >=20
> >     -static void spapr_lmb_release(DeviceState *dev, void *opaque)
> >     +    sPAPRDRConnector *drc;
> >     +    int i =3D 0;
> >     +    for (i =3D 0; i < nr_lmbs; i++) {
> >     +        drc =3D spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_L=
MB,
> >     +                addr / SPAPR_MEMORY_BLOCK_SIZE);
> >     +        g_assert(drc);
> >     +        if (drc->indicator_state !=3D
> >     SPAPR_DR_INDICATOR_STATE_INACTIVE) {
> >     +            return false;
> >     +        }
> >     +        addr +=3D SPAPR_MEMORY_BLOCK_SIZE;
> >     +    }
> >     +    return true;
> >     +}
> >     +
> >     +static void spapr_lmb_release(DeviceState *dev)
> >      {
> >     -    sPAPRDIMMState *ds =3D (sPAPRDIMMState *)opaque;
> >          HotplugHandler *hotplug_ctrl;
> >=20
> >     -    if (--ds->nr_lmbs) {
> >     +    if (!spapr_all_lmbs_drcs_released(PC_DIMM(dev))) {
> >              return;
> >          }
> >=20
> >=20
> > I am concerned about the number of times we walk the DRC list
> > corresponding to each DIMM device. When a DIMM device is being removed,
> > spapr_lmb_release() will be invoked for each of the LMBs of that DIMM.
> > Now in this scheme, we end up walking through all the DRC objects of the
> > DIMM from every LMB's release function.
>=20
> Hi Bharata,
>=20
>=20
> I agree, this is definitely a poorer performance than simply decrementing
> ds->nr_lmbs.
> The reasons why I went on with it:
>=20
> - hot unplug isn't an operation that happens too often, so it's not terri=
ble
> to have a delay increase here;

So, if it were just a fixed increase in the time, I'd agree.  But IIUC
=66rom the above, this basically makes the removal O(N^2) in the size of
the DIMM, which sounds like it could get bad to me.

> - it didn't increased the unplug delay in an human noticeable way, at lea=
st
> in
> my tests;

Right, but what size of DIMM did you use?

> - apart from migrating the information, there is nothing much we can do in
> the
> callback side about it. The callback isn't aware of the current state of =
the
> DIMM
> removal process, so the scanning is required every time.

Well we could potentially use "cached" state here.  In the normal way
of things we use a value like this, but in the case of migration we
re-generate the information with a full scan.

> All that said, assuming that the process of DIMM removal will always go
> through
> 'spapr_del_lmbs', why do we need this callback? Can't we simply do someth=
ing
> like this in spapr_del_lmbs?
>=20
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index cd42449..e443fea 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2734,6 +2734,20 @@ static void spapr_del_lmbs(DeviceState *dev, uint6=
4_t
> addr_start, uint64_t size,
>          addr +=3D SPAPR_MEMORY_BLOCK_SIZE;
>      }
>=20
> +    if (!spapr_all_lmbs_drcs_released(PC_DIMM(dev))) {
> +        // something went wrong in the removal of the LMBs.
> +        // propagate error and return
> +        throw_error_code;
> +        return;
> +    }
> +
> +    /*
> +     * Now that all the LMBs have been removed by the guest, call the
> +     * pc-dimm unplug handler to cleanup up the pc-dimm device.
> +     */
> +    hotplug_ctrl =3D qdev_get_hotplug_handler(dev);
> +    hotplug_handler_unplug(hotplug_ctrl, dev, &error_abort);
> +
>      drc =3D spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_LMB,
>                                     addr_start / SPAPR_MEMORY_BLOCK_SIZE);
>      drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
>=20
>=20
> With this change we run the LMB scanning once at the end of the for
> loop inside spapr_del_lmbs to make sure everything went fine (something
> that the current code  isn't doing, there are operationsvbeing done
> afterwards
> without checking if the LMB removals actually happened).
>=20
> If something went wrong, propagate an error. If not, proceed with the
> removal
> of the DIMM device and the remaining spapr_del_lmbs code. spapr_lmb_relea=
se
> can
> be safely removed from the code after that.
>=20
>=20
> What do you think?

That seems like a good idea, independent of anything else.  But I may
not be remembering how the LMB removal paths all work.  Bharata?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZCtZPAAoJEGw4ysog2bOSJNUP/3szZCdKdXcUpPyq+wTMNBoQ
VR4ZSo2mfZntcLPCkiY2RVjFoPqZNWCIr51uo2ymaikO1I27n2PqTs4BPUPvXwJE
sUWFbfekQ57rgQTVdQeGMCz+33Q+ep9yhQOACoN5UPPA9uh/M0EZR6CfhrCvjSU+
NuFSmB0KwJfJrNDldVKUdVq445r+F3m5y/wApMwXjroX2R4IbDzkGhzcVy29vnU9
j85ir90mKTJCAnvNOLkF1W5J/rXtrnQivg/bYVpe0lcaW09AhM3yBVzXkJMK5KG5
YgGJXl9Z1qaiA2SobEpOSbwL84ElscNgWexC+T8+QONoJFU9CcI2gQEZKb0+YnjL
Qab/emQy1d1H74Djrja1bQ0FJthbCHmoSB2eEKj4lG2loJzffCY1T0ImslGQbi5a
3YT7R3SvMp8Ndox+wA0Ro8Eu5dnRPTKzTb3wLXLurJzdNydLaMCCvNziN86g1T8Q
6TGJJtR4ghWl0ju3/LkgqTWXMkZ4C+WGoGpieS28LFv9z0DDSwPuiPY30n+sJVxM
6l+5ShJnuEL1z5vzjW4pshxDsJN+mLXWvn9Do4vPvMPWl/rr0o7A9/IpFtFbKdW3
w4joe1xAC/Zi+plrpzDE6ardbmT6xC26Di+MWE9oOgcVIo1Ud6ML+Zn9Dgy5Ei+0
nNKl9+V0yveV0rSuUOVx
=y3ES
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--
