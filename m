Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798A2C2BD0F
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 15:27:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3790120775
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 15:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QgBFkhWL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3790120775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDr8j-0008QH-9P
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 11:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kDr4S-0000QO-Tz
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 11:22:40 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58929
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kDr4R-00082g-59
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 11:22:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599146558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3JXPYA2yrsOAf5k3nPhmksH7m/JuM8SwBbaZNJhTJO8=;
 b=QgBFkhWLARnwwX6B5uxK9C878OZ/4RlLMxd45NuC2khBev4lTglqGIzo9Tq3MQBr0lBLXj
 87OyEkCa+UwsZwuVyhxVl3aJuHkjdUp2m1v+jiyq7F6cgyCzF3Vug0HJMnclgnEa15smdC
 57UKAXZgTmd+2alt+bV4vnL+QXK1boo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-ZiLnBF77OIaOMtPViWnAXw-1; Thu, 03 Sep 2020 11:22:34 -0400
X-MC-Unique: ZiLnBF77OIaOMtPViWnAXw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77A46100746C;
 Thu,  3 Sep 2020 15:22:32 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.14])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1C0C92D07D;
 Thu,  3 Sep 2020 15:22:29 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 7/8] util: give a specific error message when O_DIRECT
 doesn't work
Date: Thu,  3 Sep 2020 16:22:09 +0100
Message-Id: <20200903152210.1917355-8-berrange@redhat.com>
In-Reply-To: <20200903152210.1917355-1-berrange@redhat.com>
References: <20200903152210.1917355-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:28:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

A common error scenario is to tell QEMU to use O_DIRECT in combination
with a filesystem that doesn't support it. To aid users to diagnosing
their mistake we want to provide a clear error message when this happens.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 util/osdep.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/util/osdep.c b/util/osdep.c
index c99f1e7db2..8ea7a807c1 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -332,11 +332,24 @@ qemu_open_internal(const char *name, int flags, mode_t mode, Error **errp)
 
     if (ret == -1) {
         const char *action = flags & O_CREAT ? "create" : "open";
+#ifdef O_DIRECT
+        /* Give more helpful error message for O_DIRECT */
+        if (errno == EINVAL && (flags & O_DIRECT)) {
+            ret = open(name, flags & ~O_DIRECT, mode);
+            if (ret != -1) {
+                close(ret);
+                error_setg(errp, "Could not %s '%s': "
+                           "filesystem does not support O_DIRECT",
+                           action, name);
+                errno = EINVAL; /* restore first open()'s errno */
+                return -1;
+            }
+        }
+#endif /* O_DIRECT */
         error_setg_errno(errp, errno, "Could not %s '%s'",
                          action, name);
     }
 
-
     return ret;
 }
 
-- 
2.26.2


