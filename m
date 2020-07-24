Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29970C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 13:47:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8DB1206D8
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 13:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AdvoAbwW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8DB1206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyy3H-0004zH-44
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 09:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jyy2a-00042z-2K
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 09:47:12 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25000
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jyy2Y-0004CW-FK
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 09:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595598429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qNIKTQj4D6Q6eHY0NCKLobup86zWLaw9aLCiYkrrDgI=;
 b=AdvoAbwWATDgZHLK7clsw8Bw/3YE6Oh03JOeZbxfW86zatN0542IY/8BzKjs6WtAD7jauI
 xJWu/SdNqEKMqS1UngxSBRWGM9DIma5XqWiUFZsuAJtpMa0VnT4EuXqzvSTzBHJJoiaCtL
 TO66WeGZnaaoL/Mblx+eqN/f8EsKHL4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-QWRbpA7oPIuNWJRExO8BOA-1; Fri, 24 Jul 2020 09:47:07 -0400
X-MC-Unique: QWRbpA7oPIuNWJRExO8BOA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58AB7800468;
 Fri, 24 Jul 2020 13:47:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 298DB2DE72;
 Fri, 24 Jul 2020 13:47:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A4FF411385EB; Fri, 24 Jul 2020 15:47:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/4] coccinelle/err-bad-newline: Fix for Python 3,
 and add patterns
Date: Fri, 24 Jul 2020 15:47:01 +0200
Message-Id: <20200724134704.2248335-2-armbru@redhat.com>
In-Reply-To: <20200724134704.2248335-1-armbru@redhat.com>
References: <20200724134704.2248335-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200722084048.1726105-2-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 scripts/coccinelle/err-bad-newline.cocci | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/scripts/coccinelle/err-bad-newline.cocci b/scripts/coccinelle/err-bad-newline.cocci
index 1316cc86a6..5394421873 100644
--- a/scripts/coccinelle/err-bad-newline.cocci
+++ b/scripts/coccinelle/err-bad-newline.cocci
@@ -1,22 +1,42 @@
 // Error messages should not contain newlines.  This script finds
 // messages that do.  Fixing them is manual.
 @r@
-expression errp, eno, cls, fmt;
+expression errp, err, eno, cls, fmt, ap;
 position p;
 @@
 (
+error_vreport(fmt, ap)@p
+|
+warn_vreport(fmt, ap)@p
+|
+info_vreport(fmt, ap)@p
+|
 error_report(fmt, ...)@p
 |
+warn_report(fmt, ...)@p
+|
+info_report(fmt, ...)@p
+|
+error_report_once(fmt, ...)@p
+|
+warn_report_once(fmt, ...)@p
+|
 error_setg(errp, fmt, ...)@p
 |
 error_setg_errno(errp, eno, fmt, ...)@p
 |
 error_setg_win32(errp, eno, cls, fmt, ...)@p
 |
+error_propagate_prepend(errp, err, fmt, ...)@p
+|
+error_vprepend(errp, fmt, ap)@p
+|
 error_prepend(errp, fmt, ...)@p
 |
 error_setg_file_open(errp, eno, cls, fmt, ...)@p
 |
+warn_reportf_err(errp, fmt, ...)@p
+|
 error_reportf_err(errp, fmt, ...)@p
 |
 error_set(errp, cls, fmt, ...)@p
@@ -26,4 +46,4 @@ fmt << r.fmt;
 p << r.p;
 @@
 if "\\n" in str(fmt):
-    print "%s:%s:%s:%s" % (p[0].file, p[0].line, p[0].column, fmt)
+    print("%s:%s:%s:%s" % (p[0].file, p[0].line, p[0].column, fmt))
-- 
2.26.2


