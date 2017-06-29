Received: from eggs.gnu.org ([2001:4830:134:3::10]:34393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dQhQJ-0005kb-KQ
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 17:56:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dQhQH-0000Qt-IY
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 17:56:27 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:36215)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1dQhQH-0000Qe-B2
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 17:56:25 -0400
Received: by mail-lf0-x241.google.com with SMTP id f28so8682553lfi.3
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 14:56:25 -0700 (PDT)
From: Aleksandr Bezzubikov <zuban32s@gmail.com>
Date: Fri, 30 Jun 2017 00:55:59 +0300
Message-Id: <1498773362-18675-4-git-send-email-zuban32s@gmail.com>
In-Reply-To: <1498773362-18675-1-git-send-email-zuban32s@gmail.com>
References: <1498773362-18675-1-git-send-email-zuban32s@gmail.com>
Subject: [Qemu-devel] [PATCH RFC 3/6] hw/acpi: fix pcihp io initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcel@redhat.com, mst@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, Aleksandr Bezzubikov <zuban32s@gmail.com>

Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
---
 hw/i386/acpi-build.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index b0dcd34..c99dbcc 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -129,17 +129,18 @@ static void acpi_get_pm_info(AcpiPmInfo *pm)
     Object *lpc = ich9_lpc_find();
     Object *obj = NULL;
     QObject *o;
+    int pcihp_io_len, pcihp_io_base;
 
     pm->cpu_hp_io_base = 0;
-    pm->pcihp_io_base = 0;
-    pm->pcihp_io_len = 0;
     if (piix) {
         obj = piix;
         pm->cpu_hp_io_base = PIIX4_CPU_HOTPLUG_IO_BASE;
-        pm->pcihp_io_base =
+        pcihp_io_base =
             object_property_get_int(obj, ACPI_PCIHP_IO_BASE_PROP, NULL);
-        pm->pcihp_io_len =
+        pcihp_io_len =
             object_property_get_int(obj, ACPI_PCIHP_IO_LEN_PROP, NULL);
+        pm->pcihp_io_base = (pcihp_io_base == -1) ? 0 : pcihp_io_base;
+        pm->pcihp_io_len = (pcihp_io_len == -1) ? 0 : pcihp_io_len;
     }
     if (lpc) {
         obj = lpc;
-- 
2.7.4
