Received: from eggs.gnu.org ([2001:4830:134:3::10]:52012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cgErR-0001OO-6l
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 13:08:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cgErO-0001IM-0b
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 13:08:25 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:35950)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cgErN-0001Ht-Pd
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 13:08:21 -0500
Received: by mail-wm0-x242.google.com with SMTP id r18so21107768wmd.3
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 10:08:21 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1487361200-29966-1-git-send-email-mst@redhat.com>
	<1487361200-29966-13-git-send-email-mst@redhat.com>
	<1487681835.2694.76.camel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3692fe08-f779-b713-6405-357726ca564f@redhat.com>
Date: Tue, 21 Feb 2017 19:08:17 +0100
MIME-Version: 1.0
In-Reply-To: <1487681835.2694.76.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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
To: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>



On 21/02/2017 13:57, Gerd Hoffmann wrote:
> This change breaks ovmf for me, although it isn't obvious to me why.
> Bisect landed here, and reverting indeed makes things going again.
> 
> Using q35 machine type, pcie virtio devices, with the rhel ovmf build
> (OVMF-20160608b-1.git988715a.el7.noarch).
> 
> First thing I've tried is swapping virtio-net for another nic,
> suspecting this change might trigger a bug in the ovmf virtio-net
> driver, but that didn't change things.
> 
> Effect is that qemu just exits, without logging some error, looks like a
> normal guest shutdown.  Firmware log doesn't give a clue either, it just
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

Command line?  I tried with

x86_64-softmmu/qemu-system-x86_64 \
  -pflash /usr/share/edk2/ovmf/OVMF_CODE.fd \
  -pflash /usr/share/edk2/ovmf/OVMF_VARS.fd  \
  --enable-kvm -M q35 -debugcon stdio \
  -global isa-debugcon.iobase=0x402 \
  -net nic,model=virtio \
  -net bridge,helper=/usr/libexec/qemu-bridge-helper,br=virbr0 \
  -snapshot foo.raw

and after the above lines I get:

Select Item: 0x19
[Bds]OsIndication: 0000000000000000
[Bds]=============Begin Load Options Dumping ...=============
  Driver Options:
  SysPrep Options:
  Boot Options:
    Boot0000: UiApp              0x0109
    Boot0001: UEFI QEMU DVD-ROM QM00005                  0x0001
    Boot0002: UEFI QEMU HARDDISK QM00001                 0x0001
    Boot0003: EFI Internal Shell                 0x0001
  PlatformRecovery Options:
    PlatformRecovery0000: Default PlatformRecovery               0x0001

(but I'm using a different OVMF build,
edk2-ovmf-20161105git3b25ca8-2.fc25.noarch; dinner time now).

Thanks,

Paolo
