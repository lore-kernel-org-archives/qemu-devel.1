Received: from eggs.gnu.org ([2001:4830:134:3::10]:50677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlw-0003D8-4U
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlv-0004Ox-0a
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:40 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42604)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fRGlu-0004MB-O4
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:38 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlt-0003mG-Cn
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:45:37 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  8 Jun 2018 13:45:12 +0100
Message-Id: <20180608124517.29475-27-peter.maydell@linaro.org>
In-Reply-To: <20180608124517.29475-1-peter.maydell@linaro.org>
References: <20180608124517.29475-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 26/31] sdcard: Update the Configuration Register
 (SCR) to Spec Version 1.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

The initial implementation is based on the Specs v1.10 (see a1bb27b1e98).

However the SCR is anouncing the card being v1.01.

The new chapters added in version 1.10 are:

    4.3.10 Switch function command

    Switch function command (CMD6) 1 is used to switch or expand
    memory card functions. [...]
    This is a new feature, introduced in SD physical Layer
    Specification Version 1.10. Therefore, cards that are
    compatible with earlier versions of the spec do not support
    it. The host shall check the "SD_SPEC" field in the SCR
    register to recognize what version of the spec the card
    complies with before using CMD6. It is mandatory for SD
    memory card of Ver1.10 to support CMD6.

    4.3.11 High-Speed mode (25MB/sec interface speed)

    Though the Rev 1.01 SD memory card supports up to 12.5MB/sec
    interface speed, the speed of 25MB/sec is necessary to support
    increasing performance needs of the host and because of memory
    size which continues to grow.
    To achieve 25MB/sec interface speed, clock rate is increased to
    50MHz and CLK/CMD/DAT signal timing and circuit conditions are
    reconsidered and changed from Physical Layer Specification
    Version 1.01.

    4.3.12 Command system (This chapter is newly added in version 1.10)

    SD commands CMD34-37, CMD50, CMD57 are reserved for SD command
    system expansion via the switch command.
    [These commands] will be considered as illegal commands (as
    defined in revision 1.01 of the SD physical layer specification).

The SWITCH_FUNCTION is implemented since the first commit, a1bb27b1e98.

The 25MB/sec High-Speed mode was already updated in d7ecb867529.

The current implementation does not implements CMD34-37, CMD50 and
CMD57, thus these commands already return ILLEGAL.

With this patch, the SCR register now matches the description of the header:

 * SD Memory Card emulation as defined in the "SD Memory Card Physical
 * layer specification, Version 1.10."

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20180607180641.874-2-f4bug@amsat.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/sd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 7af19fa06ca..e1218d1fb6b 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -310,8 +310,8 @@ static void sd_ocr_powerup(void *opaque)
 
 static void sd_set_scr(SDState *sd)
 {
-    sd->scr[0] = (0 << 4)       /* SCR version 1.0 */
-                 | 0;           /* Spec Versions 1.0 and 1.01 */
+    sd->scr[0] = (0 << 4)       /* SCR structure version 1.0 */
+                 | 1;           /* Spec Version 1.10 */
     sd->scr[1] = (2 << 4)       /* SDSC Card (Security Version 1.01) */
                  | 0b0101;      /* 1-bit or 4-bit width bus modes */
     sd->scr[2] = 0x00;          /* Extended Security is not supported. */
-- 
2.17.1
