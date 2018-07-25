Received: from eggs.gnu.org ([2001:4830:134:3::10]:39695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fiMSC-00053Z-11
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 12:15:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fiMS8-0006dM-VO
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 12:15:55 -0400
Date: Wed, 25 Jul 2018 18:15:42 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180725181542.0c02c720@redhat.com>
In-Reply-To: <20180725113645.fthwhvzx7otrr3ya@kamzik.brq.redhat.com>
References: <1532496652-26364-1-git-send-email-hongbo.zhang@linaro.org>
	<1532496652-26364-2-git-send-email-hongbo.zhang@linaro.org>
	<20180725095426.f7kv4ftngeje6pkx@kamzik.brq.redhat.com>
	<20180725105040.GA2366@work-vm>
	<20180725113645.fthwhvzx7otrr3ya@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] hw/arm: Add Arm Enterprise machine
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, peter.maydell@linaro.org, radoslaw.biernacki@linaro.org, Hongbo Zhang <hongbo.zhang@linaro.org>, ard.biesheuvel@linaro.org, qemu-devel@nongnu.org, leif.lindholm@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org

On Wed, 25 Jul 2018 13:36:45 +0200
Andrew Jones <drjones@redhat.com> wrote:

> On Wed, Jul 25, 2018 at 11:50:41AM +0100, Dr. David Alan Gilbert wrote:
> > * Andrew Jones (drjones@redhat.com) wrote:  
> > > On Wed, Jul 25, 2018 at 01:30:52PM +0800, Hongbo Zhang wrote:  
> > > > For the Aarch64, there is one machine 'virt', it is primarily meant to
> > > > run on KVM and execute virtualization workloads, but we need an
> > > > environment as faithful as possible to physical hardware, for supporting
> > > > firmware and OS development for pysical Aarch64 machines.
> > > > 
> > > > This patch introduces new machine type 'Enterprise' with main features:
> > > >  - Based on 'virt' machine type.
> > > >  - Re-designed memory map.
> > > >  - EL2 and EL3 are enabled by default.
> > > >  - GIC version 3 by default.
> > > >  - AHCI controller attached to system bus, and then CDROM and hard disc
> > > >    can be added to it.
> > > >  - EHCI controller attached to system bus, with USB mouse and key board
> > > >    installed by default.
> > > >  - E1000E ethernet card on PCIE bus.
> > > >  - VGA display adaptor on PCIE bus.
> > > >  - Default CPU type cortex-a57, 4 cores, and 1G bytes memory.
> > > >  - No virtio functions enabled, since this is to emulate real hardware.  
> > > 
> > > In the last review it was pointed out that using virtio-pci should still
> > > be "real" enough, so there's not much reason to avoid it. Well, unless
> > > there's some concern as to what drivers are available in the firmware and
> > > guest kernel. But that concern usually only applies to legacy firmwares
> > > and kernels, and therefore shouldn't apply to AArch64.  
> > 
> > I think the difference from last time is Ard's comments earlier in this
> > thread:
> > 
> >     The purpose of the SBSA machine is not to provide a minimal
> >     configuration. It is intended to exercise all the moving parts one
> >     might find in a server firmware/OS stack, including pieces that are
> >     not usually found on x86 machines, such as DRAM starting above 4 GB
> >     and SATA/USB controllers that are not PCIe based.
> > 
> > that suggests that the intent of this board is to provide everything
> > which a firmware writer might want to test;  that's quite different
> > from forming the basis of a virtualised machine for real use.
> >  
> 
> I think I understand the purpose, and I also don't believe anything I've
> said is counter to it. Whether or not one drives a virtio-pci nic with a
> virtio-pci-net driver or drives an E1000e, also on the PCIe bus, makes
> little difference to the firmware, nor to the guest kernel - besides which
> driver gets used. And, nothing stops somebody from not plugging the
> virtio-pci nic (use -nodefaults) and then plugging the E1000e (-device)
> instead. Machine models don't need to hard code these assumptions. For
> this patch it'd probably be best if we just ensured there were no
> default devices at all, rather than replace one with another.

with that thinking it might be better to put this machine in completely
different file so not mess with 'production' virt machine code and
call it intentionally ambiguous: "[linaro|generic|dev|...]_armv8"
so it would be just another sbsa compliant board with  a bunch of
default devices needed for testing purposes if users/authors think
that it serves their purpose better.

> Thanks,
> drew
> 
