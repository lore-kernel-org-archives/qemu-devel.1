Received: from eggs.gnu.org ([2001:4830:134:3::10]:42951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata.rao@gmail.com>) id 1d6V0y-0004nb-E2
	for qemu-devel@nongnu.org; Fri, 05 May 2017 00:38:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata.rao@gmail.com>) id 1d6V0w-0007EB-0Q
	for qemu-devel@nongnu.org; Fri, 05 May 2017 00:38:48 -0400
MIME-Version: 1.0
In-Reply-To: <20170504072050.GB14413@umbus.fritz.box>
References: <20170430172547.13415-1-danielhb@linux.vnet.ibm.com>
	<20170430172547.13415-3-danielhb@linux.vnet.ibm.com>
	<CAGZKiBok2=HRT9BjMiDx+c20YeKhknJ0ZD_GV1Zx=BrbFSmxwA@mail.gmail.com>
	<c890eaba-6d61-4e82-c771-1476cd3df0f2@linux.vnet.ibm.com>
	<20170504072050.GB14413@umbus.fritz.box>
From: Bharata B Rao <bharata.rao@gmail.com>
Date: Fri, 5 May 2017 10:08:37 +0530
Message-ID: <CAGZKiBpMjqnmL-TOcBbWy4BO+OAdLdi-UCH5fVDq_J+2eyCbTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Thu, May 4, 2017 at 12:50 PM, David Gibson <david@gibson.dropbear.id.au>
wrote:

> On Tue, May 02, 2017 at 04:43:51AM -0300, Daniel Henrique Barboza wrote:
> >
> >
> > On 05/02/2017 12:40 AM, Bharata B Rao wrote:
> > > On Sun, Apr 30, 2017 at 10:55 PM, Daniel Henrique Barboza
> > > <danielhb@linux.vnet.ibm.com <mailto:danielhb@linux.vnet.ibm.com>>
> > > wrote:
> > >
> > >     Following up the previous detach_cb change, this patch removes the
> > >     detach_cb_opaque entirely from the code.
> > >
> > >     The reason is that the drc->detach_cb_opaque object can't be
> > >     restored in the post load of the upcoming DRC migration and no
> detach
> > >     callbacks actually need this opaque. 'spapr_core_release' is
> > >     receiving it as NULL, 'spapr_phb_remove_pci_device_cb' is
> receiving
> > >     a phb object as opaque but is't using it. These were trivial
> removal
> > >     cases.
> > >
> > >     However, the LM removal callback 'spapr_lmb_release' is receiving
> > >     and using the opaque object, a 'sPAPRDIMMState' struct. This struct
> > >     holds the number of LMBs the DIMM object contains and the callback
> > >     was using this counter as a countdown to check if all LMB DRCs were
> > >     release before proceeding to the DIMM unplug. To remove the need of
> > >     this callback we have choices such as:
> > >
> > >     - migrate the 'sPAPRDIMMState' struct. This would require creating
> a
> > >     QTAILQ to store all DIMMStates and an additional 'dimm_id' field to
> > >     associate the DIMMState with the DIMM object. We could attach this
> > >     QTAILQ to the 'sPAPRPHBState' and retrieve it later in the
> callback.
> > >
> > >     - fetch the state of the LMB DRCs directly by scanning the state of
> > >     them and, if all of them are released, proceed with the DIMM
> unplug.
> > >
> > >     The second approach was chosen. The new
> 'spapr_all_lmbs_drcs_released'
> > >     function scans all LMBs of a given DIMM device to see if their DRC
> > >     state are inactive. If all of them are inactive return 'true',
> 'false'
> > >     otherwise. This function is being called inside the
> > >     'spapr_lmb_release'
> > >     callback, replacing the role of the 'sPAPRDIMMState' opaque. The
> > >     'sPAPRDIMMState' struct was removed from the code given that there
> are
> > >     no more uses for it.
> > >
> > >     After all these changes, there are no roles left for the
> > >     'detach_cb_opaque'
> > >     attribute of the 'sPAPRDRConnector' as well, so we can safely
> remove
> > >     it from the code too.
> > >
> > >     Signed-off-by: Daniel Henrique Barboza
> > >     <danielhb@linux.vnet.ibm.com <mailto:danielhb@linux.vnet.ibm.com>>
> > >     ---
> > >      hw/ppc/spapr.c             | 46
> > >     +++++++++++++++++++++++++++++++++-------------
> > >      hw/ppc/spapr_drc.c         | 16 +++++-----------
> > >      hw/ppc/spapr_pci.c         |  4 ++--
> > >      include/hw/ppc/spapr_drc.h |  6 ++----
> > >      4 files changed, 42 insertions(+), 30 deletions(-)
> > >
> > >     diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > >     index bc11757..8b9a6cf 100644
> > >     --- a/hw/ppc/spapr.c
> > >     +++ b/hw/ppc/spapr.c
> > >     @@ -1887,21 +1887,43 @@ static void spapr_drc_reset(void *opaque)
> > >          }
> > >      }
> > >
> > >     -typedef struct sPAPRDIMMState {
> > >     -    uint32_t nr_lmbs;
> > >     -} sPAPRDIMMState;
> > >     +static bool spapr_all_lmbs_drcs_released(PCDIMMDevice *dimm)
> > >     +{
> > >     +    Error *local_err = NULL;
> > >     +    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
> > >     +    MemoryRegion *mr = ddc->get_memory_region(dimm);
> > >     +    uint64_t size = memory_region_size(mr);
> > >     +
> > >     +    uint64_t addr;
> > >     +    addr = object_property_get_int(OBJECT(dimm),
> > >     PC_DIMM_ADDR_PROP, &local_err);
> > >     +    if (local_err) {
> > >     +        error_propagate(&error_abort, local_err);
> > >     +        return false;
> > >     +    }
> > >     +    uint32_t nr_lmbs = size / SPAPR_MEMORY_BLOCK_SIZE;
> > >
> > >     -static void spapr_lmb_release(DeviceState *dev, void *opaque)
> > >     +    sPAPRDRConnector *drc;
> > >     +    int i = 0;
> > >     +    for (i = 0; i < nr_lmbs; i++) {
> > >     +        drc = spapr_dr_connector_by_id(
> SPAPR_DR_CONNECTOR_TYPE_LMB,
> > >     +                addr / SPAPR_MEMORY_BLOCK_SIZE);
> > >     +        g_assert(drc);
> > >     +        if (drc->indicator_state !=
> > >     SPAPR_DR_INDICATOR_STATE_INACTIVE) {
> > >     +            return false;
> > >     +        }
> > >     +        addr += SPAPR_MEMORY_BLOCK_SIZE;
> > >     +    }
> > >     +    return true;
> > >     +}
> > >     +
> > >     +static void spapr_lmb_release(DeviceState *dev)
> > >      {
> > >     -    sPAPRDIMMState *ds = (sPAPRDIMMState *)opaque;
> > >          HotplugHandler *hotplug_ctrl;
> > >
> > >     -    if (--ds->nr_lmbs) {
> > >     +    if (!spapr_all_lmbs_drcs_released(PC_DIMM(dev))) {
> > >              return;
> > >          }
> > >
> > >
> > > I am concerned about the number of times we walk the DRC list
> > > corresponding to each DIMM device. When a DIMM device is being removed,
> > > spapr_lmb_release() will be invoked for each of the LMBs of that DIMM.
> > > Now in this scheme, we end up walking through all the DRC objects of
> the
> > > DIMM from every LMB's release function.
> >
> > Hi Bharata,
> >
> >
> > I agree, this is definitely a poorer performance than simply decrementing
> > ds->nr_lmbs.
> > The reasons why I went on with it:
> >
> > - hot unplug isn't an operation that happens too often, so it's not
> terrible
> > to have a delay increase here;
>
> So, if it were just a fixed increase in the time, I'd agree.  But IIUC
> from the above, this basically makes the removal O(N^2) in the size of
> the DIMM, which sounds like it could get bad to me.
>
> > - it didn't increased the unplug delay in an human noticeable way, at
> least
> > in
> > my tests;
>
> Right, but what size of DIMM did you use?
>
> > - apart from migrating the information, there is nothing much we can do
> in
> > the
> > callback side about it. The callback isn't aware of the current state of
> the
> > DIMM
> > removal process, so the scanning is required every time.
>
> Well we could potentially use "cached" state here.  In the normal way
> of things we use a value like this, but in the case of migration we
> re-generate the information with a full scan.
>
> > All that said, assuming that the process of DIMM removal will always go
> > through
> > 'spapr_del_lmbs', why do we need this callback? Can't we simply do
> something
> > like this in spapr_del_lmbs?
> >
> >
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index cd42449..e443fea 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -2734,6 +2734,20 @@ static void spapr_del_lmbs(DeviceState *dev,
> uint64_t
> > addr_start, uint64_t size,
> >          addr += SPAPR_MEMORY_BLOCK_SIZE;
> >      }
> >
> > +    if (!spapr_all_lmbs_drcs_released(PC_DIMM(dev))) {
> > +        // something went wrong in the removal of the LMBs.
> > +        // propagate error and return
> > +        throw_error_code;
> > +        return;
> > +    }
> > +
> > +    /*
> > +     * Now that all the LMBs have been removed by the guest, call the
> > +     * pc-dimm unplug handler to cleanup up the pc-dimm device.
> > +     */
> > +    hotplug_ctrl = qdev_get_hotplug_handler(dev);
> > +    hotplug_handler_unplug(hotplug_ctrl, dev, &error_abort);
> > +
> >      drc = spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_LMB,
> >                                     addr_start /
> SPAPR_MEMORY_BLOCK_SIZE);
> >      drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> >
> >
> > With this change we run the LMB scanning once at the end of the for
> > loop inside spapr_del_lmbs to make sure everything went fine (something
> > that the current code  isn't doing, there are operationsvbeing done
> > afterwards
> > without checking if the LMB removals actually happened).
> >
> > If something went wrong, propagate an error. If not, proceed with the
> > removal
> > of the DIMM device and the remaining spapr_del_lmbs code.
> spapr_lmb_release
> > can
> > be safely removed from the code after that.
> >
> >
> > What do you think?
>
> That seems like a good idea, independent of anything else.  But I may
> not be remembering how the LMB removal paths all work.  Bharata?
>

As I pointed out in another thread and as Daniel himself realized, the
above scheme won't work as we have to wait for the guest to acknowledge the
removal and that is when callback is executed.

Regards,
Bharata.
