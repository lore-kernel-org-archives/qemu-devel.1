Received: from eggs.gnu.org ([2001:4830:134:3::10]:35305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTZSy-0003so-BF
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 14:30:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTZSx-0001C6-Fq
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 14:30:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53566)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cTZSx-0001BM-9W
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 14:30:47 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6794481222
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 19:30:47 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 17 Jan 2017 17:30:33 -0200
Message-Id: <20170117193033.23178-4-ehabkost@redhat.com>
In-Reply-To: <20170117193033.23178-1-ehabkost@redhat.com>
References: <20170117193033.23178-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] arch_init: Move acpi_table_add() call back
 to vl.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Now that the code is not arch-dependent anymore, it can be moved
back to vl.c.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/sysemu/arch_init.h |  1 -
 arch_init.c                | 11 -----------
 vl.c                       |  7 ++++++-
 3 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
index 88dcf77a62..20b01e3004 100644
--- a/include/sysemu/arch_init.h
+++ b/include/sysemu/arch_init.h
@@ -28,7 +28,6 @@ enum {
 extern const uint32_t arch_type;
 
 void select_soundhw(const char *optarg);
-void do_acpitable_option(const QemuOpts *opts);
 void audio_init(void);
 int kvm_available(void);
 int xen_available(void);
diff --git a/arch_init.c b/arch_init.c
index 0416d84211..591afe6e2c 100644
--- a/arch_init.c
+++ b/arch_init.c
@@ -235,17 +235,6 @@ void audio_init(void)
     }
 }
 
-void do_acpitable_option(const QemuOpts *opts)
-{
-    Error *err = NULL;
-
-    acpi_table_add(opts, &err);
-    if (err) {
-        error_reportf_err(err, "Wrong acpi table provided: ");
-        exit(1);
-    }
-}
-
 int kvm_available(void)
 {
 #ifdef CONFIG_KVM
diff --git a/vl.c b/vl.c
index 38d812286a..9571b17eb6 100644
--- a/vl.c
+++ b/vl.c
@@ -65,6 +65,7 @@ int main(int argc, char **argv)
 #include "hw/bt.h"
 #include "sysemu/watchdog.h"
 #include "hw/smbios/smbios.h"
+#include "hw/acpi/acpi.h"
 #include "hw/xen/xen.h"
 #include "hw/qdev.h"
 #include "hw/loader.h"
@@ -3699,7 +3700,11 @@ int main(int argc, char **argv, char **envp)
                 if (!opts) {
                     exit(1);
                 }
-                do_acpitable_option(opts);
+                acpi_table_add(opts, &err);
+                if (err) {
+                    error_reportf_err(err, "Wrong acpi table provided: ");
+                    exit(1);
+                }
                 break;
             case QEMU_OPTION_smbios:
                 opts = qemu_opts_parse_noisily(qemu_find_opts("smbios"),
-- 
2.11.0.259.g40922b1
