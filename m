Received: from eggs.gnu.org ([2001:4830:134:3::10]:40534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1g8Lts-0006DX-Vp
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 04:55:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1g8Ltp-0001xS-LE
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 04:55:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1g8Ltn-0001vV-5X
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 04:55:51 -0400
Date: Fri, 5 Oct 2018 10:55:46 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181005105546.5ceb5a71@redhat.com>
In-Reply-To: <20181004132112-mutt-send-email-mst@kernel.org>
References: <CAEJ3UntstF2hsn11MrcoMqb7_JMOxs9GRiALF==S6o2aMpAAeg@mail.gmail.com>
	<20181004135721.0223f3dc@redhat.com>
	<20181004132112-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] ACPI PCI hotplug table updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, open sorcerer <0p3n.s0rc3r3r@gmail.com>

On Thu, 4 Oct 2018 13:24:40 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Oct 04, 2018 at 01:57:21PM +0200, Igor Mammedov wrote:
> > On Wed, 3 Oct 2018 10:44:20 -0700
> > open sorcerer <0p3n.s0rc3r3r@gmail.com> wrote:
> >   
> > > Hi,
> > > 
> > > I am digging into an issue where qmp_device_del does not actually delete
> > > devices when a guest OS is in prelaunch. This seems to be due to the guest
> > > OS not handling ACPI events because it is not currently running. If I
> > > assume correctly, qmp should allow you to add/remove devices while the host
> > > is down, or if not possible, publish an error message.  
> > may I ask why one would delete a device at -S pause point, isn't it easier
> > to start QEMU without it, to begin with?
> >   
> > > I think fixing this issue is as simple as making sure that the VM is in a
> > > safe state to ignore the hotplug ACPI dance but eject the disk, something
> > > like:  
> > in prelaunch runstate where '-S' option pauses VM, it is practically paused
> > at the first instruction to be executed. So device_add at that point is
> > considered as hotplug with all actions already executed on hardware level
> > (interrupts sent, devices responsible for hotplug handling has changed state).
> > So if one wished to delete device at that point, one would have to rollback
> > related state changes.
> > If one would additionally use -incoming CLI option, it becomes more complicated
> > as we might endup in prelaunch runstate with VM in running state
> > (see possible transitions in runstate_transitions_def[])
> > I'd say prelauch runstate can't be used for removing devices that do not
> > support surprise removal (in our case PCI isn't).  
> 
> I'd say the point is this. In prelaunch guest did not observe any
> device state yet, we could make device_add look just like
> a non-hotplugged device. And we could make device_del pretend
> there was a reset immediately afterwards.
> 
> Not sure why it matters to anyone, but it's doable I think.
in case we came to prelaunch from freshly started QEMU with -S
and no other disrupting things in between /migration, chekpointing, .../
it's theoretically possible.

However even then to make a clean device_del in that state for
devices that expect guest cooperation, one would need chain
unplug_request (which is what device_del translates to) with
whatever hotunplug hw is used and simulate guest unplugging it. 

And then on top we might need to rebuild/reload firmware tables
(ARM) (x86 should work as it will rebuild ACPI tables on the
first access). In generic case we might need to fixup something
else elsewhere.

When I looked into early numa configuration, I've failed to
convince myself that using prelaunch, changing its semantics to
coldplug and fixing up already built machine as safe/robust thing
to do.(Resulted prelaunch based RFC even worked fine, but I
wouldn't bet it wouldn't fall apart or in all other combinations
prelaunch runstate could be reached)

As result we ended up with new preconfig option/runstate where to
we can gradually move machine building steps. One possible way
to deal with subject would be queue at preconfig stage -device/device_add
and use this queue later to add devices to board (not sure
if it's a sound idea in general).
This early it should be possible to remove a device from queue.
But why one would add device and immediately remove it ... :/
