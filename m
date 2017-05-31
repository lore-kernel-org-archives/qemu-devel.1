Received: from eggs.gnu.org ([2001:4830:134:3::10]:60479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dFxnf-0000Yd-6I
	for qemu-devel@nongnu.org; Wed, 31 May 2017 03:12:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dFxna-0005oa-4u
	for qemu-devel@nongnu.org; Wed, 31 May 2017 03:12:11 -0400
References: <20170530160445.12810-1-lvivier@redhat.com>
	<20170531043557.GI12163@umbus.fritz.box>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <733c46f8-80f9-6c8d-d2c8-c2086b26a0f3@redhat.com>
Date: Wed, 31 May 2017 09:12:02 +0200
MIME-Version: 1.0
In-Reply-To: <20170531043557.GI12163@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] spapr: manage hotplugged devices while the
 VM is not started
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 31/05/2017 06:35, David Gibson wrote:
> On Tue, May 30, 2017 at 06:04:45PM +0200, Laurent Vivier wrote:
>> For QEMU, a hotlugged device is a device added using the HMP/QMP
>> interface.
>> For SPAPR, a hotplugged device is a device added while the
>> machine is running. In this case QEMU doesn't update internal
>> state but relies on the OS for this part
>>
>> In the case of migration, when we (libvirt) hotplug a device
>> on the source guest, we (libvirt) generally hotplug the same
>> device on the destination guest. But in this case, the machine
>> is stopped (RUN_STATE_INMIGRATE) and QEMU must not expect
>> the OS will manage it as an hotplugged device as it will
>> be "imported" by the migration.
>>
>> This patch changes the meaning of "hotplugged" in spapr.c
>> to manage a QEMU hotplugged device like a "coldplugged" one
>> when the machine is awaiting an incoming migration.
>>
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> 
> So, I think this is a reasonable concept, at least in terms of
> cleanliness and not doing unnecessary work.  However, if it's fixing
> bugs, I suspect that means we still have problems elsewhere.
> 
> Specifically, what is it we're doing before the incoming migration
> that's breaking things.  Even if it's unnecessary, anything done there
> should be overwritten by the incoming stream.  That should certainly
> be the case (now) for the DRC state variables.  Maybe not for the
> queued hotplug events - but that means we should update the queue
> migration to make sure we clear anything existing on the destination
> before adding migrated events.
> 
> I'm also concerned by the fact that this makes changes for memory and
> cpu hotplug, but not for PCI devices.  Why aren't they also affected
> by this problem?

There are some specific tests for PCI that change the behavior.

For instance, see hw/ppc/spapr_drc.c,

set_allocation_state()

151     if (drc->type != SPAPR_DR_CONNECTOR_TYPE_PCI) {
152         drc->allocation_state = state;
153         if (drc->awaiting_release &&
154             drc->allocation_state == SPAPR_DR_ALLOCATION_STATE_UNUSABLE) {
155             trace_spapr_drc_set_allocation_state_finalizing(get_index(drc));
156             drck->detach(drc, DEVICE(drc->dev), drc->detach_cb,
157                          drc->detach_cb_opaque, NULL);
158         } else if (drc->allocation_state == SPAPR_DR_ALLOCATION_STATE_USABLE) {
159             drc->awaiting_allocation = false;
160         }
161     }

attach():

394     drc->signalled = (drc->type != SPAPR_DR_CONNECTOR_TYPE_PCI)
395                      ? true : coldplug;
396 
397     if (drc->type != SPAPR_DR_CONNECTOR_TYPE_PCI) {
398         drc->awaiting_allocation = true;
399     }
400 

detach()

442     if (drc->type != SPAPR_DR_CONNECTOR_TYPE_PCI &&
443         drc->allocation_state != SPAPR_DR_ALLOCATION_STATE_UNUSABLE) {
444         trace_spapr_drc_awaiting_unusable(get_index(drc));
445         drc->awaiting_release = true;
446         return;
447     }

and more...

> 
> One nit in the implementation, see below:

I agree, will fix.

Thanks,
Laurent
