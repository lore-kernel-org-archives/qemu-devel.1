Received: from eggs.gnu.org ([2001:4830:134:3::10]:42682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1erL64-0005I0-G5
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:06:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1erL5y-00050I-Ao
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:05:56 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60222 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1erL5y-000502-6D
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 05:05:50 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C98AF407519A
	for <qemu-devel@nongnu.org>; Thu,  1 Mar 2018 10:05:49 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  1 Mar 2018 11:05:41 +0100
Message-Id: <20180301100547.18962-8-kraxel@redhat.com>
In-Reply-To: <20180301100547.18962-1-kraxel@redhat.com>
References: <20180301100547.18962-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 07/13] console: add ui module loading support
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
 Makefile.objs         | 1 +
 include/qemu/module.h | 1 +
 ui/console.c          | 6 ++++++
 3 files changed, 8 insertions(+)

diff --git a/Makefile.objs b/Makefile.objs
index 5dc134818c..57ca6d908b 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -56,6 +56,7 @@ common-obj-y += hw/
 common-obj-y += replay/
 
 common-obj-y += ui/
+common-obj-m += ui/
 common-obj-y += bt-host.o bt-vhci.o
 bt-host.o-cflags := $(BLUEZ_CFLAGS)
 
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
