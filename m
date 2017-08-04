Received: from eggs.gnu.org ([2001:4830:134:3::10]:53883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dhiru.kholia@gmail.com>) id 1ddWMy-0000iS-Lx
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 02:46:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dhiru.kholia@gmail.com>) id 1ddWMv-0003pA-VH
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 02:46:00 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36707)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dhiru.kholia@gmail.com>)
	id 1ddWMv-0003ma-MN
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 02:45:57 -0400
Received: by mail-wm0-x244.google.com with SMTP id d40so4592355wma.3
	for <qemu-devel@nongnu.org>; Thu, 03 Aug 2017 23:45:56 -0700 (PDT)
From: Dhiru Kholia <dhiru.kholia@gmail.com>
Date: Fri,  4 Aug 2017 12:15:40 +0530
Message-Id: <20170804064540.10523-1-dhiru.kholia@gmail.com>
Subject: [Qemu-devel] [PATCH] pc/acpi: Fix booting of macOS with Clover EFI
 bootloader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Dhiru Kholia <dhiru.kholia@gmail.com>

This was tested with macOS 10.12.5 and Clover r4114.

Without this patch, the macOS boot process gets stuck at the Apple logo
without showing any progress bar.

I have documented the process of running macOS on QEMU/KVM at,

https://github.com/kholia/OSX-KVM/

Instead of using this patch, adding an additional command-line knob
which exposes this setting (force_rev1_fadt) to the user might be a more
general solution.
---
 hw/i386/acpi-build.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index b9c245c..0f8df19 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -145,6 +145,7 @@ static void acpi_get_pm_info(AcpiPmInfo *pm)
             object_property_get_uint(obj, ACPI_PCIHP_IO_LEN_PROP, NULL);
     }
     if (lpc) {
+        pm->force_rev1_fadt = true;
         obj = lpc;
         pm->cpu_hp_io_base = ICH9_CPU_HOTPLUG_IO_BASE;
     }
-- 
2.9.4
