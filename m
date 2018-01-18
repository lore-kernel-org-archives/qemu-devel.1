Received: from eggs.gnu.org ([2001:4830:134:3::10]:36801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ec9Nn-0000Vc-6s
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 07:33:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ec9Nl-0007PY-AC
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 07:33:26 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:45807)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ec9Nl-0007PQ-5c
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 07:33:25 -0500
Received: by mail-qt0-x244.google.com with SMTP id x27so21691898qtm.12
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 04:33:25 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 18 Jan 2018 09:32:18 -0300
Message-Id: <20180118123219.19410-17-f4bug@amsat.org>
In-Reply-To: <20180118123219.19410-1-f4bug@amsat.org>
References: <20180118123219.19410-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 16/16] sdhci: throw an error if capabilities
 are incorrectly configured
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Kevin O'Connor <kevin@koconnor.net>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Marcel Apfelbaum <marcel@redhat.com>

now than the Exynos4210 uses the 'capareg-reserved' property,
we can safely report missing capabilities as error, since
capabilities will only get changed once new SDHCI models
are added.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sdhci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 7799382e89..07a7ebcc1e 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -23,7 +23,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "hw/hw.h"
 #include "sysemu/block-backend.h"
@@ -1208,7 +1207,8 @@ static void sdhci_init_readonly_registers(SDHCIState *s, Error **errp)
     } else {
         capab = s->capareg & ~capab;
         if (capab) {
-            warn_report("SDHCI: missing capability mask: 0x%" PRIx64, capab);
+            error_setg(errp, "missing capability mask: 0x%" PRIx64, capab);
+            return;
         }
     }
 }
-- 
2.15.1
