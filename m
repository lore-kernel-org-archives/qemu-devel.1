Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44203C388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 05:23:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 994562244C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 05:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ceRBqAmd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 994562244C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVT4U-00014E-6l
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 01:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kVSuA-0003ot-JO
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 01:12:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54664)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kVSu6-0003z5-Dk
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 01:12:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603343563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n9L3X1tq6cvpCG18lwfprM2YEvEWgjOvtpIfTHmh4U8=;
 b=ceRBqAmd9ci5B6H2FY30UbZwDr96HEqo5ynFmsc7FF9Ckk5duXPngdjKH1S7zQGCY21gAp
 WX0CEu8rprwUxhPw0x0eFivVoaSaCW8JnETDtEKgMixJ02SquIWksVvSEDjX2+hjHwyYbR
 MC3qZqFM7KFpb87lhiY+alV0Hoy2ZYs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-Wf6Uulz4OFy5ArgdwmNmyQ-1; Thu, 22 Oct 2020 01:12:41 -0400
X-MC-Unique: Wf6Uulz4OFy5ArgdwmNmyQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C48C835B52
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 05:12:40 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 515FA5C225;
 Thu, 22 Oct 2020 05:12:31 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id CDEF443BFB9; Thu, 22 Oct 2020 07:12:23 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/14] spice: move display_add_client() to QemuSpiceOps.
Date: Thu, 22 Oct 2020 07:12:16 +0200
Message-Id: <20201022051223.6181-8-kraxel@redhat.com>
In-Reply-To: <20201022051223.6181-1-kraxel@redhat.com>
References: <20201022051223.6181-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Message-id: 20201019075224.14803-8-kraxel@redhat.com
---
 include/ui/qemu-spice-module.h | 1 +
 include/ui/qemu-spice.h        | 6 ------
 monitor/qmp-cmds.c             | 2 +-
 ui/spice-core.c                | 3 ++-
 ui/spice-module.c              | 7 +++++++
 5 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/ui/qemu-spice-module.h b/include/ui/qemu-spice-module.h
index 1ea3a999ce8a..7422f6404ba0 100644
--- a/include/ui/qemu-spice-module.h
+++ b/include/ui/qemu-spice-module.h
@@ -29,6 +29,7 @@ struct QemuSpiceOps {
     int (*set_passwd)(const char *passwd,
                       bool fail_if_connected, bool disconnect_if_connected);
     int (*set_pw_expire)(time_t expires);
+    int (*display_add_client)(int csock, int skipauth, int tls);
 #ifdef CONFIG_SPICE
     int (*add_interface)(SpiceBaseInstance *sin);
 #endif
diff --git a/include/ui/qemu-spice.h b/include/ui/qemu-spice.h
index 921b7a38d023..2beb7929728c 100644
--- a/include/ui/qemu-spice.h
+++ b/include/ui/qemu-spice.h
@@ -28,7 +28,6 @@
 
 void qemu_spice_input_init(void);
 void qemu_spice_display_init(void);
-int qemu_spice_display_add_client(int csock, int skipauth, int tls);
 bool qemu_spice_have_display_interface(QemuConsole *con);
 int qemu_spice_add_display_interface(QXLInstance *qxlin, QemuConsole *con);
 int qemu_spice_migrate_info(const char *hostname, int port, int tls_port,
@@ -45,11 +44,6 @@ int qemu_spice_migrate_info(const char *hostname, int port, int tls_port,
 #include "qemu/error-report.h"
 
 #define spice_displays 0
-static inline int qemu_spice_display_add_client(int csock, int skipauth,
-                                                int tls)
-{
-    return -1;
-}
 
 #endif /* CONFIG_SPICE */
 
diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index 8ac59977e661..a08143b32335 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -340,7 +340,7 @@ void qmp_add_client(const char *protocol, const char *fdname,
         }
         skipauth = has_skipauth ? skipauth : false;
         tls = has_tls ? tls : false;
-        if (qemu_spice_display_add_client(fd, skipauth, tls) < 0) {
+        if (qemu_spice.display_add_client(fd, skipauth, tls) < 0) {
             error_setg(errp, "spice failed to add client");
             close(fd);
         }
diff --git a/ui/spice-core.c b/ui/spice-core.c
index 4fe543aba058..99457c226e6f 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -959,7 +959,7 @@ static int qemu_spice_set_pw_expire(time_t expires)
     return qemu_spice_set_ticket(false, false);
 }
 
-int qemu_spice_display_add_client(int csock, int skipauth, int tls)
+static int qemu_spice_display_add_client(int csock, int skipauth, int tls)
 {
     if (tls) {
         return spice_server_add_ssl_client(spice_server, csock, skipauth);
@@ -999,6 +999,7 @@ static struct QemuSpiceOps real_spice_ops = {
     .migrate_info = qemu_spice_migrate_info,
     .set_passwd   = qemu_spice_set_passwd,
     .set_pw_expire = qemu_spice_set_pw_expire,
+    .display_add_client = qemu_spice_display_add_client,
     .add_interface = qemu_spice_add_interface,
 };
 
diff --git a/ui/spice-module.c b/ui/spice-module.c
index 299aeb479be5..8fbc99c03c55 100644
--- a/ui/spice-module.c
+++ b/ui/spice-module.c
@@ -52,10 +52,17 @@ static int qemu_spice_set_pw_expire_stub(time_t expires)
     return -1;
 }
 
+static int qemu_spice_display_add_client_stub(int csock, int skipauth,
+                                              int tls)
+{
+    return -1;
+}
+
 struct QemuSpiceOps qemu_spice = {
     .init         = qemu_spice_init_stub,
     .display_init = qemu_spice_display_init_stub,
     .migrate_info = qemu_spice_migrate_info_stub,
     .set_passwd   = qemu_spice_set_passwd_stub,
     .set_pw_expire = qemu_spice_set_pw_expire_stub,
+    .display_add_client = qemu_spice_display_add_client_stub,
 };
-- 
2.27.0


