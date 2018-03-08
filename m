Received: from eggs.gnu.org ([2001:4830:134:3::10]:56332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eu4Cl-0006nK-SV
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 17:40:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eu4Cl-0003uE-0o
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 17:40:07 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu,  8 Mar 2018 23:39:27 +0100
Message-Id: <20180308223946.26784-7-f4bug@amsat.org>
In-Reply-To: <20180308223946.26784-1-f4bug@amsat.org>
References: <20180308223946.26784-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 06/25] hw/isa/pc87312: Use uint16_t for the ISA
 I/O base address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Marcel Apfelbaum <marcel@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexey Kardashevskiy <aik@ozlabs.ru>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Eduardo Habkost <ehabkost@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, "open list:PReP" <qemu-ppc@nongnu.org>

This matches the isa_register_ioport() prototype.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/isa/pc87312.h |  2 +-
 hw/isa/pc87312.c         | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/hw/isa/pc87312.h b/include/hw/isa/pc87312.h
index 710eb1c807..b65b219a8a 100644
--- a/include/hw/isa/pc87312.h
+++ b/include/hw/isa/pc87312.h
@@ -34,7 +34,7 @@
 typedef struct PC87312State {
     ISADevice dev;
 
-    uint32_t iobase;
+    uint16_t iobase;
     uint8_t config; /* initial configuration */
 
     struct {
diff --git a/hw/isa/pc87312.c b/hw/isa/pc87312.c
index e9edbc6c50..105c23e680 100644
--- a/hw/isa/pc87312.c
+++ b/hw/isa/pc87312.c
@@ -69,9 +69,9 @@ static inline bool is_parallel_enabled(PC87312State *s)
     return s->regs[REG_FER] & FER_PARALLEL_EN;
 }
 
-static const uint32_t parallel_base[] = { 0x378, 0x3bc, 0x278, 0x00 };
+static const uint16_t parallel_base[] = { 0x378, 0x3bc, 0x278, 0x00 };
 
-static inline uint32_t get_parallel_iobase(PC87312State *s)
+static inline uint16_t get_parallel_iobase(PC87312State *s)
 {
     return parallel_base[s->regs[REG_FAR] & FAR_PARALLEL_ADDR];
 }
@@ -92,12 +92,12 @@ static inline uint32_t get_parallel_irq(PC87312State *s)
 
 /* UARTs */
 
-static const uint32_t uart_base[2][4] = {
+static const uint16_t uart_base[2][4] = {
     { 0x3e8, 0x338, 0x2e8, 0x220 },
     { 0x2e8, 0x238, 0x2e0, 0x228 }
 };
 
-static inline uint32_t get_uart_iobase(PC87312State *s, int i)
+static inline uint16_t get_uart_iobase(PC87312State *s, int i)
 {
     int idx;
     idx = (s->regs[REG_FAR] >> (2 * i + 2)) & 0x3;
@@ -130,7 +130,7 @@ static inline bool is_fdc_enabled(PC87312State *s)
     return s->regs[REG_FER] & FER_FDC_EN;
 }
 
-static inline uint32_t get_fdc_iobase(PC87312State *s)
+static inline uint16_t get_fdc_iobase(PC87312State *s)
 {
     return (s->regs[REG_FER] & FER_FDC_ADDR) ? 0x370 : 0x3f0;
 }
@@ -143,7 +143,7 @@ static inline bool is_ide_enabled(PC87312State *s)
     return s->regs[REG_FER] & FER_IDE_EN;
 }
 
-static inline uint32_t get_ide_iobase(PC87312State *s)
+static inline uint16_t get_ide_iobase(PC87312State *s)
 {
     return (s->regs[REG_FER] & FER_IDE_ADDR) ? 0x170 : 0x1f0;
 }
@@ -373,7 +373,7 @@ static const VMStateDescription vmstate_pc87312 = {
 };
 
 static Property pc87312_properties[] = {
-    DEFINE_PROP_UINT32("iobase", PC87312State, iobase, 0x398),
+    DEFINE_PROP_UINT16("iobase", PC87312State, iobase, 0x398),
     DEFINE_PROP_UINT8("config", PC87312State, config, 1),
     DEFINE_PROP_END_OF_LIST()
 };
-- 
2.16.2
