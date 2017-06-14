Received: from eggs.gnu.org ([2001:4830:134:3::10]:42285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dL4Z6-0001K1-16
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 05:26:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dL4Z2-0005NB-0P
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 05:26:16 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170614110001.7816209b@nial.brq.redhat.com> (Igor Mammedov's
	message of "Wed, 14 Jun 2017 11:00:01 +0200")
References: <20170530160445.12810-1-lvivier@redhat.com>
	<20170531043557.GI12163@umbus.fritz.box>
	<149695205346.23353.3484869110998357783@loki>
	<20170609102733.0eb7293d@nial.brq.redhat.com>
	<149739016562.5725.6958577924052221756@loki>
	<20170614110001.7816209b@nial.brq.redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 14 Jun 2017 11:26:08 +0200
Message-ID: <87y3suex8v.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Igor Mammedov <imammedo@redhat.com> wrote:
> On Tue, 13 Jun 2017 16:42:45 -0500
> Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
>
>> Quoting Igor Mammedov (2017-06-09 03:27:33)
>> > On Thu, 08 Jun 2017 15:00:53 -0500
>> > Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
>> >   
>> > > Quoting David Gibson (2017-05-30 23:35:57)  
>> > > > On Tue, May 30, 2017 at 06:04:45PM +0200, Laurent Vivier wrote:    
>> > > > > For QEMU, a hotlugged device is a device added using the HMP/QMP
>> > > > > interface.
>> > > > > For SPAPR, a hotplugged device is a device added while the
>> > > > > machine is running. In this case QEMU doesn't update internal
>> > > > > state but relies on the OS for this part
>> > > > > 
>> > > > > In the case of migration, when we (libvirt) hotplug a device
>> > > > > on the source guest, we (libvirt) generally hotplug the same
>> > > > > device on the destination guest. But in this case, the machine
>> > > > > is stopped (RUN_STATE_INMIGRATE) and QEMU must not expect
>> > > > > the OS will manage it as an hotplugged device as it will
>> > > > > be "imported" by the migration.
>> > > > > 
>> > > > > This patch changes the meaning of "hotplugged" in spapr.c
>> > > > > to manage a QEMU hotplugged device like a "coldplugged" one
>> > > > > when the machine is awaiting an incoming migration.
>> > > > > 
>> > > > > Signed-off-by: Laurent Vivier <lvivier@redhat.com>    
>> > > > 
>> > > > So, I think this is a reasonable concept, at least in terms of
>> > > > cleanliness and not doing unnecessary work.  However, if it's fixing
>> > > > bugs, I suspect that means we still have problems elsewhere.    
>> > > 
>> > > I was hoping a lot of these issues would go away once we default
>> > > the initial/reset DRC states to "coldplugged". I think your pending
>> > > patch:
>> > > 
>> > >   "spapr: Make DRC reset force DRC into known state"
>> > > 
>> > > But I didn't consider the fact that libvirt will be issuing these
>> > > hotplugs *after* reset, so those states would indeed need to
>> > > be fixed up again to reflect boot-time,attached as opposed to
>> > > boot-time,unattached before starting the target.
>> > > 
>> > > So I do think this patch addresses a specific bug that isn't
>> > > obviously fixable elsewhere.
>> > > 
>> > > To me it seems like the only way to avoid doing something like
>> > > what this patch does is to migrate all attached DRCs from the
>> > > source in all cases.
>> > > 
>> > > This would break backward-migration though, unless we switch from
>> > > using subregions for DRCs to explicitly disabling DRC migration
>> > > based on machine type.  
>> > we could leave old machines broken and fix only new machine types,
>> > then it would be easy ot migrate 'additional' DRC state as subsection
>> > only on new for new machines.  
>> 
>> That's an option, but subsections were only really used for backward
>> compatibility. Not sure how much we have to gain from using both.
> If I remember correctly subsections could be/are used for forward compat stuff
> i.e. subsection is generated on source side when .needed callback returns
> true and destinations will just consume whatever data were sent
> without looking at .need callback. So source could generate extra
> DRC subsection when cpu hotplug is enabled for new machine types,
> ex: f816a62daa
>
> adding David/Juan to CC list to correct me if I'm wrong.

Yeap.  subsections are used when we know that we have missed some data
(or we need some more data for some other reason).

If the data would have been required always, we would have detected
before.  So subsections allows us to remain compatible, if needed()
returns false, we are compatible with old version, and if it returns
true, we send the additional data because we know that it is needed.

So  we have the following cases:

old-qemu  -> old-qemu
   will work as before
   if "needed" data is required, migration fails
old-qemu -> new-qemu
   identical to previous
new-qemu -> new-qemu
   subsection is sent when nededed
new-qemu -> old-qemu
   subsection is sent if it is neded, and then it breaks migration
   but we know that it would have failed anyways.
new-qemu -M old-machine-type -> new-qemu -M old-machine-type
   we sent and recognize the new subsection if it is required
   so, even with old machine types, if the qemus are new, we do the
   right thing.

This is how subsections are supposed to work.  I haven't investigated
your particular problem or set of patches, if you need help here, please
ask.

Later, Juan.
