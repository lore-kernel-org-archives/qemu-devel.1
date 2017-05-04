Received: from eggs.gnu.org ([2001:4830:134:3::10]:51268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1d6Jea-0005o6-44
	for qemu-devel@nongnu.org; Thu, 04 May 2017 12:30:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1d6JeW-0004lv-1d
	for qemu-devel@nongnu.org; Thu, 04 May 2017 12:30:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58248
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1d6JeV-0004lM-QB
	for qemu-devel@nongnu.org; Thu, 04 May 2017 12:30:51 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v44GTBLc124666
	for <qemu-devel@nongnu.org>; Thu, 4 May 2017 12:30:49 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2a7rcxgad7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 04 May 2017 12:30:48 -0400
Received: from localhost
	by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Thu, 4 May 2017 13:30:46 -0300
References: <20170430172547.13415-1-danielhb@linux.vnet.ibm.com>
	<20170430172547.13415-3-danielhb@linux.vnet.ibm.com>
	<CAGZKiBok2=HRT9BjMiDx+c20YeKhknJ0ZD_GV1Zx=BrbFSmxwA@mail.gmail.com>
	<c890eaba-6d61-4e82-c771-1476cd3df0f2@linux.vnet.ibm.com>
	<CAGZKiBrEihUiYSNRetQzWVjOgrAQdTHze0_9Ec3XtGxk2LYhmw@mail.gmail.com>
	<e73ca259-9535-da41-0c21-3e4d6c1b8f63@linux.vnet.ibm.com>
	<783051ae-b92c-3679-ca25-979db6d2d7d6@linux.vnet.ibm.com>
	<20170504072434.GC14413@umbus.fritz.box>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Thu, 4 May 2017 13:30:37 -0300
MIME-Version: 1.0
In-Reply-To: <20170504072434.GC14413@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <7a4e02e6-c7b3-52b4-ab52-aadbd71ba808@linux.vnet.ibm.com>
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Bharata B Rao <bharata.rao@gmail.com>



On 05/04/2017 04:24 AM, David Gibson wrote:
> On Wed, May 03, 2017 at 05:33:54PM -0300, Daniel Henrique Barboza wrote:
>> Update: I have talked with Michael Roth about the spapr_release_lmb
>> callback, the flow
>> of the LMB releases and so on. He clarified to me that it is not possible to
>> get rid of
>> the callback and put its code in the spapr_del_lmbs function.
>>
>> The reason is that the callback is being executed by the guest via
>> spapr_rtas.c:rtas_set_indicator(),
>> which in turn will follow the flow of the DRC releases and eventually will
>> hit the spapr_release_lmb
>> callback, but this will not necessarily happen in the spam of the
>> spapr_del_lmbs function. This means that
>> my idea of putting the cb code in the spapr_del_lmbs and removing the
>> callback not possible.
>>
>> On the other hand, Bharata raised the issue about the scan function in the
>> callback being a problem.
>> My tests with a 1 Gb unplug didn't show any noticeable delay increase but in
>> theory we support memory
>> unplugs of 1 Terabyte. With 1Gb of RAM we need 4 DRCs, so 1 Tb would require
>> 4000 DRCs. Then we
>> would scan through them 4000 times. I don't think the scan inside the
>> callback is feasible in this scenario
>> either.
>>
>> In the v9 I'll migrate the sPAPRDIMMState structure like Michael Roth
>> mentioned somewhere in the
>> v6 review to use it inside the spapr_lmb_release callback - looks like the
>> best option we have.
> I don't think you have to migrate that actual structure, just the fact
> that there's an in-progress removal (which you might be able to derive
> from existing migrated state anyway).  You can reconstruct the nr_lmbs
> state with a full scan on post_load().  That way it's only O(N) not
> O(N^2), and only in the case that a migration occurs mid-unplug.

Interesting idea. I'll give it a go.

Daniel

>
>>
>> Thanks,
>>
>>
>> Daniel
>>
>>
>>
>> On 05/03/2017 10:56 AM, Daniel Henrique Barboza wrote:
>>>
>>> On 05/03/2017 12:26 AM, Bharata B Rao wrote:
>>>> On Tue, May 2, 2017 at 1:13 PM, Daniel Henrique Barboza
>>>> <danielhb@linux.vnet.ibm.com <mailto:danielhb@linux.vnet.ibm.com>>
>>>> wrote:
>>>>
>>>>
>>>>
>>>>      On 05/02/2017 12:40 AM, Bharata B Rao wrote:
>>>>>      On Sun, Apr 30, 2017 at 10:55 PM, Daniel Henrique Barboza
>>>>>      <danielhb@linux.vnet.ibm.com
>>>>>      <mailto:danielhb@linux.vnet.ibm.com>> wrote:
>>>>>
>>>>>          Following up the previous detach_cb change, this patch
>>>>>          removes the
>>>>>          detach_cb_opaque entirely from the code.
>>>>>
>>>>>          The reason is that the drc->detach_cb_opaque object can't be
>>>>>          restored in the post load of the upcoming DRC migration and
>>>>>          no detach
>>>>>          callbacks actually need this opaque. 'spapr_core_release' is
>>>>>          receiving it as NULL, 'spapr_phb_remove_pci_device_cb' is
>>>>>          receiving
>>>>>          a phb object as opaque but is't using it. These were trivial
>>>>>          removal
>>>>>          cases.
>>>>>
>>>>>          However, the LM removal callback 'spapr_lmb_release' is
>>>>> receiving
>>>>>          and using the opaque object, a 'sPAPRDIMMState' struct. This
>>>>>          struct
>>>>>          holds the number of LMBs the DIMM object contains and the
>>>>>          callback
>>>>>          was using this counter as a countdown to check if all LMB
>>>>>          DRCs were
>>>>>          release before proceeding to the DIMM unplug. To remove the
>>>>>          need of
>>>>>          this callback we have choices such as:
>>>>>
>>>>>          - migrate the 'sPAPRDIMMState' struct. This would require
>>>>>          creating a
>>>>>          QTAILQ to store all DIMMStates and an additional 'dimm_id'
>>>>>          field to
>>>>>          associate the DIMMState with the DIMM object. We could attach
>>>>>          this
>>>>>          QTAILQ to the 'sPAPRPHBState' and retrieve it later in the
>>>>>          callback.
>>>>>
>>>>>          - fetch the state of the LMB DRCs directly by scanning the
>>>>>          state of
>>>>>          them and, if all of them are released, proceed with the DIMM
>>>>>          unplug.
>>>>>
>>>>>          The second approach was chosen. The new
>>>>>          'spapr_all_lmbs_drcs_released'
>>>>>          function scans all LMBs of a given DIMM device to see if
>>>>>          their DRC
>>>>>          state are inactive. If all of them are inactive return
>>>>>          'true', 'false'
>>>>>          otherwise. This function is being called inside the
>>>>>          'spapr_lmb_release'
>>>>>          callback, replacing the role of the 'sPAPRDIMMState'
>>>>> opaque. The
>>>>>          'sPAPRDIMMState' struct was removed from the code given that
>>>>>          there are
>>>>>          no more uses for it.
>>>>>
>>>>>          After all these changes, there are no roles left for the
>>>>>          'detach_cb_opaque'
>>>>>          attribute of the 'sPAPRDRConnector' as well, so we can safely
>>>>>          remove
>>>>>          it from the code too.
>>>>>
>>>>>          Signed-off-by: Daniel Henrique Barboza
>>>>>          <danielhb@linux.vnet.ibm.com
>>>>>          <mailto:danielhb@linux.vnet.ibm.com>>
>>>>>          ---
>>>>>           hw/ppc/spapr.c             | 46
>>>>>          +++++++++++++++++++++++++++++++++-------------
>>>>>           hw/ppc/spapr_drc.c         | 16 +++++-----------
>>>>>           hw/ppc/spapr_pci.c         |  4 ++--
>>>>>           include/hw/ppc/spapr_drc.h |  6 ++----
>>>>>           4 files changed, 42 insertions(+), 30 deletions(-)
>>>>>
>>>>>          diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>>>>          index bc11757..8b9a6cf 100644
>>>>>          --- a/hw/ppc/spapr.c
>>>>>          +++ b/hw/ppc/spapr.c
>>>>>          @@ -1887,21 +1887,43 @@ static void spapr_drc_reset(void
>>>>> *opaque)
>>>>>               }
>>>>>           }
>>>>>
>>>>>          -typedef struct sPAPRDIMMState {
>>>>>          -    uint32_t nr_lmbs;
>>>>>          -} sPAPRDIMMState;
>>>>>          +static bool spapr_all_lmbs_drcs_released(PCDIMMDevice *dimm)
>>>>>          +{
>>>>>          +    Error *local_err = NULL;
>>>>>          +    PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
>>>>>          +    MemoryRegion *mr = ddc->get_memory_region(dimm);
>>>>>          +    uint64_t size = memory_region_size(mr);
>>>>>          +
>>>>>          +    uint64_t addr;
>>>>>          +    addr = object_property_get_int(OBJECT(dimm),
>>>>>          PC_DIMM_ADDR_PROP, &local_err);
>>>>>          +    if (local_err) {
>>>>>          +        error_propagate(&error_abort, local_err);
>>>>>          +        return false;
>>>>>          +    }
>>>>>          +    uint32_t nr_lmbs = size / SPAPR_MEMORY_BLOCK_SIZE;
>>>>>
>>>>>          -static void spapr_lmb_release(DeviceState *dev, void *opaque)
>>>>>          +    sPAPRDRConnector *drc;
>>>>>          +    int i = 0;
>>>>>          +    for (i = 0; i < nr_lmbs; i++) {
>>>>>          +        drc =
>>>>>          spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_LMB,
>>>>>          +                addr / SPAPR_MEMORY_BLOCK_SIZE);
>>>>>          +        g_assert(drc);
>>>>>          +        if (drc->indicator_state !=
>>>>>          SPAPR_DR_INDICATOR_STATE_INACTIVE) {
>>>>>          +            return false;
>>>>>          +        }
>>>>>          +        addr += SPAPR_MEMORY_BLOCK_SIZE;
>>>>>          +    }
>>>>>          +    return true;
>>>>>          +}
>>>>>          +
>>>>>          +static void spapr_lmb_release(DeviceState *dev)
>>>>>           {
>>>>>          -    sPAPRDIMMState *ds = (sPAPRDIMMState *)opaque;
>>>>>               HotplugHandler *hotplug_ctrl;
>>>>>
>>>>>          -    if (--ds->nr_lmbs) {
>>>>>          +    if (!spapr_all_lmbs_drcs_released(PC_DIMM(dev))) {
>>>>>                   return;
>>>>>               }
>>>>>
>>>>>
>>>>>      I am concerned about the number of times we walk the DRC list
>>>>>      corresponding to each DIMM device. When a DIMM device is being
>>>>>      removed, spapr_lmb_release() will be invoked for each of the LMBs
>>>>>      of that DIMM. Now in this scheme, we end up walking through all
>>>>>      the DRC objects of the DIMM from every LMB's release function.
>>>>      Hi Bharata,
>>>>
>>>>
>>>>      I agree, this is definitely a poorer performance than simply
>>>>      decrementing ds->nr_lmbs.
>>>>      The reasons why I went on with it:
>>>>
>>>>      - hot unplug isn't an operation that happens too often, so it's
>>>>      not terrible
>>>>      to have a delay increase here;
>>>>
>>>>      - it didn't increased the unplug delay in an human noticeable way,
>>>>      at least in
>>>>      my tests;
>>>>
>>>>      - apart from migrating the information, there is nothing much we
>>>>      can do in the
>>>>      callback side about it. The callback isn't aware of the current
>>>>      state of the DIMM
>>>>      removal process, so the scanning is required every time.
>>>>
>>>>
>>>>      All that said, assuming that the process of DIMM removal will
>>>>      always go through
>>>>      'spapr_del_lmbs', why do we need this callback? Can't we simply do
>>>>      something
>>>>      like this in spapr_del_lmbs?
>>>>
>>>>
>>>>      diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>>>      index cd42449..e443fea 100644
>>>>      --- a/hw/ppc/spapr.c
>>>>      +++ b/hw/ppc/spapr.c
>>>>      @@ -2734,6 +2734,20 @@ static void spapr_del_lmbs(DeviceState
>>>>      *dev, uint64_t addr_start, uint64_t size,
>>>>               addr += SPAPR_MEMORY_BLOCK_SIZE;
>>>>           }
>>>>
>>>>      +    if (!spapr_all_lmbs_drcs_released(PC_DIMM(dev))) {
>>>>      +        // something went wrong in the removal of the LMBs.
>>>>      +        // propagate error and return
>>>>      +        throw_error_code;
>>>>      +        return;
>>>>      +    }
>>>>
>>>>
>>>> spapr_del_lmbs() is called from ->unplug_request(). Here we notify
>>>> the guest about the unplug request. We have to wait till the guest
>>>> gives us a go ahead so that we can cleanup the DIMM device. The
>>>> cleanup is done as part of release callback (spapr_lmb_release) at
>>>> which point we are sure that the given LMB has been indeed removed
>>>> by the guest.
>>> I wasn't clear enough in my last comment. Let me rephrase. Is there any
>>> other use for
>>> the 'spapr_lmb_release' callback function other than being called by the
>>> spapr_del_lmbs()
>>> in the flow you've stated above? Searching the master code now I've
>>> found:
>>>
>>>
>>> $ grep -R 'spapr_lmb_release' .
>>> ./spapr.c:static void spapr_lmb_release(DeviceState *dev, void *opaque)
>>> ./spapr.c:        drck->detach(drc, dev, spapr_lmb_release, ds, errp);
>>>
>>>
>>> Note that all the callback is doing is asserting that a nr_lmb counter
>>> will be zero after
>>> a decrement and, if true,  execute the following:
>>>
>>>
>>>      hotplug_ctrl = qdev_get_hotplug_handler(dev);
>>>      hotplug_handler_unplug(hotplug_ctrl, dev, &error_abort);
>>>
>>>
>>> So, if the callback spapr_lmb_release is only being called in the
>>> following for loop of spapr_del_lmbs()
>>> to clean up each LMB DRC, can't we get rid of it and do the following
>>> after this for loop?
>>>
>>>      for (i = 0; i < nr_lmbs; i++) {
>>>          drc = spapr_dr_connector_by_id(SPAPR_DR_CONNECTOR_TYPE_LMB,
>>>                  addr / SPAPR_MEMORY_BLOCK_SIZE);
>>>          g_assert(drc);
>>>
>>>          drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
>>>          drck->detach(drc, dev, ds, errp);
>>>          addr += SPAPR_MEMORY_BLOCK_SIZE;
>>>      }
>>>
>>>      if (!spapr_all_lmbs_drcs_released(PC_DIMM(dev))) {
>>>          // All LMBs were cleared, proceed with detach
>>>          hotplug_ctrl = qdev_get_hotplug_handler(dev);
>>>          hotplug_handler_unplug(hotplug_ctrl, dev, &error_abort);
>>>     }
>>>     // proceed with spapr_del_lmbs code
>>>
>>>
>>> Doesn't this code does exactly the same thing that the callback does
>>> today? Note that we can
>>> even use that conditional to block the remaining spapr_del_lmbs code
>>> from executing if the
>>> LMBs weren't properly cleansed - something that today isn't done.
>>>
>>>
>>> If removing this callback is too problematic or can somehow cause
>>> problems that I am unable to
>>> foresee, then the alternative would be to either deal with the scanning
>>> inside the callback
>>> (as it is being done in this patch) or migrate the nr_lmbs information
>>> for late retrieval in
>>> the callback. I am fine with any alternative, we just need to agree on
>>> what makes more
>>> sense.
>>>
>>>
>>> Daniel
>>>
>>>> Regards,
>>>> Bharata.
