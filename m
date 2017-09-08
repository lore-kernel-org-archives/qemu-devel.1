Received: from eggs.gnu.org ([2001:4830:134:3::10]:45391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dqHCz-0000rR-M5
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 07:12:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dqHCu-0007uq-Hf
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 07:12:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dqHCu-0007uA-8e
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 07:12:20 -0400
Date: Fri, 8 Sep 2017 12:12:14 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170908111214.GB2095@work-vm>
References: <20170907092010.3605-1-aik@ozlabs.ru>
	<20170907095142.GA2194@work-vm>
	<f83c81f0-7f4e-7518-750b-86eb84141d9b@ozlabs.ru>
	<20170907145403.GR2098@work-vm>
	<3b4eb5d7-a73a-b0b4-97d4-8033cc3aed8c@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b4eb5d7-a73a-b0b4-97d4-8033cc3aed8c@ozlabs.ru>
Subject: Re: [Qemu-devel] [RFC PATCH qemu 0/4] memory: Reduce memory use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

* Alexey Kardashevskiy (aik@ozlabs.ru) wrote:
> On 08/09/17 00:54, Dr. David Alan Gilbert wrote:
> > * Alexey Kardashevskiy (aik@ozlabs.ru) wrote:
> >> On 07/09/17 19:51, Dr. David Alan Gilbert wrote:
> >>> * Alexey Kardashevskiy (aik@ozlabs.ru) wrote:
> >>>> This was inspired by https://bugzilla.redhat.com/show_bug.cgi?id=1481593
> >>>>
> >>>> What happens ithere is that every virtio block device creates 2 address
> >>>> spaces - for modern config space (called "virtio-pci-cfg-as") and
> >>>> for busmaster (common pci thing, called after the device name,
> >>>> in my case "virtio-blk-pci").
> >>>>
> >>>> Each address_space_init() updates topology for every address space.
> >>>> Every topology update (address_space_update_topology()) creates a new
> >>>> dispatch tree - AddressSpaceDispatch with nodes (1KB) and
> >>>> sections (48KB) and destroys the old one.
> >>>>
> >>>> However the dispatch destructor is postponed via RCU which does not
> >>>> get a chance to execute until the machine is initialized but before
> >>>> we get there, memory is not returned to the pool, and this is a lot
> >>>> of memory which grows n^2.
> >>>>
> >>>> These patches are trying to address the memory use and boot time
> >>>> issues but tbh only the first one provides visible outcome.
> >>>
> >>> Do you have a feel for how much memory is saved?
> >>
> >>
> >> The 1/4 saves ~33GB (~44GB -> 11GB) for a 2GB guest and 400 virtio-pci
> >> devices. These GB figures are the peak values (but it does not matter for
> >> OOM killer), memory gets released in one go when RCU kicks in, it just
> >> happens too late.
> > 
> > Nice saving!  Still, why is it using 11GB?
> 
> Yet to be discovered :) Not clear at the moment.
> 
> 
> > What's it like for more sane configurations, say 2-3 virtio devices - is
> > there anything noticable or is it just the huge setups?
> > 
> > Dave
> > 
> > 
> >> The 3/4 saves less, I'd say 50KB per VCPU (more if you count peaks but so
> >> much). Strangely, I do not see the difference in valgrind output when I run
> >> a guest with 1024 or just 8 CPUs, probably "massif" is not the right tool
> >> to catch this.
> 
> I did some more tests.
> 
> v2.10:
> 1024 CPUs, no virtio:     0:47   490.8MB   38/34
> 1 CPU, 500 virtio-block:  5:03   59.69GB   2354438/3
> 
> 1/4 applied:
> 1024 CPUs, no virtio:	  0:49   490.8MB   38/34
> 1 CPU, 500 virtio-block:  1:57   17.74GB   2186/3
> 
> 3/4 applied:
> 1024 CPUs, no virtio:     0:53   491.1MB   20/17
> 1 CPU, 500 virtio-block:  2:01    17.7GB   2167/0
> 
> 
> Time is what it takes to start QEMU with -S and then Q-Ax.
> 
> Memory amount is peak use from valgrind massif.
> 
> Last 2 numbers - "38/34" for example - 38 is the number of g_new(FlatView,
> 1), 34 is the number of g_free(view); the numbers are printed at
> https://git.qemu.org/?p=qemu.git;a=blob;f=vl.c;h=8e247cc2a239ae8fb3d3cdf6d4ee78fd723d1053;hb=1ab5eb4efb91a3d4569b0df6e824cc08ab4bd8ec#l4666
> before RCU kicks in.
> 
> 500 virtio-block + bridges use around 1100 address spaces.

What I find interesting is the effect even on small VMs, I'm using
valgrind --tool=exp-dhat as per your bz comment, on a qemu close to
head:

valgrind --tool=exp-dhat ~/try/x86_64-softmmu/qemu-system-x86_64 -nographic -device sga -m 1G -M pc,accel=kvm -drive file=/home/vmimages/littlefed20.img,id=d1,if=none -device virtio-blk,drive=d1 -drive file=/home/vmimages/dummy1,id=d2,if=none -device virtio-blk,drive=d2 -drive file=/home/vmimages/dummy2,id=d3,if=none -device virtio-blk,drive=d3 -device virtio-serial -device virtio-serial -device virtio-serial -object rng-random,id=objrng0,filename=/dev/urandom -device virtio-rng-pci,rng=objrng0,id=rng0

==5945== guest_insns:  2,845,498,404
==5945== max_live:     73,745,261 in 45,395 blocks
==5945== tot_alloc:    615,696,752 in 515,110 blocks

with your 1-4 patches:
==14661== guest_insns:  2,626,826,254
==14661== max_live:     27,825,659 in 28,950 blocks
==14661== tot_alloc:    529,978,686 in 444,043 blocks

so that's a 45MB saving on a simple VM - those type of numbers add up
for people running lots of small VMs; they notice when their total
qemu RAM overhead for their box goes up by a few GB.

Dave

> 
> 
> 
> 
> >>
> >>>
> >>> Dave
> >>>
> >>>> There are still things to polish and double check the use of RCU,
> >>>> I'd like to get any feedback before proceeding - is this going
> >>>> the right way or way too ugly?
> >>>>
> >>>>
> >>>> This is based on sha1
> >>>> 1ab5eb4efb Peter Maydell "Update version for v2.10.0 release".
> >>>>
> >>>> Please comment. Thanks.
> >>>>
> >>>>
> >>>>
> >>>> Alexey Kardashevskiy (4):
> >>>>   memory: Postpone flatview and dispatch tree building till all devices
> >>>>     are added
> >>>>   memory: Prepare for shared flat views
> >>>>   memory: Share flat views and dispatch trees between address spaces
> >>>>   memory: Add flat views to HMP "info mtree"
> >>>>
> >>>>  include/exec/memory-internal.h |   6 +-
> >>>>  include/exec/memory.h          |  93 +++++++++----
> >>>>  exec.c                         | 242 +++++++++++++++++++--------------
> >>>>  hw/alpha/typhoon.c             |   2 +-
> >>>>  hw/dma/rc4030.c                |   4 +-
> >>>>  hw/i386/amd_iommu.c            |   2 +-
> >>>>  hw/i386/intel_iommu.c          |   9 +-
> >>>>  hw/intc/openpic_kvm.c          |   2 +-
> >>>>  hw/pci-host/apb.c              |   2 +-
> >>>>  hw/pci/pci.c                   |   3 +-
> >>>>  hw/ppc/spapr_iommu.c           |   4 +-
> >>>>  hw/s390x/s390-pci-bus.c        |   2 +-
> >>>>  hw/vfio/common.c               |   6 +-
> >>>>  hw/virtio/vhost.c              |   6 +-
> >>>>  memory.c                       | 299 +++++++++++++++++++++++++++--------------
> >>>>  monitor.c                      |   3 +-
> >>>>  vl.c                           |   4 +
> >>>>  hmp-commands-info.hx           |   7 +-
> >>>>  18 files changed, 448 insertions(+), 248 deletions(-)
> >>>>
> >>>> -- 
> >>>> 2.11.0
> >>>>
> >>>>
> >>> --
> >>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >>>
> >>
> >>
> >> -- 
> >> Alexey
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > 
> 
> 
> -- 
> Alexey
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
