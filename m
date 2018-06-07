Received: from eggs.gnu.org ([2001:4830:134:3::10]:46098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQzJY-0002Ec-VG
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 14:07:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQzJX-0004Xo-Jh
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 14:07:12 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu,  7 Jun 2018 15:06:41 -0300
Message-Id: <20180607180641.874-8-f4bug@amsat.org>
In-Reply-To: <20180607180641.874-1-f4bug@amsat.org>
References: <20180607180641.874-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v2 7/7] hw/sd/ssi-sd: Force cards connected
 in SPI mode to use Spec v1.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Due to physical restriction in SPI mode the maximum transfer
speed is limited. All the extensions added after Spec v3 are
simply not supported in SPI mode:

  7.1 Introduction

    The SPI mode consists of a secondary communication protocol
    that is offered by Flash-based SD Memory Cards. This mode is
    a subset of the SD Memory Card protocol, designed to communicate
    with a SPI channel, commonly found in Motorola's (and lately a
    few other vendors') microcontrollers. The interface is selected
    during the first reset command after power up (CMD0) and cannot
    be changed once the part is powered on.
    The SPI standard defines the physical link only, and not the
    complete data transfer protocol. The SD Memory Card SPI
    implementation uses a subset of the SD Memory Card protocol and
    command set. The advantage of the SPI mode is the capability of
    using an off-the-shelf host, hence reducing the design-in effort
    to minimum. The disadvantage is the loss of performance of the
    SPI mode versus SD mode (e.g. Single data line and hardware CS
    signal per card).
    The commands and functions in SD mode defined after the Version
    2.00 are not supported in SPI mode. The card may respond to the
    commands and functions even if the card is in SPI mode but host
    should not use them in SPI mode.

Some firmwares use the CMD8 in SPI mode to poll which Spec version
the SD card supports.

  7.2.1 Mode Selection and Initialization (SPI mode)

    The SD Card is powered up in the SD mode. It will enter SPI mode
    if the CS signal is asserted (negative) during the reception of
    the reset command (CMD0). If the card recognizes that the SD mode
    is required it will not respond to the command and remain in the
    SD mode. If SPI mode is required, the card will switch to SPI and
    respond with the SPI mode R1 response.
    The only way to return to the SD mode is by entering the power
    cycle. In SPI mode, the SD Card protocol state machine in SD mode
    is not observed. All the SD Card commands supported in SPI mode
    are always available. [...]
    If the card indicates an illegal command, the card is legacy and
    does not support CMD8. If the card supports CMD8 and can operate
    on the supplied voltage, the response echoes back the supply
    voltage and the check pattern that were set in the command
    argument.

The NuttX RTOS use it too:

    /* Check for SDHC Version 2.x.  CMD 8 is reserved on SD version 1.0 and
     * MMC.
     */
    finfo("Send CMD8\n");
    result = mmcsd_sendcmd(slot, &g_cmd8, 0x1aa);
    if (result == MMCSD_SPIR1_IDLESTATE)
      ...
    /* Check for SDC version 1.x or MMC */
    else
      ...

See https://bitbucket.org/nuttx/nuttx/src/nuttx-7.25/drivers/mmcsd/mmcsd_spi.c?mmcsd_spi.c-1645#mmcsd_spi.c-1645

The Stellaris LM3S6965EVB board is the only model using SD cards in
SPI mode. The firmware found to work with the board expect the card
to be following Spec v1 to work, and is the only one stressing the
v1 code path of the SD card model.
Thus it seems clever to restrict SPI connected cards to use Spec v1.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
This change would be better in the lm3s6965evb_init() rathar than here in
ssi-sd.

As suggested by Peter and Thomas here:
http://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg06616.html

We can use -device sd-card,spec_version=1 to avoid this change.

$ arm-softmmu/qemu-system-arm \
      -M lm3s6965evb -nodefaults \
      -serial stdio \
      -kernel sd_card.bin \
      -drive file=sdcard.img,id=mycard,if=none \
      -device sd-card,spi=true,spec_version=1,drive=mycard 
qemu-system-arm: warning: nic stellaris_enet.0 has no peer
SD Card Example Program
Type 'help' for help.

/> ls
Open
listing

----A 2012/04/25 17:44        12  README.TXT

   1 File(s),        12 bytes total
   0 Dir(s),      61182K bytes free

/> cat README.TXT
Hello World

/> 

Even if there are still 2 cards...

(qemu) info qtree
bus: main-system-bus
  type System
  dev: pl022, id ""
    gpio-out "sysbus-irq" 1
    mmio 0000000040008000/0000000000001000
    bus: ssi
      type SSI
      dev: ssd0323, id ""
        gpio-in "" 1
        gpio-in "ssi-gpio-cs" 1
      dev: ssi-sd, id ""
        gpio-in "ssi-gpio-cs" 1
        bus: sd-bus
          type sd-bus
          dev: sd-card, id ""
            spec_version = 1 (0x1)
            drive = "mycard"
            spi = true
          dev: sd-card, id ""
            spec_version = 2 (0x2)
            drive = ""
            spi = true

 hw/sd/ssi-sd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index 96542ecd62..82470a12e2 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -252,6 +252,8 @@ static void ssi_sd_realize(SSISlave *d, Error **errp)
     /* FIXME use a qdev drive property instead of drive_get_next() */
     dinfo = drive_get_next(IF_SD);
     carddev = qdev_create(&s->sdbus.qbus, TYPE_SD_CARD);
+    object_property_set_uint(OBJECT(carddev),
+                             SD_PHY_SPECv1_10_VERS, "spec_version", &err);
     if (dinfo) {
         qdev_prop_set_drive(carddev, "drive", blk_by_legacy_dinfo(dinfo), &err);
     }
-- 
2.17.1
