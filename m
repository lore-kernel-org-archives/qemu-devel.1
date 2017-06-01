Received: from eggs.gnu.org ([2001:4830:134:3::10]:52487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dGT6j-0008Kc-Ac
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 12:37:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dGT6e-0000Ph-E0
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 12:37:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dGT6e-0000PQ-5n
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 12:37:52 -0400
References: <20170601112241.2580-1-ard.biesheuvel@linaro.org>
	<ccc0e728-0348-e386-6f71-0c1c69eaa01d@redhat.com>
	<20170601171650.4a196f36@nial.brq.redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <3de97c67-5b9d-35a0-ec5d-0098180dec9b@redhat.com>
Date: Thu, 1 Jun 2017 18:37:47 +0200
MIME-Version: 1.0
In-Reply-To: <20170601171650.4a196f36@nial.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH] OvmfPkg/AcpiPlatformDxe: lift 4 GB
 alloc limit for modern ACPI systems
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, edk2-devel@lists.01.org, leif.lindholm@linaro.org, jordan.l.justen@intel.com, Shannon Zhao <zhaoshenglong@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu devel list <qemu-devel@nongnu.org>, gengdongjiu <gengdongjiu@huawei.com>, Drew Jones <drjones@redhat.com>

On 06/01/17 17:16, Igor Mammedov wrote:
> On Thu, 1 Jun 2017 14:25:48 +0200
> Laszlo Ersek <lersek@redhat.com> wrote:
> 
>> On 06/01/17 13:22, Ard Biesheuvel wrote:
>>> ACPI supports architectures such as arm64, which did not exist when the
>>> original 32-bit ACPI 1.0 was introduced. These days, ACPI tables can all
>>> support 64-bit memory addresses, and so QEMU has been updated to emit
>>> 64-bit table and entry point types on arm64/mach-virt.  
>>
>> Do you have commit cb51ac2ffe36 ("hw/arm/virt: generate 64-bit
>> addressable ACPI objects", 2017-04-10) in mind?

> My understanding was that OVMF discards RSDP/[RX]SDT so that commit
> probably irrelevant.

OVMF does not install these root tables, that's correct, but it does
execute the commands that refer to the blob(s) that contain these
tables. So for example pointers and checksums are updated, it's only the
last heuristics phase that detects if a pointer points to RSDT / XSDT
and then those tables are not installed.

OVMF catches pointer field overflows, and rolls back the entire
processing if one occurs. So the commit in question is certainly
relevant; without it, a >4GB allocation address would be added to an
RSDT entry (which is 4-byte wide), and that would fail the entire process.

> Now about FADT or any other blob, do we really need to extend
> loader protocol? Couldn't firmware decide where to allocate
> table based on size in add_pointer commands?
> 
> That might be a bit complicated but on the bright side is that
> it is firmware only change and it should work both on old and
> new qemu without breaking anything.

For this I'd have to pre-scan the ADD_POINTER commands, and for target
blob ever pointed-at by them, find the minimum referring pointer width.
If that minimum width is smaller than 8 bytes, the pointed-at blob must
be allocated under 4GB.

I think this is too complex (it would add a third pass to OVMF's
processing), especially given that we already have a dedicated Zone
field that specifically tells the firmware where the blobs should be
allocated. The goal is to decrease the dirty tricks in OVMF, not
increase them.

Furthermore, this wouldn't help us turn off the SDT header probing in
OVMF (the feature that currently requires those strange AML-level offset
increments, into blobs that don't host ACPI tables). Suppressing the
probe in a nice way surely needs a specific hint, so we might as well
handle both cases with Zone extensions.

Laszlo
