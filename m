Received: from eggs.gnu.org ([2001:4830:134:3::10]:50210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXVn7-0006P6-P3
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:32:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXVn3-0004SF-Hd
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:32:57 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51474)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXVn3-0004RT-9F
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 13:32:53 -0500
Received: by mail-wm1-x342.google.com with SMTP id s14so3375558wmh.1
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 10:32:53 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Dec 2018 18:32:49 +0000
Message-Id: <20181213183249.3468-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] hw/misc/tz-mpc: Fix value of BLK_MAX register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

In the TZ Memory Protection Controller, the BLK_MAX register is supposed
to return the maximum permitted value of the BLK_IDX register. Our
implementation incorrectly returned max+1 (ie the total number of
valid index values, since BLK_IDX is zero-based).

Correct this off-by-one error. Since we consistently initialize
and use s->blk_max throughout the implementation as the 'size'
of the LUT, just adjust the value we return when the guest reads
the BLK_MAX register, rather than trying to change the semantics
of the s->blk_max internal struct field.

Fixes: https://bugs.launchpad.net/qemu/+bug/1806824
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/tz-mpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/tz-mpc.c b/hw/misc/tz-mpc.c
index e0c58ba37ec..946147b1c02 100644
--- a/hw/misc/tz-mpc.c
+++ b/hw/misc/tz-mpc.c
@@ -150,7 +150,7 @@ static MemTxResult tz_mpc_reg_read(void *opaque, hwaddr addr,
         r = s->ctrl;
         break;
     case A_BLK_MAX:
-        r = s->blk_max;
+        r = s->blk_max - 1;
         break;
     case A_BLK_CFG:
         /* We are never in "init in progress state", so this just indicates
-- 
2.19.2
