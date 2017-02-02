Received: from eggs.gnu.org ([2001:4830:134:3::10]:41495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marc.zyngier@arm.com>) id 1cZIrU-0003M6-QA
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:59:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marc.zyngier@arm.com>) id 1cZIrQ-00005S-TP
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:59:48 -0500
Received: from foss.arm.com ([217.140.101.70]:38634)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marc.zyngier@arm.com>) id 1cZIrQ-0008WD-N1
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:59:44 -0500
References: <32ff6fa9-696a-f4a2-e884-3b22f91506e5@iki.fi>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <fd9dbed6-2a65-24e8-2f76-f6f814cef1d5@arm.com>
Date: Thu, 2 Feb 2017 14:59:40 +0000
MIME-Version: 1.0
In-Reply-To: <32ff6fa9-696a-f4a2-e884-3b22f91506e5@iki.fi>
Content-Type: text/plain; charset=utf-8
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
To: Pekka Enberg <penberg@iki.fi>, kvm@vger.kernel.org, qemu-devel@nongnu.org
Cc: Christoffer Dall <christoffer.dall@linaro.org>

[+Christoffer]

Hi Pekka,

On 02/02/17 14:44, Pekka Enberg wrote:
> Hi,
>=20
> Has anyone been able to successfully run QEMU/KVM under Raspberry Pi 3?
>=20
> I have installed 64-bit Fedora 24 by Gerd Hoffmann on the hardware:
>=20
>    https://www.kraxel.org/blog/2016/04/fedora-on-raspberry-pi-updates/
>=20
> and built a VM image using virt-builder:
>=20
>    virt-builder --root-password password:root --arch aarch64 fedora-24
>=20
> I also built the latest UEFI for QEMU from sources:
>=20
>    https://wiki.linaro.org/LEG/UEFIforQEMU
>=20
> and updated to QEMU 2.8.0 from rawhide:
>=20
>    [root@fedora-rpi2 ~]# qemu-system-aarch64 -version
>    QEMU emulator version 2.8.0(qemu-2.8.0-1.fc26)
>    Copyright (c) 2003-2016 Fabrice Bellard and the QEMU Project develop=
ers
>=20
> The VM image should be fine because I=E2=80=99m able to boot to it unde=
r CPU=20
> emulation:
>=20
> qemu-system-aarch64 \
>            -nographic \
>            -M virt \
>            -cpu cortex-a57 \
>            -smp 1 \
>            -m 512 \
>            -bios QEMU_EFI.fd \
>            -device virtio-blk-device,drive=3Dimage -drive=20
> if=3Dnone,id=3Dimage,file=3Dfedora-24.img \
>            -netdev bridge,id=3Dhn0,br=3Dvirbr0 -device=20
> virtio-net-pci,netdev=3Dhn0,romfile=3D \
>            -device virtio-rng-pci
>=20
> However, when I enable KVM, keyboard stops working (interrupt delivery=20
> issue?) and Fedora boot process hangs at random places before reaching=20
> login:

[snip]

TL;DR: as it stands now, none of the RPi{2,3} can run KVM out of the
box, as they lack a virtualization capable interrupt controller. This
means that timer interrupts cannot be reported to the core, and things
die a painful death.

The longer story: we have a set of patches somewhere on the list that do
enable the timer interrupts to be reported to userspace (QEMU), which
can then inject them into its on GIC emulation and kick the vcpu. So
far, work on this seems to have stopped (API issues? QEMU patches?)

Christoffer was about to revive the kernel patches, but we need someone
to pick up the QEMU part, and work with us and the QEMU people so that
we agree once and for all on the ABI to signal PPIs to userspace.

Once everyone is happy with the way it looks, we'll merge the patches,
and I take that the QEMU folks will do the same with their side of things=
.

Thanks,

	M.
--=20
Jazz is not dead. It just smells funny...
