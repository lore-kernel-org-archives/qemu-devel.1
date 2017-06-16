Received: from eggs.gnu.org ([2001:4830:134:3::10]:59748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dLrgh-0005tf-P2
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 09:53:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dLrge-0004QD-J1
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 09:53:23 -0400
Date: Fri, 16 Jun 2017 15:53:12 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170616155312.623f859e@nial.brq.redhat.com>
In-Reply-To: <149748643237.3448.7122634958390452661@loki>
References: <20170530160445.12810-1-lvivier@redhat.com>
	<20170531043557.GI12163@umbus.fritz.box>
	<149695205346.23353.3484869110998357783@loki>
	<20170609102733.0eb7293d@nial.brq.redhat.com>
	<149739016562.5725.6958577924052221756@loki>
	<20170614110001.7816209b@nial.brq.redhat.com>
	<149748643237.3448.7122634958390452661@loki>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

On Wed, 14 Jun 2017 19:27:12 -0500
Michael Roth <mdroth@linux.vnet.ibm.com> wrote:

> Quoting Igor Mammedov (2017-06-14 04:00:01)
> > On Tue, 13 Jun 2017 16:42:45 -0500
> > Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> >   
> > > Quoting Igor Mammedov (2017-06-09 03:27:33)  
[...]

> > Currently I'd suggest to look into always migrate DRCs if cpu hotplug
> > is enabled even if dev->hotplugged is false (not nice but it might work).
> > Consider:
> >   SRC1: hotplug CPU1 => CPU1.hotplugged = true
> >   DST1: -device CPU1 => CPU1.hotplugged = false
> > so in current code relying on CPU1.hotplugged would not work as expected,
> > it works by accident because libvirt uses device_add on target
> >   DST1: device_add CPU1 => CPU1.hotplugged = true  
> 
> It's actually the reverse for us, DST1: -device CPU1 works, because
> default DRC state for CPU1.hotplugged = false matches the state a
> hotplugged CPU will be brought to after onlining at the source, so
> we don't send it over the wire in the first place once it reaches
> that post-hotplug/coldplug state. So things work as expected, even
> though technically the source has dev->hotplugged == true, whereas
> the dest has dev->hotplugged == false.
in your case it seems fragile to rely on -device setting hotplugged cpu
on target the way you want.

it could be:

SRC: hotplug CPU and start migration with DST: -device cpu[,hotplugged=false]
  *: machine is in hotplugging state and one would lose transitional state if DRC is not migrated.
 
> It's the DST1: device_add case that wasn't accounted for when the DRC
> migration patches were written, as those don't default to coldplug,
> so, because the source doesn't send it, it ends up being presented
> in pre-hotplug state because the dest doesn't know that the guest
> already onlined the resource and transitioned it to
> post-hotplug/coldplug state. Ironically, dev->hotplugged
> is true on both source and dest in this case, but it ends up being
> the broken one.
it looks like for hotplugged CPUs DRC state should be always migrated


> But your point stands, the fact that both situations are possible
> means we can't currently rely on dev->hotplugged without migrating
> it, infering it based on QEMU lifecycle, or forcing management to
> set it.
> 
> But that raises a 2nd point. Our dilemma isn't that we can't
> rely on dev->hotplugged being synchronized (though if it
> was we could build something around that), our dilemma is
> that we make the following assumption in our code:
> 
> "Devices present at start-time will be handled the same way,
> on source or dest, regardless of whether they were added via
> cmdline or via device_add prior to machine start / migration
> stream processing."
> 
> And I think that's a sensible expectation, since in theory
> even the source could build up a machine via device_add
> prior to starting it, and the reasonable default there is
> dev->hotplugged = false rather than the opposite. That
> suggests a need to fix things outside of migration.
Agreed to a degree, i.e.

  -device/device_add before machine has been started
without migration should follow coldplug path

it shouldn't cause problems for CPU/mem hotplug on x86
and maybe will work for PCI (it may change behavior of
ACPI based hotplug and bridges),
CCing Marcel to confirm.


> So far, all QEMU's existing migration code has managed ok
> with the dest being starting with dev->hotplugged == false
> via cmdline devices, even though maybe they were hotplugged
> on the source. To me, it makes more sense to maintain this
> behavior by fixing up this relatively new use-case of
> adding devices via device_add before start to match the
> same expectations we have around cmdline-specified devices.
> 
> This would fix migration for spapr, leave it working for
> everyone else (since that's basically what we expect for
> everything except newer-style cpu hotplug), and also make
> the device-add-before-start be truly synonymous with
> cmdline-created devices (which is applicable even outside
> of migration).
Neither -device or device_add can't really bring DRC/CPU into
the state that devices might be at the moment when their state
is transferred to target.

i.e. any state that has been changed after -device/device_add
on SRC, should be in migration stream. I'd say even if state would
eventually go back default (coldplugged) when hotplug is completed.
So trying to avoid transmitting runtime state to optimize some bytes
on migration stream is just asking for trouble.

[...]
> > 
> > May be we should
> >  1. make DeviceState:hotpluggable property write-able again
> >  2. transmit DeviceState:hotpluggable as part of migration stream
> >  3. add generic migration hook which will check if target and
> >     source value match, if value differs => fail/abort migration.
> >  4. in case values mismatch mgmt will be forced to explicitly
> >     provide hotplugged property value on -device/device_add
> > That would enforce consistent DeviceState:hotpluggable value
> > on target and source.
> > We can enforce it only for new machine types so it won't break
> > old mgmt tools with old machine types but would force mgmt
> > for new machines to use hotplugged property on target
> > so QEMU could rely on its value for migration purposes.
> >   
> 
> That would work, and generalizing this beyond spapr seems
> appropriate.
> 
> It also has reasonable semantics, and it would work for us
> *provided that* we always send DRC state for hotplugged devices
> and not just DRCs in a transitional state:
> 
> SRC1: device_add $cpu
>  -> dev->hotplugged == true
>  -> device starts in pre-hotplug, ends up in post-hotplug state  
>     after guest onlines it
> <migrate>
> DST1: device_add $cpu,hotplugged=true
>  -> dev->hotplugged == true
>  -> device starts in pre-hotplug state. guest sends updated state  
>     to transition DRC to post-hotplug
> 
> But what about stuff like mem/pci? Currently, migration works for
> cases like:
> 
> SRC1: device_add virtio-net-pci
> DST1: qemu -device virtio-net-pci
> 
> Even though DST1 has dev->hotplugged == false, and SRC1 has the
> opposite. So for new machines, checking SRC1:dev->hotplugged ==
> DST1:dev->hotplugged would fail, even though the migration
> scenario is unchanged from before.
> 
> So management would now have to do:
> 
> SRC1: device_add virtio-net-pci
> DST1: qemu -device virtio-net-pci,hotplugged=true
> 
> But the code behavior is a bit different then, since we now get
> an ACPI hotplug event via the hotplug handler. Maybe the
> migration stream fixes that up for us, but I think we would need
> to audit this and similar cases to be sure.
> 
> That's all fine if it's necessary, but I feel like this is
> the hard way to address what's actually a much more specific
> issue: that device_add before machine-start doesn't currently
> match the behavior for a device started via cmdline. i.e.
> dev->hotplugged in the former vs. !dev->hotplugged in the
> latter. I don't really see a good reason these 2 cases should
> be different, and we can bring them to parity by doing
> something like:
> 
> 1. For device_adds after qdev_machine_creation_done(), but
>    before machine start, set a flag: reset_before_start.
> 2. At the start of processing migration stream, or unpausing
>    a -S guest (in the non-migration case), issue a system-wide
>    reset if reset_before_start is set.
> 3. reset handlers will already unset dev->hotplugged at that
>    point and re-execute all the hotplug hooks with
>    dev->hotplugged == false. This should put everything in
>    a state that's identical to cmdline-created devices.
instead of flag for non migration case we could use
 RUN_STATE_PRELAUNCH -> RUN_STATE_RUNNING
transition to reset all devices or
maybe do something like this:

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 0ce45a2..cdeb8f8 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c

@@ -1020,7 +1010,7 @@ static void device_initfn(Object *obj)
     ObjectClass *class;
     Property *prop;
 
-    if (qdev_hotplug) {
+    if (runstate_check(RUN_STATE_RUNNING) || ...) {
         dev->hotplugged = 1;
         qdev_hot_added = true;
     }

> 4. Only allow management to do device_add before it sends
>    the migration stream (if management doesn't already guard
>    against this then it's probably a bug anyway)
seems like Juan already took care of it.

> This allows management to treat device_add/cmdline as being
> completely synonymous for guests that haven't started yet,
> both for -incoming and -S in general, and it maintains
> the behavior that existing migration code expects of
> cmdline-specified devices.
