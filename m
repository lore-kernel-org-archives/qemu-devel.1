Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD450C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 09:50:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 660C122225
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 09:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hat9pJ8N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 660C122225
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIU4v-0002uC-9B
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 05:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kIU25-0006La-Tg
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 05:47:21 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36687
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kIU24-0008K9-4a
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 05:47:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600249639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V+05SS4UCsP/bMVJucHP6bpXPrium8HR8Ap+BdMCfME=;
 b=hat9pJ8N8elSdK/7NuyR8/8K+yHPRJ2Nztz/AjcR+wqZHfV6D5INdwrKTk+UkK6kWVITit
 8RB6HqkR1zQso6dIJiL3rq+F6Sxw5J0kS3ebxo0dkqmebJcVIZeujOkp5K1Iw0jqc5GAW/
 /zfUCNtJi7mVI1WPQXXpIOoJWK7oRzM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-Kwge5TyFNEywH6DV9yHUuQ-1; Wed, 16 Sep 2020 05:47:15 -0400
X-MC-Unique: Kwge5TyFNEywH6DV9yHUuQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C731186DD21;
 Wed, 16 Sep 2020 09:47:14 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF0A675141;
 Wed, 16 Sep 2020 09:47:11 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/8] util: split off a helper for dealing with O_CLOEXEC flag
Date: Wed, 16 Sep 2020 10:46:59 +0100
Message-Id: <20200916094705.2625331-3-berrange@redhat.com>
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
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:41:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We're going to have multiple callers to open() from qemu_open()
soon. Readability would thus benefit from having a helper for
dealing with O_CLOEXEC.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 util/osdep.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/util/osdep.c b/util/osdep.c
index 3d94b4d732..0d8fa9f016 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -279,6 +279,20 @@ int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive)
 }
 #endif
 
+static int qemu_open_cloexec(const char *name, int flags, mode_t mode)
+{
+    int ret;
+#ifdef O_CLOEXEC
+    ret = open(name, flags | O_CLOEXEC, mode);
+#else
+    ret = open(name, flags, mode);
+    if (ret >= 0) {
+        qemu_set_cloexec(ret);
+    }
+#endif
+    return ret;
+}
+
 /*
  * Opens a file with FD_CLOEXEC set
  */
@@ -318,14 +332,7 @@ int qemu_open(const char *name, int flags, ...)
         va_end(ap);
     }
 
-#ifdef O_CLOEXEC
-    ret = open(name, flags | O_CLOEXEC, mode);
-#else
-    ret = open(name, flags, mode);
-    if (ret >= 0) {
-        qemu_set_cloexec(ret);
-    }
-#endif
+    ret = qemu_open_cloexec(name, flags, mode);
 
 #ifdef O_DIRECT
     if (ret == -1 && errno == EINVAL && (flags & O_DIRECT)) {
-- 
2.26.2


