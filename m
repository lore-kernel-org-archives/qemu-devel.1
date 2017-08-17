Received: from eggs.gnu.org ([2001:4830:134:3::10]:55789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diCSl-0000KH-OZ
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 00:31:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diCSk-0004rp-RM
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 00:31:19 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:37988)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diCSk-0004rO-MT
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 00:31:18 -0400
Received: by mail-qt0-x242.google.com with SMTP id p3so5286826qtg.5
	for <qemu-devel@nongnu.org>; Wed, 16 Aug 2017 21:31:18 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 17 Aug 2017 01:30:55 -0300
Message-Id: <20170817043102.6322-2-f4bug@amsat.org>
In-Reply-To: <20170817043102.6322-1-f4bug@amsat.org>
References: <20170817043102.6322-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/8] mips: move hw/mips/cputimer.c to
 target/mips/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, James Hogan <james.hogan@imgtec.com>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

This timer is a required part of the MIPS32/MIPS64 System Control coprocessor
(CP0). Moving it with the other architecture related files will allow an opaque
use of CPUMIPSState* in the next commit (introduce "internal.h").

also remove it from 'user' targets, remove an unnecessary include.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/cputimer.c => target/mips/cp0_timer.c | 1 -
 hw/mips/Makefile.objs                         | 2 +-
 target/mips/Makefile.objs                     | 2 +-
 3 files changed, 2 insertions(+), 3 deletions(-)
 rename hw/mips/cputimer.c => target/mips/cp0_timer.c (99%)

diff --git a/hw/mips/cputimer.c b/target/mips/cp0_timer.c
similarity index 99%
rename from hw/mips/cputimer.c
rename to target/mips/cp0_timer.c
index 8a166b3ea7..a9a58c5604 100644
--- a/hw/mips/cputimer.c
+++ b/target/mips/cp0_timer.c
@@ -21,7 +21,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/mips/cpudevs.h"
 #include "qemu/timer.h"
 #include "sysemu/kvm.h"
diff --git a/hw/mips/Makefile.objs b/hw/mips/Makefile.objs
index 48cd2ef50e..17a311aaba 100644
--- a/hw/mips/Makefile.objs
+++ b/hw/mips/Makefile.objs
@@ -1,5 +1,5 @@
 obj-y += mips_r4k.o mips_malta.o mips_mipssim.o
-obj-y += addr.o cputimer.o mips_int.o
+obj-y += addr.o mips_int.o
 obj-$(CONFIG_JAZZ) += mips_jazz.o
 obj-$(CONFIG_FULONG) += mips_fulong2e.o
 obj-y += gt64xxx_pci.o
diff --git a/target/mips/Makefile.objs b/target/mips/Makefile.objs
index bc5ed8511f..651f36f517 100644
--- a/target/mips/Makefile.objs
+++ b/target/mips/Makefile.objs
@@ -1,4 +1,4 @@
 obj-y += translate.o dsp_helper.o op_helper.o lmi_helper.o helper.o cpu.o
 obj-y += gdbstub.o msa_helper.o mips-semi.o
-obj-$(CONFIG_SOFTMMU) += machine.o
+obj-$(CONFIG_SOFTMMU) += machine.o cp0_timer.o
 obj-$(CONFIG_KVM) += kvm.o
-- 
2.14.1
