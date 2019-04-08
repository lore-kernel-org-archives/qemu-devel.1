Received: from eggs.gnu.org ([209.51.188.92]:48911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDPla-00089G-3P
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:36:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDPlZ-0003dl-38
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:36:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hDPlY-0003cz-Rz
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:36:33 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  8 Apr 2019 10:36:17 +0200
Message-Id: <20190408083627.7479-6-armbru@redhat.com>
In-Reply-To: <20190408083627.7479-1-armbru@redhat.com>
References: <20190408083627.7479-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 05/15] mips/boston: Report errors with
 error_report(), not error_printf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paul Burton <pburton@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>

Cc: Paul Burton <pburton@wavecomp.com>
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/mips/boston.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index e5bab3cadc..a8b29f62f5 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -528,21 +528,21 @@ static void boston_mach_init(MachineState *machine)
         fw_size = load_image_targphys(machine->firmware,
                                       0x1fc00000, 4 * MiB);
         if (fw_size == -1) {
-            error_printf("unable to load firmware image '%s'\n",
+            error_report("unable to load firmware image '%s'",
                           machine->firmware);
             exit(1);
         }
     } else if (machine->kernel_filename) {
         fit_err = load_fit(&boston_fit_loader, machine->kernel_filename, s);
         if (fit_err) {
-            error_printf("unable to load FIT image\n");
+            error_report("unable to load FIT image");
             exit(1);
         }
 
         gen_firmware(memory_region_get_ram_ptr(flash) + 0x7c00000,
                      s->kernel_entry, s->fdt_base, is_64b);
     } else if (!qtest_enabled()) {
-        error_printf("Please provide either a -kernel or -bios argument\n");
+        error_report("Please provide either a -kernel or -bios argument");
         exit(1);
     }
 }
-- 
2.17.2
