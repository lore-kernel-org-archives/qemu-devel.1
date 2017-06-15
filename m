Received: from eggs.gnu.org ([2001:4830:134:3::10]:47388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dLIio-0003MB-OQ
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 20:33:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dLIij-0004kb-Mw
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 20:33:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60286)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dLIij-0004k8-E2
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 20:33:09 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5F0TW55146965
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 20:33:06 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2b3dpxm16m-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 20:33:06 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Jun 2017 18:33:05 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170614110001.7816209b@nial.brq.redhat.com>
References: <20170530160445.12810-1-lvivier@redhat.com>
	<20170531043557.GI12163@umbus.fritz.box>
	<149695205346.23353.3484869110998357783@loki>
	<20170609102733.0eb7293d@nial.brq.redhat.com>
	<149739016562.5725.6958577924052221756@loki>
	<20170614110001.7816209b@nial.brq.redhat.com>
Date: Wed, 14 Jun 2017 19:27:12 -0500
Message-Id: <149748643237.3448.7122634958390452661@loki>
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

Quoting Igor Mammedov (2017-06-14 04:00:01)
> On Tue, 13 Jun 2017 16:42:45 -0500
> Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> =

> > Quoting Igor Mammedov (2017-06-09 03:27:33)
> > > On Thu, 08 Jun 2017 15:00:53 -0500
> > > Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> > >   =

> > > > Quoting David Gibson (2017-05-30 23:35:57)  =

> > > > > On Tue, May 30, 2017 at 06:04:45PM +0200, Laurent Vivier wrote:  =
  =

> > > > > > For QEMU, a hotlugged device is a device added using the HMP/QMP
> > > > > > interface.
> > > > > > For SPAPR, a hotplugged device is a device added while the
> > > > > > machine is running. In this case QEMU doesn't update internal
> > > > > > state but relies on the OS for this part
> > > > > > =

> > > > > > In the case of migration, when we (libvirt) hotplug a device
> > > > > > on the source guest, we (libvirt) generally hotplug the same
> > > > > > device on the destination guest. But in this case, the machine
> > > > > > is stopped (RUN_STATE_INMIGRATE) and QEMU must not expect
> > > > > > the OS will manage it as an hotplugged device as it will
> > > > > > be "imported" by the migration.
> > > > > > =

> > > > > > This patch changes the meaning of "hotplugged" in spapr.c
> > > > > > to manage a QEMU hotplugged device like a "coldplugged" one
> > > > > > when the machine is awaiting an incoming migration.
> > > > > > =

> > > > > > Signed-off-by: Laurent Vivier <lvivier@redhat.com>    =

> > > > > =

> > > > > So, I think this is a reasonable concept, at least in terms of
> > > > > cleanliness and not doing unnecessary work.  However, if it's fix=
ing
> > > > > bugs, I suspect that means we still have problems elsewhere.    =

> > > > =

> > > > I was hoping a lot of these issues would go away once we default
> > > > the initial/reset DRC states to "coldplugged". I think your pending
> > > > patch:
> > > > =

> > > >   "spapr: Make DRC reset force DRC into known state"
> > > > =

> > > > But I didn't consider the fact that libvirt will be issuing these
> > > > hotplugs *after* reset, so those states would indeed need to
> > > > be fixed up again to reflect boot-time,attached as opposed to
> > > > boot-time,unattached before starting the target.
> > > > =

> > > > So I do think this patch addresses a specific bug that isn't
> > > > obviously fixable elsewhere.
> > > > =

> > > > To me it seems like the only way to avoid doing something like
> > > > what this patch does is to migrate all attached DRCs from the
> > > > source in all cases.
> > > > =

> > > > This would break backward-migration though, unless we switch from
> > > > using subregions for DRCs to explicitly disabling DRC migration
> > > > based on machine type.  =

> > > we could leave old machines broken and fix only new machine types,
> > > then it would be easy ot migrate 'additional' DRC state as subsection
> > > only on new for new machines.  =

> > =

> > That's an option, but subsections were only really used for backward
> > compatibility. Not sure how much we have to gain from using both.
> If I remember correctly subsections could be/are used for forward compat =
stuff
> i.e. subsection is generated on source side when .needed callback returns
> true and destinations will just consume whatever data were sent
> without looking at .need callback. So source could generate extra
> DRC subsection when cpu hotplug is enabled for new machine types,
> ex: f816a62daa

Well, what I was thinking was that if we dropped the approach of basing
.needed around "is this DRC in a transitional state?" (which can only
be determined on the source) in favor of "if (dev->hotplugged)", we
could possible get away with a non-subsection VMSD. But you're right,
unless we can ensure dev->hotplugged is sychronized on both source
and dest, we might still need to use a subsection regardless. *Unless*
we just migrate all DRCs indiscriminately...

> =

> adding David/Juan to CC list to correct me if I'm wrong.

Thanks Juan and David for clarifying.

> =

> > > > That approach seems to similar to what x86 does, e.g.
> > > > hw/acpi/ich9.c and hw/acpi/piix.c migrate vmstate_memhp_state
> > > > (corresponding to all DIMMs' slot status) in all cases where
> > > > memory hotplug is enabled. If they were to do this using
> > > > subregions for DIMMs in a transitional state I think similar
> > > > issues would pop up in that code as well.
> > > > =

> > > > Even if we take this route, we still need to explicitly suppress
> > > > hotplug events during INMIGRATE to avoid extra events going on
> > > > the queue. *Unless* we similarly rely purely on the ones sent by
> > > > the source.  =

> > > pc/q35 might also lose events if device is hotplugged during migratio=
n,
> > > in addition migration would fail anyway since dst qemu
> > > should be launched with all devices that are present on src.
> > > =

> > > ex: consider if one hotplugs DIMM during migration, it creates
> > > RAM region mapped into guest and that region might be transferred
> > > as part of VMState (not sure if it even works)
> > > and considering dst qemu has no idea about hotplugged memory mapping,
> > > the migration would fail on receiving unknown VMState.
> > > =

> > > Hotplug generally doesn't work during migration, so it should be disa=
bled
> > > in a generic way on migration start and re-enabled on target
> > > on migration completion. How about blocking device_add when
> > > INMIGRATE state and unblocking it when switching to runnig on dst?  =

> > =

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

Ok, looks like that works because the all the CPU/ACPI hotplug state
is always migrated for newer machines. So we could do similar in our
case for DRCs, and that would work, but in our case that's not quite
ideal since we generally have a few hundred DRCs for a normal guest.
It's maybe 8KB of data so it's not a huge deal, but it would be nice
if we could avoid that. If we start having larger guests with
multiple PHBs that could be an issue though, since we have 32*8 DRCs
per PHB (and there's been some talk on having libvirt default to
starting spapr guests with multiple PHBs (possibly the max) to deal
with some limitations around hotplug for passthrough devices, so
even if we don't have any passthrough devices attached we'd still
have to deal with these DRCs if we take this approach).

> =

> =

> > If the CPUs were all specified via command-line, I don't think these
> > patches would be needed, since the coldplug hooks would be executed
> > without the need to make any special considerations for INMIGRATE.
> I don't think that it's libvirt's problem, user if free to use either
> -device or device_add to add devices on target side.
> =

> We might re-enable writing to hotplugged property (36cccb8c5)
> and ask mgmt to set its value on target but that would not work
> fine for old mgmt tools.
> Perhaps we should migrate DeviceState::hotplugged property state
> as part of every device so that target could fixup device state
> according to its value, but I'm not sure if it is useful.
> =

> =

> > This libvirt commit seems to confirm that the CPUs are added via
> > device_add, and we've seen similar behavior in our testing:
> > =

> > =

> > commit 9eb9106ea51b43102ee51132f69780b2c86ccbca
> > Author: Peter Krempa <pkrempa@redhat.com>
> > Date:   Thu Aug 4 14:36:24 2016 +0200
> > =

> >     qemu: command: Add support for sparse vcpu topologies
> >     =

> >     Add support for using the new approach to hotplug vcpus using devic=
e_add
> >     during startup of qemu to allow sparse vcpu topologies.
> >     =

> >     There are a few limitations imposed by qemu on the supported
> >     configuration:
> >     - vcpu0 needs to be always present and not hotpluggable
> >     - non-hotpluggable cpus need to be ordered at the beginning
> >     - order of the vcpus needs to be unique for every single hotpluggab=
le
> >       entity
> >     =

> >     Qemu also doesn't really allow to query the information necessary to
> >     start a VM with the vcpus directly on the commandline. Fortunately =
they
> >     can be hotplugged during startup.
> >     =

> >     The new hotplug code uses the following approach:
> >     - non-hotpluggable vcpus are counted and put to the -smp option
> >     - qemu is started
> >     - qemu is queried for the necessary information
> >     - the configuration is checked
> >     - the hotpluggable vcpus are hotplugged
> >     - vcpus are started
> >     =

> >     This patch adds a lot of checking code and enables the support to
> >     specify the individual vcpu element with qemu.
> > =

> > =

> > So I don't think disabling migration during inmigrate is a possible
> > alternative unless we rework how libvirt handles this. The only
> > alternative to this patch that I'm aware of would be to always
> > migrate DRCs when dev->hotplugged =3D=3D true.
> Currently I'd suggest to look into always migrate DRCs if cpu hotplug
> is enabled even if dev->hotplugged is false (not nice but it might work).
> Consider:
>   SRC1: hotplug CPU1 =3D> CPU1.hotplugged =3D true
>   DST1: -device CPU1 =3D> CPU1.hotplugged =3D false
> so in current code relying on CPU1.hotplugged would not work as expected,
> it works by accident because libvirt uses device_add on target
>   DST1: device_add CPU1 =3D> CPU1.hotplugged =3D true

It's actually the reverse for us, DST1: -device CPU1 works, because
default DRC state for CPU1.hotplugged =3D false matches the state a
hotplugged CPU will be brought to after onlining at the source, so
we don't send it over the wire in the first place once it reaches
that post-hotplug/coldplug state. So things work as expected, even
though technically the source has dev->hotplugged =3D=3D true, whereas
the dest has dev->hotplugged =3D=3D false.

It's the DST1: device_add case that wasn't accounted for when the DRC
migration patches were written, as those don't default to coldplug,
so, because the source doesn't send it, it ends up being presented
in pre-hotplug state because the dest doesn't know that the guest
already onlined the resource and transitioned it to
post-hotplug/coldplug state. Ironically, dev->hotplugged
is true on both source and dest in this case, but it ends up being
the broken one.

But your point stands, the fact that both situations are possible
means we can't currently rely on dev->hotplugged without migrating
it, infering it based on QEMU lifecycle, or forcing management to
set it.

But that raises a 2nd point. Our dilemma isn't that we can't
rely on dev->hotplugged being synchronized (though if it
was we could build something around that), our dilemma is
that we make the following assumption in our code:

"Devices present at start-time will be handled the same way,
on source or dest, regardless of whether they were added via
cmdline or via device_add prior to machine start / migration
stream processing."

And I think that's a sensible expectation, since in theory
even the source could build up a machine via device_add
prior to starting it, and the reasonable default there is
dev->hotplugged =3D false rather than the opposite. That
suggests a need to fix things outside of migration.

So far, all QEMU's existing migration code has managed ok
with the dest being starting with dev->hotplugged =3D=3D false
via cmdline devices, even though maybe they were hotplugged
on the source. To me, it makes more sense to maintain this
behavior by fixing up this relatively new use-case of
adding devices via device_add before start to match the
same expectations we have around cmdline-specified devices.

This would fix migration for spapr, leave it working for
everyone else (since that's basically what we expect for
everything except newer-style cpu hotplug), and also make
the device-add-before-start be truly synonymous with
cmdline-created devices (which is applicable even outside
of migration).

> =

> If we try to fix it by migrating 'DeviceState::hotplugged' flag,
> we would need CPU/memory/machine specific migration hooks which will
> fix device/machine state as by the time migration stream is processed
> on target side, all devices are already wired up using -device or
> device_add paths (cold/hotplugged paths).
> Approach doesn't seem robust to me.

If we infer it on the target within qdev, without relying on
migration stream, maybe those fix-ups are less invasive.

And what about the non-migration case as mentioned above? Should
the source also be able to assume device_add-before-start matches
behavior for cmdline-specified devices?

> =

> May be we should
>  1. make DeviceState:hotpluggable property write-able again
>  2. transmit DeviceState:hotpluggable as part of migration stream
>  3. add generic migration hook which will check if target and
>     source value match, if value differs =3D> fail/abort migration.
>  4. in case values mismatch mgmt will be forced to explicitly
>     provide hotplugged property value on -device/device_add
> That would enforce consistent DeviceState:hotpluggable value
> on target and source.
> We can enforce it only for new machine types so it won't break
> old mgmt tools with old machine types but would force mgmt
> for new machines to use hotplugged property on target
> so QEMU could rely on its value for migration purposes.
> =


That would work, and generalizing this beyond spapr seems
appropriate.

It also has reasonable semantics, and it would work for us
*provided that* we always send DRC state for hotplugged devices
and not just DRCs in a transitional state:

SRC1: device_add $cpu
 -> dev->hotplugged =3D=3D true
 -> device starts in pre-hotplug, ends up in post-hotplug state
    after guest onlines it
<migrate>
DST1: device_add $cpu,hotplugged=3Dtrue
 -> dev->hotplugged =3D=3D true
 -> device starts in pre-hotplug state. guest sends updated state
    to transition DRC to post-hotplug

But what about stuff like mem/pci? Currently, migration works for
cases like:

SRC1: device_add virtio-net-pci
DST1: qemu -device virtio-net-pci

Even though DST1 has dev->hotplugged =3D=3D false, and SRC1 has the
opposite. So for new machines, checking SRC1:dev->hotplugged =3D=3D
DST1:dev->hotplugged would fail, even though the migration
scenario is unchanged from before.

So management would now have to do:

SRC1: device_add virtio-net-pci
DST1: qemu -device virtio-net-pci,hotplugged=3Dtrue

But the code behavior is a bit different then, since we now get
an ACPI hotplug event via the hotplug handler. Maybe the
migration stream fixes that up for us, but I think we would need
to audit this and similar cases to be sure.

That's all fine if it's necessary, but I feel like this is
the hard way to address what's actually a much more specific
issue: that device_add before machine-start doesn't currently
match the behavior for a device started via cmdline. i.e.
dev->hotplugged in the former vs. !dev->hotplugged in the
latter. I don't really see a good reason these 2 cases should
be different, and we can bring them to parity by doing
something like:

1. For device_adds after qdev_machine_creation_done(), but
   before machine start, set a flag: reset_before_start.
2. At the start of processing migration stream, or unpausing
   a -S guest (in the non-migration case), issue a system-wide
   reset if reset_before_start is set.
3. reset handlers will already unset dev->hotplugged at that
   point and re-execute all the hotplug hooks with
   dev->hotplugged =3D=3D false. This should put everything in
   a state that's identical to cmdline-created devices.
4. Only allow management to do device_add before it sends
   the migration stream (if management doesn't already guard
   against this then it's probably a bug anyway)

This allows management to treat device_add/cmdline as being
completely synonymous for guests that haven't started yet,
both for -incoming and -S in general, and it maintains
the behavior that existing migration code expects of
cmdline-specified devices.
