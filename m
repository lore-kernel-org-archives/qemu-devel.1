Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C43DC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 09:48:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D60022243
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 09:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IyUPgtg0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D60022243
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIU3O-0008Hq-44
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 05:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kIU2B-0006Wm-7i
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 05:47:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48011)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kIU28-0008Lx-AX
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 05:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600249643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OBlwjFxU47XSKApD1+IlD4HJKgm38Z1/BvcNTQ3pVb0=;
 b=IyUPgtg0+T09le6q6qtnO5b6wpV19gdlpya/3GYqVzLmtGDix+j3ohK8MfzdMWoYv7/a/5
 zf0QlLCN/cWFI0sGTDSQTbG8nXcxo+cwXFH7kiZL0tMGpGXuRvowGZrfzEZS5KmrecZvW+
 00MqsRjz7Qg4ym0FHAGnk7+MrfnzS6k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-XGKY2quZMOWkB7N7CkrsTA-1; Wed, 16 Sep 2020 05:47:21 -0400
X-MC-Unique: XGKY2quZMOWkB7N7CkrsTA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8812F1006701;
 Wed, 16 Sep 2020 09:47:20 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F269B75123;
 Wed, 16 Sep 2020 09:47:17 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/8] util: refactor qemu_open_old to split off variadic args
 handling
Date: Wed, 16 Sep 2020 10:47:01 +0100
Message-Id: <20200916094705.2625331-5-berrange@redhat.com>
In-Reply-To: <20200916094705.2625331-1-berrange@redhat.com>
References: <20200916094705.2625331-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:35:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This simple refactoring prepares for future patches. The variadic args
handling is split from the main bulk of the open logic.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 util/osdep.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/util/osdep.c b/util/osdep.c
index 7504c156e8..11531e8f59 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -296,10 +296,10 @@ static int qemu_open_cloexec(const char *name, int flags, mode_t mode)
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
@@ -324,15 +324,25 @@ int qemu_open_old(const char *name, int flags, ...)
     }
 #endif
 
-    if (flags & O_CREAT) {
-        va_list ap;
+    ret = qemu_open_cloexec(name, flags, mode);
+
+    return ret;
+}
+
 
-        va_start(ap, flags);
+int qemu_open_old(const char *name, int flags, ...)
+{
+    va_list ap;
+    mode_t mode = 0;
+    int ret;
+
+    va_start(ap, flags);
+    if (flags & O_CREAT) {
         mode = va_arg(ap, int);
-        va_end(ap);
     }
+    va_end(ap);
 
-    ret = qemu_open_cloexec(name, flags, mode);
+    ret = qemu_open_internal(name, flags, mode);
 
 #ifdef O_DIRECT
     if (ret == -1 && errno == EINVAL && (flags & O_DIRECT)) {
-- 
2.26.2


