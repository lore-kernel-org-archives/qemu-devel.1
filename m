Received: from eggs.gnu.org ([2001:4830:134:3::10]:33851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWnsK-0003Bg-Pe
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:34:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWnsK-0007PD-2a
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:34:52 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:42482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWnsJ-0007P9-UN
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:34:52 -0500
Received: by mail-qk0-x243.google.com with SMTP id d202so2654403qkc.9
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 10:34:51 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  3 Jan 2018 15:34:02 -0300
Message-Id: <20180103183418.23730-10-f4bug@amsat.org>
In-Reply-To: <20180103183418.23730-1-f4bug@amsat.org>
References: <20180103183418.23730-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 09/25] sdhci: Fix 64-bit ADMA2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, =?UTF-8?q?Gr=C3=A9gory=20Estrade?= <gregory.estrade@gmail.com>, Prasad J Pandit <pjp@fedoraproject.org>
Cc: Sai Pavan Boddu <saipava@xilinx.com>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Sai Pavan Boddu <saipava@xilinx.com>

The 64-bit ADMA address is not converted to the cpu endianes correctly.
This patch fixes the issue and uses a valid mask for the attribute data.

Signed-off-by: Sai Pavan Boddu <saipava@xilinx.com>
[AF: Re-write commit message]
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sdhci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 755bbbecd1..50b483cbf2 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -623,8 +623,8 @@ static void get_adma_description(SDHCIState *s, ADMADescr *dscr)
         dscr->length = le16_to_cpu(dscr->length);
         dma_memory_read(&s->dma_as, entry_addr + 4,
                         (uint8_t *)(&dscr->addr), 8);
-        dscr->attr = le64_to_cpu(dscr->attr);
-        dscr->attr &= 0xfffffff8;
+        dscr->addr = le64_to_cpu(dscr->addr);
+        dscr->attr &= (uint8_t) ~0xC0;
         dscr->incr = 12;
         break;
     }
-- 
2.15.1
