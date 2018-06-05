Received: from eggs.gnu.org ([2001:4830:134:3::10]:37519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fQAkP-00031u-Rp
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 08:07:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fQAkL-0008Sy-Rb
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 08:07:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46778 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fQAkL-0008S2-Ma
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 08:07:29 -0400
References: <20180323122520.11270-1-kraxel@redhat.com>
	<43fc23c1-d72f-748a-5b9d-a816466d7406@redhat.com>
	<20180425140749.6x3w4h4i2n6uaq7o@sirius.home.kraxel.org>
	<1ed94b1c-b416-eebe-9cf3-91943a0e6c5a@redhat.com>
	<20180531084347.xb2r5aolkis2nmqg@sirius.home.kraxel.org>
	<4b65af58-8451-a365-6c81-52c49e42b6ff@redhat.com>
	<20180605110647.7ctaj7fiy6x4ewdw@sirius.home.kraxel.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <a3fe57cf-1569-834d-5528-d85847b29f9f@redhat.com>
Date: Tue, 5 Jun 2018 14:07:27 +0200
MIME-Version: 1.0
In-Reply-To: <20180605110647.7ctaj7fiy6x4ewdw@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/7] ramfb: simple boot framebuffer,
 no legacy vga
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>

On 06/05/18 13:06, Gerd Hoffmann wrote:
>   Hi,
> 
>>>> I could imagine an OvmfPkg-specific PCI capability that said, "all PCI
>>>> drivers in OvmfPkg that could otherwise drive this device, ignore it --
>>>> another (platform) driver in OvmfPkg will pick it up instead".
>>>
>>> pci capability for ramfb could be useful (also for linux).  I'll keep it
>>> in mind for now.
>>
>> Please do. :)
> 
> Hmm, well.  Virtio 1.0 uses vendor specific capabilities already to
> define the regions, and they don't have a fixed field saying "this is
> for virtio".  So adding another vendor specific capability for something
> else on the same device is a bit problematic ...

Can we invent a non-PCI method, e.g. fw_cfg, that tells QemuVideoDxe and
Virtio10Dxe not to bind some PCI S/B/D/Fs? Something like:

(1) When the UEFI driver (QemuVideoDxe or Virtio10Dxe) is loaded, it
looks up and caches the fw_cfg selector key (from the fw_cfg directory)
for the fw_cfg file that exposes what S/B/D/Fs not to bind.

(2) When the UEFI driver is asked by BDS (Boot Device Selection) to
state if it supports a specific controller handle, the driver (same as
now) first checks if a PciIo protocol interface is available on the
handle at all. If so, the driver selects the cached fw_cfg selector.

(3) When the key is selected for the first time ever, QEMU refreshes the
contents of the fw_cfg file, with the S/B/D/Fs assigned to the combined
devices. The ordering should be fine here, because in step (2), we first
open a PciIo protocol interface (before selecting the fw_cfg key), and
successfully opening a PciIo interface implies that PciBusDxe has
enumerated the PCI(e) hierarchies and has assigned bus numbers to
devices. The fw_cfg file would be padded at machine startup to a large
enough size so that the regenerated contents fit.

I think this is similar to how ACPI is regenerated in QEMU, to reflect
the resources assigned to PCI(e) devices in various AML aperture
objects. (IIRC.)

(4) The UEFI driver reads (caches) the selected fw_cfg file into a
memory buffer, calls PciIo->GetLocation(), then searches the buffer for
a S/B/D/F match. If there's a match, then the driver returns
EFI_UNSUPPORTED.

(5) Once the fw_cfg file is read (cached), it could be reused for
deciding about further controller binding attempts (involving that
driver), without any further fw_cfg traffic (in that driver anyway).

Thanks,
Laszlo
