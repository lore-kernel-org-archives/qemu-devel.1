Received: from eggs.gnu.org ([2001:4830:134:3::10]:57681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dfZEu-00040k-3c
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 18:14:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dfZEq-0000To-MF
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 18:14:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57265)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dfZEq-0000Ta-Fl
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 18:14:04 -0400
References: <34458438-9913-6bab-0ddb-e2908ddd006a@bluestop.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <faffe6ab-b094-5f9a-0834-12d5c380edd4@redhat.com>
Date: Thu, 10 Aug 2017 00:13:57 +0200
MIME-Version: 1.0
In-Reply-To: <34458438-9913-6bab-0ddb-e2908ddd006a@bluestop.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Rebecca Cran <rebecca@bluestop.org>
Cc: edk2-devel@lists.01.org, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu devel list <qemu-devel@nongnu.org>

On 08/09/17 22:47, Rebecca Cran wrote:
> I've been investigating adding support for Qemu's nvdimm devices to
> OVMF.  I was thinking such support would go into PlatformPei, but it
> looks like I can only read the ACPI NFIT in the DXE phase. So, should
> Qemu be changed to add non-volatile memory to the e820 table, or
> should such memory be added during the DXE phase instead?

I don't have the slightest idea, sorry.

One thing that does look bad is that both edk2's

  MdeModulePkg/Universal/Disk/RamDiskDxe

and QEMU's

  hw/acpi/nvdimm.c

think they own the NVDIMM root device with, with _HID=ACPI0012.

I don't recall being consulted when QEMU's NVDIMM stuff was designed and
implemented, despite the fact that it uses the ACPI linker/loader
(apparently).

In general, using the ACPI linker/loader is a good recipe for making an
ACPI-defined feature "just work" under both SeaBIOS and OVMF, without
having to resort to specialized information channels such as new fw_cfg
files, or additional paravirt hardware. However, there are enough quirks
in edk2 / UEFI with regard to ACPI that, without special attention to
OVMF / edk2 at design time, things will likely break due to infighting
over ACPI ownership.

In RamDiskPublishNfit(), there is

    //
    // Assumption is made that if no NFIT is in the ACPI table, there is no
    // NVDIMM root device in the \SB scope.
    // Therefore, a NVDIMM root device will be reported via Secondary System
    // Description Table (SSDT).
    //
    Status = RamDiskPublishSsdt ();

That assumption might or might not be good enough, when QEMU pushes down
its NVDIMM / NFIT stuff. I suggest reading "docs/specs/acpi_nvdimm.txt"
in the QEMU tree, and figuring out if that can work with OVMF's ACPI
linker/loader client, and the rest of the edk2 modules. The assumption
could also be affected by whether OvmfPkg/AcpiTableDxe installs QEMU's
NVDIM stuff before or after RamDiskDxe does its thing. I have no clue.

I apologize but I don't think I can help (or even find the bandwidth to
research or discuss this -- it's 00:13 local time and I'm reviewing
patches...)

I'm CC'ing Michael and Igor, maybe they can provide you with pointers.
(Also adding qemu-devel.)

Thanks
Laszlo
