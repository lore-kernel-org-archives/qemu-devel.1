Received: from eggs.gnu.org ([2001:4830:134:3::10]:44105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dhBSl-00081Z-HE
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 05:15:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dhBSg-0001aC-GG
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 05:15:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dhBSg-0001ZV-72
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 05:15:02 -0400
Date: Mon, 14 Aug 2017 11:14:54 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170814111454.6060171d@nial.brq.redhat.com>
In-Reply-To: <faffe6ab-b094-5f9a-0834-12d5c380edd4@redhat.com>
References: <34458438-9913-6bab-0ddb-e2908ddd006a@bluestop.org>
	<faffe6ab-b094-5f9a-0834-12d5c380edd4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] OvmfPkg (PlatformPei?): supporting Qemu's nvdimm
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Rebecca Cran <rebecca@bluestop.org>, edk2-devel@lists.01.org, qemu devel list <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

On Thu, 10 Aug 2017 00:13:57 +0200
Laszlo Ersek <lersek@redhat.com> wrote:

> On 08/09/17 22:47, Rebecca Cran wrote:
> > I've been investigating adding support for Qemu's nvdimm devices to
> > OVMF.  I was thinking such support would go into PlatformPei, but it
> > looks like I can only read the ACPI NFIT in the DXE phase. So, should
> > Qemu be changed to add non-volatile memory to the e820 table, or
> > should such memory be added during the DXE phase instead?  
> 
> I don't have the slightest idea, sorry.
> 
> One thing that does look bad is that both edk2's
> 
>   MdeModulePkg/Universal/Disk/RamDiskDxe
> 
> and QEMU's
> 
>   hw/acpi/nvdimm.c
> 
> think they own the NVDIMM root device with, with _HID=ACPI0012.
> 
> I don't recall being consulted when QEMU's NVDIMM stuff was designed and
> implemented, despite the fact that it uses the ACPI linker/loader
> (apparently).
> 
> In general, using the ACPI linker/loader is a good recipe for making an
> ACPI-defined feature "just work" under both SeaBIOS and OVMF, without
> having to resort to specialized information channels such as new fw_cfg
> files, or additional paravirt hardware. However, there are enough quirks
> in edk2 / UEFI with regard to ACPI that, without special attention to
> OVMF / edk2 at design time, things will likely break due to infighting
> over ACPI ownership.
> 
> In RamDiskPublishNfit(), there is
> 
>     //
>     // Assumption is made that if no NFIT is in the ACPI table, there is no
>     // NVDIMM root device in the \SB scope.
>     // Therefore, a NVDIMM root device will be reported via Secondary System
>     // Description Table (SSDT).
>     //
>     Status = RamDiskPublishSsdt ();
> 
> That assumption might or might not be good enough, when QEMU pushes down
> its NVDIMM / NFIT stuff. I suggest reading "docs/specs/acpi_nvdimm.txt"
> in the QEMU tree, and figuring out if that can work with OVMF's ACPI
> linker/loader client, and the rest of the edk2 modules. The assumption
> could also be affected by whether OvmfPkg/AcpiTableDxe installs QEMU's
> NVDIM stuff before or after RamDiskDxe does its thing. I have no clue.
> 
> I apologize but I don't think I can help (or even find the bandwidth to
> research or discuss this -- it's 00:13 local time and I'm reviewing
> patches...)
> 
> I'm CC'ing Michael and Igor, maybe they can provide you with pointers.
> (Also adding qemu-devel.)

QEMU already provides NFIT table with all nvdimm devices present at startup,
but looking at EDK's RamDiskPublishNfit() if we add to E820 the same nvdimm
device with type set to EfiReservedMemoryType, EDK would append range from
E820 again which would result in duplicate record, that would probably be wrong.

> 
> Thanks
> Laszlo
> 
