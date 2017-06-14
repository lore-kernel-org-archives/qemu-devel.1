Received: from eggs.gnu.org ([2001:4830:134:3::10]:55441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dL6xR-00066P-Am
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 07:59:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dL6xD-0003RY-Ct
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 07:59:33 -0400
Date: Wed, 14 Jun 2017 12:59:10 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170614115909.GC2687@work-vm>
References: <20170530160445.12810-1-lvivier@redhat.com>
	<20170531043557.GI12163@umbus.fritz.box>
	<149695205346.23353.3484869110998357783@loki>
	<20170609102733.0eb7293d@nial.brq.redhat.com>
	<149739016562.5725.6958577924052221756@loki>
	<20170614110001.7816209b@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170614110001.7816209b@nial.brq.redhat.com>
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Juan Quintela <quintela@redhat.com>

* Igor Mammedov (imammedo@redhat.com) wrote:
> On Tue, 13 Jun 2017 16:42:45 -0500
> Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> 
> > Quoting Igor Mammedov (2017-06-09 03:27:33)
> > > On Thu, 08 Jun 2017 15:00:53 -0500
> > > Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> > >   
> > > > Quoting David Gibson (2017-05-30 23:35:57)  
> > > > > On Tue, May 30, 2017 at 06:04:45PM +0200, Laurent Vivier wrote:    
> > > > > > For QEMU, a hotlugged device is a device added using the HMP/QMP
> > > > > > interface.
> > > > > > For SPAPR, a hotplugged device is a device added while the
> > > > > > machine is running. In this case QEMU doesn't update internal
> > > > > > state but relies on the OS for this part
> > > > > > 
> > > > > > In the case of migration, when we (libvirt) hotplug a device
> > > > > > on the source guest, we (libvirt) generally hotplug the same
> > > > > > device on the destination guest. But in this case, the machine
> > > > > > is stopped (RUN_STATE_INMIGRATE) and QEMU must not expect
> > > > > > the OS will manage it as an hotplugged device as it will
> > > > > > be "imported" by the migration.
> > > > > > 
> > > > > > This patch changes the meaning of "hotplugged" in spapr.c
> > > > > > to manage a QEMU hotplugged device like a "coldplugged" one
> > > > > > when the machine is awaiting an incoming migration.
> > > > > > 
> > > > > > Signed-off-by: Laurent Vivier <lvivier@redhat.com>    
> > > > > 
> > > > > So, I think this is a reasonable concept, at least in terms of
> > > > > cleanliness and not doing unnecessary work.  However, if it's fixing
> > > > > bugs, I suspect that means we still have problems elsewhere.    
> > > > 
> > > > I was hoping a lot of these issues would go away once we default
> > > > the initial/reset DRC states to "coldplugged". I think your pending
> > > > patch:
> > > > 
> > > >   "spapr: Make DRC reset force DRC into known state"
> > > > 
> > > > But I didn't consider the fact that libvirt will be issuing these
> > > > hotplugs *after* reset, so those states would indeed need to
> > > > be fixed up again to reflect boot-time,attached as opposed to
> > > > boot-time,unattached before starting the target.
> > > > 
> > > > So I do think this patch addresses a specific bug that isn't
> > > > obviously fixable elsewhere.
> > > > 
> > > > To me it seems like the only way to avoid doing something like
> > > > what this patch does is to migrate all attached DRCs from the
> > > > source in all cases.
> > > > 
> > > > This would break backward-migration though, unless we switch from
> > > > using subregions for DRCs to explicitly disabling DRC migration
> > > > based on machine type.  
> > > we could leave old machines broken and fix only new machine types,
> > > then it would be easy ot migrate 'additional' DRC state as subsection
> > > only on new for new machines.  
> > 
> > That's an option, but subsections were only really used for backward
> > compatibility. Not sure how much we have to gain from using both.
> If I remember correctly subsections could be/are used for forward compat stuff
> i.e. subsection is generated on source side when .needed callback returns
> true and destinations will just consume whatever data were sent
> without looking at .need callback. So source could generate extra
> DRC subsection when cpu hotplug is enabled for new machine types,
> ex: f816a62daa
> 
> adding David/Juan to CC list to correct me if I'm wrong.

Yes I think that's right; but note that the destination does have to
know about the subsection definition to consume it.
It can't consume a subsection sent by a newer qemu which it doesn't
have a definition of and so can't parse.

Dave

> > > > That approach seems to similar to what x86 does, e.g.
> > > > hw/acpi/ich9.c and hw/acpi/piix.c migrate vmstate_memhp_state
> > > > (corresponding to all DIMMs' slot status) in all cases where
> > > > memory hotplug is enabled. If they were to do this using
> > > > subregions for DIMMs in a transitional state I think similar
> > > > issues would pop up in that code as well.
> > > > 
> > > > Even if we take this route, we still need to explicitly suppress
> > > > hotplug events during INMIGRATE to avoid extra events going on
> > > > the queue. *Unless* we similarly rely purely on the ones sent by
> > > > the source.  
> > > pc/q35 might also lose events if device is hotplugged during migration,
> > > in addition migration would fail anyway since dst qemu
> > > should be launched with all devices that are present on src.
> > > 
> > > ex: consider if one hotplugs DIMM during migration, it creates
> > > RAM region mapped into guest and that region might be transferred
> > > as part of VMState (not sure if it even works)
> > > and considering dst qemu has no idea about hotplugged memory mapping,
> > > the migration would fail on receiving unknown VMState.
> > > 
> > > Hotplug generally doesn't work during migration, so it should be disabled
> > > in a generic way on migration start and re-enabled on target
> > > on migration completion. How about blocking device_add when
> > > INMIGRATE state and unblocking it when switching to runnig on dst?  
> > 
> > Maybe I'm misunderstanding the intent of this patch, but in our own
> > testing we've seen that even for CPUs hotplugged *before* migration
> > starts, libvirt will add them to the dest via device_add instead of
> > via the command-line.
> the way migration currently works, this behavior seems fine to me,
> whether hotplugged CPUs on target side are specified with -device or
> device_add, it shouldn't affect machine behavior. It doesn't in
> case of cpu for x86, where hotplug process state is
> migrated as VMSTATE_CPU_HOTPLUG subsection of piix4_pm/ich9
> device.
> 
> 
> > If the CPUs were all specified via command-line, I don't think these
> > patches would be needed, since the coldplug hooks would be executed
> > without the need to make any special considerations for INMIGRATE.
> I don't think that it's libvirt's problem, user if free to use either
> -device or device_add to add devices on target side.
> 
> We might re-enable writing to hotplugged property (36cccb8c5)
> and ask mgmt to set its value on target but that would not work
> fine for old mgmt tools.
> Perhaps we should migrate DeviceState::hotplugged property state
> as part of every device so that target could fixup device state
> according to its value, but I'm not sure if it is useful.
> 
> 
> > This libvirt commit seems to confirm that the CPUs are added via
> > device_add, and we've seen similar behavior in our testing:
> > 
> > 
> > commit 9eb9106ea51b43102ee51132f69780b2c86ccbca
> > Author: Peter Krempa <pkrempa@redhat.com>
> > Date:   Thu Aug 4 14:36:24 2016 +0200
> > 
> >     qemu: command: Add support for sparse vcpu topologies
> >     
> >     Add support for using the new approach to hotplug vcpus using device_add
> >     during startup of qemu to allow sparse vcpu topologies.
> >     
> >     There are a few limitations imposed by qemu on the supported
> >     configuration:
> >     - vcpu0 needs to be always present and not hotpluggable
> >     - non-hotpluggable cpus need to be ordered at the beginning
> >     - order of the vcpus needs to be unique for every single hotpluggable
> >       entity
> >     
> >     Qemu also doesn't really allow to query the information necessary to
> >     start a VM with the vcpus directly on the commandline. Fortunately they
> >     can be hotplugged during startup.
> >     
> >     The new hotplug code uses the following approach:
> >     - non-hotpluggable vcpus are counted and put to the -smp option
> >     - qemu is started
> >     - qemu is queried for the necessary information
> >     - the configuration is checked
> >     - the hotpluggable vcpus are hotplugged
> >     - vcpus are started
> >     
> >     This patch adds a lot of checking code and enables the support to
> >     specify the individual vcpu element with qemu.
> > 
> > 
> > So I don't think disabling migration during inmigrate is a possible
> > alternative unless we rework how libvirt handles this. The only
> > alternative to this patch that I'm aware of would be to always
> > migrate DRCs when dev->hotplugged == true.
> Currently I'd suggest to look into always migrate DRCs if cpu hotplug
> is enabled even if dev->hotplugged is false (not nice but it might work).
> Consider:
>   SRC1: hotplug CPU1 => CPU1.hotplugged = true
>   DST1: -device CPU1 => CPU1.hotplugged = false
> so in current code relying on CPU1.hotplugged would not work as expected,
> it works by accident because libvirt uses device_add on target
>   DST1: device_add CPU1 => CPU1.hotplugged = true
> 
> If we try to fix it by migrating 'DeviceState::hotplugged' flag,
> we would need CPU/memory/machine specific migration hooks which will
> fix device/machine state as by the time migration stream is processed
> on target side, all devices are already wired up using -device or
> device_add paths (cold/hotplugged paths).
> Approach doesn't seem robust to me.
> 
> May be we should
>  1. make DeviceState:hotpluggable property write-able again
>  2. transmit DeviceState:hotpluggable as part of migration stream
>  3. add generic migration hook which will check if target and
>     source value match, if value differs => fail/abort migration.
>  4. in case values mismatch mgmt will be forced to explicitly
>     provide hotplugged property value on -device/device_add
> That would enforce consistent DeviceState:hotpluggable value
> on target and source.
> We can enforce it only for new machine types so it won't break
> old mgmt tools with old machine types but would force mgmt
> for new machines to use hotplugged property on target
> so QEMU could rely on its value for migration purposes.
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
