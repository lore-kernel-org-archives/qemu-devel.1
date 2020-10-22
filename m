Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D96C388F2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 05:15:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D76CB2145D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 05:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H+d7l21A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D76CB2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVSwW-0007WF-H7
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 01:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kVSu0-0003ej-CH
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 01:12:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46623)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kVStv-0003wD-74
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 01:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603343554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l//AX153FspWPkvWboiscr8w6tNgQgDXAHu+0xePpzQ=;
 b=H+d7l21AFbsS/wjisGeOhS3RZpmO7Jn+6vxFMOYOmfOn2+3/uwjkvmNu+o9mRF/qRHIQaf
 k2PDDOCRWX28cGCaEl5g5Hop5e4Mc6XgxooHlzRWnDZ+dSJbEDtSY7ok2TwzBjwm1AHRp9
 w2WrWys5a9W3YeWavP3qfWIwzHE6Hzo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-pmrJobdtMnisJ2JTORR4ag-1; Thu, 22 Oct 2020 01:12:31 -0400
X-MC-Unique: pmrJobdtMnisJ2JTORR4ag-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E69C0803F61
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 05:12:30 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 57D626EF42;
 Thu, 22 Oct 2020 05:12:24 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6FC289D74; Thu, 22 Oct 2020 07:12:23 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/14] spice: add module helpers
Date: Thu, 22 Oct 2020 07:12:10 +0200
Message-Id: <20201022051223.6181-2-kraxel@redhat.com>
In-Reply-To: <20201022051223.6181-1-kraxel@redhat.com>
References: <20201022051223.6181-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

Add new spice-module.c + qemu-spice-module.h files.  The code needed to
support modular spice will be there.  For starters this will be only the
using_spice variable, more will follow ...

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-id: 20201019075224.14803-2-kraxel@redhat.com
---
 include/ui/qemu-spice-module.h | 23 +++++++++++++++++++++++
 include/ui/qemu-spice.h        |  4 +---
 ui/spice-core.c                |  1 -
 ui/spice-module.c              | 23 +++++++++++++++++++++++
 ui/meson.build                 |  1 +
 5 files changed, 48 insertions(+), 4 deletions(-)
 create mode 100644 include/ui/qemu-spice-module.h
 create mode 100644 ui/spice-module.c

diff --git a/include/ui/qemu-spice-module.h b/include/ui/qemu-spice-module.h
new file mode 100644
index 000000000000..1af0e659a109
--- /dev/null
+++ b/include/ui/qemu-spice-module.h
@@ -0,0 +1,23 @@
+/*
+ * Copyright (C) 2010 Red Hat, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 or
+ * (at your option) version 3 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef QEMU_SPICE_MODULE_H
+#define QEMU_SPICE_MODULE_H
+
+extern int using_spice;
+
+#endif
diff --git a/include/ui/qemu-spice.h b/include/ui/qemu-spice.h
index 0e8ec3f0d776..ab523788b9a9 100644
--- a/include/ui/qemu-spice.h
+++ b/include/ui/qemu-spice.h
@@ -19,14 +19,13 @@
 #define QEMU_SPICE_H
 
 #include "qapi/error.h"
+#include "ui/qemu-spice-module.h"
 
 #ifdef CONFIG_SPICE
 
 #include <spice.h>
 #include "qemu/config-file.h"
 
-extern int using_spice;
-
 void qemu_spice_init(void);
 void qemu_spice_input_init(void);
 void qemu_spice_display_init(void);
@@ -50,7 +49,6 @@ int qemu_spice_migrate_info(const char *hostname, int port, int tls_port,
 
 #include "qemu/error-report.h"
 
-#define using_spice 0
 #define spice_displays 0
 static inline int qemu_spice_set_passwd(const char *passwd,
                                         bool fail_if_connected,
diff --git a/ui/spice-core.c b/ui/spice-core.c
index 47700b220059..a7fa5743585f 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -48,7 +48,6 @@ static time_t auth_expires = TIME_MAX;
 static int spice_migration_completed;
 static int spice_display_is_running;
 static int spice_have_target_host;
-int using_spice = 0;
 
 static QemuThread me;
 
diff --git a/ui/spice-module.c b/ui/spice-module.c
new file mode 100644
index 000000000000..f86b0ac517dc
--- /dev/null
+++ b/ui/spice-module.c
@@ -0,0 +1,23 @@
+/*
+ * spice module support, also spice stubs.
+ *
+ * Copyright (C) 2010 Red Hat, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 or
+ * (at your option) version 3 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "ui/qemu-spice-module.h"
+
+int using_spice;
diff --git a/ui/meson.build b/ui/meson.build
index ab4de98b381b..e89e298643a3 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -12,6 +12,7 @@ softmmu_ss.add(files(
   'keymaps.c',
   'qemu-pixman.c',
 ))
+softmmu_ss.add([spice_headers, files('spice-module.c')])
 
 softmmu_ss.add(when: 'CONFIG_LINUX', if_true: files('input-linux.c'))
 softmmu_ss.add(when: [spice, 'CONFIG_SPICE'], if_true: files('spice-core.c', 'spice-input.c', 'spice-display.c'))
-- 
2.27.0


