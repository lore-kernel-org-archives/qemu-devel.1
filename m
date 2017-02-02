Received: from eggs.gnu.org ([2001:4830:134:3::10]:54854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1cZLUS-0008RS-R6
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 12:48:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1cZLUR-0008T5-I5
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 12:48:12 -0500
Received: from mail-it0-x234.google.com ([2607:f8b0:4001:c0b::234]:33361)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1cZLUR-0008Sk-Bp
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 12:48:11 -0500
Received: by mail-it0-x234.google.com with SMTP id d9so4600606itc.0
	for <qemu-devel@nongnu.org>; Thu, 02 Feb 2017 09:48:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <128aeca5-099c-e82b-5cc7-314c899231de@redhat.com>
References: <32ff6fa9-696a-f4a2-e884-3b22f91506e5@iki.fi>
	<128aeca5-099c-e82b-5cc7-314c899231de@redhat.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 2 Feb 2017 17:48:10 +0000
Message-ID: <CAKv+Gu-k6ZS=+jd5eQ58_M44gzOCJzQhm212ASVr1espiB167A@mail.gmail.com>
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
To: Laszlo Ersek <lersek@redhat.com>
Cc: Pekka Enberg <penberg@iki.fi>, KVM devel mailing list <kvm@vger.kernel.org>, QEMU Developers <qemu-devel@nongnu.org>

On 2 February 2017 at 15:50, Laszlo Ersek <lersek@redhat.com> wrote:
> Adding Ard, just in case...
>
> I have one (half-)comment re: GICv3:
>
> On 02/02/17 15:44, Pekka Enberg wrote:
>> Hi,
>>
>> Has anyone been able to successfully run QEMU/KVM under Raspberry Pi 3?
>>
>> I have installed 64-bit Fedora 24 by Gerd Hoffmann on the hardware:
>>
>>   https://www.kraxel.org/blog/2016/04/fedora-on-raspberry-pi-updates/
>>
>> and built a VM image using virt-builder:
>>
>>   virt-builder --root-password password:root --arch aarch64 fedora-24
>>
>> I also built the latest UEFI for QEMU from sources:
>>
>>   https://wiki.linaro.org/LEG/UEFIforQEMU
>>
>> and updated to QEMU 2.8.0 from rawhide:
>>
>>   [root@fedora-rpi2 ~]# qemu-system-aarch64 -version
>>   QEMU emulator version 2.8.0(qemu-2.8.0-1.fc26)
>>   Copyright (c) 2003-2016 Fabrice Bellard and the QEMU Project developer=
s
>>
>> The VM image should be fine because I=E2=80=99m able to boot to it under=
 CPU
>> emulation:
>>
>> qemu-system-aarch64 \
>>           -nographic \
>>           -M virt \
>>           -cpu cortex-a57 \
>>           -smp 1 \
>>           -m 512 \
>>           -bios QEMU_EFI.fd \
>>           -device virtio-blk-device,drive=3Dimage -drive
>> if=3Dnone,id=3Dimage,file=3Dfedora-24.img \
>>           -netdev bridge,id=3Dhn0,br=3Dvirbr0 -device
>> virtio-net-pci,netdev=3Dhn0,romfile=3D \
>>           -device virtio-rng-pci
>>
[..]
>> I also tried to enable GIC v3 by adding the =E2=80=9C-machine gic-versio=
n=3D3=E2=80=9D
>> command one option but the UEFI firmware doesn=E2=80=99t like that:
>>
>> Found GIC v3 (re)distributor @ 0x8000000 (0x80A0000)
>>
>>
>> Synchronous Exception at 0x000000005BD5B820
>> PC 0x00005BD5B820 (0x00005BD58000+0x00003820) [ 0] ArmGicDxe.dll
>> PC 0x00005BD5BC38 (0x00005BD58000+0x00003C38) [ 0] ArmGicDxe.dll
>> PC 0x00005BD593B0 (0x00005BD58000+0x000013B0) [ 0] ArmGicDxe.dll
>> PC 0x00005BD590A0 (0x00005BD58000+0x000010A0) [ 0] ArmGicDxe.dll
>> PC 0x00005EF1ADF4 (0x00005EF14000+0x00006DF4) [ 1] DxeCore.dll
>> PC 0x00005EF32B0C (0x00005EF14000+0x0001EB0C) [ 1] DxeCore.dll
>> PC 0x00005EF165E4 (0x00005EF14000+0x000025E4) [ 1] DxeCore.dll
>> PC 0x00005EF15828 (0x00005EF14000+0x00001828) [ 1] DxeCore.dll
>> PC 0x00005EF15024 (0x00005EF14000+0x00001024) [ 1] DxeCore.dll
>>
>> [ 0]
>> /home/penberg/raspberrypi/uefi/edk2/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5=
/AARCH64/ArmPkg/Drivers/ArmGic/ArmGicDxe/DEBUG/ArmGicDxe.dll
>>
>> [ 1]
>> /home/penberg/raspberrypi/uefi/edk2/Build/ArmVirtQemu-AARCH64/DEBUG_GCC5=
/AARCH64/MdeModulePkg/Core/Dxe/DxeMain/DEBUG/DxeCore.dll
>>
>>
>>   X0 0x0000000000000036   X1 0x0000000000000004   X2 0x0000000000000036
>>   X3 0x0000000000000000
>>   X4 0x0000000000000001   X5 0x0000000000000000   X6 0x0A01191513061C12
>>   X7 0x121C06131519010A
>>   X8 0x00000000041ECB83   X9 0x0000000700000000  X10 0x0000000058B60000
>>  X11 0x0000000000000004
>>  X12 0x0000000000000001  X13 0x0000000000000008  X14 0x0000000000000000
>>  X15 0x0000000000000000
>>  X16 0x000000005EF13DF0  X17 0x0000000000000000  X18 0x0000000000000000
>>  X19 0x000000004007C268
>>  X20 0x0000000000000000  X21 0x0000000000000000  X22 0x0000000000000000
>>  X23 0x0000000000000000
>>  X24 0x0000000000000000  X25 0x0000000000000000  X26 0x0000000000000000
>>  X27 0x0000000000000000
>>  X28 0x0000000000000000   FP 0x000000005EF13D20   LR 0x000000005BD5BC38
>>
>>   V0 0xAFAFAFAFAFAFAFAF AFAFAFAFAFAFAFAF   V1 0x0000000000000000
>> 0000000000000000
>>   V2 0x0000000000000000 0000000000000000   V3 0x0000000000000000
>> 0000000000000000
>>   V4 0x0000000000000000 0000000000000000   V5 0x0000000000000000
>> 0000000000000000
>>   V6 0x0000000000000000 0000000000000000   V7 0x0000000000000000
>> 0000000000000000
>>   V8 0x0000000000000000 0000000000000000   V9 0x0000000000000000
>> 0000000000000000
>>  V10 0x0000000000000000 0000000000000000  V11 0x0000000000000000
>> 0000000000000000
>>  V12 0x0000000000000000 0000000000000000  V13 0x0000000000000000
>> 0000000000000000
>>  V14 0x0000000000000000 0000000000000000  V15 0x0000000000000000
>> 0000000000000000
>>  V16 0x0000000000000000 0000000000000000  V17 0x0000000000000000
>> 0000000000000000
>>  V18 0x0000000000000000 0000000000000000  V19 0x0000000000000000
>> 0000000000000000
>>  V20 0x0000000000000000 0000000000000000  V21 0x0000000000000000
>> 0000000000000000
>>  V22 0x0000000000000000 0000000000000000  V23 0x0000000000000000
>> 0000000000000000
>>  V24 0x0000000000000000 0000000000000000  V25 0x0000000000000000
>> 0000000000000000
>>  V26 0x0000000000000000 0000000000000000  V27 0x0000000000000000
>> 0000000000000000
>>  V28 0x0000000000000000 0000000000000000  V29 0x0000000000000000
>> 0000000000000000
>>  V30 0x0000000000000000 0000000000000000  V31 0x0000000000000000
>> 0000000000000000
>>
>>   SP 0x000000005EF13D20  ELR 0x000000005BD5B820  SPSR 0x80000205  FPSR
>> 0x00000000
>>  ESR 0x02000000          FAR 0x1DE7EC7EDBADC0DE
>>


$ git grep -C5 -ni 0x1DE7EC7EDBADC0DE
arch/arm64/kvm/sys_regs.h-105-static inline void reset_unknown(struct
kvm_vcpu *vcpu,
arch/arm64/kvm/sys_regs.h-106-                           const struct
sys_reg_desc *r)
arch/arm64/kvm/sys_regs.h-107-{
arch/arm64/kvm/sys_regs.h-108-  BUG_ON(!r->reg);
arch/arm64/kvm/sys_regs.h-109-  BUG_ON(r->reg >=3D NR_SYS_REGS);
arch/arm64/kvm/sys_regs.h:110:  vcpu_sys_reg(vcpu, r->reg) =3D
0x1de7ec7edbadc0deULL;
arch/arm64/kvm/sys_regs.h-111-}
arch/arm64/kvm/sys_regs.h-112-

In other words (or rather, in words), KVM is triggering this exception
in the guest deliberately, which I suspect has something to do with
the lack of a GIC? Are you using these patches Peter mentions?

--=20
Ard.
