Received: from eggs.gnu.org ([2001:4830:134:3::10]:34441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emBBA-0007rK-1c
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:29:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emBB8-00043G-BX
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:29:52 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:38239)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emBB8-000439-4Z
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 23:29:50 -0500
Received: by mail-qt0-x243.google.com with SMTP id k13so10472585qtg.5
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 20:29:50 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 15 Feb 2018 01:28:42 -0300
Message-Id: <20180215042900.16078-13-f4bug@amsat.org>
In-Reply-To: <20180215042900.16078-1-f4bug@amsat.org>
References: <20180215042900.16078-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 12/30] hw/hppa: use the BYTE-based definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>

It ease code review, unit is explicit.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/hppa/dino.c    | 2 +-
 hw/hppa/machine.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/hppa/dino.c b/hw/hppa/dino.c
index 15aefde09c..7728123cc8 100644
--- a/hw/hppa/dino.c
+++ b/hw/hppa/dino.c
@@ -76,7 +76,7 @@
 /* #define xxx    0x200 - bit 9 not used */
 #define RS232INT  0x400
 
-#define DINO_MEM_CHUNK_SIZE (8 * 1024 * 1024) /* 8MB */
+#define DINO_MEM_CHUNK_SIZE (8 * M_BYTE)
 
 #define DINO_PCI_HOST_BRIDGE(obj) \
     OBJECT_CHECK(DinoState, (obj), TYPE_DINO_PCI_HOST_BRIDGE)
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 22a15112df..8fd364ad43 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -177,8 +177,8 @@ static void machine_hppa_init(MachineState *machine)
         }
         qemu_log_mask(CPU_LOG_PAGE, "Kernel loaded at 0x%08" PRIx64
                       "-0x%08" PRIx64 ", entry at 0x%08" PRIx64
-                      ", size %ld kB.\n",
-                      kernel_low, kernel_high, kernel_entry, size / 1024);
+                      ", size %llu kB\n",
+                      kernel_low, kernel_high, kernel_entry, size / K_BYTE);
 
         if (kernel_cmdline) {
             cpu[0]->env.gr[24] = 0x4000;
@@ -202,8 +202,8 @@ static void machine_hppa_init(MachineState *machine)
                (1) Due to sign-extension problems and PDC,
                put the initrd no higher than 1G.
                (2) Reserve 64k for stack.  */
-            initrd_base = MIN(ram_size, 1024 * 1024 * 1024);
-            initrd_base = initrd_base - 64 * 1024;
+            initrd_base = MIN(ram_size, 1 * G_BYTE);
+            initrd_base = initrd_base - 64 * K_BYTE;
             initrd_base = (initrd_base - initrd_size) & TARGET_PAGE_MASK;
 
             if (initrd_base < kernel_high) {
-- 
2.16.1
