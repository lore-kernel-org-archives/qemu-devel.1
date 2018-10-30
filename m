Received: from eggs.gnu.org ([2001:4830:134:3::10]:56019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gHVki-0005RZ-8e
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:16:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gHVkb-0005qG-VC
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:16:19 -0400
Date: Tue, 30 Oct 2018 16:15:52 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181030161552.073b6f6a@redhat.com>
In-Reply-To: <9d503a8b-5847-a1ae-2d2c-a2d1f0e7ac95@redhat.com>
References: <1539696820-273275-1-git-send-email-imammedo@redhat.com>
	<20181016155600.31de8883@redhat.com>
	<9d503a8b-5847-a1ae-2d2c-a2d1f0e7ac95@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH] call HotplugHandler->plug()
 as the last step in device realization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, cohuck@redhat.com, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, stefanha@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au

On Wed, 24 Oct 2018 15:09:36 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 16.10.18 15:56, Igor Mammedov wrote:
> > On Tue, 16 Oct 2018 15:33:40 +0200
> > Igor Mammedov <imammedo@redhat.com> wrote:
> >   
> >> When [2] was fixed it was agreed that adding and calling post_plug()
> >> callback after device_reset() was low risk approach to hotfix issue
> >> right before release. So it was merged instead of moving already
> >> existing plug() callback after device_reset() is called which would
> >> be more risky and require all plug() callbacks audit.
> >>
> >> Looking at the current plug() callbacks, it doesn't seem that moving
> >> plug() callback after device_reset() is breaking anything, so here
> >> goes agreed upon [3] proper fix which essentially reverts [1][2]
> >> and moves plug() callback after device_reset().
> >> This way devices always comes to plug() stage, after it's been fully
> >> initialized (including being reset), which fixes race condition [2]
> >> without need for an extra post_plug() callback.
> >>
> >>  1. (25e897881 "qdev: add HotplugHandler->post_plug() callback")
> >>  2. (8449bcf94 "virtio-scsi: fix hotplug ->reset() vs event race")
> >>  3. https://www.mail-archive.com/qemu-devel@nongnu.org/msg549915.html
> >>
> >> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> >> ---
> >> TODO:
> >>  remove usage of Error** from plug() callback, we need to factor out
> >>  pre_plug part from plug() callbacks, before proceeding with it.
> >>  DavidH has recently finished it for pc-dimm/memory_devices, cpus
> >>  mostly have pre_plug parts factored out, but there still are parts
> >>  that could fail so it needs some more work to eliminate failure points
> >>  from plug() callbacks. Meanwhile, I'll plan to treat other misc
> >>  handlers (pci[e]/acpi/usb/...) and introduce pre_plug() where
> >>  necessary.  
> 
> Saw this mail just now. I guess we should do more. Especially what seems
> to be fragile is errors during unrealize() and unplug().
> 
> Errors during unplug() should only ever happen if it was not triggered
> via unplug_request(). Otherwise, unplug_request() should check for all
> possible errors and unplug() will not result in errors.
Not sure that I read it right, I see 2 cases:
 1: unplug_request == NULL (i.e. where surprise device removal is supported)
     should not fail
 2: unplug_request != NULL && unplug() is called by guest side, it's caller
    policy to decide what to do on failure. One use case is NOP, i.e. caller
    should not destroy object if unplug() fails and unplug() should fail without
    side effects, and possibly notify guest about it if such mechanism is supported.
    Could be tricky to handle errors in case of chained handlers.


> Also, errors during unrealize() should definitely be avoided. Or even
> forbidden. E.g. looking at hw/core/qdev.c:device_set_realized,
> 
> 1. failing to unrealize might already have resulted in the unplug
> handler getting called.
> 2. will result in a unparent of the device and therefore removal
> 3. will have already eventually unrealized child devices or buses.
> 
> To summarize, failing in unrealize() is a bad idea and might leave the
> rest of the system in a very unpredictable state.
failure path isn't really usable here, I'd assume that initial idea
was that unrealize() could fail cleanly and let caller to decide on
what to do. But with child bus handling and co it won't really work.

BTW what devices are the users of DeviceState::child_bus,
I don't think that we have any composite devices that actually
exercise realize() part of it and maybe unrealize() part.

...
