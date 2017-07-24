Received: from eggs.gnu.org ([2001:4830:134:3::10]:50536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi6O-0000fD-2M
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:29:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi6N-0005Hv-6k
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:29:08 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 24 Jul 2017 15:27:36 -0300
Message-Id: <20170724182751.18261-21-f4bug@amsat.org>
In-Reply-To: <20170724182751.18261-1-f4bug@amsat.org>
References: <20170724182751.18261-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.10 20/35] arm/boot: fix undefined
 instruction on secondary smp cpu bootloader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-arm@nongnu.org

In a ARM multicore system, write_secondary_boot() only initializes fixups for
FIXUP_GIC_CPU_IF and FIXUP_BOOTREG, while smpboot[] also uses FIXUP_DSB.
This results in write_bootloader() using uninitialized fixupcontext[FIXUP_DSB]
instruction in the bootloader code...
Zero-initialize fixupcontext[] to avoid this issue.

hw/arm/boot.c:157:18: warning: Assigned value is garbage or undefined
            insn = fixupcontext[fixup];
                 ^ ~~~~~~~~~~~~~~~~~~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/boot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index c2720c8046..fb21f113c2 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -170,7 +170,7 @@ static void write_bootloader(const char *name, hwaddr addr,
 static void default_write_secondary(ARMCPU *cpu,
                                     const struct arm_boot_info *info)
 {
-    uint32_t fixupcontext[FIXUP_MAX];
+    uint32_t fixupcontext[FIXUP_MAX] = {};
 
     fixupcontext[FIXUP_GIC_CPU_IF] = info->gic_cpu_if_addr;
     fixupcontext[FIXUP_BOOTREG] = info->smp_bootreg_addr;
-- 
2.13.3
