Received: from eggs.gnu.org ([2001:4830:134:3::10]:55705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d6Iah-0000vD-9k
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:22:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d6Iad-0007K0-VW
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:22:51 -0400
Date: Thu, 4 May 2017 17:24:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170504072434.GC14413@umbus.fritz.box>
References: <20170430172547.13415-1-danielhb@linux.vnet.ibm.com>
	<20170430172547.13415-3-danielhb@linux.vnet.ibm.com>
	<CAGZKiBok2=HRT9BjMiDx+c20YeKhknJ0ZD_GV1Zx=BrbFSmxwA@mail.gmail.com>
	<c890eaba-6d61-4e82-c771-1476cd3df0f2@linux.vnet.ibm.com>
	<CAGZKiBrEihUiYSNRetQzWVjOgrAQdTHze0_9Ec3XtGxk2LYhmw@mail.gmail.com>
	<e73ca259-9535-da41-0c21-3e4d6c1b8f63@linux.vnet.ibm.com>
	<783051ae-b92c-3679-ca25-979db6d2d7d6@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="c3bfwLpm8qysLVxt"
Content-Disposition: inline
In-Reply-To: <783051ae-b92c-3679-ca25-979db6d2d7d6@linux.vnet.ibm.com>
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
Cc: Bharata B Rao <bharata.rao@gmail.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 03, 2017 at 05:33:54PM -0300, Daniel Henrique Barboza wrote:
> Update: I have talked with Michael Roth about the spapr_release_lmb
> callback, the flow
> of the LMB releases and so on. He clarified to me that it is not possible=
 to
> get rid of
> the callback and put its code in the spapr_del_lmbs function.
>=20
> The reason is that the callback is being executed by the guest via
> spapr_rtas.c:rtas_set_indicator(),
> which in turn will follow the flow of the DRC releases and eventually will
> hit the spapr_release_lmb
> callback, but this will not necessarily happen in the spam of the
> spapr_del_lmbs function. This means that
> my idea of putting the cb code in the spapr_del_lmbs and removing the
> callback not possible.
>=20
> On the other hand, Bharata raised the issue about the scan function in the
> callback being a problem.
> My tests with a 1 Gb unplug didn't show any noticeable delay increase but=
 in
> theory we support memory
> unplugs of 1 Terabyte. With 1Gb of RAM we need 4 DRCs, so 1 Tb would requ=
ire
> 4000 DRCs. Then we
> would scan through them 4000 times. I don't think the scan inside the
> callback is feasible in this scenario
> either.
>=20
> In the v9 I'll migrate the sPAPRDIMMState structure like Michael Roth
> mentioned somewhere in the
> v6 review to use it inside the spapr_lmb_release callback - looks like the
> best option we have.

I don't think you have to migrate that actual structure, just the fact
that there's an in-progress removal (which you might be able to derive
=66rom existing migrated state anyway).  You can reconstruct the nr_lmbs
state with a full scan on post_load().  That way it's only O(N) not
O(N^2), and only in the case that a migration occurs mid-unplug.

>=20
>=20
> Thanks,
>=20
>=20
> Daniel
>=20
>=20
>=20
> On 05/03/2017 10:56 AM, Daniel Henrique Barboza wrote:
> >=20
> >=20
> > On 05/03/2017 12:26 AM, Bharata B Rao wrote:
> > > On Tue, May 2, 2017 at 1:13 PM, Daniel Henrique Barboza
> > > <danielhb@linux.vnet.ibm.com <mailto:danielhb@linux.vnet.ibm.com>>
> > > wrote:
> > >=20
> > >=20
> > >=20
> > >     On 05/02/2017 12:40 AM, Bharata B Rao wrote:
> > > >     On Sun, Apr 30, 2017 at 10:55 PM, Daniel Henrique Barboza
> > > >     <danielhb@linux.vnet.ibm.com
> > > >     <mailto:danielhb@linux.vnet.ibm.com>> wrote:
> > > >=20
> > > >         Following up the previous detach_cb change, this patch
> > > >         removes the
> > > >         detach_cb_opaque entirely from the code.
> > > >=20
> > > >         The reason is that the drc->detach_cb_opaque object can't be
> > > >         restored in the post load of the upcoming DRC migration and
> > > >         no detach
> > > >         callbacks actually need this opaque. 'spapr_core_release' is
> > > >         receiving it as NULL, 'spapr_phb_remove_pci_device_cb' is
> > > >         receiving
> > > >         a phb object as opaque but is't using it. These were trivial
> > > >         removal
> > > >         cases.
> > > >=20
> > > >         However, the LM removal callback 'spapr_lmb_release' is
> > > > receiving
> > > >         and using the opaque object, a 'sPAPRDIMMState' struct. This
> > > >         struct
> > > >         holds the number of LMBs the DIMM object contains and the
> > > >         callback
> > > >         was using this counter as a countdown to check if all LMB
> > > >         DRCs were
> > > >         release before proceeding to the DIMM unplug. To remove the
> > > >         need of
> > > >         this callback we have choices such as:
> > > >=20
> > > >         - migrate the 'sPAPRDIMMState' struct. This would require
> > > >         creating a
> > > >         QTAILQ to store all DIMMStates and an additional 'dimm_id'
> > > >         field to
> > > >         associate the DIMMState with the DIMM object. We could atta=
ch
> > > >         this
> > > >         QTAILQ to the 'sPAPRPHBState' and retrieve it later in the
> > > >         callback.
> > > >=20
> > > >         - fetch the state of the LMB DRCs directly by scanning the
> > > >         state of
> > > >         them and, if all of them are released, proceed with the DIMM
> > > >         unplug.
> > > >=20
> > > >         The second approach was chosen. The new
> > > >         'spapr_all_lmbs_drcs_released'
> > > >         function scans all LMBs of a given DIMM device to see if
> > > >         their DRC
> > > >         state are inactive. If all of them are inactive return
> > > >         'true', 'false'
> > > >         otherwise. This function is being called inside the
> > > >         'spapr_lmb_release'
> > > >         callback, replacing the role of the 'sPAPRDIMMState'
> > > > opaque. The
> > > >         'sPAPRDIMMState' struct was removed from the code given that
> > > >         there are
> > > >         no more uses for it.
> > > >=20
> > > >         After all these changes, there are no roles left for the
> > > >         'detach_cb_opaque'
> > > >         attribute of the 'sPAPRDRConnector' as well, so we can safe=
ly
> > > >         remove
> > > >         it from the code too.
> > > >=20
> > > >         Signed-off-by: Daniel Henrique Barboza
> > > >         <danielhb@linux.vnet.ibm.com
> > > >         <mailto:danielhb@linux.vnet.ibm.com>>
> > > >         ---
> > > >          hw/ppc/spapr.c             | 46
> > > >         +++++++++++++++++++++++++++++++++-------------
> > > >          hw/ppc/spapr_drc.c         | 16 +++++-----------
> > > >          hw/ppc/spapr_pci.c         |  4 ++--
> > > >          include/hw/ppc/spapr_drc.h |  6 ++----
> > > >          4 files changed, 42 insertions(+), 30 deletions(-)
> > > >=20
> > > >         diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > >         index bc11757..8b9a6cf 100644
> > > >         --- a/hw/ppc/spapr.c
> > > >         +++ b/hw/ppc/spapr.c
> > > >         @@ -1887,21 +1887,43 @@ static void spapr_drc_reset(void
> > > > *opaque)
> > > >              }
> > > >          }
> > > >=20
> > > >         -typedef struct sPAPRDIMMState {
> > > >         -    uint32_t nr_lmbs;
> > > >         -} sPAPRDIMMState;
> > > >         +static bool spapr_all_lmbs_drcs_released(PCDIMMDevice *dim=
m)
> > > >         +{
> > > >         +    Error *local_err =3D NULL;
> > > >         +    PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(dimm);
> > > >         +    MemoryRegion *mr =3D ddc->get_memory_region(dimm);
> > > >         +    uint64_t size =3D memory_region_size(mr);
> > > >         +
> > > >         +    uint64_t addr;
> > > >         +    addr =3D object_property_get_int(OBJECT(dimm),
> > > >         PC_DIMM_ADDR_PROP, &local_err);
> > > >         +    if (local_err) {
> > > >         +        error_propagate(&error_abort, local_err);
> > > >         +        return false;
> > > >         +    }
> > > >         +    uint32_t nr_lmbs =3D size / SPAPR_MEMORY_BLOCK_SIZE;
> > > >=20
> > > >         -static void spapr_lmb_release(DeviceState *dev, void *opaq=
ue)
> > > >         +    sPAPRDRConnector *drc;
> > > >         +    int i =3D 0;
> > > >         +    for (i =3D 0; i < nr_lmbs; i++) {
> > > >         +        drc =3D
> > > >         spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_LMB,
> > > >         +                addr / SPAPR_MEMORY_BLOCK_SIZE);
> > > >         +        g_assert(drc);
> > > >         +        if (drc->indicator_state !=3D
> > > >         SPAPR_DR_INDICATOR_STATE_INACTIVE) {
> > > >         +            return false;
> > > >         +        }
> > > >         +        addr +=3D SPAPR_MEMORY_BLOCK_SIZE;
> > > >         +    }
> > > >         +    return true;
> > > >         +}
> > > >         +
> > > >         +static void spapr_lmb_release(DeviceState *dev)
> > > >          {
> > > >         -    sPAPRDIMMState *ds =3D (sPAPRDIMMState *)opaque;
> > > >              HotplugHandler *hotplug_ctrl;
> > > >=20
> > > >         -    if (--ds->nr_lmbs) {
> > > >         +    if (!spapr_all_lmbs_drcs_released(PC_DIMM(dev))) {
> > > >                  return;
> > > >              }
> > > >=20
> > > >=20
> > > >     I am concerned about the number of times we walk the DRC list
> > > >     corresponding to each DIMM device. When a DIMM device is being
> > > >     removed, spapr_lmb_release() will be invoked for each of the LM=
Bs
> > > >     of that DIMM. Now in this scheme, we end up walking through all
> > > >     the DRC objects of the DIMM from every LMB's release function.
> > >=20
> > >     Hi Bharata,
> > >=20
> > >=20
> > >     I agree, this is definitely a poorer performance than simply
> > >     decrementing ds->nr_lmbs.
> > >     The reasons why I went on with it:
> > >=20
> > >     - hot unplug isn't an operation that happens too often, so it's
> > >     not terrible
> > >     to have a delay increase here;
> > >=20
> > >     - it didn't increased the unplug delay in an human noticeable way,
> > >     at least in
> > >     my tests;
> > >=20
> > >     - apart from migrating the information, there is nothing much we
> > >     can do in the
> > >     callback side about it. The callback isn't aware of the current
> > >     state of the DIMM
> > >     removal process, so the scanning is required every time.
> > >=20
> > >=20
> > >     All that said, assuming that the process of DIMM removal will
> > >     always go through
> > >     'spapr_del_lmbs', why do we need this callback? Can't we simply do
> > >     something
> > >     like this in spapr_del_lmbs?
> > >=20
> > >=20
> > >     diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > >     index cd42449..e443fea 100644
> > >     --- a/hw/ppc/spapr.c
> > >     +++ b/hw/ppc/spapr.c
> > >     @@ -2734,6 +2734,20 @@ static void spapr_del_lmbs(DeviceState
> > >     *dev, uint64_t addr_start, uint64_t size,
> > >              addr +=3D SPAPR_MEMORY_BLOCK_SIZE;
> > >          }
> > >=20
> > >     +    if (!spapr_all_lmbs_drcs_released(PC_DIMM(dev))) {
> > >     +        // something went wrong in the removal of the LMBs.
> > >     +        // propagate error and return
> > >     +        throw_error_code;
> > >     +        return;
> > >     +    }
> > >=20
> > >=20
> > > spapr_del_lmbs() is called from ->unplug_request(). Here we notify
> > > the guest about the unplug request. We have to wait till the guest
> > > gives us a go ahead so that we can cleanup the DIMM device. The
> > > cleanup is done as part of release callback (spapr_lmb_release) at
> > > which point we are sure that the given LMB has been indeed removed
> > > by the guest.
> >=20
> > I wasn't clear enough in my last comment. Let me rephrase. Is there any
> > other use for
> > the 'spapr_lmb_release' callback function other than being called by the
> > spapr_del_lmbs()
> > in the flow you've stated above? Searching the master code now I've
> > found:
> >=20
> >=20
> > $ grep -R 'spapr_lmb_release' .
> > ./spapr.c:static void spapr_lmb_release(DeviceState *dev, void *opaque)
> > ./spapr.c:        drck->detach(drc, dev, spapr_lmb_release, ds, errp);
> >=20
> >=20
> > Note that all the callback is doing is asserting that a nr_lmb counter
> > will be zero after
> > a decrement and, if true,  execute the following:
> >=20
> >=20
> >     hotplug_ctrl =3D qdev_get_hotplug_handler(dev);
> >     hotplug_handler_unplug(hotplug_ctrl, dev, &error_abort);
> >=20
> >=20
> > So, if the callback spapr_lmb_release is only being called in the
> > following for loop of spapr_del_lmbs()
> > to clean up each LMB DRC, can't we get rid of it and do the following
> > after this for loop?
> >=20
> >     for (i =3D 0; i < nr_lmbs; i++) {
> >         drc =3D spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_LMB,
> >                 addr / SPAPR_MEMORY_BLOCK_SIZE);
> >         g_assert(drc);
> >=20
> >         drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> >         drck->detach(drc, dev, ds, errp);
> >         addr +=3D SPAPR_MEMORY_BLOCK_SIZE;
> >     }
> >=20
> >     if (!spapr_all_lmbs_drcs_released(PC_DIMM(dev))) {
> >         // All LMBs were cleared, proceed with detach
> >         hotplug_ctrl =3D qdev_get_hotplug_handler(dev);
> >         hotplug_handler_unplug(hotplug_ctrl, dev, &error_abort);
> >    }
> >    // proceed with spapr_del_lmbs code
> >=20
> >=20
> > Doesn't this code does exactly the same thing that the callback does
> > today? Note that we can
> > even use that conditional to block the remaining spapr_del_lmbs code
> > from executing if the
> > LMBs weren't properly cleansed - something that today isn't done.
> >=20
> >=20
> > If removing this callback is too problematic or can somehow cause
> > problems that I am unable to
> > foresee, then the alternative would be to either deal with the scanning
> > inside the callback
> > (as it is being done in this patch) or migrate the nr_lmbs information
> > for late retrieval in
> > the callback. I am fine with any alternative, we just need to agree on
> > what makes more
> > sense.
> >=20
> >=20
> > Daniel
> >=20
> > >=20
> > > Regards,
> > > Bharata.
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--c3bfwLpm8qysLVxt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZCtcyAAoJEGw4ysog2bOSr/8QAKfRETb33I6ZLdMsPqIS/uJf
OaAU8xLfOD6W6d2sm6R7qi45d5O/Q1LJ/WG01gnv8h99rI/hEhYNHbIAoIXtlhZF
uj0tcOzzash7RHCoZ9hIF5x8GR3Rvgm19Cm7dSh5EHhmpYnkM9WJU9ZI0arMkmtK
/0TKvY34S1MhSHZ6z2M+1rkOjanSKeiDDxiCDRB3Q5Ytwg1yyYb3JIuse2eLUv5t
MOpshhSto7jw9vd9b91gY3s3sKmUJp2ln8uq61oICOOzd9dTkDrr1bXXilphTTJo
iPYZlUP3atReOvp94uNgrUXSZ9//EnrZPhjtBoYmKUvqyyyS8IE28wZrBxArKuwE
tbPdftph8AFlxBupgDXfG7L1NNG/zCzn2IW7cTW9jJ1rJPJGcpQuisQ+bmUSEJ5+
mefGH+IDN9uPd3N+HL667GiWy//FbihI8ILSnQKIF6rpoZ+7DPZwhmH2gdPC+3Pk
S4wnlKp6+Hm9awlwJ00Q+kEaZHc3iIxwf1iDFGk+79LJn8D+rJmwqOPGyaMiv9TU
uioJniPfx84iMfcyhM1twA/bFAFQn7OVfcWpGiSlMkqJfawWdtLaxBee87TcOJu3
y48SBG5+OCyvldMxPoXmYW2Vz0TKdUcP3FsIi4kVdfbbi9A9H1oqfuJ6lLvVzdIG
ueKJR7Jkp7hh1am+zQOH
=x9ZV
-----END PGP SIGNATURE-----

--c3bfwLpm8qysLVxt--
