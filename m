Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABC3C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:25:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99F1C207DE
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="My8ES9Jf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99F1C207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9Ane-0007Ht-RF
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 13:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k9AjK-0000tb-55
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 13:21:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21313
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k9AjI-0008Qn-Ep
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 13:21:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598030487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=25DfPV+B9U+ja5hn8kQuVsOtB+UX5eUec8epW7TjHTI=;
 b=My8ES9Jfy7iA0nG3tyYSgIC7RFwWcwcN1W/iQAxeaf54RbJnFcKez7aUQSto9m+wh7w4hs
 bgxmY+cAuGZnGfmvndb/lAPTgM6NgnB+yPQXjuBfIL+1rXXmjbws594Yq1y7BEf3QiUgbh
 QgX3ySN0h8dfZu2sTWraLvU0fA1xFZ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89--1zsK2SbPf6pGxiabSSNGA-1; Fri, 21 Aug 2020 13:21:20 -0400
X-MC-Unique: -1zsK2SbPf6pGxiabSSNGA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20E9051B7;
 Fri, 21 Aug 2020 17:21:19 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B890C60CD0;
 Fri, 21 Aug 2020 17:21:16 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 4/6] util: introduce qemu_open and qemu_create with error
 reporting
Date: Fri, 21 Aug 2020 18:21:03 +0100
Message-Id: <20200821172105.608752-5-berrange@redhat.com>
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
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 04:55:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qemu_open_old() works like open(): set errno and return -1 on failure.
It has even more failure modes, though.  Reporting the error clearly
to users is basically impossible for many of them.

Our standard cure for "errno is too coarse" is the Error object.
Introduce two new helper methods:

  int qemu_open(const char *name, int flags, Error **errp);
  int qemu_create(const char *name, int flags, mode_t mode, Error **errp);

Note that with this design we no longer require or even accept the
O_CREAT flag. Avoiding overloading the two distinct operations
means we can avoid variable arguments which would prevent 'errp' from
being the last argument. It also gives us a guarantee that the 'mode' is
given when creating files, avoiding a latent security bug.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qemu/osdep.h |  6 ++++++
 util/osdep.c         | 21 +++++++++++++++++----
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 18333e9006..13a821845b 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -497,7 +497,13 @@ int qemu_madvise(void *addr, size_t len, int advice);
 int qemu_mprotect_rwx(void *addr, size_t size);
 int qemu_mprotect_none(void *addr, size_t size);
 
+/*
+ * Don't introduce new usage of this function, prefer the following
+ * qemu_open/qemu_create that take an "Error **errp"
+ */
 int qemu_open_old(const char *name, int flags, ...);
+int qemu_open(const char *name, int flags, Error **errp);
+int qemu_create(const char *name, int flags, mode_t mode, Error **errp);
 int qemu_close(int fd);
 int qemu_unlink(const char *name);
 #ifndef _WIN32
diff --git a/util/osdep.c b/util/osdep.c
index 9c7118d3cb..a4956fbf6b 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -344,10 +344,7 @@ qemu_open_internal(const char *name, int flags, mode_t mode, Error **errp)
 #endif /* ! O_CLOEXEC */
 
     if (ret == -1) {
-        const char *action = "open";
-        if (flags & O_CREAT) {
-            action = "create";
-        }
+        const char *action = flags & O_CREAT ? "create" : "open";
         error_setg_errno(errp, errno, "Could not %s '%s' flags 0x%x",
                          action, name, flags);
     }
@@ -357,6 +354,22 @@ qemu_open_internal(const char *name, int flags, mode_t mode, Error **errp)
 }
 
 
+int qemu_open(const char *name, int flags, Error **errp)
+{
+    assert(!(flags & O_CREAT));
+
+    return qemu_open_internal(name, flags, 0, errp);
+}
+
+
+int qemu_create(const char *name, int flags, mode_t mode, Error **errp)
+{
+    assert(!(flags & O_CREAT));
+
+    return qemu_open_internal(name, flags | O_CREAT, mode, errp);
+}
+
+
 int qemu_open_old(const char *name, int flags, ...)
 {
     va_list ap;
-- 
2.26.2


