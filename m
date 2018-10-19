Received: from eggs.gnu.org ([2001:4830:134:3::10]:43294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1gDQZI-0005aS-KU
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 04:55:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1gDQZE-00084k-KT
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 04:55:40 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:40646)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hongbo.zhang@linaro.org>)
	id 1gDQZD-0007rr-L2
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 04:55:36 -0400
Received: by mail-pl1-x641.google.com with SMTP id 1-v6so15584354plv.7
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 01:55:27 -0700 (PDT)
From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Fri, 19 Oct 2018 16:55:11 +0800
Message-Id: <1539939312-19713-1-git-send-email-hongbo.zhang@linaro.org>
Subject: [Qemu-devel] [PATCH v4] Add arm SBSA reference machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, alex.bennee@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: ard.biesheuvel@linaro.org, leif.lindholm@linaro.org, radoslaw.biernacki@linaro.org, Hongbo Zhang <hongbo.zhang@linaro.org>

For the Aarch64, there is one machine 'virt', it is primarily meant to
run on KVM and execute virtualization workloads, but we need an
environment as faithful as possible to physical hardware,  to support
firmware and OS development for pysical Aarch64 machines.

See the patch commit comments for the features description.

V4 changes:
 - rebased to v3.0.0
 - removed timer, uart, rtc, *hci device tree nodes
   (others were removerd in v3)
 - other minore codes clean up, mainly unsed header files, comments etc.

V3 changes:
 - rename the platform 'sbsa-ref'
 - move all the codes to a separate file sbsa-ref.c
 - remove paravirtualized fw_cfg device
 - do not supply ACPI tables, since firmware will do it
 - supply only necessary DT nodes
 - and other minor code clean up


Well, there are still pending issues, you can find my whole tree here:
http://git.linaro.org/people/hongbo.zhang/qemu-enterprise.git/log/?h=sbsa-v3.0.0

 workaround: add fw_cfg, smbios and acpi
 workaround: add device tree nodes back
 hw/arm: Add arm SBSA reference machine
 Revert "target/arm: Implement new do_transaction_failed hook"
 Revert "device_tree: Increase FDT_MAX_SIZE to 1 MiB"

there are two commit reverts I have to do to boot system currently, these block not only my new 'sbsa-ref', but also the 'virt'.
(other two workarounds can be ignored, they are just for temp using before firmware porting is fully finished)

I am not saying the comments themselves have problem, maybe firmware need to be adapted accordingly too. But before they are fixed, I just simply revert them to not block my run.
(And, I've mentioned in v3 list that there are still problem of booting SMP too, but I won't mention it here this time, otherwise this patch/cover letter becomes too complicated -- at least we can boot one core, I can fix/discuss it later separately.)

Steps to reproduce issues:
1. Compile ARMTF
make CROSS_COMPILE=aarch64-linux-gnu- PLAT=qemu all DEBUG=1

2. Compile edk2
make -C BaseTools
. edksetup.sh
export GCC49_AARCH64_PREFIX=aarch64-linux-gnu-
build -a AARCH64 -t GCC49 -p ArmVirtPkg/ArmVirtQemuKernel.dsc

3. Run QEMU
3a. copy or link ARMTF and edk2 images to the directory where you want to launch QEMU
bl1.bin -> /home/hongbo/work/arm-trusted-firmware/build/qemu/debug/bl1.bin*
bl2.bin -> /home/hongbo/work/arm-trusted-firmware/build/qemu/debug/bl2.bin*
bl31.bin -> /home/hongbo/work/arm-trusted-firmware/build/qemu/debug/bl31.bin*
bl33.bin -> /home/hongbo/work/edk2/Build/ArmVirtQemuKernel-AARCH64/DEBUG_GCC49/FV/QEMU_EFI.fd

3b. command to launch QEMU
command1 to load a whole system
qemu-system-aarch64 -machine virt,secure=on,virtualization=on -cpu cortex-a57 -m 1024 -bios bl1.bin -semihosting -serial stdio -device virtio-scsi-device,id=scsi -drive file=../qemu-imgs/deb9_arm64_netinst_uefi.raw,id=rootimg,if=none -device scsi-hd,drive=rootimg -netdev user,id=unet -device virtio-net-device,netdev=unet -net user

or command2 simply load a kernel
qemu-system-aarch64 -machine virt,secure=on,virtualization=on -cpu cortex-a57 -m 1024 -bios bl1.bin -semihosting -serial stdio -kernel Image -initrd xxx -append "root=/dev/xxx console=ttyAMA0"

4a. system halt with error message
ASSERT_EFI_ERROR (Status = Not Found)
ASSERT [ResetSystemRuntimeDxe] /home/hongbo/work/edk2/Build/ArmVirtQemuKernel-AARCH64/DEBUG_GCC49/AARCH64/MdeModulePkg/Universal/ResetSystemRuntimeDxe/ResetSystemRuntimeDxe/DEBUG/AutoGen.c(370): !EFI_ERROR (Status)

4b. Revert "device_tree: Increase FDT_MAX_SIZE to 1 MiB"
command1 can run further to halt at nother place, see 5a and 5b
command2 can load kernel successfully

5a. 2nd system halt with message
Synchronous Exception at 0x0000000078A152F0
PC 0x000078A152F0 (0x000078A00000+0x000152F0) [ 0] ArmVeNorFlashDxe.dll
PC 0x000078A152A0 (0x000078A00000+0x000152A0) [ 0] ArmVeNorFlashDxe.dll
PC 0x000078A11DF0 (0x000078A00000+0x00011DF0) [ 0] ArmVeNorFlashDxe.dll
[...snip...]
PC 0x0000600088C4
PC 0x000060008230
PC 0x580B24C2580B24A1

Recursive exception occurred while dumping the CPU state

5b Revert "target/arm: Implement new do_transaction_failed hook"
then no halt, command1 can boot OS successfully

Hongbo Zhang (1):
  hw/arm: Add arm SBSA reference machine

 hw/arm/Makefile.objs  |   2 +-
 hw/arm/sbsa-ref.c     | 937 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/arm/virt.h |   2 +
 3 files changed, 940 insertions(+), 1 deletion(-)
 create mode 100644 hw/arm/sbsa-ref.c

-- 
2.7.4
