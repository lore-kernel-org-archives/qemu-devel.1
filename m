Received: from eggs.gnu.org ([209.51.188.92]:46811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXpT-0005lt-Gy
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:32:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggXpR-0003Jt-Bx
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:32:43 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:34557)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggXpP-0002Ya-9X
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:32:41 -0500
Received: by mail-wm1-x330.google.com with SMTP id y185so6501230wmd.1
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 08:32:05 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	j14sm46039759wrv.96.2019.01.07.08.32.03 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 07 Jan 2019 08:32:04 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  7 Jan 2019 16:31:16 +0000
Message-Id: <20190107163117.16269-37-peter.maydell@linaro.org>
In-Reply-To: <20190107163117.16269-1-peter.maydell@linaro.org>
References: <20190107163117.16269-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 36/37] hw/misc/tz-mpc: Fix value of BLK_MAX
 register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181213183249.3468-1-peter.maydell@linaro.org
---
 hw/misc/tz-mpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/tz-mpc.c b/hw/misc/tz-mpc.c
index fb48a1540b9..9a84be75ed6 100644
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
