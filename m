Received: from eggs.gnu.org ([2001:4830:134:3::10]:49919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFdvH-0000qZ-2n
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:31:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFdvC-0007NT-1W
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:30:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eFdvB-0007Lb-Ou
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 05:30:53 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DCFA8D5704
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 10:30:52 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 17 Nov 2017 11:30:42 +0100
Message-Id: <20171117103046.15943-21-kraxel@redhat.com>
In-Reply-To: <20171117103046.15943-1-kraxel@redhat.com>
References: <20171117103046.15943-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 20/24] console: add ui module loading support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/qemu/module.h | 1 +
 ui/console.c          | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/include/qemu/module.h b/include/qemu/module.h
index 56dd218205..9fea75aaeb 100644
--- a/include/qemu/module.h
+++ b/include/qemu/module.h
@@ -53,6 +53,7 @@ typedef enum {
 #define trace_init(function) module_init(function, MODULE_INIT_TRACE)
 
 #define block_module_load_one(lib) module_load_one("block-", lib)
+#define ui_module_load_one(lib) module_load_one("ui-", lib)
 
 void register_module_init(void (*fn)(void), module_init_type type);
 void register_dso_module_init(void (*fn)(void), module_init_type type);
diff --git a/ui/console.c b/ui/console.c
index 4c9ac8b21a..9937da06a4 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -2187,6 +2187,9 @@ bool qemu_display_find_default(DisplayOptions *opts)
 
     for (i = 0; i < ARRAY_SIZE(prio); i++) {
         if (dpys[prio[i]] == NULL) {
+            ui_module_load_one(DisplayType_lookup.array[prio[i]]);
+        }
+        if (dpys[prio[i]] == NULL) {
             continue;
         }
         opts->type = prio[i];
@@ -2202,6 +2205,9 @@ void qemu_display_early_init(DisplayOptions *opts)
         return;
     }
     if (dpys[opts->type] == NULL) {
+        ui_module_load_one(DisplayType_lookup.array[opts->type]);
+    }
+    if (dpys[opts->type] == NULL) {
         error_report("Display '%s' is not available.",
                      DisplayType_lookup.array[opts->type]);
         exit(1);
-- 
2.9.3
