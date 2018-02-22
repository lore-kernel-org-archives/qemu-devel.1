Received: from eggs.gnu.org ([2001:4830:134:3::10]:38595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosip-000543-6R
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosio-0001uY-9B
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:47 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46616)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eosio-0001tO-2F
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:46 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eosin-00026T-3S
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 15:23:45 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 15:23:01 +0000
Message-Id: <20180222152307.7499-27-peter.maydell@linaro.org>
In-Reply-To: <20180222152307.7499-1-peter.maydell@linaro.org>
References: <20180222152307.7499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 26/32] sdcard: handle the Security Specification
 commands
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

returning sd_illegal, since they are not implemented.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Message-id: 20180215221325.7611-11-f4bug@amsat.org
[PMM: tweak multiline comment format]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/sd.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 63da05eaef..f13f33efca 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1546,6 +1546,18 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
         }
         break;
 
+    case 18:    /* Reserved for SD security applications */
+    case 25:
+    case 26:
+    case 38:
+    case 43 ... 49:
+        /* Refer to the "SD Specifications Part3 Security Specification" for
+         * information about the SD Security Features.
+         */
+        qemu_log_mask(LOG_UNIMP, "SD: CMD%i Security not implemented\n",
+                      req.cmd);
+        return sd_illegal;
+
     default:
         /* Fall back to standard commands.  */
         return sd_normal_command(sd, req);
-- 
2.16.1
