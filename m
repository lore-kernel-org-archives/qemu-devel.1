Received: from eggs.gnu.org ([2001:4830:134:3::10]:36496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gDXdY-0001IA-Mp
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:28:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gDXdV-0007d0-Fg
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:28:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:25926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gDXdV-0007b6-6O
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:28:29 -0400
Date: Fri, 19 Oct 2018 12:28:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181019122756-mutt-send-email-mst@kernel.org>
References: <1538423049-29524-1-git-send-email-brijesh.singh@amd.com>
	<849fed2b-3763-14c1-d3a7-cc9891aeaff5@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <849fed2b-3763-14c1-d3a7-cc9891aeaff5@amd.com>
Subject: Re: [Qemu-devel] [PATCH v5 0/9] x86_iommu/amd: add interrupt remap
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Singh, Brijesh" <brijesh.singh@amd.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>, Peter Xu <peterx@redhat.com>

It looks good to me, I am merging it.

On Fri, Oct 19, 2018 at 02:05:06PM +0000, Singh, Brijesh wrote:
> Hi Michael, Paolo and Eduardo,
> 
> Any thoughts on the series ?
> 
> Thanks
> Brijesh
> 
> On 10/1/18 12:44 PM, Singh, Brijesh wrote:
> > This series adds the interrupt remapping support for amd-iommu device.
> >
> > IOMMU spec is available at: https://support.amd.com/TechDocs/48882_IOMMU.pdf
> >
> > To enable the interrupt remap use below qemu cli
> > # $QEMU \
> >   -device amd-iommu,intremap=on
> >
> > I have tested FC-28 and Ubuntu 18.04 guest. 
> >
> > Linux guest bootup log shows the interrupt remap supports:
> >
> > [root@localhost ~]# dmesg | grep -i AMD-Vi
> > [    0.001761] AMD-Vi: Using IVHD type 0x10
> > [    0.003051] AMD-Vi: device: 00:03.0 cap: 0040 seg: 0 flags: d1 info 0000
> > [    0.004007] AMD-Vi:        mmio-addr: 00000000fed80000
> > [    0.004874] AMD-Vi:   DEV_ALL                        flags: 00
> > [    0.006236] AMD-Vi:   DEV_SPECIAL(IOAPIC[0])         devid: 00:14.0
> > [    0.667943] AMD-Vi: Found IOMMU at 0000:00:03.0 cap 0x40
> > [    0.668727] AMD-Vi: Extended features (0x29d3):
> > [    0.669874] AMD-Vi: Interrupt remapping enabled
> > [    0.671074] AMD-Vi: Lazy IO/TLB flushing enabled
> >
> > cat /proc/interrupts confirms that its using IR
> >
> > [root@localhost ~]# cat /proc/interrupts 
> > CPU0       
> >  0:         40  IR-IO-APIC    2-edge      timer
> >  1:          9  IR-IO-APIC    1-edge      i8042
> >  4:       1770  IR-IO-APIC    4-edge      ttyS0
> >  7:          0  IR-IO-APIC    7-edge      parport0
> >  8:          1  IR-IO-APIC    8-edge      rtc0
> >  9:          0  IR-IO-APIC    9-fasteoi   acpi
> > 12:         15  IR-IO-APIC   12-edge      i8042
> > 16:          0  IR-IO-APIC   16-fasteoi   i801_smbus
> > 24:          0   PCI-MSI 49152-edge      AMD-Vi
> > 25:      13070  IR-PCI-MSI 512000-edge      ahci[0000:00:1f.2]
> > 26:         86  IR-PCI-MSI 32768-edge      enp0s2-rx-0
> > 27:        139  IR-PCI-MSI 32769-edge      enp0s2-tx-0
> > 28:          1  IR-PCI-MSI 32770-edge      enp0s2
> > NMI:          0   Non-maskable interrupts
> > LOC:      26686   Local timer interrupts
> > SPU:          0   Spurious interrupts
> > ...
> > ...
> >
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Richard Henderson <rth@twiddle.net>
> > Cc: Eduardo Habkost <ehabkost@redhat.com>
> > Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
> > Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> > Cc: Peter Xu <peterx@redhat.com>
> >
> > Changes since v4:
> > - Based on Peter's comment use error_report_once in patch 5 and
> >   tracepoint in Patch 6
> >
> > Changes since v3:
> > - do not treat errors as a passthrough (where applicable)
> > - use error_report_once when applicable
> >
> > Changes since v2:
> > - make the address space rename a separate patch
> > - fix the V=1 check in patch 2
> > - add more comments in the patches
> > - use amdvi_target_abort trace point where applicable
> > - use error_report_once where applicable
> > - do not cause exit() when configuration mismatch is detected,
> >   but log the error so that user knows about it.
> >
> > Changes since v1:
> > - move vtd_generate_msi_message to common code
> > - fix the dest_mode bit extraction
> > - add more comments explaining why we add the special device
> > - some minor cleanups based on Peter's feedbacks
> > Brijesh Singh (9):
> >   x86_iommu: move the kernel-irqchip check in common code
> >   x86_iommu: move vtd_generate_msi_message in common file
> >   x86_iommu/amd: remove V=1 check from amdvi_validate_dte()
> >   x86_iommu/amd: make the address space naming consistent with
> >     intel-iommu
> >   x86_iommu/amd: Prepare for interrupt remap support
> >   x86_iommu/amd: Add interrupt remap support when VAPIC is not enabled
> >   i386: acpi: add IVHD device entry for IOAPIC
> >   x86_iommu/amd: Add interrupt remap support when VAPIC is enabled
> >   x86_iommu/amd: Enable Guest virtual APIC support
> >
> >  hw/i386/acpi-build.c          |  31 +++-
> >  hw/i386/amd_iommu.c           | 414 +++++++++++++++++++++++++++++++++++++++++-
> >  hw/i386/amd_iommu.h           |  96 +++++++++-
> >  hw/i386/intel_iommu.c         |  39 +---
> >  hw/i386/trace-events          |  14 ++
> >  hw/i386/x86-iommu.c           |  33 ++++
> >  include/hw/i386/intel_iommu.h |  59 ------
> >  include/hw/i386/x86-iommu.h   |  66 +++++++
> >  8 files changed, 643 insertions(+), 109 deletions(-)
> >
> 
