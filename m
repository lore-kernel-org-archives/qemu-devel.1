Received: from eggs.gnu.org ([2001:4830:134:3::10]:35160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g76XT-00041Z-MO
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 18:19:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g76OU-0007P2-OC
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 18:10:23 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43488)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g76OP-0007N1-6P
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 18:10:19 -0400
Received: by mail-wr1-x443.google.com with SMTP id n1-v6so5502586wrt.10
	for <qemu-devel@nongnu.org>; Mon, 01 Oct 2018 15:10:13 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue,  2 Oct 2018 00:09:36 +0200
Message-Id: <20181001220942.2382-10-f4bug@amsat.org>
In-Reply-To: <20181001220942.2382-1-f4bug@amsat.org>
References: <20181001220942.2382-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 09/15] hw/mips/malta: Replace 'empty_slot' by
 'unimplemented_device'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>

The TYPE_EMPTY_SLOT and TYPE_UNIMPLEMENTED_DEVICE are identical devices,
however the later use more recent APIs and is more widely used.

Replace 'empty_slot' by 'unimplemented_device' to simplify devices code
maintenance.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 default-configs/mips-softmmu-common.mak | 1 -
 hw/mips/mips_malta.c                    | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/mips-softmmu-common.mak
index fae2347ee7..f9d664e120 100644
--- a/default-configs/mips-softmmu-common.mak
+++ b/default-configs/mips-softmmu-common.mak
@@ -32,7 +32,6 @@ CONFIG_PFLASH_CFI01=y
 CONFIG_I8259=y
 CONFIG_MC146818RTC=y
 CONFIG_ISA_TESTDEV=y
-CONFIG_EMPTY_SLOT=y
 CONFIG_MIPS_CPS=y
 CONFIG_MIPS_ITU=y
 CONFIG_I2C=y
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 40041d5ec0..4ccfa87c35 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -53,7 +53,7 @@
 #include "sysemu/qtest.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "hw/empty_slot.h"
+#include "hw/misc/unimp.h"
 #include "sysemu/kvm.h"
 #include "exec/semihost.h"
 #include "hw/mips/cps.h"
@@ -1216,7 +1216,7 @@ void mips_malta_init(MachineState *machine)
     /* The whole address space decoded by the GT-64120A doesn't generate
        exception when accessing invalid memory. Create an empty slot to
        emulate this feature. */
-    empty_slot_init(0, 0x20000000);
+    create_unimplemented_device("gt64120-SysAD", 0, 0x20000000);
 
     qdev_init_nofail(dev);
 
-- 
2.19.0
