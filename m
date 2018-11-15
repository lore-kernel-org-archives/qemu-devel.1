Received: from eggs.gnu.org ([2001:4830:134:3::10]:36152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNKOP-0002SS-Vy
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 11:21:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNKOP-0002Ka-0u
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 11:21:21 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:38136)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gNKOO-0002Jx-La
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 11:21:20 -0500
Received: by mail-ot1-x343.google.com with SMTP id u3so13422674ota.5
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 08:21:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1539939312-19713-1-git-send-email-hongbo.zhang@linaro.org>
References: <1539939312-19713-1-git-send-email-hongbo.zhang@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Nov 2018 16:20:59 +0000
Message-ID: <CAFEAcA-gt4aLx171zU=qzbzygL6AN98HEPmL6iKG2O6E31ka4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4] Add arm SBSA reference machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hongbo Zhang <hongbo.zhang@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Leif Lindholm <leif.lindholm@linaro.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>

On 19 October 2018 at 09:55, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
> there are two commit reverts I have to do to boot system currently, these=
 block not only my new 'sbsa-ref', but also the 'virt'.
> (other two workarounds can be ignored, they are just for temp using befor=
e firmware porting is fully finished)
>
> I am not saying the comments themselves have problem, maybe firmware need=
 to be adapted accordingly too. But before they are fixed, I just simply re=
vert them to not block my run.
> (And, I've mentioned in v3 list that there are still problem of booting S=
MP too, but I won't mention it here this time, otherwise this patch/cover l=
etter becomes too complicated -- at least we can boot one core, I can fix/d=
iscuss it later separately.)

We do need to investigate and at least understand all these issues
before we can take this new board. Thanks for the repro instructions
for the virt board.

> Steps to reproduce issues:
> 1. Compile ARMTF
> make CROSS_COMPILE=3Daarch64-linux-gnu- PLAT=3Dqemu all DEBUG=3D1

What source tree do I need to build this EDK ?

> 2. Compile edk2
> make -C BaseTools
> . edksetup.sh
> export GCC49_AARCH64_PREFIX=3Daarch64-linux-gnu-
> build -a AARCH64 -t GCC49 -p ArmVirtPkg/ArmVirtQemuKernel.dsc
>
> 3. Run QEMU
> 3a. copy or link ARMTF and edk2 images to the directory where you want to=
 launch QEMU
> bl1.bin -> /home/hongbo/work/arm-trusted-firmware/build/qemu/debug/bl1.bi=
n*
> bl2.bin -> /home/hongbo/work/arm-trusted-firmware/build/qemu/debug/bl2.bi=
n*
> bl31.bin -> /home/hongbo/work/arm-trusted-firmware/build/qemu/debug/bl31.=
bin*
> bl33.bin -> /home/hongbo/work/edk2/Build/ArmVirtQemuKernel-AARCH64/DEBUG_=
GCC49/FV/QEMU_EFI.fd
>
> 3b. command to launch QEMU
> command1 to load a whole system
> qemu-system-aarch64 -machine virt,secure=3Don,virtualization=3Don -cpu co=
rtex-a57 -m 1024 -bios bl1.bin -semihosting -serial stdio -device virtio-sc=
si-device,id=3Dscsi -drive file=3D../qemu-imgs/deb9_arm64_netinst_uefi.raw,=
id=3Drootimg,if=3Dnone -device scsi-hd,drive=3Drootimg -netdev user,id=3Dun=
et -device virtio-net-device,netdev=3Dunet -net user
>
> or command2 simply load a kernel
> qemu-system-aarch64 -machine virt,secure=3Don,virtualization=3Don -cpu co=
rtex-a57 -m 1024 -bios bl1.bin -semihosting -serial stdio -kernel Image -in=
itrd xxx -append "root=3D/dev/xxx console=3DttyAMA0"
>
> 4a. system halt with error message
> ASSERT_EFI_ERROR (Status =3D Not Found)
> ASSERT [ResetSystemRuntimeDxe] /home/hongbo/work/edk2/Build/ArmVirtQemuKe=
rnel-AARCH64/DEBUG_GCC49/AARCH64/MdeModulePkg/Universal/ResetSystemRuntimeD=
xe/ResetSystemRuntimeDxe/DEBUG/AutoGen.c(370): !EFI_ERROR (Status)
>
> 4b. Revert "device_tree: Increase FDT_MAX_SIZE to 1 MiB"
> command1 can run further to halt at nother place, see 5a and 5b
> command2 can load kernel successfully

I'm not sure what's going on here. Some debugging of what the
assertion is checking and why we've hit it would be required.
I didn't expect changing FDT_MAX_SIZE would affect much but
perhaps it changes where the fdt winds up in memory or how
big it is so it overlaps with something else.
There is an fdt_pack() function which should compress a
created dtb, and which QEMU uses for some board models but
not others; but I would want to find out what's actually
happening here before looking at whether that is the right fix.

> 5a. 2nd system halt with message
> Synchronous Exception at 0x0000000078A152F0
> PC 0x000078A152F0 (0x000078A00000+0x000152F0) [ 0] ArmVeNorFlashDxe.dll
> PC 0x000078A152A0 (0x000078A00000+0x000152A0) [ 0] ArmVeNorFlashDxe.dll
> PC 0x000078A11DF0 (0x000078A00000+0x00011DF0) [ 0] ArmVeNorFlashDxe.dll
> [...snip...]
> PC 0x0000600088C4
> PC 0x000060008230
> PC 0x580B24C2580B24A1
>
> Recursive exception occurred while dumping the CPU state
>
> 5b Revert "target/arm: Implement new do_transaction_failed hook"
> then no halt, command1 can boot OS successfully

The bug here will be that the firmware is attempting to access
an address which has no device present there. We need to
find out what code in the firmware is doing that, and what
device it is trying to access. Then we can find out if it's
a firmware bug, or if there needs to be some device present,
or if we've given the wrong information in the device tree
or ACPI tables.

Can EDK be made to give a backtrace with source filenames
and line numbers for the exception ?

thanks
-- PMM
