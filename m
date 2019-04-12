Received: from eggs.gnu.org ([209.51.188.92]:60987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hF2Bw-0003od-6c
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 15:50:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hF2Bu-0002zN-SL
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 15:50:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49201)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hF2Bs-0002pJ-Sa
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 15:50:26 -0400
Date: Fri, 12 Apr 2019 16:50:15 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190412195015.GG31999@habkost.net>
References: <20190322134447.14831-1-jfreimann@redhat.com>
	<20190404082933.ke7tvryocpdd2h54@jenstp.localdomain>
	<20190405085628.GA2819@work-vm>
	<20190405191850-mutt-send-email-mst@kernel.org>
	<20190405234659.GJ7238@habkost.net>
	<87sgutjcef.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sgutjcef.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] implement the failover feature for
 assigned network devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, pkrempa@redhat.com, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, liran.alon@oracle.com, laine@redhat.com, ogerlitz@mellanox.com, Jens Freimann <jfreimann@redhat.com>, ailan@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Mon, Apr 08, 2019 at 07:26:16AM +0200, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
> 
> > On Fri, Apr 05, 2019 at 07:22:35PM -0400, Michael S. Tsirkin wrote:
> >> On Fri, Apr 05, 2019 at 09:56:29AM +0100, Dr. David Alan Gilbert wrote:
> >> > * Jens Freimann (jfreimann@redhat.com) wrote:
> >> > > On Fri, Mar 22, 2019 at 02:44:45PM +0100, Jens Freimann wrote:
> > [...]
> >> > > > 3. Management layer software should handle this. Open Stack already has
> >> > > >  components/code to handle unplug/replug VFIO devices and metadata to
> >> > > >  provide to the guest for detecting which devices should be paired.
> >> > > >  -> An approach that includes all software from firmware to
> >> > > >     higher-level management software wasn't tried in the last years. This is
> >> > > >     an attempt to keep it simple and contained in QEMU as much as possible.
> >> > > > 4. Hotplugging a device and then making it part of a failover setup is
> >> > > >   not possible
> >> > > >  -> addressed by extending qdev hotplug functions to check for hidden
> >> > > >     attribute, so e.g. device_add can be used to plug a device.
> >> > > > 
> >> > > > There are still some open issues:
> >> > > > 
> >> > > > Migration: I'm looking for something like a pre-migration hook that I
> >> > > > could use to unplug the vfio-pci device. I tried with a migration
> >> > > > notifier but it is called to late, i.e. after migration is aborted due
> >> > > > to vfio-pci marked unmigrateable. I worked around this by setting it
> >> > > > to migrateable and used a migration notifier on the virtio-net device.
> >> > 
> >> > Why not just let this happen at the libvirt level; then you do the
> >> > hotunplug etc before you actually tell qemu anything about starting a
> >> > migration?
> >> 
> >> If qemu frees up resources (as it does on unplug) then libvirt
> >> is not guaranteed it can roll the change back on e.g.
> >> migration failure.
> >
> > Why should we always free up resources on unplug?
> >
> > Unplug of a disk device doesn't close the corresponding -blockdev.
> 
> It does for block backends created with -drive, and that was a mistake
> we corrected with -blockdev.
> 
> > Unplug of a serial device doesn't close the corresponding -chardev.
> > Unplug of a memory device doesn't close the corresponding memory backend.
> > Unplug of a crypto device doesn't close the corresponding crypto backend.
> >
> > Why do we expect device_del of a passthrough PCI device to always
> > release the host side PCI device?  We can provide a better API
> > than that.
> 
> device_del should free what device_add allocates.

Absolutely.  Making unplug of the guest device not close the host
device implies in having the host device not being opened by
device_add (it would be opened by -object/object_add, I assume).

> 
> Does device_add allocate the host side PCI device?  If yes, should it?

I don't see any reason it should.

-- 
Eduardo
