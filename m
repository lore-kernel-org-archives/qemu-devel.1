Received: from eggs.gnu.org ([2001:4830:134:3::10]:58481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRn0-0005Ae-GU
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:14:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRmz-0005Fo-KV
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:14:02 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:43783)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emRmz-0005FY-FN
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 17:14:01 -0500
Received: by mail-qt0-x243.google.com with SMTP id d26so1606532qtk.10
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 14:14:01 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 15 Feb 2018 19:13:15 -0300
Message-Id: <20180215221325.7611-11-f4bug@amsat.org>
In-Reply-To: <20180215221325.7611-1-f4bug@amsat.org>
References: <20180215221325.7611-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 10/20] sdcard: handle the Security
 Specification commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Andrzej Zaborowski <balrogg@gmail.com>

returning sd_illegal, since they are not implemented.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 30acd04ad7..0457f5214b 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1551,6 +1551,17 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
         }
         break;
 
+    case 18:    /* Reserved for SD security applications */
+    case 25:
+    case 26:
+    case 38:
+    case 43 ... 49:
+        /* Refer to the "SD Specifications Part3 Security Specification" for
+         * information about the SD Security Features */
+        qemu_log_mask(LOG_UNIMP, "SD: CMD%i Security not implemented\n",
+                      req.cmd);
+        return sd_illegal;
+
     default:
         /* Fall back to standard commands.  */
         return sd_normal_command(sd, req);
-- 
2.16.1
