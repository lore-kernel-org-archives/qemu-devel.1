Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDBCC388F9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 05:14:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 478BF223FB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 05:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gYscflQ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 478BF223FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVSvH-0005OG-95
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 01:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kVSu4-0003hy-AB
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 01:12:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25100)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kVStw-0003ww-9D
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 01:12:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603343555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wJlzlctCSWD+0j21f5dbiNPatstrKGJhxTWBIT81Asw=;
 b=gYscflQ01rlx1hLNtEX1OEnuFaYz+izO+sHQ46Ba/pwd5IEZdYTvEykAIRtP6S/fNTgYUT
 fnb8/SwALS24rGdrzyxI/eigMXIlD5bz7qBFZOorj7A4WbgB6Cj3F39cjtYCHX0gQzBYyb
 rA+H3N7lZMs0eKs5b1ebSHX3gtwruGg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-RK2ApFONOu--FUgF3TmHXg-1; Thu, 22 Oct 2020 01:12:32 -0400
X-MC-Unique: RK2ApFONOu--FUgF3TmHXg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E6C4186DD34
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 05:12:31 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5262560C15;
 Thu, 22 Oct 2020 05:12:31 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id D9DBC1FCE5; Thu, 22 Oct 2020 07:12:23 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/14] spice: wire up monitor in QemuSpiceOps.
Date: Thu, 22 Oct 2020 07:12:17 +0200
Message-Id: <20201022051223.6181-9-kraxel@redhat.com>
In-Reply-To: <20201022051223.6181-1-kraxel@redhat.com>
References: <20201022051223.6181-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 23:30:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Rename qmp_query_spice() to qmp_query_spice_real(), add to QemuSpiceOps.

Add new qmp_query_spice() function which calls the real function via
QemuSpiceOps if available, otherwise return SpiceInfo.enabled = false.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-id: 20201019075224.14803-9-kraxel@redhat.com
---
 include/ui/qemu-spice-module.h |  3 +++
 ui/spice-core.c                |  3 ++-
 ui/spice-module.c              | 17 +++++++++++++++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/ui/qemu-spice-module.h b/include/ui/qemu-spice-module.h
index 7422f6404ba0..1f22d557ea2f 100644
--- a/include/ui/qemu-spice-module.h
+++ b/include/ui/qemu-spice-module.h
@@ -22,6 +22,8 @@
 #include <spice.h>
 #endif
 
+typedef struct SpiceInfo SpiceInfo;
+
 struct QemuSpiceOps {
     void (*init)(void);
     void (*display_init)(void);
@@ -32,6 +34,7 @@ struct QemuSpiceOps {
     int (*display_add_client)(int csock, int skipauth, int tls);
 #ifdef CONFIG_SPICE
     int (*add_interface)(SpiceBaseInstance *sin);
+    SpiceInfo* (*qmp_query)(Error **errp);
 #endif
 };
 
diff --git a/ui/spice-core.c b/ui/spice-core.c
index 99457c226e6f..eea52f538999 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -502,7 +502,7 @@ static QemuOptsList qemu_spice_opts = {
     },
 };
 
-SpiceInfo *qmp_query_spice(Error **errp)
+static SpiceInfo *qmp_query_spice_real(Error **errp)
 {
     QemuOpts *opts = QTAILQ_FIRST(&qemu_spice_opts.head);
     int port, tls_port;
@@ -1001,6 +1001,7 @@ static struct QemuSpiceOps real_spice_ops = {
     .set_pw_expire = qemu_spice_set_pw_expire,
     .display_add_client = qemu_spice_display_add_client,
     .add_interface = qemu_spice_add_interface,
+    .qmp_query = qmp_query_spice_real,
 };
 
 static void spice_register_config(void)
diff --git a/ui/spice-module.c b/ui/spice-module.c
index 8fbc99c03c55..32223358722c 100644
--- a/ui/spice-module.c
+++ b/ui/spice-module.c
@@ -19,6 +19,9 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "qapi/qapi-types-ui.h"
+#include "qapi/qapi-commands-ui.h"
 #include "ui/qemu-spice-module.h"
 
 int using_spice;
@@ -66,3 +69,17 @@ struct QemuSpiceOps qemu_spice = {
     .set_pw_expire = qemu_spice_set_pw_expire_stub,
     .display_add_client = qemu_spice_display_add_client_stub,
 };
+
+#ifdef CONFIG_SPICE
+
+SpiceInfo *qmp_query_spice(Error **errp)
+{
+    if (!qemu_spice.qmp_query) {
+        SpiceInfo *info = g_new0(SpiceInfo, 1);
+        info->enabled = false;
+        return info;
+    }
+    return qemu_spice.qmp_query(errp);
+}
+
+#endif
-- 
2.27.0


