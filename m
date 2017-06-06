Received: from eggs.gnu.org ([2001:4830:134:3::10]:39376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dIIei-0002oG-3V
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 13:52:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dIIee-0003o0-DY
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 13:52:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dIIee-0003nl-7S
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 13:52:32 -0400
References: <c76b36de-ebf9-c662-d454-0a95b43901e8@redhat.com>
	<2ff62b03-d71b-93c4-79bf-10682b229758@redhat.com>
	<20170605115429.29c252f6@nial.brq.redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <7a08004a-cc4d-6144-4fc8-4b85062033e8@redhat.com>
Date: Tue, 6 Jun 2017 19:52:21 +0200
MIME-Version: 1.0
In-Reply-To: <20170605115429.29c252f6@nial.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] allocation zone extensions for the firmware
 linker/loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: SeaBIOS devel list <SeaBIOS@seabios.org>, qemu devel list <qemu-devel@nongnu.org>, edk2-devel-ml01 <edk2-devel@ml01.01.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Ben Warren <ben@skyportsystems.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Xiao Guangrong <guangrong.xiao@linux.intel.com>, "Jordan Justen (Intel address)" <jordan.l.justen@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Leif Lindholm (Linaro address)" <leif.lindholm@linaro.org>, Dongjiu Geng <gengdongjiu@huawei.com>, Kevin O'Connor <kevin@koconnor.net>, Gerd Hoffmann <kraxel@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>

On 06/05/17 11:54, Igor Mammedov wrote:

> BTW:
> how OVMF would deal with booting 32-bit OS if it would allocate
> ACPI tables above 4Gb?
> For BIOS on baremetal I'd expect some switch in settings, something
> like "Disable 32-bit OS support".

In order to answer your question exhaustively, I'd have to ponder this a
lot longer. For now my basic answer is the following:

- If you can allocate memory above 4GB in the DXE phase, that means your
DXE and BDS phases are 64-bit. Which in turn implies you *cannot* boot a
32-bit OS at all.

Generally speaking, with PI / UEFI, the bitness of the firmware (the DXE
and the BDS phases) and the bitness of the OS (incl. its UEFI boot
loader) must be identical.

As a trick, Linux can work around this, in *one* direction -- 64-bit
Linux can run on 32-bit UEFI firmware (on x86; not sure about other
arches). But, the other direction (32-bit UEFI OS on 64-bit firmware)
cannot work, minimally because you can only call the UEFI runtime
services in 64-bit mode.

In short (again, this is quite rudimentary), if your memory allocation
in the DXE and/or BDS phases ends up being served from above 4GB, you
won't be booting a 32-bit-only OS.

Thanks
Laszlo
