Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128BAC388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 05:13:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80BE82145D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 05:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bUvaKSqC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80BE82145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVSvF-0005KP-FE
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 01:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kVStx-0003dQ-Po
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 01:12:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25710)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kVStu-0003vw-CZ
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 01:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603343553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b/dqN6zoU6R/3M/XJ+oBnTnmMnYempTT8Ndoj0VMJSo=;
 b=bUvaKSqClexq3GqAyAExtY2eqLQ6zPef+yZwzvdT8O8VKRdwf9wFqZ85PnysWsCws3uJ2Q
 aTmnXJENeQ4LlBtlq37Ou6dNZrPrPkCt4nw1Y0hKbEZ3MTh82FDM3AwzhkPL+naLV+SwVU
 PG3WfUjlbRzi6+sTWmpDurtzpC+OUEY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-WI1_ygz3O6ugq_Ge7Vg64A-1; Thu, 22 Oct 2020 01:12:31 -0400
X-MC-Unique: WI1_ygz3O6ugq_Ge7Vg64A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76B81835B49
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 05:12:30 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 57B5C5D9DD;
 Thu, 22 Oct 2020 05:12:24 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 7F61D9D0D; Thu, 22 Oct 2020 07:12:23 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/14] spice: add QemuSpiceOps, move migrate_info
Date: Thu, 22 Oct 2020 07:12:11 +0200
Message-Id: <20201022051223.6181-3-kraxel@redhat.com>
In-Reply-To: <20201022051223.6181-1-kraxel@redhat.com>
References: <20201022051223.6181-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

Add QemuSpiceOps struct.  This struct holds function pointers to the
spice functions.  It will be initialized with pointers to the stub
functions.  When spice gets initialized the function pointers will
be re-written to the real functions.

The spice stubs will move from qemu-spice.h to spice-module.c for that,
because they will be needed for both "CONFIG_SPICE=n" and "CONFIG_SPICE=y
but spice module not loaded" cases.

This patch adds the infrastructure and starts with moving
qemu_spice_migrate_info() to QemuSpiceOps.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-id: 20201019075224.14803-3-kraxel@redhat.com
---
 include/ui/qemu-spice-module.h |  5 +++++
 include/ui/qemu-spice.h        |  5 -----
 monitor/misc.c                 |  2 +-
 ui/spice-core.c                |  5 +++++
 ui/spice-module.c              | 10 ++++++++++
 5 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/include/ui/qemu-spice-module.h b/include/ui/qemu-spice-module.h
index 1af0e659a109..7a9963dd5810 100644
--- a/include/ui/qemu-spice-module.h
+++ b/include/ui/qemu-spice-module.h
@@ -18,6 +18,11 @@
 #ifndef QEMU_SPICE_MODULE_H
 #define QEMU_SPICE_MODULE_H
 
+struct QemuSpiceOps {
+    int (*migrate_info)(const char *h, int p, int t, const char *s);
+};
+
 extern int using_spice;
+extern struct QemuSpiceOps qemu_spice;
 
 #endif
diff --git a/include/ui/qemu-spice.h b/include/ui/qemu-spice.h
index ab523788b9a9..3157016c2bb4 100644
--- a/include/ui/qemu-spice.h
+++ b/include/ui/qemu-spice.h
@@ -60,11 +60,6 @@ static inline int qemu_spice_set_pw_expire(time_t expires)
 {
     return -1;
 }
-static inline int qemu_spice_migrate_info(const char *h, int p, int t,
-                                          const char *s)
-{
-    return -1;
-}
 
 static inline int qemu_spice_display_add_client(int csock, int skipauth,
                                                 int tls)
diff --git a/monitor/misc.c b/monitor/misc.c
index 4a859fb24a21..32e6a8c13d07 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -437,7 +437,7 @@ void qmp_client_migrate_info(const char *protocol, const char *hostname,
             return;
         }
 
-        if (qemu_spice_migrate_info(hostname,
+        if (qemu_spice.migrate_info(hostname,
                                     has_port ? port : -1,
                                     has_tls_port ? tls_port : -1,
                                     cert_subject)) {
diff --git a/ui/spice-core.c b/ui/spice-core.c
index a7fa5743585f..b03d743cf9b9 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -993,8 +993,13 @@ int qemu_spice_display_is_running(SimpleSpiceDisplay *ssd)
     return spice_display_is_running;
 }
 
+static struct QemuSpiceOps real_spice_ops = {
+    .migrate_info = qemu_spice_migrate_info,
+};
+
 static void spice_register_config(void)
 {
+    qemu_spice = real_spice_ops;
     qemu_add_opts(&qemu_spice_opts);
 }
 opts_init(spice_register_config);
diff --git a/ui/spice-module.c b/ui/spice-module.c
index f86b0ac517dc..f1939545a684 100644
--- a/ui/spice-module.c
+++ b/ui/spice-module.c
@@ -21,3 +21,13 @@
 #include "ui/qemu-spice-module.h"
 
 int using_spice;
+
+static int qemu_spice_migrate_info_stub(const char *h, int p, int t,
+                                        const char *s)
+{
+    return -1;
+}
+
+struct QemuSpiceOps qemu_spice = {
+    .migrate_info = qemu_spice_migrate_info_stub,
+};
-- 
2.27.0


