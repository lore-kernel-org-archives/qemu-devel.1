Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACFEC282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 10:06:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6385D24B8B
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 10:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6385D24B8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49681 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY6Ky-0000wv-IM
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 06:06:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tina.zhang@intel.com>) id 1hY6J6-00083S-9V
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 06:04:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tina.zhang@intel.com>) id 1hY6J4-0000mv-Cf
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 06:04:40 -0400
Received: from mga18.intel.com ([134.134.136.126]:33971)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tina.zhang@intel.com>)
	id 1hY6J4-0000hK-0f
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 06:04:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
	by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	04 Jun 2019 03:04:30 -0700
X-ExtLoop1: 1
Received: from gvt.bj.intel.com ([10.238.158.187])
	by orsmga007.jf.intel.com with ESMTP; 04 Jun 2019 03:04:28 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: intel-gvt-dev@lists.freedesktop.org,
	qemu-devel@nongnu.org
Date: Tue,  4 Jun 2019 17:58:46 +0800
Message-Id: <20190604095847.10532-3-tina.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604095847.10532-1-tina.zhang@intel.com>
References: <20190604095847.10532-1-tina.zhang@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.126
Subject: [Qemu-devel] [RFC PATCH 2/3] ui/console: Introduce two new APIs
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kevin.tian@intel.com, zhenyuw@linux.intel.com,
	Tina Zhang <tina.zhang@intel.com>, alex.williamson@redhat.com,
	zhiyuan.lv@intel.com, hang.yuan@intel.com, zhi.a.wang@intel.com,
	kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

graphic_hw_refresh is used by display to invoke console refresh.
dpy_update_interval is used by display to update gui timer interval.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 include/ui/console.h |  2 ++
 ui/console.c         | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/ui/console.h b/include/ui/console.h
index fef900db76..3b46264efb 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -275,6 +275,7 @@ void register_displaychangelistener(DisplayChangeListener *dcl);
 void update_displaychangelistener(DisplayChangeListener *dcl,
                                   uint64_t interval);
 void unregister_displaychangelistener(DisplayChangeListener *dcl);
+void dpy_update_interval(QemuConsole *con, uint64_t interval);
 
 bool dpy_ui_info_supported(QemuConsole *con);
 int dpy_set_ui_info(QemuConsole *con, QemuUIInfo *info);
@@ -379,6 +380,7 @@ void graphic_console_set_hwops(QemuConsole *con,
 void graphic_console_close(QemuConsole *con);
 
 void graphic_hw_update(QemuConsole *con);
+void graphic_hw_refresh(QemuConsole *con);
 void graphic_hw_invalidate(QemuConsole *con);
 void graphic_hw_text_update(QemuConsole *con, console_ch_t *chardata);
 void graphic_hw_gl_block(QemuConsole *con, bool block);
diff --git a/ui/console.c b/ui/console.c
index 6d2282d3e9..3a02cea37d 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -268,6 +268,24 @@ void graphic_hw_update(QemuConsole *con)
     }
 }
 
+void graphic_hw_refresh(QemuConsole *con)
+{
+    DisplayState *ds;
+    DisplayChangeListener *dcl;
+
+    if (!con) {
+        con = active_console;
+    }
+
+    ds = con->ds;
+
+    QLIST_FOREACH(dcl, &ds->listeners, next) {
+        if (dcl->ops->dpy_refresh) {
+            dcl->ops->dpy_refresh(dcl);
+        }
+    }
+}
+
 void graphic_hw_gl_block(QemuConsole *con, bool block)
 {
     assert(con != NULL);
@@ -1480,6 +1498,23 @@ void update_displaychangelistener(DisplayChangeListener *dcl,
     }
 }
 
+void dpy_update_interval(QemuConsole *con, uint64_t interval)
+{
+    DisplayChangeListener *dcl;
+    DisplayState *ds;
+
+    if (!con) {
+        return;
+    }
+
+    ds = con->ds;
+
+    QLIST_FOREACH(dcl, &ds->listeners, next) {
+        update_displaychangelistener(dcl, interval);
+    }
+}
+
+
 void unregister_displaychangelistener(DisplayChangeListener *dcl)
 {
     DisplayState *ds = dcl->ds;
-- 
2.17.1


