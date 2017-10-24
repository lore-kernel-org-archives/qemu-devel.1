Received: from eggs.gnu.org ([2001:4830:134:3::10]:60637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linuc.decode@gmail.com>) id 1e72er-0002fk-1k
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 13:06:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linuc.decode@gmail.com>) id 1e72ep-0000rb-Ss
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 13:06:29 -0400
Date: Tue, 24 Oct 2017 22:36:07 +0530
From: Linu Cherian <linuc.decode@gmail.com>
Message-ID: <20171024170607.GA4906@linu-Latitude-E5470>
References: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
	<20171024053802.GA22835@virtx40> <20171024102029.GE17909@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171024102029.GE17909@arm.com>
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
To: Will Deacon <will.deacon@arm.com>
Cc: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, prem.mallappa@gmail.com, alex.williamson@redhat.com, mohun106@gmail.com, drjones@redhat.com, tcain@qti.qualcomm.com, Radha.Chintakuntla@cavium.com, Sunil.Goutham@cavium.com, mst@redhat.com, jean-philippe.brucker@arm.com, tn@semihalf.com, robin.murphy@arm.com, peterx@redhat.com, bharat.bhushan@nxp.com, christoffer.dall@linaro.org, wtownsen@redhat.com, linu.cherian@cavium.com

Hi Will,

On Tue, Oct 24, 2017 at 11:20:29AM +0100, Will Deacon wrote:
> On Tue, Oct 24, 2017 at 11:08:02AM +0530, Linu Cherian wrote:
> > On Fri Sep 01, 2017 at 07:21:03PM +0200, Eric Auger wrote:
> > > This series implements the emulation code for ARM SMMUv3.
> > > 
> > > Changes since v6:
> > > - DPDK testpmd now running on guest with 2 assigned VFs
> > > - Changed the instantiation method: add the following option to
> > >   the QEMU command line
> > >   -device smmuv3 # for virtio/vhost use cases
> > >   -device smmuv3,caching-mode # for vfio use cases (based on [1])
> > > - splitted the series into smaller patches to allow the review
> > > - the VFIO integration based on "tlbi-on-map" smmuv3 driver
> > >   is isolated from the rest: last 2 patches, not for upstream.
> > >   This is shipped for testing/bench until a better solution is found.
> > > - Reworked permission flag checks and event generation
> > > 
> > > testing:
> > > - in dt and ACPI modes
> > > - virtio-net-pci and vhost-net devices using dma ops with various
> > >   guest page sizes [2]
> > > - assigned VFs using dma ops [3]:
> > >   - AMD Overdrive and igbvf passthrough (using gsi direct mapping)
> > >   - Cavium ThunderX and ixgbevf passthrough (using KVM MSI routing)
> > > - DPDK testpmd on guest running with VFIO user space drivers (2 igbvf) [3]
> > >   with guest and host page size equal (4kB)
> > > 
> > > Known limitations:
> > > - no VMSAv8-32 suport
> > > - no nested stage support (S1 + S2)
> > > - no support for HYP mappings
> > > - register fine emulation, commands, interrupts and errors were
> > >   not accurately tested. Handling is sufficient to run use cases
> > >   described above though.
> > > - interrupts and event generation not observed yet.
> > > 
> > > Best Regards
> > > 
> > > Eric
> > >
> > 
> > Was looking at options to get rid of the existing hacks we have
> > in this implementation (last two patches) and also to reduce the map/unmap/translation 
> > overhead for the guest kernel devices.
> > 
> > Interestingly, the nested stage translation + smmu emulation at kernel
> >  that we were exploring, has been already tried by Will Deacon. 
> > https://www.linuxplumbersconf.org/2014/ocw/system/presentations/2019/original/vsmmu-lpc14.pdf
> > https://lists.gnu.org/archive/html/qemu-devel/2015-06/msg03379.html
> > 
> > 
> > It would be nice to understand, why this solution was not pursued atleast for vfio-pci devices.
> > OR
> > If you have already plans to do nested stage support in the future, would be interested to know 
> > about it.
> 
> I don't plan to revive that code. I got something well on the way to working
> for SMMUv2, but it had some pretty major issues:
> 
> 1. A huge amount of emulation code in the kernel
> 2. A horribly complicated user ABI
> 3. Keeping track of internal hardware caching state was a nightmare, so
>    over-invalidation was rife
> 4. Errata workarounds meant trapping all SMMU accesses (inc. for stage 1)
> 5. I remember having issues with interrupts, but this was likely
>    SMMUv2-specific
> 6. There was no scope for code re-use with other SMMU implementations (e.g.
>    SMMUv3)
> 
> Overall, it was just an unmaintainable, non-performant
> security-flaw-waiting-to-happen so I parked it. That's some of the
> background behind me preferring a virtio-iommu approach, because there's
> the potential for kernel acceleration using something like vhost.
> 
> Will

Thanks for the explanation.
