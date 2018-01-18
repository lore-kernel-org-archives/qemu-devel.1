Received: from eggs.gnu.org ([2001:4830:134:3::10]:36696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ec9Nb-0000MJ-3e
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 07:33:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ec9NW-0007J8-88
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 07:33:15 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:45801)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ec9NW-0007It-4F
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 07:33:10 -0500
Received: by mail-qt0-x241.google.com with SMTP id x27so21690044qtm.12
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 04:33:10 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 18 Jan 2018 09:32:14 -0300
Message-Id: <20180118123219.19410-13-f4bug@amsat.org>
In-Reply-To: <20180118123219.19410-1-f4bug@amsat.org>
References: <20180118123219.19410-1-f4bug@amsat.org>
Subject: [Qemu-devel] [PATCH v7 12/16] sdhci: Fix 64-bit ADMA2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Sai Pavan Boddu <saipava@xilinx.com>, qemu-devel@nongnu.org, Kevin O'Connor <kevin@koconnor.net>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Marcel Apfelbaum <marcel@redhat.com>

From: Sai Pavan Boddu <saipava@xilinx.com>

The 64-bit ADMA address is not converted to the cpu endianes correctly.
This patch fixes the issue and uses a valid mask for the attribute data.

Signed-off-by: Sai Pavan Boddu <saipava@xilinx.com>
[AF: Re-write commit message]
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 hw/sd/sdhci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index a8663979c5..aff914009b 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -632,8 +632,8 @@ static void get_adma_description(SDHCIState *s, ADMADescr *dscr)
         dscr->length = le16_to_cpu(dscr->length);
         dma_memory_read(s->dma_as, entry_addr + 4,
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
