Received: from eggs.gnu.org ([2001:4830:134:3::10]:37801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fLFBM-0000jR-MZ
	for qemu-devel@nongnu.org; Tue, 22 May 2018 17:51:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fLFBJ-0004Oi-J9
	for qemu-devel@nongnu.org; Tue, 22 May 2018 17:51:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37920 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fLFBJ-0004OO-DR
	for qemu-devel@nongnu.org; Tue, 22 May 2018 17:50:57 -0400
References: <1526801333-30613-1-git-send-email-whois.zihan.yang@gmail.com>
	<1526801333-30613-4-git-send-email-whois.zihan.yang@gmail.com>
	<ef3fc85d-7726-c888-e8ca-9dfae1b908d3@gmail.com>
	<17a3765f-b835-2d45-e8b9-ffd4aff909f9@redhat.com>
	<cbdfe0d6-f071-3560-009d-3bbdde12b33c@gmail.com>
	<f71a8c61-a0d7-6ebc-62ad-3dab8b9f8e5a@redhat.com>
	<20180522151732.36122156@w520.home>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <1d16a569-bdc2-93d8-09e7-cd76f3899c36@redhat.com>
Date: Tue, 22 May 2018 23:50:54 +0200
MIME-Version: 1.0
In-Reply-To: <20180522151732.36122156@w520.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Zihan Yang <whois.zihan.yang@gmail.com>, qemu-devel@nongnu.org, Wei Huang <wei@redhat.com>, Drew Jones <drjones@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eric Auger <eauger@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On 05/22/18 23:17, Alex Williamson wrote:
> On Tue, 22 May 2018 21:51:47 +0200
> Laszlo Ersek <lersek@redhat.com> wrote:

Thanks Michael and Alex for the education on ARI.

I'd just like to comment on one sub-topic:

>> There are signs that the edk2 core supports ARI if the underlying
>> platform supports it. (Which is not the case with multiple PCIe domains
>> / multiple ECAM ranges.)
> 
> It's pretty surprising to me that edk2 wouldn't already have support
> for multiple PCIe domains, they're really not *that* uncommon.  Some
> architectures make almost gratuitous use of PCIe domains.  I certainly
> know there were UEFI ia64 platforms with multiple domains.

>> Semantics :) Obviously, everything "can be done" in software; that's why
>> it's *soft*ware. Who is going to write it in practice? It had taken
>> years until the edk2 core gained a universal PciHostBridgeDxe driver
>> with a well-defined platform customization interface, and that interface
>> doesn't support multiple domains / segments. It had also taken years
>> until the same edk2 core driver gained support for nonzero MMIO address
>> translation (i.e. where the CPU view of system RAM addresses differs
>> from the PCI device view of the same, for DMA purposes) -- and that's
>> just a linear translation, not even about IOMMUs. The PCI core
>> maintainers in edk2 are always very busy, and upstreaming such changes
>> tends to take forever.
> 
> Wow, that's surprising, ia64 was doing all of that on UEFI platforms a
> decade ago.

Plenty of physical PI/UEFI platforms support multiple PCIe domains
(similarly to how plenty of physical PI/UEFI platforms support CPU
hotplug with SMM).

None of that is open source, to my knowledge, so it might as well not
exist. EDK2 purposely does not accept any contributions under the GPL.
Convincing proprietary downstreams to open up and upstream their code is
nigh impossible, and even when it succeeds, it takes absolutely forever.

Technically it also happens that a proprietary downstream contributes an
independent (likely more limited) open source variant of a feature that
their physical platforms support -- assuming they see (or are shown)
value in allocating resources to such a contribution. This is very rare,
and I'm including it for technical correctness.

For open source edk2 this would be a development from zero; it would
even conflict with some assumptions in edk2.

(On May 4th I submitted a small library to core edk2 that parses the
capabilities lists of a device and puts the capabilities into an
associative array (basically a dictionary). So that we wouldn't have to
open-code yet more caplist parsing loops when looking for specific
capabilities. In 18 days I've pinged once and haven't gotten any
technical feedback. I'm not even annoyed because I know they simply
don't have time for reviewing larger than halfway trivial patches.)

Thanks,
Laszlo
