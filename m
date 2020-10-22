Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EC8C388F2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 05:18:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12F4F2145D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 05:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bvQ4CUob"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12F4F2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVSzP-0003lG-1M
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 01:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kVSu0-0003er-FR
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 01:12:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47273)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kVStu-0003vx-DE
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 01:12:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603343553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sSEzA0lt6WFnE/KBczxLWYIGVO/nSAAX0EbUW7irl+M=;
 b=bvQ4CUobowDfhAc1D6SZvQPmUGLCcZVTUrdZ1ZYcFC0GSrPYBkxJVimbL8aZ86aRyBtCaS
 mkDH4MG1rvzTDvgXt21AZ4Mtg9jZqS3iQQu81i8mvl9VexXnW80lhSJzctyI1hwi5JQVwQ
 MXhAxkmjCvss3lYaprwy+kV5OjZM9YE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-fHnzmxquOzmfID1H_zGs3g-1; Thu, 22 Oct 2020 01:12:31 -0400
X-MC-Unique: fHnzmxquOzmfID1H_zGs3g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F908186DD24
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 05:12:30 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 57BCB60C47;
 Thu, 22 Oct 2020 05:12:24 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8EB129D0E; Thu, 22 Oct 2020 07:12:23 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/14] spice: move qemu_spice_init() to QemuSpiceOps.
Date: Thu, 22 Oct 2020 07:12:12 +0200
Message-Id: <20201022051223.6181-4-kraxel@redhat.com>
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

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-id: 20201019075224.14803-4-kraxel@redhat.com
---
 include/ui/qemu-spice-module.h | 1 +
 include/ui/qemu-spice.h        | 5 -----
 softmmu/vl.c                   | 2 +-
 ui/spice-core.c                | 3 ++-
 ui/spice-module.c              | 5 +++++
 5 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/ui/qemu-spice-module.h b/include/ui/qemu-spice-module.h
index 7a9963dd5810..b182bc4c21a6 100644
--- a/include/ui/qemu-spice-module.h
+++ b/include/ui/qemu-spice-module.h
@@ -19,6 +19,7 @@
 #define QEMU_SPICE_MODULE_H
 
 struct QemuSpiceOps {
+    void (*init)(void);
     int (*migrate_info)(const char *h, int p, int t, const char *s);
 };
 
diff --git a/include/ui/qemu-spice.h b/include/ui/qemu-spice.h
index 3157016c2bb4..e6df0a8715b0 100644
--- a/include/ui/qemu-spice.h
+++ b/include/ui/qemu-spice.h
@@ -26,7 +26,6 @@
 #include <spice.h>
 #include "qemu/config-file.h"
 
-void qemu_spice_init(void);
 void qemu_spice_input_init(void);
 void qemu_spice_display_init(void);
 int qemu_spice_display_add_client(int csock, int skipauth, int tls);
@@ -74,10 +73,6 @@ static inline void qemu_spice_display_init(void)
     abort();
 }
 
-static inline void qemu_spice_init(void)
-{
-}
-
 #endif /* CONFIG_SPICE */
 
 static inline bool qemu_using_spice(Error **errp)
diff --git a/softmmu/vl.c b/softmmu/vl.c
index cb476aa70bcc..65c34a6b8a2e 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -4151,7 +4151,7 @@ void qemu_init(int argc, char **argv, char **envp)
     /* spice needs the timers to be initialized by this point */
     /* spice must initialize before audio as it changes the default auiodev */
     /* spice must initialize before chardevs (for spicevmc and spiceport) */
-    qemu_spice_init();
+    qemu_spice.init();
 
     qemu_opts_foreach(qemu_find_opts("chardev"),
                       chardev_init_func, NULL, &error_fatal);
diff --git a/ui/spice-core.c b/ui/spice-core.c
index b03d743cf9b9..6ef66eb387de 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -633,7 +633,7 @@ static void vm_change_state_handler(void *opaque, int running,
     }
 }
 
-void qemu_spice_init(void)
+static void qemu_spice_init(void)
 {
     QemuOpts *opts = QTAILQ_FIRST(&qemu_spice_opts.head);
     const char *password, *str, *x509_dir, *addr,
@@ -994,6 +994,7 @@ int qemu_spice_display_is_running(SimpleSpiceDisplay *ssd)
 }
 
 static struct QemuSpiceOps real_spice_ops = {
+    .init         = qemu_spice_init,
     .migrate_info = qemu_spice_migrate_info,
 };
 
diff --git a/ui/spice-module.c b/ui/spice-module.c
index f1939545a684..a30fa452ea93 100644
--- a/ui/spice-module.c
+++ b/ui/spice-module.c
@@ -22,6 +22,10 @@
 
 int using_spice;
 
+static void qemu_spice_init_stub(void)
+{
+}
+
 static int qemu_spice_migrate_info_stub(const char *h, int p, int t,
                                         const char *s)
 {
@@ -29,5 +33,6 @@ static int qemu_spice_migrate_info_stub(const char *h, int p, int t,
 }
 
 struct QemuSpiceOps qemu_spice = {
+    .init         = qemu_spice_init_stub,
     .migrate_info = qemu_spice_migrate_info_stub,
 };
-- 
2.27.0


