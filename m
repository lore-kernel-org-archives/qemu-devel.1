Received: from eggs.gnu.org ([209.51.188.92]:54343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1h3Fsl-0000QK-47
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 04:01:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1h3FfE-0004DT-Kn
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 03:48:01 -0400
Received: from mout.gmx.net ([212.227.15.19]:42837)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <deller@gmx.de>) id 1h3FfE-0004Cr-Ac
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 03:48:00 -0400
Date: Mon, 11 Mar 2019 08:47:52 +0100
From: Helge Deller <deller@gmx.de>
Message-ID: <20190311074752.GA17747@ls3530.dellerweb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] pcnet: Avoid warning when switching back to
 16bit mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>

When Linux is shutting down, the pcnet32 driver switches the pcnet card
back to 16bit mode to "avoid problems with dumb DOS packet driver after
a warm reboot".
This triggers the following warning in the qemu pcnet32 emulation:
Bad SWSTYLE=0x04

Avoid this qemu warning by allowing the switch-back to 16bit mode.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/hw/net/pcnet.c b/hw/net/pcnet.c
index d9ba04bdfc..14eb2fa1b0 100644
--- a/hw/net/pcnet.c
+++ b/hw/net/pcnet.c
@@ -1496,8 +1496,9 @@ static void pcnet_bcr_writew(PCNetState *s, uint32_t rap, uint32_t val)
         case 1:
             val |= 0x0100;
             break;
-        case 2:
+        case 2: /* 32bit mode */
         case 3:
+        case 4: /* 16bit mode */
             val |= 0x0300;
             break;
         default:
