Received: from eggs.gnu.org ([2001:4830:134:3::10]:48804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fOJcl-0001lT-NN
	for qemu-devel@nongnu.org; Thu, 31 May 2018 05:12:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fOJch-00083T-Gx
	for qemu-devel@nongnu.org; Thu, 31 May 2018 05:11:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47906 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fOJch-00082t-AI
	for qemu-devel@nongnu.org; Thu, 31 May 2018 05:11:55 -0400
References: <20180323122520.11270-1-kraxel@redhat.com>
	<43fc23c1-d72f-748a-5b9d-a816466d7406@redhat.com>
	<20180425140749.6x3w4h4i2n6uaq7o@sirius.home.kraxel.org>
	<1ed94b1c-b416-eebe-9cf3-91943a0e6c5a@redhat.com>
	<20180531084347.xb2r5aolkis2nmqg@sirius.home.kraxel.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <4b65af58-8451-a365-6c81-52c49e42b6ff@redhat.com>
Date: Thu, 31 May 2018 11:11:51 +0200
MIME-Version: 1.0
In-Reply-To: <20180531084347.xb2r5aolkis2nmqg@sirius.home.kraxel.org>
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

On 05/31/18 10:43, Gerd Hoffmann wrote:
>   Hi,
> 
> Resuming an old discussion ...
> 
>>> From
>>> the guests point of view there is no difference between
>>>
>>>   (a) qemu -device virtio-ramfb, and
>>>   (b) qemu -device virtio-gpu-pci -device ramfb-testdev
>>>
>>> On the host side the difference is that (a) is a single QemuConsole
>>> which shows virtio-gpu-pci once activated and ramfb otherwise, and
>>> (b) is two QemuConsoles, so you can see both virtio-gpu-pci and ramfb
>>> side-by-side, for debugging purposes.
>>
>> Exactly this "multiple frontends, single backend" connection is the
>> problem. In UEFI, it is possible to establish a priority order between
>> drivers that are all capable of binding the same controller ("handle"),
>> but especially with ramfb + another (PCI) video frontend, it's the
>> "handles" that are different. The "priority mechanism" would have no
>> idea that the drivers cannot peacefully coexist, i.e. it's clueless
>> about the (host side only) competition.
> 
> Well, virtio-vga and qxl-vga are very simliar.  They both are two-in-one
> devices, with legacy vga frontend and native (qxl/virtio) frontend
> sharing a single backend.  When the guest initialized the native
> frontend the backend switches over from vga to native.

True -- the difference is however, that the firmware doesn't even try to
drive the native QXL frontend; it's clueless about it.

IOW, in the (QXL, VGA) two-in-one device, the firmware only sees VGA,
because the firmware entirely (globally) ignores the QXL frontend; it
has no driver for native QXL.

We couldn't do that for virtio-gpu (we really wanted to drive it for
aarch64's sake), so the (virtio-gpu, VGA) two-in-one device required
special hacks, to prevent double-binding.

[snip]

>> I could imagine an OvmfPkg-specific PCI capability that said, "all PCI
>> drivers in OvmfPkg that could otherwise drive this device, ignore it --
>> another (platform) driver in OvmfPkg will pick it up instead".
> 
> pci capability for ramfb could be useful (also for linux).  I'll keep it
> in mind for now.

Please do. :)

When you brought up the PCI capability last time in this thread (and I
liked it), I realized that scanning for this new (likely "vendor")
capability would require me to code up the *third* PCI caplist scanning
loop in OVMF.

(Until that point we had implemented two such scans, one in the
virtio-1.0 driver, because virtio-1.0 uses vendor capabilities
liberally, and the other one in PciHotPlugInitDxe, which looks for the
PCI resource reservation hints on bridges, for hotplug purposes.)

After I had added the 2nd such scan (in PciHotPlugInitDxe), Jordan
suggested that we should rather use some helper library to save us the
manual fiddling with the capability headers and contents.

So, when you brought up PCI capabilities the last time in this thread,
the foreseeable "third scan" got stuck in my mind, and it ultimtely
spurred me to write that helper library, originally suggested by Jordan.
It's been upstream for a week now, and both Virtio10Dxe and
PciHotPlugInitDxe have been converted to use it (commit range
4b8552d794e7..5685a243b6f8). (Thank you Ard again for the review.)

If you add the above-suggested

  "hands off for platform drivers' sake"

capability in QEMU, I think we'll be able to locate and parse it cleanly
in the OVMF PCI drivers that need to honor it.

Thanks!
Laszlo
