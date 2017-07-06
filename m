Received: from eggs.gnu.org ([2001:4830:134:3::10]:55568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dT3MQ-0007QJ-I4
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 05:46:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dT3ML-0007LY-NU
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 05:46:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dT3ML-0007Kv-Gr
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 05:46:05 -0400
References: <895558F6EA4E3B41AC93A00D163B7274162E2512@SHSMSX103.ccr.corp.intel.com>
	<503895c7-4649-a568-2ee4-0fea1908fd60@redhat.com>
	<537c874c-a5d4-30ce-6bb2-1a2bc345f66a@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <d3c0a77d-3559-c67e-705c-002460b783b2@redhat.com>
Date: Thu, 6 Jul 2017 11:46:00 +0200
MIME-Version: 1.0
In-Reply-To: <537c874c-a5d4-30ce-6bb2-1a2bc345f66a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] The maximum limit of virtual network device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, "Wu, Jiaxin" <jiaxin.wu@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Alexander Bezzubikov <zuban32s@gmail.com>

On 07/06/17 11:24, Marcel Apfelbaum wrote:
> On 06/07/2017 11:31, Laszlo Ersek wrote:

>> > Now, I would normally recommend sticking with i440fx for simplicity.
>> However, each PCI bridge requires 4KB of IO space (meaning (1 + 5) * 4KB
>> = 24KB),  and OVMF on the i440fx does not support that much (only
>> 0x4000). So, I'll recommend Q35 for IO space purposes; OVMF on Q35
>> provides 0xA000 (40KB).
> 
> So if we use OVMF, going for Q35 gives us actually more IO space, nice!
> However recommending Q35 for IO space seems odd :)

OVMF used to have only 0x4000 bytes for PCI IO aperture, since the
beginning. In <https://bugzilla.redhat.com/show_bug.cgi?id=1333238> I
investigated how much I could grow the aperture. On Q35, it was possible
to grow it to 0xA000 bytes (but even then you have to disable vmport,
which sort of sits in the middle otherwise). On i440fx, the IO ports in
use by platform devices were so badly distributed that moving beyond
0x4000 was not possible. See in particular:

https://bugzilla.redhat.com/show_bug.cgi?id=1333238#c16
https://bugzilla.redhat.com/show_bug.cgi?id=1333238#c19

>> Therefore I guess the simplest example I can give now is:
>> - use Q35 (for a larger IO space),
>> - plug a DMI-PCI bridge into the root bridge,
>> - plug 5 PCI bridges into the DMI-PCI bridge,
>> - plug 31 NICs per PCI bridge, each NIC into a separate slot.
>>
> 
> The setup looks OK to me (assuming OVMF is needed, otherwise
> PC + pci-bridges will result in more devices),

OVMF is quite needed; Jiaxin is one of the edk2 networking maintainers,
and I think he's using QEMU and OVMF as a testbed for otherwise
physically-oriented UEFI development.

> I do have a little concern.
> We want to deprecate the dmi-pci bridge since it does not support
> hot-plug (for itself or devices behind it).
> Alexandr (CCed) is a GSOC student working on a generic
> pcie-pci bridge that can (eventually) be hot-plugged
> into a PCIe Root Port and keeps the machine cleaner.

Nice!

Please include an update to "docs/pcie.txt" in the scope :)

Thanks!
Laszlo
