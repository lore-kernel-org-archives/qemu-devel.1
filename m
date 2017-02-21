Received: from eggs.gnu.org ([2001:4830:134:3::10]:38651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cgDFa-0006Ia-UP
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:25:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cgDFZ-00012y-L7
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:25:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cgDFZ-00012e-C5
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:25:13 -0500
References: <1487361200-29966-1-git-send-email-mst@redhat.com>
	<1487361200-29966-13-git-send-email-mst@redhat.com>
	<1487681835.2694.76.camel@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <c0d16fc6-e149-861d-8f82-5a96619606bd@redhat.com>
Date: Tue, 21 Feb 2017 17:25:09 +0100
MIME-Version: 1.0
In-Reply-To: <1487681835.2694.76.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 12/23] virtio: use VRingMemoryRegionCaches
 for avail and used rings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 02/21/17 13:57, Gerd Hoffmann wrote:
> On Fr, 2017-02-17 at 21:54 +0200, Michael S. Tsirkin wrote:
>> From: Paolo Bonzini <pbonzini@redhat.com>
>>
>> The virtio-net change is necessary because it uses virtqueue_fill
>> and virtqueue_flush instead of the more convenient virtqueue_push.
>>
>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> This change breaks ovmf for me, although it isn't obvious to me why.
> Bisect landed here, and reverting indeed makes things going again.

I looked at the patch (on the list) and I don't have the slightest idea
what's going on. I read the word "cache" in it, so I guess it introduces
(or exposes) some cache coherency issue.

> Using q35 machine type, pcie virtio devices, with the rhel ovmf build
> (OVMF-20160608b-1.git988715a.el7.noarch).
> 
> First thing I've tried is swapping virtio-net for another nic,
> suspecting this change might trigger a bug in the ovmf virtio-net
> driver, but that didn't change things.
> 
> Effect is that qemu just exits, without logging some error, looks like a
> normal guest shutdown.

That's very strange (especially given the OVMF log below).

> Firmware log doesn't give a clue either, it just
> stops at some point, again without any error message.  Here are the last
> lines of the log:
> 
> SataControllerStart START
> SataControllerStart error return status = Already started
> SetPciIntLine: [00:1C.0] PciRoot(0x0)/Pci(0x1C,0x0) -> 0x0A
> SetPciIntLine: [01:00.0] PciRoot(0x0)/Pci(0x1C,0x0)/Pci(0x0,0x0) -> 0x0A
> SetPciIntLine: [00:1C.1] PciRoot(0x0)/Pci(0x1C,0x1) -> 0x0A
> SetPciIntLine: [02:00.0] PciRoot(0x0)/Pci(0x1C,0x1)/Pci(0x0,0x0) -> 0x0A
> SetPciIntLine: [00:1C.2] PciRoot(0x0)/Pci(0x1C,0x2) -> 0x0A
> SetPciIntLine: [00:1C.3] PciRoot(0x0)/Pci(0x1C,0x3) -> 0x0A
> SetPciIntLine: [00:1C.4] PciRoot(0x0)/Pci(0x1C,0x4) -> 0x0A
> SetPciIntLine: [05:00.0] PciRoot(0x0)/Pci(0x1C,0x4)/Pci(0x0,0x0) -> 0x0A
> SetPciIntLine: [05:00.1] PciRoot(0x0)/Pci(0x1C,0x4)/Pci(0x0,0x1) -> 0x0A
> SetPciIntLine: [05:00.2] PciRoot(0x0)/Pci(0x1C,0x4)/Pci(0x0,0x2) -> 0x0A
> SetPciIntLine: [00:1C.5] PciRoot(0x0)/Pci(0x1C,0x5) -> 0x0A
> SetPciIntLine: [06:00.0] PciRoot(0x0)/Pci(0x1C,0x5)/Pci(0x0,0x0) -> 0x0A
> SetPciIntLine: [00:1C.6] PciRoot(0x0)/Pci(0x1C,0x6) -> 0x0A
> SetPciIntLine: [00:1C.7] PciRoot(0x0)/Pci(0x1C,0x7) -> 0x0A
> SetPciIntLine: [00:1F.2] PciRoot(0x0)/Pci(0x1F,0x2) -> 0x0A
> SetPciIntLine: [00:1F.3] PciRoot(0x0)/Pci(0x1F,0x3) -> 0x0A
> Select Item: 0x8
> Select Item: 0x17
> qemu -kernel was not used.

The next action would be the EfiBootManagerRefreshAllBootOption()
function call in PlatformBootManagerAfterConsole(), in file
"OvmfPkg/Library/PlatformBootManagerLib/BdsPlatform.c".

That function (from "MdeModulePkg/Library/UefiBootManagerLib/BmBoot.c")
"enumerates all boot options, creates them and registers them in the
BootOrder variable". While doing that, it definitely looks (indirectly)
at any UEFI-bootable virtio-scsi or virtio-blk device.

The direct symptom you are seeing ("qemu just exits / shuts down") is
inexplicable. If there were a virtio-de-sync between guest and host, I'd
expect OVMF to hang, and/or emit error messages.

Thanks
Laszlo
