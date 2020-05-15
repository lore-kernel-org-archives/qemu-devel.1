Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320EEC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 04:24:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA8EB20671
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 04:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FrMoaC1o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA8EB20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZRtD-0006a5-6N
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 00:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jZRrr-00068p-5v
 for qemu-devel@nongnu.org; Fri, 15 May 2020 00:22:39 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23511
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jZRrq-00011x-3w
 for qemu-devel@nongnu.org; Fri, 15 May 2020 00:22:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589516557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rnGy+nbz/6ihpYM8xij3AfZs61Auhjg0iER1EhIdf0Q=;
 b=FrMoaC1oiY8BHsgMnh6OB4w2r1tJitYKgM6yYL2qlMOlrQNRII5g4gvz5tSumjJQBHd2yh
 /ObVzSpLMGeJXChMnVqcuR9YAZDlieTcArAlwGLS1153SwkcHNfBWebCGhO/2ccpd4pioj
 nEjESQgQowivO7FE4rdwHuJP6ymYoeI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-h_m7paTfMmWmUlrGenbyQA-1; Fri, 15 May 2020 00:22:34 -0400
X-MC-Unique: h_m7paTfMmWmUlrGenbyQA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62F1C460;
 Fri, 15 May 2020 04:22:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1BB7B5D9D7;
 Fri, 15 May 2020 04:22:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9E11E11358BC; Fri, 15 May 2020 06:22:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] cpus: Fix botched configure_icount() error API violation
 fix
Date: Fri, 15 May 2020 06:22:31 +0200
Message-Id: <20200515042231.18201-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, philmd@redhat.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Before recent commit abc9bf69a66, configure_icount() returned early
when option "shift" was absent: succeed when option "align" was also
absent, else fail.

Since then, it still errors out when only "align" is present, but
continues when both are absent.  Crashes when examining the value of
"shift" further.  Reproducer: -icount "".

Revert this erroneous part of the commit.

Fixes: abc9bf69a66a11499a801ff545b8fe7adbb3a04c
Fixes: Coverity CID 1428754
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 cpus.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/cpus.c b/cpus.c
index 5670c96bcf..ee906dd08f 100644
--- a/cpus.c
+++ b/cpus.c
@@ -803,8 +803,10 @@ void configure_icount(QemuOpts *opts, Error **errp)
     bool align = qemu_opt_get_bool(opts, "align", false);
     long time_shift = -1;
 
-    if (!option && qemu_opt_get(opts, "align")) {
-        error_setg(errp, "Please specify shift option when using align");
+    if (!option) {
+        if (qemu_opt_get(opts, "align") != NULL) {
+            error_setg(errp, "Please specify shift option when using align");
+        }
         return;
     }
 
-- 
2.21.1


