Received: from eggs.gnu.org ([2001:4830:134:3::10]:59560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fPGZr-0003zg-NY
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 20:08:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fPGZq-0002yi-NP
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 20:08:55 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat,  2 Jun 2018 21:08:25 -0300
Message-Id: <20180603000827.30872-7-f4bug@amsat.org>
In-Reply-To: <20180603000827.30872-1-f4bug@amsat.org>
References: <20180603000827.30872-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 6/8] sdcard: Disable SEND_IF_COND (CMD8) for
 Spec v1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paul Brook <paul@codesourcery.com>

SEND_IF_COND got introduced by Spec v2.

Firmwares use the CMD8 in SPI mode to poll the Spec version supported:

  7.2.1 Mode Selection and Initialization (SPI mode)

    The SD Card is powered up in the SD mode. It will enter
    SPI mode if the CS signal is asserted (negative) during
    the reception of the reset command (CMD0). If the card
    recognizes that the SD mode is required it will not
    respond to the command and remain in the SD mode. If SPI
    mode is required, the card will switch to SPI and respond
    with the SPI mode R1 response.
    The only way to return to the SD mode is by entering the
    power cycle. In SPI mode, the SD Card protocol state
    machine in SD mode is not observed. All the SD Card
    commands supported in SPI mode are always available.
    [...]
    If the card indicates an illegal command, the card is
    legacy and does not support CMD8. If the card supports
    CMD8 and can operate on the supplied voltage, the response
    echoes back the supply voltage and the check pattern that
    were set in the command argument.

This change restore the SSI/SD functionality of the Stellaris
LM3S6965EVB board.

Message-Id: 201204252110.20873.paul@codesourcery.com
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Paolo, I guess this would be a good use of the
Based-on: 201204252110.20873.paul@codesourcery.com tag in
the git history :P

 hw/sd/sd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 81f178b36e..da65f2b178 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1017,7 +1017,9 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         break;
 
     case 8:	/* CMD8:   SEND_IF_COND */
-        /* Physical Layer Specification Version 2.00 command */
+        if (sd->spec_version < SD_PHY_SPECv2_00_VERS) {
+            break;
+        }
         if (sd->state != sd_idle_state) {
             break;
         }
-- 
2.17.1
