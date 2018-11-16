Received: from eggs.gnu.org ([2001:4830:134:3::10]:37485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1gNZPW-0003Ph-9Y
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 03:23:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1gNZPU-0001X9-Tf
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 03:23:30 -0500
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:44899)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hongbo.zhang@linaro.org>)
	id 1gNZPU-0001Wt-GD
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 03:23:28 -0500
Received: by mail-lj1-x241.google.com with SMTP id k19-v6so19541352lji.11
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 00:23:28 -0800 (PST)
MIME-Version: 1.0
References: <1539939312-19713-1-git-send-email-hongbo.zhang@linaro.org>
	<CAFEAcA-gt4aLx171zU=qzbzygL6AN98HEPmL6iKG2O6E31ka4A@mail.gmail.com>
In-Reply-To: <CAFEAcA-gt4aLx171zU=qzbzygL6AN98HEPmL6iKG2O6E31ka4A@mail.gmail.com>
From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Fri, 16 Nov 2018 16:23:15 +0800
Message-ID: <CAHmQWvA7fyCFz-qE2_B1SHH+29gns5m_tccLSwF_GTs52LV9Lw@mail.gmail.com>
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Leif Lindholm <leif.lindholm@linaro.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>

On Fri, 16 Nov 2018 at 00:21, Peter Maydell <peter.maydell@linaro.org> wrot=
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
Well, for the SMP booting, when GICv2 used, there is no problem, max
CPU number 8 can be booted, including all the three cases: kernel
only, UEFI+kernel and ATF+UEFI+kernel.

But when GICv3 used, these two cases still work: kernel only, and
UEFI+kernel, but ATF+UEFI+kernel fails booting more than 4 cores with
GICv3.
The original ATF didn't support GICv3, so I added the support:
http://git.linaro.org/people/hongbo.zhang/atf-sbsa.git/log/?h=3Dsbsa_gicv3

Root cause of failing to boot more than 4 cores with ATF+UEFI+kernel
with my GICv3 enabled is due to this:
In QEMU, we have this defination
#define ARM_DEFAULT_CPUS_PER_CLUSTER 8
But in ATF, the defination is
#define PLATFORM_MAX_CPUS_PER_CLUSTER 4
So when we pass smp=3D6 for example, QEMU generates MPIDR showing all
the 6 cores are at cluster 0, but when ATF parses such MPIDR, the
function plat_core_pos_by_mpidr() in plat/qemu/topology.c returns
error since there should be no more cores than 4.

I think we should change the definition in QEMU to 4, instead of
changing the ATF's, because I checked Cortext a57/a72/a73/a75 spec, it
says there are 4 cores max at one cluster.

> > Steps to reproduce issues:
> > 1. Compile ARMTF
> > make CROSS_COMPILE=3Daarch64-linux-gnu- PLAT=3Dqemu all DEBUG=3D1
>
> What source tree do I need to build this EDK ?
>
I use https://github.com/ARM-software/arm-trusted-firmware.git
And you can also use my
http://git.linaro.org/people/hongbo.zhang/atf-sbsa.git/log/?h=3Dsbsa_gicv3
with GICv3 enabled.

Use additional compiling parameter QEMU_USE_GIC_DRIVER to selecct GICv3
"make PLAT=3Dqemu all DEBUG=3D1 QEMU_USE_GIC_DRIVER=3DQEMU_GICV3"
No such parameter to select default GICv2
(But I found if you change GICv2 and v3 from time to time when
compiling, the build system may not do the correct changing every
time, so it is better to do a clean before compiling)

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
I think the firmware is checking mass storage device to find a
bootable OS at this stage.

> Can EDK be made to give a backtrace with source filenames
> and line numbers for the exception ?
>
> thanks
> -- PMM
