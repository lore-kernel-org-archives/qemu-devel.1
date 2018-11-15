Received: from eggs.gnu.org ([2001:4830:134:3::10]:50612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1gNMs4-0005g3-JD
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 14:00:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1gNMs1-0003X2-H0
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 14:00:08 -0500
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:40731)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1gNMs1-0003Wh-CC
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 14:00:05 -0500
Received: by mail-io1-xd44.google.com with SMTP id r7-v6so15106104iog.7
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 11:00:05 -0800 (PST)
MIME-Version: 1.0
References: <1539939312-19713-1-git-send-email-hongbo.zhang@linaro.org>
	<CAFEAcA-gt4aLx171zU=qzbzygL6AN98HEPmL6iKG2O6E31ka4A@mail.gmail.com>
In-Reply-To: <CAFEAcA-gt4aLx171zU=qzbzygL6AN98HEPmL6iKG2O6E31ka4A@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 15 Nov 2018 10:59:52 -0800
Message-ID: <CAKv+Gu_3nzz3Z0a70YHXUd4e-FWLxZokaqPqwTL4Z70zzE80aw@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Hongbo Zhang <hongbo.zhang@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Leif Lindholm <leif.lindholm@linaro.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>

On Thu, 15 Nov 2018 at 08:21, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On 19 October 2018 at 09:55, Hongbo Zhang <hongbo.zhang@linaro.org> wrote=
:
> > there are two commit reverts I have to do to boot system currently, the=
se block not only my new 'sbsa-ref', but also the 'virt'.
> > (other two workarounds can be ignored, they are just for temp using bef=
ore firmware porting is fully finished)
> >
> > I am not saying the comments themselves have problem, maybe firmware ne=
ed to be adapted accordingly too. But before they are fixed, I just simply =
revert them to not block my run.
> > (And, I've mentioned in v3 list that there are still problem of booting=
 SMP too, but I won't mention it here this time, otherwise this patch/cover=
 letter becomes too complicated -- at least we can boot one core, I can fix=
/discuss it later separately.)
>
> We do need to investigate and at least understand all these issues
> before we can take this new board. Thanks for the repro instructions
> for the virt board.
>
> > Steps to reproduce issues:
> > 1. Compile ARMTF
> > make CROSS_COMPILE=3Daarch64-linux-gnu- PLAT=3Dqemu all DEBUG=3D1
>
> What source tree do I need to build this EDK ?
>
> > 2. Compile edk2
> > make -C BaseTools
> > . edksetup.sh
> > export GCC49_AARCH64_PREFIX=3Daarch64-linux-gnu-
> > build -a AARCH64 -t GCC49 -p ArmVirtPkg/ArmVirtQemuKernel.dsc
> >
> > 3. Run QEMU
> > 3a. copy or link ARMTF and edk2 images to the directory where you want =
to launch QEMU
> > bl1.bin -> /home/hongbo/work/arm-trusted-firmware/build/qemu/debug/bl1.=
bin*
> > bl2.bin -> /home/hongbo/work/arm-trusted-firmware/build/qemu/debug/bl2.=
bin*
> > bl31.bin -> /home/hongbo/work/arm-trusted-firmware/build/qemu/debug/bl3=
1.bin*
> > bl33.bin -> /home/hongbo/work/edk2/Build/ArmVirtQemuKernel-AARCH64/DEBU=
G_GCC49/FV/QEMU_EFI.fd
> >
> > 3b. command to launch QEMU
> > command1 to load a whole system
> > qemu-system-aarch64 -machine virt,secure=3Don,virtualization=3Don -cpu =
cortex-a57 -m 1024 -bios bl1.bin -semihosting -serial stdio -device virtio-=
scsi-device,id=3Dscsi -drive file=3D../qemu-imgs/deb9_arm64_netinst_uefi.ra=
w,id=3Drootimg,if=3Dnone -device scsi-hd,drive=3Drootimg -netdev user,id=3D=
unet -device virtio-net-device,netdev=3Dunet -net user
> >
> > or command2 simply load a kernel
> > qemu-system-aarch64 -machine virt,secure=3Don,virtualization=3Don -cpu =
cortex-a57 -m 1024 -bios bl1.bin -semihosting -serial stdio -kernel Image -=
initrd xxx -append "root=3D/dev/xxx console=3DttyAMA0"
> >
> > 4a. system halt with error message
> > ASSERT_EFI_ERROR (Status =3D Not Found)
> > ASSERT [ResetSystemRuntimeDxe] /home/hongbo/work/edk2/Build/ArmVirtQemu=
Kernel-AARCH64/DEBUG_GCC49/AARCH64/MdeModulePkg/Universal/ResetSystemRuntim=
eDxe/ResetSystemRuntimeDxe/DEBUG/AutoGen.c(370): !EFI_ERROR (Status)
> >
> > 4b. Revert "device_tree: Increase FDT_MAX_SIZE to 1 MiB"
> > command1 can run further to halt at nother place, see 5a and 5b
> > command2 can load kernel successfully
>
> I'm not sure what's going on here. Some debugging of what the
> assertion is checking and why we've hit it would be required.
> I didn't expect changing FDT_MAX_SIZE would affect much but
> perhaps it changes where the fdt winds up in memory or how
> big it is so it overlaps with something else.
> There is an fdt_pack() function which should compress a
> created dtb, and which QEMU uses for some board models but
> not others; but I would want to find out what's actually
> happening here before looking at whether that is the right fix.
>
> > 5a. 2nd system halt with message
> > Synchronous Exception at 0x0000000078A152F0
> > PC 0x000078A152F0 (0x000078A00000+0x000152F0) [ 0] ArmVeNorFlashDxe.dll
> > PC 0x000078A152A0 (0x000078A00000+0x000152A0) [ 0] ArmVeNorFlashDxe.dll
> > PC 0x000078A11DF0 (0x000078A00000+0x00011DF0) [ 0] ArmVeNorFlashDxe.dll
> > [...snip...]
> > PC 0x0000600088C4
> > PC 0x000060008230
> > PC 0x580B24C2580B24A1
> >
> > Recursive exception occurred while dumping the CPU state
> >
> > 5b Revert "target/arm: Implement new do_transaction_failed hook"
> > then no halt, command1 can boot OS successfully
>
> The bug here will be that the firmware is attempting to access
> an address which has no device present there. We need to
> find out what code in the firmware is doing that, and what
> device it is trying to access. Then we can find out if it's
> a firmware bug, or if there needs to be some device present,
> or if we've given the wrong information in the device tree
> or ACPI tables.
>
> Can EDK be made to give a backtrace with source filenames
> and line numbers for the exception ?
>

The list you see up there is the backtrace. You'll have to objdump the
.dll file yourself (it is actually an ELF file with the exact same
memory layout as the PE/COFF image) The numbers in brackets are
indexes into the list of complete filenames that usually follows, but
unfortunately the corrupted PC breaks the backtracer before it gets
there.

My copy of that file is at
Build/ArmVirtQemu-AARCH64/DEBUG_GCC5/AARCH64/ArmPlatformPkg/Drivers/NorFlas=
hDxe/NorFlashDxe/DEBUG/ArmVeNorFlashDxe.dll
