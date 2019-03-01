Received: from eggs.gnu.org ([209.51.188.92]:46621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gzhBg-0000Hv-W5
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 07:22:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gzhBf-0000sF-MQ
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 07:22:48 -0500
Received: from 13.mo1.mail-out.ovh.net ([178.33.253.128]:36617)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gzhBf-0000rO-Fx
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 07:22:47 -0500
Received: from player797.ha.ovh.net (unknown [10.109.146.50])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id DC9DC15D542
	for <qemu-devel@nongnu.org>; Fri,  1 Mar 2019 13:22:44 +0100 (CET)
Date: Fri, 1 Mar 2019 13:22:33 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190301132233.00bf8590@bahia.lan>
In-Reply-To: <b26a4742-4e87-c65f-d3ed-4e37c87bf1fe@redhat.com>
References: <20190226045304.25618-1-david@gibson.dropbear.id.au>
	<20190226045304.25618-41-david@gibson.dropbear.id.au>
	<ec8e11d1-c966-b814-98da-a6ab56572834@redhat.com>
	<155140389645.9499.14782774845761701651@sif>
	<4038f585-feaa-2fca-cfb7-ba28416748bf@redhat.com>
	<20190301114807.0d3a255a@bahia.lan>
	<b26a4742-4e87-c65f-d3ed-4e37c87bf1fe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 40/50] spapr_events: add support for phb
 hotplug events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, lvivier@redhat.com, gkurz@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org

On Fri, 1 Mar 2019 11:49:30 +0100
Thomas Huth <thuth@redhat.com> wrote:

> On 01/03/2019 11.48, Greg Kurz wrote:
> > On Fri, 1 Mar 2019 11:30:18 +0100
> > David Hildenbrand <david@redhat.com> wrote:
> >   
> >> On 01.03.19 02:31, Michael Roth wrote:  
> >>> Quoting Thomas Huth (2019-02-28 12:40:52)    
> >>>> On 26/02/2019 05.52, David Gibson wrote:    
> >>>>> From: Michael Roth <mdroth@linux.vnet.ibm.com>
> >>>>>
> >>>>> Extend the existing EPOW event format we use for PCI
> >>>>> devices to emit PHB plug/unplug events.
> >>>>>
> >>>>> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> >>>>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> >>>>> Signed-off-by: Greg Kurz <groug@kaod.org>
> >>>>> Message-Id: <155059671405.1466090.535964535260503283.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
> >>>>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> >>>>> ---
> >>>>>  hw/ppc/spapr_events.c | 3 +++
> >>>>>  1 file changed, 3 insertions(+)
> >>>>>
> >>>>> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> >>>>> index b9c7ecb9e9..ab9a1f0063 100644
> >>>>> --- a/hw/ppc/spapr_events.c
> >>>>> +++ b/hw/ppc/spapr_events.c
> >>>>> @@ -526,6 +526,9 @@ static void spapr_hotplug_req_event(uint8_t hp_id, uint8_t hp_action,
> >>>>>      case SPAPR_DR_CONNECTOR_TYPE_CPU:
> >>>>>          hp->hotplug_type = RTAS_LOG_V6_HP_TYPE_CPU;
> >>>>>          break;
> >>>>> +    case SPAPR_DR_CONNECTOR_TYPE_PHB:
> >>>>> +        hp->hotplug_type = RTAS_LOG_V6_HP_TYPE_PHB;
> >>>>> +        break;
> >>>>>      default:
> >>>>>          /* we shouldn't be signaling hotplug events for resources
> >>>>>           * that don't support them    
> >>>>
> >>>> I think this patch (or something else in this PULL request) broke CPU
> >>>> hot-plugging with older machine types:
> >>>>
> >>>> $ QTEST_QEMU_BINARY=ppc64-softmmu/qemu-system-ppc64 ./tests/cpu-plug-test -m=slow
> >>>> /ppc64/cpu-plug/pseries-3.1/device-add/2x3x1&maxcpus=6: OK
> >>>> /ppc64/cpu-plug/pseries-2.12-sxxm/device-add/2x3x1&maxcpus=6: OK
> >>>> /ppc64/cpu-plug/pseries-3.0/device-add/2x3x1&maxcpus=6: OK
> >>>> /ppc64/cpu-plug/pseries-2.10/device-add/2x3x1&maxcpus=6: OK
> >>>> /ppc64/cpu-plug/pseries-2.11/device-add/2x3x1&maxcpus=6: OK
> >>>> /ppc64/cpu-plug/pseries-2.12/device-add/2x3x1&maxcpus=6: OK
> >>>> /ppc64/cpu-plug/pseries-2.9/device-add/2x3x1&maxcpus=6: OK
> >>>> /ppc64/cpu-plug/pseries-2.7/device-add/2x3x1&maxcpus=6: **
> >>>> ERROR:/home/thuth/devel/qemu/hw/ppc/spapr_events.c:313:rtas_event_log_to_source: assertion failed: (source->enabled)
> >>>> Broken pipe
> >>>> /home/thuth/devel/qemu/tests/libqtest.c:143: kill_qemu() detected QEMU death from signal 6 (Aborted) (core dumped)
> >>>> Aborted (core dumped)
> >>>>
> >>>> Could you please have a look?    
> >>>
> >>> Bisected to:
> >>>
> >>>   commit b8165118f52ce5ee88565d3cec83d30374efdc96
> >>>   Author: David Hildenbrand <david@redhat.com>
> >>>   Date:   Mon Feb 18 10:21:58 2019 +0100
> >>>   
> >>>       spapr: support memory unplug for qtest
> >>>       
> >>>       Fake availability of OV5_HP_EVT, so we can test memory unplug in qtest.
> >>>
> >>> Which makes sense since OV5_HP_EVT assumes that
> >>> spapr->spapr->use_hotplug_event_source == true, which isn't the default for
> >>> 2.7 and below.
> >>>
> >>> If I revert that I think I hit the bug it was meant to fix:
> >>>
> >>>   mdroth@sif:~/w/qemu-build3$ make V=1 check-qtest-ppc64
> >>>   ...
> >>>   PASS 1 device-plug-test /ppc64/device-plug/pci-unplug-request
> >>>   PASS 2 device-plug-test /ppc64/device-plug/spapr-cpu-unplug-request
> >>>   **
> >>>   ERROR:/home/mdroth/w/qemu3.git/tests/device-plug-test.c:28:device_del_finish: assertion failed: (qdict_haskey(resp, "return"))
> >>>   ERROR - Bail out! ERROR:/home/mdroth/w/qemu3.git/tests/device-plug-test.c:28:device_del_finish: assertion failed: (qdict_haskey(resp, "return"))
> >>>   Aborted (core dumped)
> >>>   /home/mdroth/w/qemu3.git/tests/Makefile.include:875: recipe for target 'check-qtest-ppc64' failed
> >>>   make: *** [check-qtest-ppc64] Error 1
> >>>   mdroth@sif:~/w/qemu-build3$
> >>>
> >>> Which is probably due to this check in spapr_machine_device_unplug_request():
> >>>
> >>>     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> >>>         if (spapr_ovec_test(sms->ov5_cas, OV5_HP_EVT)) {
> >>>             spapr_memory_unplug_request(hotplug_dev, dev, errp);
> >>>         } else {
> >>>             /* NOTE: this means there is a window after guest reset, prior to
> >>>              * CAS negotiation, where unplug requests will fail due to the
> >>>              * capability not being detected yet. This is a bit different than
> >>>              * the case with PCI unplug, where the events will be queued and
> >>>              * eventually handled by the guest after boot
> >>>              */
> >>>             error_setg(errp, "Memory hot unplug not supported for this guest");
> >>>         }
> >>>
> >>>
> >>>
> >>> This spapr-cpu-unplug-request test is failing because
> >>> spapr_ovec_test(sms->ov5_cas, OV5_HP_EVT) relies on the CAS-negotiated OV5 bit,
> >>> which wouldn't have happened with qtest. If we want to make these tests run in
> >>> this scenario we probably need a different approach than the original patch.    
> >>
> >> We could rip out the patch along with the spapr memory unplug test.
> >> However it feels like a step back to not have any memory unplug tests
> >> for QEMU at all.
> >>
> >> Any spapr experts here if we can work around this?
> >>  
> > 
> > Not sure about the expertise :) but I'm currently looking into it. As
> > you say, it would be unfortunate to drop a test because of that.
> >   
> 
> Could this work:
> 
> diff --git a/hw/ppc/spapr_ovec.c b/hw/ppc/spapr_ovec.c
> --- a/hw/ppc/spapr_ovec.c
> +++ b/hw/ppc/spapr_ovec.c
> @@ -12,6 +12,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "hw/ppc/spapr.h"
>  #include "hw/ppc/spapr_ovec.h"
>  #include "qemu/bitmap.h"
>  #include "exec/address-spaces.h"
> @@ -134,7 +135,9 @@ bool spapr_ovec_test(sPAPROptionVector *ov, long bitnr)
>  
>      /* support memory unplug for qtest */
>      if (qtest_enabled() && bitnr == OV5_HP_EVT) {
> -        return true;
> +        sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
> +
> +        return spapr->use_hotplug_event_source;
>      }
>  

This patch definitely fixes make check but having to add yet another
qdev_get_machine() here is an indication that something is wrong.
An older machine type that doesn't have use_hotplug_event_source
shouldn't even bother about OV5_HP_EVT in the first place.

rtas_event_log_to_source() seems to assume that the machine has
an hotplug event source based on the fact that the guest advertised
it has support to use such a source. This might be true with a
regular guest because CAS would always clear the OV5_HP_EVT bit
if the machine didn't support it. Anyway, this is subtle and
thus fragile. If the machine doesn't know about hotplug event
source, we should step away from EVENT_CLASS_HOT_PLUG explicitly.

Something like:

---
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index ab9a1f0063d5..1a09dab6857d 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -307,11 +307,13 @@ rtas_event_log_to_source(sPAPRMachineState *spapr, int lo>
 
     switch (log_type) {
     case RTAS_LOG_TYPE_HOTPLUG:
-        source = spapr_event_sources_get_source(spapr->event_sources,
-                                                EVENT_CLASS_HOT_PLUG);
-        if (spapr_ovec_test(spapr->ov5_cas, OV5_HP_EVT)) {
-            g_assert(source->enabled);
-            break;
+        if (spapr->use_hotplug_event_source) {
+            source = spapr_event_sources_get_source(spapr->event_sources,
+                                                    EVENT_CLASS_HOT_PLUG);
+            if (spapr_ovec_test(spapr->ov5_cas, OV5_HP_EVT)) {
+                g_assert(source->enabled);
+                break;
+            }
         }
         /* fall back to epow for legacy hotplug interrupt source */
     case RTAS_LOG_TYPE_EPOW:
---

>      return test_bit(bitnr, ov->bitmap) ? true : false;
> 
> 
> ?
> 
>  Thomas
