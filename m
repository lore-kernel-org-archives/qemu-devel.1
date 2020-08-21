Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC27C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:22:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B6F820748
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJYu9cU4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B6F820748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9Ak1-0001vY-CZ
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 13:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k9AjA-0000Sf-0s
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 13:21:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32834)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k9Aj7-0008Of-HQ
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 13:21:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598030476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4L5xY7hnZTbpnE4UWtkZJDAbXGSq8u3Zb3Rzq8nKXhU=;
 b=IJYu9cU4yXt5gxgmEx7Wbx2WRkW3p7xP9C2+cchA4OGH34IutBVaEAJd9UDVrHCtt6mtWz
 GvL+wPQBF7pO/Qz68Y//NhmcO9GEE/9Sa4EyoWZE6SFGCylO7CsZZwyGw4mwe1uydmVhZZ
 kJIQPzAjAaNrK2sEAVszEfmNZWTd+20=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-tmEXOINWOsSHHg4TN0E0Ew-1; Fri, 21 Aug 2020 13:21:14 -0400
X-MC-Unique: tmEXOINWOsSHHg4TN0E0Ew-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04D1651B7;
 Fri, 21 Aug 2020 17:21:14 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F384160CD0;
 Fri, 21 Aug 2020 17:21:11 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 2/6] util: refactor qemu_open_old to split off variadic
 args handling
Date: Fri, 21 Aug 2020 18:21:01 +0100
Message-Id: <20200821172105.608752-3-berrange@redhat.com>
In-Reply-To: <20200821172105.608752-1-berrange@redhat.com>
References: <20200821172105.608752-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 04:26:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This simple refactoring prepares for future patches. The variadic args
handling is split from the main bulk of the open logic. The duplicated
calls to open() are removed in favour of updating the "flags" variable
to have O_CLOEXEC.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 util/osdep.c | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/util/osdep.c b/util/osdep.c
index 9df1b6adec..9ff92551e7 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -22,6 +22,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 
 /* Needed early for CONFIG_BSD etc. */
 
@@ -282,10 +283,10 @@ int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive)
 /*
  * Opens a file with FD_CLOEXEC set
  */
-int qemu_open_old(const char *name, int flags, ...)
+static int
+qemu_open_internal(const char *name, int flags, mode_t mode)
 {
     int ret;
-    int mode = 0;
 
 #ifndef _WIN32
     const char *fdset_id_str;
@@ -323,22 +324,35 @@ int qemu_open_old(const char *name, int flags, ...)
     }
 #endif
 
-    if (flags & O_CREAT) {
-        va_list ap;
-
-        va_start(ap, flags);
-        mode = va_arg(ap, int);
-        va_end(ap);
-    }
-
 #ifdef O_CLOEXEC
-    ret = open(name, flags | O_CLOEXEC, mode);
-#else
+    flags |= O_CLOEXEC;
+#endif /* O_CLOEXEC */
+
     ret = open(name, flags, mode);
+
+#ifndef O_CLOEXEC
     if (ret >= 0) {
         qemu_set_cloexec(ret);
     }
-#endif
+#endif /* ! O_CLOEXEC */
+
+    return ret;
+}
+
+
+int qemu_open_old(const char *name, int flags, ...)
+{
+    va_list ap;
+    mode_t mode = 0;
+    int ret;
+
+    va_start(ap, flags);
+    if (flags & O_CREAT) {
+        mode = va_arg(ap, int);
+    }
+    va_end(ap);
+
+    ret = qemu_open_internal(name, flags, mode);
 
 #ifdef O_DIRECT
     if (ret == -1 && errno == EINVAL && (flags & O_DIRECT)) {
-- 
2.26.2


