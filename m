Received: from eggs.gnu.org ([2001:4830:134:3::10]:47099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1evlxT-0005ZF-93
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:35:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1evlxS-0005zE-CP
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:35:23 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Mar 2018 15:34:49 +0000
Message-Id: <20180313153458.26822-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/9] raspi3: various fixes for Linux booting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Pekka Enberg <penberg@iki.fi>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>

I had a go at booting Debian's Linux kernel on our raspi3 model.
These patches fix a variety of bugs that were stopping that working:
 * the board was trying to boot in secure mode, which isn't
   right for AArch64 Linux kernels
 * the hw/arm/boot.c code didn't set SCR_EL3.HCE, which meant that
   the HVC instruction would UNDEF and the guest would panic trying
   to initialize KVM
 * BCM2837 uses different affinity (cluster ID) values than BCM2836;
   this really confused Linux since it didn't think the primary CPU
   existed and it ended up panicing in an obscure way.
   I opted to fix this one with a modest refactor of the bcm2836
   code into one device for each SoC, similar to how we handle the
   Aspeed SoCs.
 * the board was trying to use AArch32 code for the secondary
   CPU bootup, so secondaries just went into an infinite UNDEF
   exception loop. Using the correct instruction set and the right
   spintable protocol allows the kernel to detect all the secondaries.

Unfortunately this doesn't entirely suffice to boot, because there's
a problem with our bcm2835_sdhost device model. I've analysed the
problem, but am not sure how to fix it because as far as I can tell
there is no public documentation for this bit of the hardware :-(
Does anybody have a datasheet for it?

[Summary of the sdhost issue:

    The Linux bcm2835_sdhost driver doesn't work on QEMU, because
    our model raises spurious data interrupts. Our function
    bcm2835_sdhost_fifo_run() will flag an interrupt any time
    it is called with s->datacnt == 0, even if the host hasn't
    actually issued a data read or write command yet. This means
    that the driver gets a spurious data interrupt as soon as
    it enables IRQs and then does something else that causes
    us to call the fifo_run routine, like writing to SDHCFG.
    The driver's IRQ handler then spins forever complaining that
    there's no data and the SD controller isn't in a state where
    there's going to be any data:
    [   41.040738] sdhost-bcm2835 3f202000.mmc: fsm 1, hsts 00000000
    [   41.042059] sdhost-bcm2835 3f202000.mmc: fsm 1, hsts 00000000
    (continues forever).

    Without the h/w docs it's hard to know exactly when we are
    supposed to signal interrupts, though obviously what we do now
    is definitely wrong...
]

thanks
-- PMM


Peter Maydell (9):
  hw/arm/raspi: Don't do board-setup or secure-boot for raspi3
  hw/arm/boot: assert that secure_boot and secure_board_setup are false
    for AArch64
  hw/arm/boot: If booting a kernel in EL2, set SCR_EL3.HCE
  hw/arm/bcm2386: Fix parent type of bcm2386
  hw/arm/bcm2836: Rename bcm2836 type/struct to bcm283x
  hw/arm/bcm2836: Create proper bcm2837 device
  hw/arm/bcm2836: Use correct affinity values for BCM2837
  hw/arm/bcm2836: Hardcode correct CPU type
  hw/arm/raspi: Provide spin-loop code for AArch64 CPUs

 include/hw/arm/bcm2836.h | 31 ++++++++++++++----
 hw/arm/bcm2836.c         | 81 +++++++++++++++++++++++++++++++++++-------------
 hw/arm/boot.c            | 12 +++++++
 hw/arm/raspi.c           | 77 ++++++++++++++++++++++++++++++++++++---------
 4 files changed, 158 insertions(+), 43 deletions(-)

-- 
2.16.2
