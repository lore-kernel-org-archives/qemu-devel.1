Received: from eggs.gnu.org ([2001:4830:134:3::10]:50712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlx-0003EG-KO
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlw-0004RV-Li
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:41 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42608)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fRGlw-0004QX-EX
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:45:40 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fRGlv-0003ne-Dh
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:45:39 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  8 Jun 2018 13:45:15 +0100
Message-Id: <20180608124517.29475-30-peter.maydell@linaro.org>
In-Reply-To: <20180608124517.29475-1-peter.maydell@linaro.org>
References: <20180608124517.29475-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 29/31] sdcard: Disable SEND_IF_COND (CMD8) for
 Spec v1
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

CMD8 is "Reserved" in Spec v1.10.

Spec v2.00 introduces the SEND_IF_COND command:

  6.4.1 Power Up

    CMD8 is newly added in the Physical Layer Specification Version
    2.00 to support multiple voltage ranges and used to check whether
    the card supports supplied voltage. The version 2.00 or later host
    shall issue CMD8 and verify voltage before card initialization.
    The host that does not support CMD8 shall supply high voltage range.

Message-Id: 201204252110.20873.paul@codesourcery.com
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20180607180641.874-5-f4bug@amsat.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/sd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 1ae085de69a..3ec0f71f240 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1018,7 +1018,9 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
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
