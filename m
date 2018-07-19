Received: from eggs.gnu.org ([2001:4830:134:3::10]:58015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fgAu9-00079U-ML
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 11:31:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fgAu4-0000YW-OZ
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 11:31:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1fgAu4-0000YJ-H0
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 11:31:40 -0400
Date: Thu, 19 Jul 2018 09:31:33 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180719093133.5a6b8584@t450s.home>
In-Reply-To: <20180719044923.GC4071@xz-mi>
References: <20180717222721.14019.27548.stgit@gimli.home>
	<20180718064803.GA6197@xz-mi>
	<20180718113640.7b3b905d.cohuck@redhat.com>
	<20180719044923.GC4071@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 0/3] Balloon inhibit enhancements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org

On Thu, 19 Jul 2018 12:49:23 +0800
Peter Xu <peterx@redhat.com> wrote:

> On Wed, Jul 18, 2018 at 11:36:40AM +0200, Cornelia Huck wrote:
> > On Wed, 18 Jul 2018 14:48:03 +0800
> > Peter Xu <peterx@redhat.com> wrote:
> >   
> > > On Tue, Jul 17, 2018 at 04:47:31PM -0600, Alex Williamson wrote:  
> > > > Directly assigned vfio devices have never been compatible with
> > > > ballooning.  Zapping MADV_DONTNEED pages happens completely
> > > > independent of vfio page pinning and IOMMU mapping, leaving us with
> > > > inconsistent GPA to HPA mapping between vCPUs and assigned devices
> > > > when the balloon deflates.  Mediated devices can theoretically do
> > > > better, if we make the assumption that the mdev vendor driver is fully
> > > > synchronized to the actual working set of the guest driver.  In that
> > > > case the guest balloon driver should never be able to allocate an mdev
> > > > pinned page for balloon inflation.  Unfortunately, QEMU can't know the
> > > > workings of the vendor driver pinning, and doesn't actually know the
> > > > difference between mdev devices and directly assigned devices.  Until
> > > > we can sort out how the vfio IOMMU backend can tell us if ballooning
> > > > is safe, the best approach is to disabling ballooning any time a vfio
> > > > devices is attached.
> > > > 
> > > > To do that, simply make the balloon inhibitor a counter rather than a
> > > > boolean, fixup a case where KVM can then simply use the inhibit
> > > > interface, and inhibit ballooning any time a vfio device is attached.
> > > > I'm expecting we'll expose some sort of flag similar to
> > > > KVM_CAP_SYNC_MMU from the vfio IOMMU for cases where we can resolve
> > > > this.  An addition we could consider here would be yet another device
> > > > option for vfio, such as x-disable-balloon-inhibit, in case there are
> > > > mdev devices that behave in a manner compatible with ballooning.
> > > > 
> > > > Please let me know if this looks like a good idea.  Thanks,    
> > > 
> > > IMHO patches 1-2 are good cleanup as standalone patches...
> > > 
> > > I totally have no idea on whether people would like to use vfio-pci
> > > and the balloon device at the same time.  After all vfio-pci are
> > > majorly for performance players, then I would vaguely guess that they
> > > don't really care thin provisioning of memory at all, hence the usage
> > > scenario might not exist much.  Is that the major reason that we'd
> > > just like to disable it (which makes sense to me)?  
> > 
> > Don't people use vfio-pci as well if they want some special
> > capabilities from the passed-through device? (At least that's the main
> > use case for vfio-ccw, not any performance considerations.)  
> 
> Good to know these.
> 
> Out of topic: could I further ask what's these capabilities, and why
> these capabilities can't be emulated (or hard to be emulated) if we
> don't care about performance?

Are you assuming that anything that isn't strictly performance focused
for device assignment is self contained, fully documented, suitable for
emulation, and there's someone willing and able to invest and upstream
(open source) that emulation?  What about things like data acquisition
devices, TV capture cards, serial ports, real-time control systems,
etc.  This is one of the basic tenants of device assignment, it
provides users the ability to migrate physical systems to virtual, even
if the entire reason for the system existing is tied to hardware.  The
world is more than just NICs and HBAs.  Thanks,

Alex
