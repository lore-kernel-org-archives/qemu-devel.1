Received: from eggs.gnu.org ([2001:4830:134:3::10]:57004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eUynl-0003LV-5d
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 12:50:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eUynk-0006aD-9x
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 12:50:37 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:41616)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eUynk-0006ZV-4p
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 12:50:36 -0500
Received: by mail-qk0-x241.google.com with SMTP id a8so16160233qkb.8
	for <qemu-devel@nongnu.org>; Fri, 29 Dec 2017 09:50:35 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 29 Dec 2017 14:49:07 -0300
Message-Id: <20171229174933.1781-17-f4bug@amsat.org>
In-Reply-To: <20171229174933.1781-1-f4bug@amsat.org>
References: <20171229174933.1781-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 16/42] sdhci: use deposit64() on admasysaddr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>

This makes the code slightly safer, and easier to review.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 hw/sd/sdhci.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index a47ed61248..7f2c3dc9d5 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1117,12 +1117,10 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
         MASKED_WRITE(s->admaerr, mask, value);
         break;
     case SDHC_ADMASYSADDR:
-        s->admasysaddr = (s->admasysaddr & (0xFFFFFFFF00000000ULL |
-                (uint64_t)mask)) | (uint64_t)value;
+        s->admasysaddr = deposit64(s->admasysaddr, 0, 32, value);
         break;
     case SDHC_ADMASYSADDR + 4:
-        s->admasysaddr = (s->admasysaddr & (0x00000000FFFFFFFFULL |
-                ((uint64_t)mask << 32))) | ((uint64_t)value << 32);
+        s->admasysaddr = deposit64(s->admasysaddr, 32, 32, value);
         break;
     case SDHC_FEAER:
         s->acmd12errsts |= value;
-- 
2.15.1
