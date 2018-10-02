Received: from eggs.gnu.org ([2001:4830:134:3::10]:42972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g7SAx-0003Yf-H8
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 17:25:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g7SAt-0007Nt-2H
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 17:25:51 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:54832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g7SAs-0007NU-R3
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 17:25:46 -0400
Received: by mail-wm1-x329.google.com with SMTP id r63-v6so3674716wma.4
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 14:25:46 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue,  2 Oct 2018 23:25:18 +0200
Message-Id: <20181002212522.23303-10-f4bug@amsat.org>
In-Reply-To: <20181002212522.23303-1-f4bug@amsat.org>
References: <20181002212522.23303-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 09/12] hw/sparc64/niagara: Model the I/O
 Bridge with the 'unimplemented_device'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Since the I/O Bridge device is not implemented,  Use the
TYPE_UNIMPLEMENTED_DEVICE which suits better: if the user
asks for 'unimp' warnings via the -d option then all accesses
will generate logging.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>
---
 default-configs/sparc64-softmmu.mak | 1 -
 hw/sparc64/niagara.c                | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/default-configs/sparc64-softmmu.mak b/default-configs/sparc64-softmmu.mak
index 52edafe547..ce63d47046 100644
--- a/default-configs/sparc64-softmmu.mak
+++ b/default-configs/sparc64-softmmu.mak
@@ -16,5 +16,4 @@ CONFIG_SIMBA=y
 CONFIG_SUNHME=y
 CONFIG_MC146818RTC=y
 CONFIG_ISA_TESTDEV=y
-CONFIG_EMPTY_SLOT=y
 CONFIG_SUN4V_RTC=y
diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
index 4fa8cb2904..f8a856f611 100644
--- a/hw/sparc64/niagara.c
+++ b/hw/sparc64/niagara.c
@@ -29,7 +29,7 @@
 #include "hw/hw.h"
 #include "hw/boards.h"
 #include "hw/char/serial.h"
-#include "hw/empty_slot.h"
+#include "hw/misc/unimp.h"
 #include "hw/loader.h"
 #include "hw/sparc/sparc64.h"
 #include "hw/timer/sun4v-rtc.h"
@@ -161,7 +161,7 @@ static void niagara_init(MachineState *machine)
         serial_mm_init(sysmem, NIAGARA_UART_BASE, 0, NULL, 115200,
                        serial_hd(0), DEVICE_BIG_ENDIAN);
     }
-    empty_slot_init(NIAGARA_IOBBASE, NIAGARA_IOBSIZE);
+    create_unimplemented_device("sun4v-iob", NIAGARA_IOBBASE, NIAGARA_IOBSIZE);
     sun4v_rtc_init(NIAGARA_RTC_BASE);
 }
 
-- 
2.19.0
