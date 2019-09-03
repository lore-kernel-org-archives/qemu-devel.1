Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAD1C3A5A5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 06:21:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 621C9215EA
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 06:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 621C9215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i52Bi-0000NW-W5
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 02:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57001)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1i529e-0007BH-Es
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 02:19:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1i529d-0003Xl-Ek
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 02:19:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47922)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1i529d-0003XG-9b
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 02:19:01 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 24FBC307CDFC
 for <qemu-devel@nongnu.org>; Tue,  3 Sep 2019 06:19:00 +0000 (UTC)
Received: from thuth.com (ovpn-116-80.ams2.redhat.com [10.36.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 59B53600C6;
 Tue,  3 Sep 2019 06:18:58 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>,
	qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 08:18:44 +0200
Message-Id: <20190903061849.21493-2-thuth@redhat.com>
In-Reply-To: <20190903061849.21493-1-thuth@redhat.com>
References: <20190903061849.21493-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Tue, 03 Sep 2019 06:19:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/6] tests/migration: Do not use functions
 anymore that rely on global_qtest
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The migration tests deal with multiple test states, so we really should
not use functions here that rely on the single global_qtest variable.
Switch from qtest_start() to qtest_init() to make sure that global_qtest
is not set anymore. This also revealed a regression in the migrate()
function: It has once been converted to use the qtest_qmp() function,
but commit b5bbd3f315d686bd511 ("Clean up string interpolation into QMP,
part 2") accidentally reverted it back to qmp().

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/migration-test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index b87ba99a9e..a9f81cc185 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -490,7 +490,7 @@ static void migrate(QTestState *who, const char *uri, const char *fmt, ...)
     g_assert(!qdict_haskey(args, "uri"));
     qdict_put_str(args, "uri", uri);
 
-    rsp = qmp("{ 'execute': 'migrate', 'arguments': %p}", args);
+    rsp = qtest_qmp(who, "{ 'execute': 'migrate', 'arguments': %p}", args);
 
     g_assert(qdict_haskey(rsp, "return"));
     qobject_unref(rsp);
@@ -625,7 +625,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         cmd_dst = tmp;
     }
 
-    *from = qtest_start(cmd_src);
+    *from = qtest_init(cmd_src);
     g_free(cmd_src);
 
     *to = qtest_init(cmd_dst);
@@ -715,7 +715,7 @@ static void test_deprecated(void)
 {
     QTestState *from;
 
-    from = qtest_start("-machine none");
+    from = qtest_init("-machine none");
 
     deprecated_set_downtime(from, 0.12345);
     deprecated_set_speed(from, 12345);
-- 
2.18.1


