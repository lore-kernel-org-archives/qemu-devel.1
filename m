Received: from eggs.gnu.org ([2001:4830:134:3::10]:39770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cgFmU-0000h5-My
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 14:07:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cgFmP-000151-OU
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 14:07:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cgFmP-00014n-FN
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 14:07:17 -0500
References: <1487361200-29966-1-git-send-email-mst@redhat.com>
	<1487361200-29966-13-git-send-email-mst@redhat.com>
	<1487681835.2694.76.camel@redhat.com>
	<3692fe08-f779-b713-6405-357726ca564f@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <c008fcbb-96cc-285a-099a-a5ad4b9848c3@redhat.com>
Date: Tue, 21 Feb 2017 20:07:13 +0100
MIME-Version: 1.0
In-Reply-To: <3692fe08-f779-b713-6405-357726ca564f@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On 02/21/17 19:08, Paolo Bonzini wrote:
> 
> 
> On 21/02/2017 13:57, Gerd Hoffmann wrote:
>> This change breaks ovmf for me, although it isn't obvious to me why.
>> Bisect landed here, and reverting indeed makes things going again.
>>
>> Using q35 machine type, pcie virtio devices, with the rhel ovmf build
>> (OVMF-20160608b-1.git988715a.el7.noarch).
>>
>> First thing I've tried is swapping virtio-net for another nic,
>> suspecting this change might trigger a bug in the ovmf virtio-net
>> driver, but that didn't change things.
>>
>> Effect is that qemu just exits, without logging some error, looks like a
>> normal guest shutdown.  Firmware log doesn't give a clue either, it just
>> stops at some point, again without any error message.  Here are the last
>> lines of the log:
>>
>> SataControllerStart START
>> SataControllerStart error return status = Already started
>> SetPciIntLine: [00:1C.0] PciRoot(0x0)/Pci(0x1C,0x0) -> 0x0A
>> SetPciIntLine: [01:00.0] PciRoot(0x0)/Pci(0x1C,0x0)/Pci(0x0,0x0) -> 0x0A
>> SetPciIntLine: [00:1C.1] PciRoot(0x0)/Pci(0x1C,0x1) -> 0x0A
>> SetPciIntLine: [02:00.0] PciRoot(0x0)/Pci(0x1C,0x1)/Pci(0x0,0x0) -> 0x0A
>> SetPciIntLine: [00:1C.2] PciRoot(0x0)/Pci(0x1C,0x2) -> 0x0A
>> SetPciIntLine: [00:1C.3] PciRoot(0x0)/Pci(0x1C,0x3) -> 0x0A
>> SetPciIntLine: [00:1C.4] PciRoot(0x0)/Pci(0x1C,0x4) -> 0x0A
>> SetPciIntLine: [05:00.0] PciRoot(0x0)/Pci(0x1C,0x4)/Pci(0x0,0x0) -> 0x0A
>> SetPciIntLine: [05:00.1] PciRoot(0x0)/Pci(0x1C,0x4)/Pci(0x0,0x1) -> 0x0A
>> SetPciIntLine: [05:00.2] PciRoot(0x0)/Pci(0x1C,0x4)/Pci(0x0,0x2) -> 0x0A
>> SetPciIntLine: [00:1C.5] PciRoot(0x0)/Pci(0x1C,0x5) -> 0x0A
>> SetPciIntLine: [06:00.0] PciRoot(0x0)/Pci(0x1C,0x5)/Pci(0x0,0x0) -> 0x0A
>> SetPciIntLine: [00:1C.6] PciRoot(0x0)/Pci(0x1C,0x6) -> 0x0A
>> SetPciIntLine: [00:1C.7] PciRoot(0x0)/Pci(0x1C,0x7) -> 0x0A
>> SetPciIntLine: [00:1F.2] PciRoot(0x0)/Pci(0x1F,0x2) -> 0x0A
>> SetPciIntLine: [00:1F.3] PciRoot(0x0)/Pci(0x1F,0x3) -> 0x0A
>> Select Item: 0x8
>> Select Item: 0x17
>> qemu -kernel was not used.
> 
> Command line?  I tried with
> 
> x86_64-softmmu/qemu-system-x86_64 \
>   -pflash /usr/share/edk2/ovmf/OVMF_CODE.fd \
>   -pflash /usr/share/edk2/ovmf/OVMF_VARS.fd  \
>   --enable-kvm -M q35 -debugcon stdio \
>   -global isa-debugcon.iobase=0x402 \
>   -net nic,model=virtio \
>   -net bridge,helper=/usr/libexec/qemu-bridge-helper,br=virbr0 \
>   -snapshot foo.raw
> 
> and after the above lines I get:
> 
> Select Item: 0x19
> [Bds]OsIndication: 0000000000000000
> [Bds]=============Begin Load Options Dumping ...=============
>   Driver Options:
>   SysPrep Options:
>   Boot Options:
>     Boot0000: UiApp              0x0109
>     Boot0001: UEFI QEMU DVD-ROM QM00005                  0x0001
>     Boot0002: UEFI QEMU HARDDISK QM00001                 0x0001
>     Boot0003: EFI Internal Shell                 0x0001
>   PlatformRecovery Options:
>     PlatformRecovery0000: Default PlatformRecovery               0x0001
> 
> (but I'm using a different OVMF build,
> edk2-ovmf-20161105git3b25ca8-2.fc25.noarch; dinner time now).

The bug reproduces for me with current upstream OVMF. I sent a full QEMU
backtrace (SIGSEGV) in another message. I use libvirt (and I assume Gerd
does that too, because otherwise the shell would report the SIGSEGV
immediately).

Interestingly, in that call stack, I see pflash_update -> blk_pwrite ->
blk_prw -> aio_poll -> ... -> virtio_queue_host_notifier_aio_poll.
Therefore the direct trigger seems to be a UEFI variable update, but I
don't understand how that lands in virtio code in QEMU.

Thanks
Laszlo
