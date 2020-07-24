Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F725C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 13:47:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A617206D8
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 13:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q3412s6D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A617206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyy3G-0004z9-Lq
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 09:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jyy2a-000436-AK
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 09:47:12 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34539
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jyy2Y-0004CY-O7
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 09:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595598429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VvFsC7Lqmvx3of1PoGeArHby5M5skyMWuK3318nba+A=;
 b=Q3412s6DwzuChrspLcmzEmj5Of1LAZ7M27E37ZX1uEnQh3sXQZjz9BM7wljYIjDaLT4wTz
 JRQa4DQmChMUF3CpW6xgezdr21WaDe9k1roYwkodhQASMOWuchVgSPcJ+Pv188fTUUjcNG
 s3suxI06p4rGqYs7R0YRrp9RxwCdpsE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-4oQbOpbIMnqEijZVec0nlA-1; Fri, 24 Jul 2020 09:47:07 -0400
X-MC-Unique: 4oQbOpbIMnqEijZVec0nlA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A09F0107B7F0;
 Fri, 24 Jul 2020 13:47:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 38479712C1;
 Fri, 24 Jul 2020 13:47:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AFAD611385FA; Fri, 24 Jul 2020 15:47:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/4] qapi/error: Check format string argument in
 error_*prepend()
Date: Fri, 24 Jul 2020 15:47:04 +0200
Message-Id: <20200724134704.2248335-5-armbru@redhat.com>
In-Reply-To: <20200724134704.2248335-1-armbru@redhat.com>
References: <20200724134704.2248335-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 06:44:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Weil <sw@weilnetz.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

error_propagate_prepend() "behaves like error_prepend()", and
error_prepend() uses "formatting @fmt, ... like printf()".
error_prepend() checks its format string argument, but
error_propagate_prepend() does not. Fix by addint the format
attribute to error_propagate_prepend() and error_vprepend().

This would have caught the bug fixed in the previous commit.

Missed in commit 4b5766488f "error: Fix use of error_prepend() with
&error_fatal, &error_abort".

Inspired-by: Stefan Weil <sw@weilnetz.de>
Suggested-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200723171205.14949-1-philmd@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Commit message tweaked]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/error.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/qapi/error.h b/include/qapi/error.h
index 7932594dce..eaa05c4837 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -382,13 +382,15 @@ void error_propagate(Error **dst_errp, Error *local_err);
  * Please use ERRP_GUARD() and error_prepend() instead when possible.
  */
 void error_propagate_prepend(Error **dst_errp, Error *local_err,
-                             const char *fmt, ...);
+                             const char *fmt, ...)
+    GCC_FMT_ATTR(3, 4);
 
 /*
  * Prepend some text to @errp's human-readable error message.
  * The text is made by formatting @fmt, @ap like vprintf().
  */
-void error_vprepend(Error *const *errp, const char *fmt, va_list ap);
+void error_vprepend(Error *const *errp, const char *fmt, va_list ap)
+    GCC_FMT_ATTR(2, 0);
 
 /*
  * Prepend some text to @errp's human-readable error message.
-- 
2.26.2


