Received: from eggs.gnu.org ([2001:4830:134:3::10]:57707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eoUFS-0003Fx-0S
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 08:15:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eoUFO-0007Tr-Ps
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 08:15:49 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56420 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eoUFO-0007St-Kc
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 08:15:46 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4603F8182D06
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 13:15:44 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 21 Feb 2018 14:15:32 +0100
Message-Id: <20180221131537.31341-8-kraxel@redhat.com>
In-Reply-To: <20180221131537.31341-1-kraxel@redhat.com>
References: <20180221131537.31341-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 07/12] console: add ui module loading support
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

If a requested user interface is not available, try loading it as
module, simliar to block layer modules.  Needed to keep things working
when followup patches start to build user interfaces as modules.

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
index 5a63e9dfa2..dd663b9127 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -2189,6 +2189,9 @@ bool qemu_display_find_default(DisplayOptions *opts)
 
     for (i = 0; i < ARRAY_SIZE(prio); i++) {
         if (dpys[prio[i]] == NULL) {
+            ui_module_load_one(DisplayType_lookup.array[prio[i]]);
+        }
+        if (dpys[prio[i]] == NULL) {
             continue;
         }
         opts->type = prio[i];
@@ -2204,6 +2207,9 @@ void qemu_display_early_init(DisplayOptions *opts)
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
