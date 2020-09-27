Return-Path: <SRS0=PST1=DE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56A0C4346E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 15:01:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18C1F23899
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 15:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fSES/4Ca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18C1F23899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMYBJ-0008K0-4T
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 11:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kMY8U-0005bY-O1
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 10:58:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20552)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kMY8T-0006Tq-1X
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 10:58:46 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601218724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hNLcghou2JIIFL8nOu0gOdDNzxKgsPO8BGkR410M6LI=;
 b=fSES/4Cas0OthixwQM55GDrXZVuBH77IjnnIYUAjcR7vlFIrupJ06DDVW70mNyGQXRTnR6
 PcsLvF8cAiU7gbULD94z+GOjNUog5b/orj/xmYA9gjDvZfMTzXIrfooUC+0NOWObnDZEVf
 4d0hhYjL5bwzKCXTq3398EJCs0dcs5w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-aKgGuxWjPr-Q2HZlDuMVUw-1; Sun, 27 Sep 2020 10:58:41 -0400
X-MC-Unique: aKgGuxWjPr-Q2HZlDuMVUw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF8AA807331;
 Sun, 27 Sep 2020 14:58:40 +0000 (UTC)
Received: from localhost (unknown [10.36.110.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 10DAA5D9CA;
 Sun, 27 Sep 2020 14:58:27 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/6] ui: add getter for UIInfo
Date: Sun, 27 Sep 2020 18:57:48 +0400
Message-Id: <20200927145751.365446-4-marcandre.lureau@redhat.com>
In-Reply-To: <20200927145751.365446-1-marcandre.lureau@redhat.com>
References: <20200927145751.365446-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/27 10:58:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.576,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: spice-devel@lists.freedesktop.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The following patch is going to introduce extra fields / details to
UIInfo. Add a getter and keep the current values, instead of memset(0)

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/console.h | 1 +
 ui/console.c         | 7 +++++++
 ui/spice-display.c   | 2 +-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 79e301f946..353d2e49a1 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -264,6 +264,7 @@ void update_displaychangelistener(DisplayChangeListener *dcl,
 void unregister_displaychangelistener(DisplayChangeListener *dcl);
 
 bool dpy_ui_info_supported(QemuConsole *con);
+const QemuUIInfo *dpy_get_ui_info(const QemuConsole *con);
 int dpy_set_ui_info(QemuConsole *con, QemuUIInfo *info);
 
 void dpy_gfx_update(QemuConsole *con, int x, int y, int w, int h);
diff --git a/ui/console.c b/ui/console.c
index 7592c3c324..54a74c0b16 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1516,6 +1516,13 @@ bool dpy_ui_info_supported(QemuConsole *con)
     return con->hw_ops->ui_info != NULL;
 }
 
+const QemuUIInfo *dpy_get_ui_info(const QemuConsole *con)
+{
+    assert(con != NULL);
+
+    return &con->ui_info;
+}
+
 int dpy_set_ui_info(QemuConsole *con, QemuUIInfo *info)
 {
     assert(con != NULL);
diff --git a/ui/spice-display.c b/ui/spice-display.c
index 19632fdf6c..625d9232b9 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -672,7 +672,7 @@ static int interface_client_monitors_config(QXLInstance *sin,
         return 1;
     }
 
-    memset(&info, 0, sizeof(info));
+    info = *dpy_get_ui_info(ssd->dcl.con);
 
     if (mc->num_of_monitors == 1) {
         /*
-- 
2.26.2


