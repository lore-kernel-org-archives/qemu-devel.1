Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172E2C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 08:42:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3B8C205CB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 08:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eu1yy6Jv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3B8C205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyAKi-0005T1-2A
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 04:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jyAJA-0003ms-OR
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 04:41:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25145
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jyAJ8-0000Np-GJ
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 04:41:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595407253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v4qjKJe9vEQSPCqLFgJL2Yoi057G7kUTdd4SX34/9jU=;
 b=Eu1yy6JvBBIidnlBg4chCofpDousGgbaen+xTC0XNMXbdrGJcq6fu8c+poO+BMFU+GTjRF
 nd+MFyhtWrqv1mjimvMeytZaKrYlZuhHJ6yeXCpAkAiV490ALin/CVZ7zwz33MzTrQDmGl
 PL3GghwTVYx1GdUyuz09V2tHcuAJJYs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-HZ-1MavQMPCWARZ-oPH-jA-1; Wed, 22 Jul 2020 04:40:51 -0400
X-MC-Unique: HZ-1MavQMPCWARZ-oPH-jA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 920E7107BF04
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 08:40:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 671E55BAD5
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 08:40:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 045BE10A5B7A; Wed, 22 Jul 2020 10:40:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] coccinelle/err-bad-newline: Fix for Python 3,
 and add patterns
Date: Wed, 22 Jul 2020 10:40:45 +0200
Message-Id: <20200722084048.1726105-2-armbru@redhat.com>
In-Reply-To: <20200722084048.1726105-1-armbru@redhat.com>
References: <20200722084048.1726105-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 23:27:14
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
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


