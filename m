Received: from eggs.gnu.org ([2001:4830:134:3::10]:33370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1gVC7G-0005wU-4c
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 04:08:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1gVC7C-0001LE-Pl
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 04:08:10 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:37148)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hongbo.zhang@linaro.org>)
	id 1gVC7C-00018O-Fy
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 04:08:06 -0500
Received: by mail-pl1-x644.google.com with SMTP id b5so1556197plr.4
	for <qemu-devel@nongnu.org>; Fri, 07 Dec 2018 01:08:05 -0800 (PST)
From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Fri,  7 Dec 2018 17:07:53 +0800
Message-Id: <1544173675-14217-1-git-send-email-hongbo.zhang@linaro.org>
Subject: [Qemu-devel] [PATCH v5 0/2] [PATCH v4] Add arm SBSA reference
 machine
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

This machine comes with:
 - Re-designed memory map.
 - CPU cortex-a57.
 - EL2 and EL3 enabled.
 - GIC version 3.
 - System bus AHCI controller.
 - System bus XHCI controller(TBD).
 - CDROM and hard disc on AHCI bus.
 - E1000E ethernet card on PCIE bus.
 - VGA display adaptor on PCIE bus.
 - Only minimal device tree nodes.
And without:
 - virtio deivces.
 - fw_cfg device.
 - ACPI tables.

Arm Trusted Firmware and UEFI porting to this are done accordingly, and
it should supply ACPI tables to load OS, the minimal device tree nodes
supplied from this platform are only to pass the dynamic info reflecting
command line input to firmware, not for loading OS.

v5 changes:
 - removed more lines derived from virt.c
 - designed a new memory map
 - splitted former one patch into two for easier review
 - cancled previous EHCI and new HXCI coming later separately

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

In the previous v4 cover letter,
https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg04282.html
I mentioned I had to revert two commits temperarily to run:
 Revert "target/arm: Implement new do_transaction_failed hook"
 Revert "device_tree: Increase FDT_MAX_SIZE to 1 MiB"

Now the 1st one is fixed by Ard Biesheuvel in the edk2 side, and for
the 2nd one, a simple change in firmware side can fix it, so I won't
mention these issues in details in the cover letter any more.

I also put a branch here:
http://git.linaro.org/people/hongbo.zhang/qemu-enterprise.git/log/?h=sbsa-upstream-v5
with the last 3 workaroud we can test using legacy firmware
but gicv3 needs to be enabled in ATF:
http://git.linaro.org/people/hongbo.zhang/atf-sbsa.git/log/?h=sbsa_gicv3

Hongbo Zhang (2):
  hw/arm: Add arm SBSA reference machine, skeleton part
  hw/arm: add Arm SBSA reference machine, devices part

 hw/arm/Makefile.objs  |   2 +-
 hw/arm/sbsa-ref.c     | 698 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/arm/virt.h |   1 +
 3 files changed, 700 insertions(+), 1 deletion(-)
 create mode 100644 hw/arm/sbsa-ref.c

-- 
2.7.4
