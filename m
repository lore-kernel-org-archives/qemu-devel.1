Received: from eggs.gnu.org ([209.51.188.92]:54720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gzfiN-0002mb-8I
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 05:48:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gzfiL-00021Z-07
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 05:48:27 -0500
Received: from 6.mo2.mail-out.ovh.net ([87.98.165.38]:34418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gzfiI-0001zD-C0
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 05:48:23 -0500
Received: from player770.ha.ovh.net (unknown [10.109.159.136])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 88F381845EA
	for <qemu-devel@nongnu.org>; Fri,  1 Mar 2019 11:48:18 +0100 (CET)
Date: Fri, 1 Mar 2019 11:48:07 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190301114807.0d3a255a@bahia.lan>
In-Reply-To: <4038f585-feaa-2fca-cfb7-ba28416748bf@redhat.com>
References: <20190226045304.25618-1-david@gibson.dropbear.id.au>
	<20190226045304.25618-41-david@gibson.dropbear.id.au>
	<ec8e11d1-c966-b814-98da-a6ab56572834@redhat.com>
	<155140389645.9499.14782774845761701651@sif>
	<4038f585-feaa-2fca-cfb7-ba28416748bf@redhat.com>
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
To: David Hildenbrand <david@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, lvivier@redhat.com, gkurz@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org

On Fri, 1 Mar 2019 11:30:18 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 01.03.19 02:31, Michael Roth wrote:
> > Quoting Thomas Huth (2019-02-28 12:40:52)  
> >> On 26/02/2019 05.52, David Gibson wrote:  
> >>> From: Michael Roth <mdroth@linux.vnet.ibm.com>
> >>>
> >>> Extend the existing EPOW event format we use for PCI
> >>> devices to emit PHB plug/unplug events.
> >>>
> >>> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> >>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> >>> Signed-off-by: Greg Kurz <groug@kaod.org>
> >>> Message-Id: <155059671405.1466090.535964535260503283.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
> >>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> >>> ---
> >>>  hw/ppc/spapr_events.c | 3 +++
> >>>  1 file changed, 3 insertions(+)
> >>>
> >>> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> >>> index b9c7ecb9e9..ab9a1f0063 100644
> >>> --- a/hw/ppc/spapr_events.c
> >>> +++ b/hw/ppc/spapr_events.c
> >>> @@ -526,6 +526,9 @@ static void spapr_hotplug_req_event(uint8_t hp_id, uint8_t hp_action,
> >>>      case SPAPR_DR_CONNECTOR_TYPE_CPU:
> >>>          hp->hotplug_type = RTAS_LOG_V6_HP_TYPE_CPU;
> >>>          break;
> >>> +    case SPAPR_DR_CONNECTOR_TYPE_PHB:
> >>> +        hp->hotplug_type = RTAS_LOG_V6_HP_TYPE_PHB;
> >>> +        break;
> >>>      default:
> >>>          /* we shouldn't be signaling hotplug events for resources
> >>>           * that don't support them  
> >>
> >> I think this patch (or something else in this PULL request) broke CPU
> >> hot-plugging with older machine types:
> >>
> >> $ QTEST_QEMU_BINARY=ppc64-softmmu/qemu-system-ppc64 ./tests/cpu-plug-test -m=slow
> >> /ppc64/cpu-plug/pseries-3.1/device-add/2x3x1&maxcpus=6: OK
> >> /ppc64/cpu-plug/pseries-2.12-sxxm/device-add/2x3x1&maxcpus=6: OK
> >> /ppc64/cpu-plug/pseries-3.0/device-add/2x3x1&maxcpus=6: OK
> >> /ppc64/cpu-plug/pseries-2.10/device-add/2x3x1&maxcpus=6: OK
> >> /ppc64/cpu-plug/pseries-2.11/device-add/2x3x1&maxcpus=6: OK
> >> /ppc64/cpu-plug/pseries-2.12/device-add/2x3x1&maxcpus=6: OK
> >> /ppc64/cpu-plug/pseries-2.9/device-add/2x3x1&maxcpus=6: OK
> >> /ppc64/cpu-plug/pseries-2.7/device-add/2x3x1&maxcpus=6: **
> >> ERROR:/home/thuth/devel/qemu/hw/ppc/spapr_events.c:313:rtas_event_log_to_source: assertion failed: (source->enabled)
> >> Broken pipe
> >> /home/thuth/devel/qemu/tests/libqtest.c:143: kill_qemu() detected QEMU death from signal 6 (Aborted) (core dumped)
> >> Aborted (core dumped)
> >>
> >> Could you please have a look?  
> > 
> > Bisected to:
> > 
> >   commit b8165118f52ce5ee88565d3cec83d30374efdc96
> >   Author: David Hildenbrand <david@redhat.com>
> >   Date:   Mon Feb 18 10:21:58 2019 +0100
> >   
> >       spapr: support memory unplug for qtest
> >       
> >       Fake availability of OV5_HP_EVT, so we can test memory unplug in qtest.
> > 
> > Which makes sense since OV5_HP_EVT assumes that
> > spapr->spapr->use_hotplug_event_source == true, which isn't the default for
> > 2.7 and below.
> > 
> > If I revert that I think I hit the bug it was meant to fix:
> > 
> >   mdroth@sif:~/w/qemu-build3$ make V=1 check-qtest-ppc64
> >   ...
> >   PASS 1 device-plug-test /ppc64/device-plug/pci-unplug-request
> >   PASS 2 device-plug-test /ppc64/device-plug/spapr-cpu-unplug-request
> >   **
> >   ERROR:/home/mdroth/w/qemu3.git/tests/device-plug-test.c:28:device_del_finish: assertion failed: (qdict_haskey(resp, "return"))
> >   ERROR - Bail out! ERROR:/home/mdroth/w/qemu3.git/tests/device-plug-test.c:28:device_del_finish: assertion failed: (qdict_haskey(resp, "return"))
> >   Aborted (core dumped)
> >   /home/mdroth/w/qemu3.git/tests/Makefile.include:875: recipe for target 'check-qtest-ppc64' failed
> >   make: *** [check-qtest-ppc64] Error 1
> >   mdroth@sif:~/w/qemu-build3$
> > 
> > Which is probably due to this check in spapr_machine_device_unplug_request():
> > 
> >     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> >         if (spapr_ovec_test(sms->ov5_cas, OV5_HP_EVT)) {
> >             spapr_memory_unplug_request(hotplug_dev, dev, errp);
> >         } else {
> >             /* NOTE: this means there is a window after guest reset, prior to
> >              * CAS negotiation, where unplug requests will fail due to the
> >              * capability not being detected yet. This is a bit different than
> >              * the case with PCI unplug, where the events will be queued and
> >              * eventually handled by the guest after boot
> >              */
> >             error_setg(errp, "Memory hot unplug not supported for this guest");
> >         }
> > 
> > 
> > 
> > This spapr-cpu-unplug-request test is failing because
> > spapr_ovec_test(sms->ov5_cas, OV5_HP_EVT) relies on the CAS-negotiated OV5 bit,
> > which wouldn't have happened with qtest. If we want to make these tests run in
> > this scenario we probably need a different approach than the original patch.  
> 
> We could rip out the patch along with the spapr memory unplug test.
> However it feels like a step back to not have any memory unplug tests
> for QEMU at all.
> 
> Any spapr experts here if we can work around this?
> 

Not sure about the expertise :) but I'm currently looking into it. As
you say, it would be unfortunate to drop a test because of that.
