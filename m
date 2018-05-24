Received: from eggs.gnu.org ([2001:4830:134:3::10]:58138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fLmzq-0000EG-9s
	for qemu-devel@nongnu.org; Thu, 24 May 2018 05:57:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fLmzp-0004W7-4z
	for qemu-devel@nongnu.org; Thu, 24 May 2018 05:57:22 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:37437)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <whois.zihan.yang@gmail.com>)
	id 1fLmzo-0004Vp-Sj
	for qemu-devel@nongnu.org; Thu, 24 May 2018 05:57:21 -0400
Received: by mail-wm0-x241.google.com with SMTP id l1-v6so3484040wmb.2
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 02:57:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <83f46e13-b3df-2f90-bd39-8822c47cfa6e@redhat.com>
References: <1526801333-30613-1-git-send-email-whois.zihan.yang@gmail.com>
	<1526801333-30613-4-git-send-email-whois.zihan.yang@gmail.com>
	<ef3fc85d-7726-c888-e8ca-9dfae1b908d3@gmail.com>
	<17a3765f-b835-2d45-e8b9-ffd4aff909f9@redhat.com>
	<cbdfe0d6-f071-3560-009d-3bbdde12b33c@gmail.com>
	<f71a8c61-a0d7-6ebc-62ad-3dab8b9f8e5a@redhat.com>
	<dd40007d-b63b-d965-505f-11ff0748e54f@redhat.com>
	<20180523023944-mutt-send-email-mst@kernel.org>
	<e027866e-9740-0866-f1c4-45b8181a6f71@redhat.com>
	<CAKwiv-jMKSUYusO4S4HR5HCMXLxGNrpYwywm1dWBWsFKMEGzpg@mail.gmail.com>
	<83f46e13-b3df-2f90-bd39-8822c47cfa6e@redhat.com>
From: Zihan Yang <whois.zihan.yang@gmail.com>
Date: Thu, 24 May 2018 17:57:18 +0800
Message-ID: <CAKwiv-ioWOfjVY=Afanm6vNg=BNePZfB1k7iS-G=5cu_6ZeHTQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC 3/3] acpi-build: allocate mcfg for multiple
 host bridges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, lersek@redhat.com
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Igor Mammedov <imammedo@redhat.com>, alex.williamson@redhat.com, eauger@redhat.com, drjones@redhat.com, wei@redhat.com

> > The original purpose was just to support multiple segments in Intel
> > Q35 archtecure for PCIe topology, which makes bus number a less scarce
> > resource. The patches are very primitive and many things are left for
> > firmware to finish(the initial plan was to implement it in SeaBIOS),
> > the AML part in QEMU is not finished either. I'm not familiar with
> > OVMF or edk2, so there is no plan to touch it yet, but it seems not
> > necessary since it already supports multi-segment in the end.
>
> That's incorrect. EDK2 stands for "EFI Development Kit II", and it is a
> collection of "universal" (= platform- and ISA-independent) modules
> (drivers and libraries), and platfor- and/or ISA-dependent modules
> (drivers and libraries). The OVMF firmware is built from a subset of
> these modules; the final firmware image includes modules from both
> categories -- universal modules, and modules specific to the i440fx and
> Q35 QEMU boards. The first category generally lives under MdePkg/,
> MdeModulePkg/, UefiCpuPkg/, NetworkPkg/, PcAtChipsetPkg, etc; while the
> second category lives under OvmfPkg/.
>
> (The exact same applies to the ArmVirtQemu firmware, with the second
> category consisting of ArmVirtPkg/ and OvmfPkg/ modules.)
>
> When we discuss anything PCI-related in edk2, it usually affects both
> categories:
>
> (a) the universal/core modules, such as
>
>   - the PCI host bridge / root bridge driver at
>     "MdeModulePkg/Bus/Pci/PciHostBridgeDxe",
>
>   - the PCI bus driver at "MdeModulePkg/Bus/Pci/PciBusDxe",
>
> (b) and the platform-specific modules, such as
>
>   - "OvmfPkg/IncompatiblePciDeviceSupportDxe" which causes PciBusDxe to
>     allocate 64-bit MMIO BARs above 4 GB, regardless of option ROM
>     availability (as long as a CSM is not present), conserving 32-bit
>     MMIO aperture for 32-bit BARs,
>
>   - "OvmfPkg/PciHotPlugInitDxe", which implements support for QEMU's
>     resource reservation hints, so that we can avoid IO space exhaustion
>     with many PCIe root ports, and so that we can reserve MMIO aperture
>     for hot-plugging devices with large MMIO BARs,
>
>   - "OvmfPkg/Library/DxePciLibI440FxQ35", which is a low-level PCI
>     config space access library, usable in the DXE and later phases,
>     that plugs into several drivers, and uses 0xCF8/0xCFC on i440x, and
>     ECAM on Q35,
>
>   - "OvmfPkg/Library/PciHostBridgeLib", which plugs into
>     "PciHostBridgeDxe" above, exposing the various resource apertures to
>     said host bridge / root bridge driver, and implementing support for
>     the PXB / PXBe devices,
>
>   - "OvmfPkg/PlatformPei", which is an early (PEI phase) module with a
>     grab-bag of platform support code; e.g. it informs
>     "DxePciLibI440FxQ35" above about the QEMU board being Q35 vs.
>     i440fx, it configures the ECAM (exbar) registers on Q35, it
>     determines where the 32-bit and 64-bit PCI MMIO apertures should be;
>
>   - "ArmVirtPkg/Library/BaseCachingPciExpressLib", which is the
>     aarch64/virt counterpart of "DxePciLibI440FxQ35" above,
>
>   - "ArmVirtPkg/Library/FdtPciHostBridgeLib", which is the aarch64/virt
>     counterpart of "PciHostBridgeLib", consuming the DTB exposed by
>     qemu-system-aarch64,
>
>   - "ArmVirtPkg/Library/FdtPciPcdProducerLib", which is an internal
>     library that turns parts of the DTB that is exposed by
>     qemu-system-aarch64 into various PCI-related, firmware-wide, scalar
>     variables (called "PCDs"), upon which both
>     "BaseCachingPciExpressLib" and "FdtPciHostBridgeLib" rely.
>
> The point is that any PCI feature in any edk2 platform firmware comes
> together from (a) core module support for the feature, and (b) platform
> integration between the core code and the QEMU board in question.
>
> If (a) is missing, that implies a very painful uphill battle, which is
> why I'd been loudly whining, initially, in this thread, until I realized
> that the core support was there in edk2, for PCIe segments.
>
> However, (b) is required as well -- i.e., platform integration under
> OvmfPkg/ and perhaps ArmVirtPkg/, between the QEMU boards and the core
> edk2 code --, and that definitely doesn't exist for the PCIe segments
> feature.
>
> If (a) exists and is flexible enough, then we at least have a chance at
> writing the platform support code (b) for it. So that's why I've stopped
> whining. Writing (b) is never easy -- in this case, a great many of the
> platform modules that I've listed above, under OvmfPkg/ pathnames, could
> be affected, or even be eligible for replacement -- but (b) is at least
> imaginable practice. Modules in category (a) are shipped *in* -- not
> "on" -- every single physical UEFI platform that you can buy today,
> which is one reason why it's hugely difficult to implement nontrivial
> changes for them.
>
> In brief: your statement is incorrect because category (b) is missing.
> And that requires dedicated QEMU support, similarly to how
> "OvmfPkg/PciHotPlugInitDxe" requires the vendor-specific resource
> reservation capability, and how "OvmfPkg/Library/PciHostBridgeLib"
> consumes the "etc/extra-pci-roots" fw_cfg file, and how most everything
> that ArmVirtQemu does for PCI(e) originates from QEMU's DTB.

Thanks for clarifying, I didn't realize the complexity in OVMF, I think at least
for now I'll only focus on SeaBIOS.

> > * NUMA modeling seems to be a stronger motivation than the limitation
> >   of 256 but nubmers, that each NUMA node holds its own PCI(e)
> >   sub-hierarchy
>
> I'd also like to get more information about this -- I thought pxb-pci(e)
> was already motivated by supporting NUMA locality. And, to my knowledge,
> pxb-pci(e) actually *solved* this problem. Am I wrong? Let's say you
> have 16 NUMA nodes (which seems pretty large to me); is it really
> insufficient to assign ~16 devices to each node?

It seems my previous statement was incorrect about the motivation,
the device number limitation is still the motivation as Marcel points out in
later comment. NUMA modeling just happens to fit into this situation.

Thanks
Zihan
