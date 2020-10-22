Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651C5C388F2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 05:13:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6C542145D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 05:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jBkNhzZg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6C542145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVSvE-0005Hi-FX
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 01:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kVStx-0003cv-44
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 01:12:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34439)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kVStu-0003w1-9R
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 01:12:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603343553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pj9BYsv+yyyPlWel/6ah+YJvXkaqMS6iE4H6MMGKnsE=;
 b=jBkNhzZg4tZGpcdNaTtwAPU5YixAUPyL91HwUsaifeF+d32JprZTnztxm1jpFx0+bJ57Yr
 XgV553lDBg48UKPtXgZ8aclstAsl6ApXiDFSrGXXOjtX4W9Ktf/Mj4FqOBwXQQ/XDs/PS/
 qYdM/9k7Hjo+n/swOxOog8eMwWp2jE8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-LcQ1_x6EPnme1WOUPixDZA-1; Thu, 22 Oct 2020 01:12:31 -0400
X-MC-Unique: LcQ1_x6EPnme1WOUPixDZA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F85B835B4F
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 05:12:30 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4D33E1002C04;
 Thu, 22 Oct 2020 05:12:24 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9DFFD9D0F; Thu, 22 Oct 2020 07:12:23 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/14] spice: move display_init() to QemuSpiceOps.
Date: Thu, 22 Oct 2020 07:12:13 +0200
Message-Id: <20201022051223.6181-5-kraxel@redhat.com>
In-Reply-To: <20201022051223.6181-1-kraxel@redhat.com>
References: <20201022051223.6181-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 00:54:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-id: 20201019075224.14803-5-kraxel@redhat.com
---
 include/ui/qemu-spice-module.h | 1 +
 include/ui/qemu-spice.h        | 7 -------
 softmmu/vl.c                   | 2 +-
 ui/spice-core.c                | 1 +
 ui/spice-module.c              | 9 +++++++++
 5 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/include/ui/qemu-spice-module.h b/include/ui/qemu-spice-module.h
index b182bc4c21a6..dbe09035dade 100644
--- a/include/ui/qemu-spice-module.h
+++ b/include/ui/qemu-spice-module.h
@@ -20,6 +20,7 @@
 
 struct QemuSpiceOps {
     void (*init)(void);
+    void (*display_init)(void);
     int (*migrate_info)(const char *h, int p, int t, const char *s);
 };
 
diff --git a/include/ui/qemu-spice.h b/include/ui/qemu-spice.h
index e6df0a8715b0..a3fd1ea5ade8 100644
--- a/include/ui/qemu-spice.h
+++ b/include/ui/qemu-spice.h
@@ -66,13 +66,6 @@ static inline int qemu_spice_display_add_client(int csock, int skipauth,
     return -1;
 }
 
-static inline void qemu_spice_display_init(void)
-{
-    /* This must never be called if CONFIG_SPICE is disabled */
-    error_report("spice support is disabled");
-    abort();
-}
-
 #endif /* CONFIG_SPICE */
 
 static inline bool qemu_using_spice(Error **errp)
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 65c34a6b8a2e..8a06fe8bf77a 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -4447,7 +4447,7 @@ void qemu_init(int argc, char **argv, char **envp)
 #endif
 
     if (using_spice) {
-        qemu_spice_display_init();
+        qemu_spice.display_init();
     }
 
     if (foreach_device_config(DEV_GDB, gdbserver_start) < 0) {
diff --git a/ui/spice-core.c b/ui/spice-core.c
index 6ef66eb387de..82d5dbda3e26 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -995,6 +995,7 @@ int qemu_spice_display_is_running(SimpleSpiceDisplay *ssd)
 
 static struct QemuSpiceOps real_spice_ops = {
     .init         = qemu_spice_init,
+    .display_init = qemu_spice_display_init,
     .migrate_info = qemu_spice_migrate_info,
 };
 
diff --git a/ui/spice-module.c b/ui/spice-module.c
index a30fa452ea93..56868aaffe9a 100644
--- a/ui/spice-module.c
+++ b/ui/spice-module.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "ui/qemu-spice-module.h"
 
 int using_spice;
@@ -26,6 +27,13 @@ static void qemu_spice_init_stub(void)
 {
 }
 
+static void qemu_spice_display_init_stub(void)
+{
+    /* This must never be called if CONFIG_SPICE is disabled */
+    error_report("spice support is disabled");
+    abort();
+}
+
 static int qemu_spice_migrate_info_stub(const char *h, int p, int t,
                                         const char *s)
 {
@@ -34,5 +42,6 @@ static int qemu_spice_migrate_info_stub(const char *h, int p, int t,
 
 struct QemuSpiceOps qemu_spice = {
     .init         = qemu_spice_init_stub,
+    .display_init = qemu_spice_display_init_stub,
     .migrate_info = qemu_spice_migrate_info_stub,
 };
-- 
2.27.0


