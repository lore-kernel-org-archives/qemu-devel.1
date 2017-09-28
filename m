Received: from eggs.gnu.org ([2001:4830:134:3::10]:59792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dxT1d-0007es-0A
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 03:14:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dxT1b-0002xR-Tt
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 03:14:24 -0400
Date: Thu, 28 Sep 2017 15:13:59 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170928071359.GG17044@pxdev.xzpeter.org>
References: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
	<20170928064312.GA1544@virtx40>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170928064312.GA1544@virtx40>
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v7 00/20] ARM SMMUv3 Emulation
 Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Linu Cherian <linuc.decode@gmail.com>
Cc: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, prem.mallappa@gmail.com, alex.williamson@redhat.com, mohun106@gmail.com, drjones@redhat.com, tcain@qti.qualcomm.com, Radha.Chintakuntla@cavium.com, Sunil.Goutham@cavium.com, mst@redhat.com, jean-philippe.brucker@arm.com, tn@semihalf.com, will.deacon@arm.com, robin.murphy@arm.com, bharat.bhushan@nxp.com, christoffer.dall@linaro.org, wtownsen@redhat.com

On Thu, Sep 28, 2017 at 12:13:12PM +0530, Linu Cherian wrote:
> Hi Eric,
> 
> 
> On Fri Sep 01, 2017 at 07:21:03PM +0200, Eric Auger wrote:
> > This series implements the emulation code for ARM SMMUv3.
> > 
> > Changes since v6:
> > - DPDK testpmd now running on guest with 2 assigned VFs
> > - Changed the instantiation method: add the following option to
> >   the QEMU command line
> >   -device smmuv3 # for virtio/vhost use cases
> >   -device smmuv3,caching-mode # for vfio use cases (based on [1])
> > - splitted the series into smaller patches to allow the review
> > - the VFIO integration based on "tlbi-on-map" smmuv3 driver
> >   is isolated from the rest: last 2 patches, not for upstream.
> >   This is shipped for testing/bench until a better solution is found.
> > - Reworked permission flag checks and event generation
> > e testing:
> > - in dt and ACPI modes
> > - virtio-net-pci and vhost-net devices using dma ops with various
> >   guest page sizes [2]
> > - assigned VFs using dma ops [3]:
> >   - AMD Overdrive and igbvf passthrough (using gsi direct mapping)
> >   - Cavium ThunderX and ixgbevf passthrough (using KVM MSI routing)
> > - DPDK testpmd on guest running with VFIO user space drivers (2 igbvf) [3]
> >   with guest and host page size equal (4kB)
> > 
> > Known limitations:
> > - no VMSAv8-32 suport
> > - no nested stage support (S1 + S2)
> > - no support for HYP mappings
> > - register fine emulation, commands, interrupts and errors were
> >   not accurately tested. Handling is sufficient to run use cases
> >   described above though.
> > - interrupts and event generation not observed yet.
> 
> While testing with vfio-pci, observed that the below two  Qemu command,
> results in two different behaviour. Is this expected by design ?
> 
> Case 1:
> # -device vfio-pci,host=0002:01:00.3 -device smmuv3,caching-mode
>  Here iommu is not attached to the pci bus in Qemu backend, since
>  pci_setup_iommu is not called before vfio_realize.
> 
> Case 2:
> # -device smmuv3,caching-mode -device vfio-pci,host=0002:01:00.3
> This works as expected, iommu is attached to the pci bus.

Not sure about SMMU, but VT-d should have similar issue - the vIOMMU
device needs to be created before the rest of the devices.

Now for VT-d the ordering of devices should be assured by Libvirt:

https://bugzilla.redhat.com/show_bug.cgi?id=1427005

For your reference only.  Thanks,

-- 
Peter Xu
