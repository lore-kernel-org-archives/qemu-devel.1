Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E806C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:12:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFAEC2071B
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AEpTQUua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFAEC2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDWJc-000344-VP
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 13:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kDWGY-0006Ek-JJ
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:09:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33689
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kDWGW-0001O6-Up
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:09:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599066584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ke2Gq7O9miraf4qjtV+qmMUZy8GFd4yQ/tYyZZhtSBE=;
 b=AEpTQUua0suGxTnc6fsuxCPhWNukK0sU5vn7ArZgxW56asrF8vCjx7VXQrTXIEziNf/PiJ
 ata9JRZlEtBf/g0MaqFeULeCT2tZhWrCiseKBOeGW25+LfhAbXMuzF2haR0uv2T8ku3QHd
 FOyU8WoneyDVs2dwY2hto06SCZckVbs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-97JOlisTPOqHHXQm9X71AQ-1; Wed, 02 Sep 2020 13:09:40 -0400
X-MC-Unique: 97JOlisTPOqHHXQm9X71AQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08B8518B9EC4;
 Wed,  2 Sep 2020 17:09:39 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4830B19C59;
 Wed,  2 Sep 2020 17:09:36 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 5/8] util: add Error object for qemu_open_internal error
 reporting
Date: Wed,  2 Sep 2020 18:09:10 +0100
Message-Id: <20200902170913.1785194-6-berrange@redhat.com>
In-Reply-To: <20200902170913.1785194-1-berrange@redhat.com>
References: <20200902170913.1785194-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of relying on the limited information from errno, we can now
also provide detailed error messages to callers that ask for it.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 util/osdep.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/util/osdep.c b/util/osdep.c
index dd34b58bb7..28aa89adc9 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -298,7 +298,7 @@ static int qemu_open_cloexec(const char *name, int flags, mode_t mode)
  * Opens a file with FD_CLOEXEC set
  */
 static int
-qemu_open_internal(const char *name, int flags, mode_t mode)
+qemu_open_internal(const char *name, int flags, mode_t mode, Error **errp)
 {
     int ret;
 
@@ -312,12 +312,15 @@ qemu_open_internal(const char *name, int flags, mode_t mode)
 
         fdset_id = qemu_parse_fdset(fdset_id_str);
         if (fdset_id == -1) {
+            error_setg(errp, "Could not parse fdset %s", name);
             errno = EINVAL;
             return -1;
         }
 
         dupfd = monitor_fdset_dup_fd_add(fdset_id, flags);
         if (dupfd == -1) {
+            error_setg_errno(errp, errno, "Could not dup FD for %s flags %x",
+                             name, flags);
             return -1;
         }
 
@@ -327,6 +330,13 @@ qemu_open_internal(const char *name, int flags, mode_t mode)
 
     ret = qemu_open_cloexec(name, flags, mode);
 
+    if (ret == -1) {
+        const char *action = flags & O_CREAT ? "create" : "open";
+        error_setg_errno(errp, errno, "Could not %s '%s'",
+                         action, name);
+    }
+
+
     return ret;
 }
 
@@ -343,7 +353,7 @@ int qemu_open_old(const char *name, int flags, ...)
     }
     va_end(ap);
 
-    ret = qemu_open_internal(name, flags, mode);
+    ret = qemu_open_internal(name, flags, mode, NULL);
 
 #ifdef O_DIRECT
     if (ret == -1 && errno == EINVAL && (flags & O_DIRECT)) {
-- 
2.26.2


