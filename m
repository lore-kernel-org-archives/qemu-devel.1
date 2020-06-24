Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8DEC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 17:04:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07C3420738
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 17:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ULUnykvs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C3420738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo8ow-0004Rl-9s
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 13:04:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jo8Vj-0004P0-6E
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 12:44:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26277
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jo8VD-00058e-KN
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 12:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593017037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=swXcdoc9eRaX4Yp+R8VG5EV9jVN+Os9mXktWkr3z+Rk=;
 b=ULUnykvsqu3L7mU+sDP/xesEIw6HzT2AxGBa/BQYS71cK69HDcwiJtcBKHda52eEpuuilL
 P+Yc4Qsor8XsmIrbtBmkmsAiZOrmhoSRU1HxkF/xDMSQynnQlLS6gj2A/EBQO4ahgrOZEY
 300q82LnbSuv0pvDSGbJDNWGIdmcvsU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-6u4Os1XwPlSU7zFIQRE70Q-1; Wed, 24 Jun 2020 12:43:52 -0400
X-MC-Unique: 6u4Os1XwPlSU7zFIQRE70Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD32B10059A3;
 Wed, 24 Jun 2020 16:43:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AB8407931F;
 Wed, 24 Jun 2020 16:43:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4DC1A113848A; Wed, 24 Jun 2020 18:43:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 29/46] acpi: Avoid unnecessary error_propagate() after
 error_setg()
Date: Wed, 24 Jun 2020 18:43:27 +0200
Message-Id: <20200624164344.3778251-30-armbru@redhat.com>
In-Reply-To: <20200624164344.3778251-1-armbru@redhat.com>
References: <20200624164344.3778251-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 02:33:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The commit before previous enables another round of the transformation
from recent commit "error: Avoid unnecessary error_propagate() after
error_setg()".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/acpi/core.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index 91ae66b806..f6d9ec4f13 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -239,7 +239,6 @@ static void acpi_table_install(const char unsigned *blob, size_t bloblen,
 void acpi_table_add(const QemuOpts *opts, Error **errp)
 {
     AcpiTableOptions *hdrs = NULL;
-    Error *err = NULL;
     char **pathnames = NULL;
     char **cur;
     size_t bloblen = 0;
@@ -257,13 +256,13 @@ void acpi_table_add(const QemuOpts *opts, Error **errp)
         goto out;
     }
     if (hdrs->has_file == hdrs->has_data) {
-        error_setg(&err, "'-acpitable' requires one of 'data' or 'file'");
+        error_setg(errp, "'-acpitable' requires one of 'data' or 'file'");
         goto out;
     }
 
     pathnames = g_strsplit(hdrs->has_file ? hdrs->file : hdrs->data, ":", 0);
     if (pathnames == NULL || pathnames[0] == NULL) {
-        error_setg(&err, "'-acpitable' requires at least one pathname");
+        error_setg(errp, "'-acpitable' requires at least one pathname");
         goto out;
     }
 
@@ -272,7 +271,7 @@ void acpi_table_add(const QemuOpts *opts, Error **errp)
         int fd = open(*cur, O_RDONLY | O_BINARY);
 
         if (fd < 0) {
-            error_setg(&err, "can't open file %s: %s", *cur, strerror(errno));
+            error_setg(errp, "can't open file %s: %s", *cur, strerror(errno));
             goto out;
         }
 
@@ -288,8 +287,8 @@ void acpi_table_add(const QemuOpts *opts, Error **errp)
                 memcpy(blob + bloblen, data, r);
                 bloblen += r;
             } else if (errno != EINTR) {
-                error_setg(&err, "can't read file %s: %s",
-                           *cur, strerror(errno));
+                error_setg(errp, "can't read file %s: %s", *cur,
+                           strerror(errno));
                 close(fd);
                 goto out;
             }
@@ -298,14 +297,12 @@ void acpi_table_add(const QemuOpts *opts, Error **errp)
         close(fd);
     }
 
-    acpi_table_install(blob, bloblen, hdrs->has_file, hdrs, &err);
+    acpi_table_install(blob, bloblen, hdrs->has_file, hdrs, errp);
 
 out:
     g_free(blob);
     g_strfreev(pathnames);
     qapi_free_AcpiTableOptions(hdrs);
-
-    error_propagate(errp, err);
 }
 
 unsigned acpi_table_len(void *current)
-- 
2.26.2


