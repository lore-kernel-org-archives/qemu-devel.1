Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDF2C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 13:26:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDFAC2065F
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 13:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eoTrp+r1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDFAC2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyxiu-0001kd-1m
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 09:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jyxhs-0008Vc-2f
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 09:25:48 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55239
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jyxhq-00011b-JH
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 09:25:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595597145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ajdPE6s1yMNNO7wKORFcQ9vEE0jTRgdP9yYAVOyvGr4=;
 b=eoTrp+r1TiFgrok/BktOUuZqtc2yrG3Kt3p4Z6X5Lzuz77+gF4KFdpXl658XEPv2q8GFDB
 Vlvh8MKL/kRndlnFpJP0OipQ9gOGGFheJJtrWMzFFRuXJtKtgcOqKvJT0DduwpoPX6Xo8x
 MXY2xGHk7O6gZ9WfFj3wk8i0Wpz61Uw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-ZuJHyflnNiSDcagZzqawkA-1; Fri, 24 Jul 2020 09:25:43 -0400
X-MC-Unique: ZuJHyflnNiSDcagZzqawkA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75D7A80BCBD;
 Fri, 24 Jul 2020 13:25:42 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A3E1C101E1BF;
 Fri, 24 Jul 2020 13:25:36 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/4] util: give a specific error message when O_DIRECT
 doesn't work
Date: Fri, 24 Jul 2020 14:25:09 +0100
Message-Id: <20200724132510.3250311-4-berrange@redhat.com>
In-Reply-To: <20200724132510.3250311-1-berrange@redhat.com>
References: <20200724132510.3250311-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 00:00:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A common error scenario is to tell QEMU to use O_DIRECT in combination
with a filesystem that doesn't support it. To aid users to diagnosing
their mistake we want to provide a clear error message when this happens.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 util/osdep.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/util/osdep.c b/util/osdep.c
index 5c0f4684b1..ac3e7f48f1 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -348,6 +348,19 @@ qemu_open_internal(const char *name, int flags, mode_t mode, Error **errp)
         if (flags & O_CREAT) {
             action = "create";
         }
+#ifdef O_DIRECT
+        if (errno == EINVAL && (flags & O_DIRECT)) {
+            ret = open(name, flags & ~O_DIRECT, mode);
+            if (ret != -1) {
+                close(ret);
+                error_setg(errp, "Could not %s '%s' flags 0x%x: "
+                           "filesystem does not support O_DIRECT",
+                           action, name, flags);
+                errno = EINVAL; /* close() clobbered earlier errno */
+                return -1;
+            }
+        }
+#endif /* O_DIRECT */
         error_setg_errno(errp, errno, "Could not %s '%s' flags 0x%x",
                          action, name, flags);
     }
-- 
2.26.2


