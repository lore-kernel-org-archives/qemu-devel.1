Received: from eggs.gnu.org ([2001:4830:134:3::10]:46342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eqaIM-0001dl-JH
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 03:07:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eqaIL-0003Eu-3d
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 03:07:30 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49008 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eqaIK-0003Ec-VR
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 03:07:29 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9FDDA81638F1
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 08:07:28 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 27 Feb 2018 09:07:19 +0100
Message-Id: <20180227080724.13585-8-kraxel@redhat.com>
In-Reply-To: <20180227080724.13585-1-kraxel@redhat.com>
References: <20180227080724.13585-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 07/12] console: add ui module loading support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

If a requested user interface is not available, try loading it as
module, simliar to block layer modules.  Needed to keep things working
when followup patches start to build user interfaces as modules.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20180221131537.31341-8-kraxel@redhat.com
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
index 25d342cdcb..78efab269a 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -2199,6 +2199,9 @@ bool qemu_display_find_default(DisplayOptions *opts)
 
     for (i = 0; i < ARRAY_SIZE(prio); i++) {
         if (dpys[prio[i]] == NULL) {
+            ui_module_load_one(DisplayType_lookup.array[prio[i]]);
+        }
+        if (dpys[prio[i]] == NULL) {
             continue;
         }
         opts->type = prio[i];
@@ -2214,6 +2217,9 @@ void qemu_display_early_init(DisplayOptions *opts)
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
