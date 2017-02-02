Received: from eggs.gnu.org ([2001:4830:134:3::10]:44972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <christoffer.dall@linaro.org>) id 1cZJ3S-0006Qo-NT
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:12:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <christoffer.dall@linaro.org>) id 1cZJ3O-0005rd-D2
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:12:10 -0500
Received: from mail-yw0-x22a.google.com ([2607:f8b0:4002:c05::22a]:34245)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <christoffer.dall@linaro.org>)
	id 1cZJ3O-0005rO-8j
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:12:06 -0500
Received: by mail-yw0-x22a.google.com with SMTP id w75so13021769ywg.1
	for <qemu-devel@nongnu.org>; Thu, 02 Feb 2017 07:12:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <fd9dbed6-2a65-24e8-2f76-f6f814cef1d5@arm.com>
References: <32ff6fa9-696a-f4a2-e884-3b22f91506e5@iki.fi>
	<fd9dbed6-2a65-24e8-2f76-f6f814cef1d5@arm.com>
From: Christoffer Dall <cdall@linaro.org>
Date: Thu, 2 Feb 2017 16:12:04 +0100
Message-ID: <CAMJs5B8k3h5BTT3Y7g6XrX+wqo7_xZt0kdQb4do95hWi0xCDiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] KVM/QEMU on Raspberry Pi 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Pekka Enberg <penberg@iki.fi>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, Feb 2, 2017 at 3:59 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> [+Christoffer]
>
> Hi Pekka,
>
> On 02/02/17 14:44, Pekka Enberg wrote:
>> Hi,
>>
>> Has anyone been able to successfully run QEMU/KVM under Raspberry Pi 3?
>>
>> I have installed 64-bit Fedora 24 by Gerd Hoffmann on the hardware:
>>
>>    https://www.kraxel.org/blog/2016/04/fedora-on-raspberry-pi-updates/
>>
>> and built a VM image using virt-builder:
>>
>>    virt-builder --root-password password:root --arch aarch64 fedora-24
>>
>> I also built the latest UEFI for QEMU from sources:
>>
>>    https://wiki.linaro.org/LEG/UEFIforQEMU
>>
>> and updated to QEMU 2.8.0 from rawhide:
>>
>>    [root@fedora-rpi2 ~]# qemu-system-aarch64 -version
>>    QEMU emulator version 2.8.0(qemu-2.8.0-1.fc26)
>>    Copyright (c) 2003-2016 Fabrice Bellard and the QEMU Project develope=
rs
>>
>> The VM image should be fine because I=E2=80=99m able to boot to it under=
 CPU
>> emulation:
>>
>> qemu-system-aarch64 \
>>            -nographic \
>>            -M virt \
>>            -cpu cortex-a57 \
>>            -smp 1 \
>>            -m 512 \
>>            -bios QEMU_EFI.fd \
>>            -device virtio-blk-device,drive=3Dimage -drive
>> if=3Dnone,id=3Dimage,file=3Dfedora-24.img \
>>            -netdev bridge,id=3Dhn0,br=3Dvirbr0 -device
>> virtio-net-pci,netdev=3Dhn0,romfile=3D \
>>            -device virtio-rng-pci
>>
>> However, when I enable KVM, keyboard stops working (interrupt delivery
>> issue?) and Fedora boot process hangs at random places before reaching
>> login:
>
> [snip]
>
> TL;DR: as it stands now, none of the RPi{2,3} can run KVM out of the
> box, as they lack a virtualization capable interrupt controller. This
> means that timer interrupts cannot be reported to the core, and things
> die a painful death.
>
> The longer story: we have a set of patches somewhere on the list that do
> enable the timer interrupts to be reported to userspace (QEMU), which
> can then inject them into its on GIC emulation and kick the vcpu. So
> far, work on this seems to have stopped (API issues? QEMU patches?)
>
> Christoffer was about to revive the kernel patches, but we need someone
> to pick up the QEMU part, and work with us and the QEMU people so that
> we agree once and for all on the ABI to signal PPIs to userspace.

Interesting timing.  I just revived the patches today, but I reworked
the ABI slightly and rebased the work on top of support for the
physical timer in the guest and ran into two issues: First, turning of
the in-kernel irqchip no longer works, and I also lost track of how
the patches should look, so indeed I need help from a QEMU person to
look at that.  Second, there is some sort of regression on the 32-bit
side using the physical timer patches.

Once I've sorted some of this out, I can send out the patch series.
At least I want to figure out the 32-bit breakage first, and then I
may simply send out the patches with a big fat UNTESTED warning in
hope that someone will work on the qemu side with me.

Thanks,
-Christoffer
