Received: from eggs.gnu.org ([2001:4830:134:3::10]:42726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eMU14-0006dG-8v
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 02:21:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eMU10-0004cQ-2F
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 02:21:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eMU0z-0004aW-Q4
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 02:21:10 -0500
Date: Wed, 6 Dec 2017 15:20:56 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171206072056.GD2797@xz-mi>
References: <20171205205409.5348.53070.stgit@gimli.home>
	<9519f733-ddb1-beea-830b-4c9cda69ca67@ozlabs.ru>
	<20171205183039.5fe06906@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171205183039.5fe06906@t450s.home>
Subject: Re: [Qemu-devel] [PATCH for-2.11] vfio: Fix vfio-kvm group
 registration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, eric.auger@redhat.com, qemu-devel@nongnu.org

On Tue, Dec 05, 2017 at 06:30:39PM -0700, Alex Williamson wrote:
> On Wed, 6 Dec 2017 12:02:01 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> 
> > On 06/12/17 08:09, Alex Williamson wrote:
> > > Commit 8c37faa475f3 ("vfio-pci, ppc64/spapr: Reorder group-to-container
> > > attaching") moved registration of groups with the vfio-kvm device from
> > > vfio_get_group() to vfio_connect_container(), but it missed the case
> > > where a group is attached to an existing container and takes an early
> > > exit.  Perhaps this is a less common case on ppc64/spapr, but on x86
> > > (without viommu) all groups are connected to the same container and
> > > thus only the first group gets registered with the vfio-kvm device.
> > > This becomes a problem if we then hot-unplug the devices associated
> > > with that first group and we end up with KVM being misinformed about
> > > any vfio connections that might remain.  Fix by including the call to
> > > vfio_kvm_device_add_group() in this early exit path.
> > > 
> > > Fixes: 8c37faa475f3 ("vfio-pci, ppc64/spapr: Reorder group-to-container attaching")
> > > Cc: qemu-stable@nongnu.org # qemu-2.10+
> > > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > > ---
> > > 
> > > This bug also existed in QEMU 2.10, but I think the fix is sufficiently
> > > obvious (famous last words) to propose for 2.11 at this late date.  If
> > > the first group is hot unplugged then KVM may revert to code emulation
> > > that assumes no non-coherent DMA is present on some systems.  Also for
> > > KVMGT, if the vGPU is not the first device registered, then the
> > > notifier to enable linkages to KVM would not be called.  Please review.  
> > 
> > For what it is worth
> > 
> > Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> 
> Thanks!
> 
> > Sorry for the breakage...
> > 
> > One question - how was this discovered? I'd love to set up a test
> > environment on my old thinkpad x230 if possible.
> 
> Assign two devices from separate iommu groups, hot unplug the first
> device, followed by the second device.  The second unplug will trigger:
> 
> qemu-kvm: Failed to remove group ## from KVM VFIO device: No such file or directory

I reproduced this with command line:

bin=x86_64-softmmu/qemu-system-x86_64  
$bin -machine q35,kernel-irqchip=split \                                       
     -enable-kvm -m 4G -nographic \    
     -monitor telnet::6666,server,nowait \                                     
     -device ioh3420,multifunction=on,bus=pcie.0,id=port0,chassis=0 \          
     -device ioh3420,bus=pcie.0,id=port1,chassis=1 \                           
     -netdev user,id=user.0,hostfwd=tcp::5555-:22 \                            
     -device e1000,netdev=user.0 \     
     -device vfio-pci,host=05:00.0,id=vfio0,bus=port0 \                        
     -device vfio-pci,host=05:00.1,id=vfio1,bus=port1 \                        
     /home/images/fedora-25.qcow2      

The patch fixes it, so:

Reviewed-by: Peter Xu <peterx@redhat.com>
Tested-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu
