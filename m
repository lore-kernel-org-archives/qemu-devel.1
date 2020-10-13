Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A3BC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:01:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B662C208D5
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KksgfoP1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B662C208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSI3J-00035y-Nv
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 07:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kSHyI-0005V6-Dy
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:55:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23586)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kSHyG-0006DX-3w
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602586555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MzVYUDP+ngwGtyz875Og2xvnQvdvvEQUx2JoCdy/J1M=;
 b=KksgfoP1jCTdcyq1UZwgyLV/vwgyucj56K76wUEenE5UAUVUMJ7Gbb9R5EBYiRagw66r6t
 C1E84Pd3pt2MYRS3XvFfVKmLSOMNFCceyqcfzPNND+Tf0fbQF5JJWKo5vLD62MYVOPmO/w
 MC3/RJ9sW/2qtAli1RxLvWmITptaAPE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-dFPbg8HXOV2a6p8C8yUJWg-1; Tue, 13 Oct 2020 06:55:53 -0400
X-MC-Unique: dFPbg8HXOV2a6p8C8yUJWg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 324C210066FC;
 Tue, 13 Oct 2020 10:55:52 +0000 (UTC)
Received: from thuth.com (ovpn-112-151.ams2.redhat.com [10.36.112.151])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2FEC36EF41;
 Tue, 13 Oct 2020 10:55:50 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 07/23] tests/migration: Allow longer timeouts
Date: Tue, 13 Oct 2020 12:55:11 +0200
Message-Id: <20201013105527.20088-8-thuth@redhat.com>
In-Reply-To: <20201013105527.20088-1-thuth@redhat.com>
References: <20201013105527.20088-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

In travis, with gcov and gprof we're seeing timeouts; hopefully fix
this by increasing the test timeouts a bit, but for xbzrle ensure it
really does get a couple of cycles through to test the cache.

I think the problem in travis is we have about 2 host CPU threads,
in the test we have at least 3:
   a) The vCPU thread (100% flat out)
   b) The source migration thread
   c) The destination migration thread

if (b) & (c) are slow for any reason - gcov+gperf or a slow host -
then they're sharing one host CPU thread so limit the migration
bandwidth.

Tested on my laptop with:
   taskset -c 0,1 ./tests/qtest/migration-test -p /x86_64/migration

Reported-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20201008160330.130431-1-dgilbert@redhat.com>
[thuth: Move the #define to the right location]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/migration-test.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 00a233cd8c..f410ec5996 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -34,6 +34,9 @@ unsigned start_address;
 unsigned end_address;
 static bool uffd_feature_thread_id;
 
+/* A downtime where the test really should converge */
+#define CONVERGE_DOWNTIME 1000
+
 #if defined(__linux__)
 #include <sys/syscall.h>
 #include <sys/vfs.h>
@@ -864,8 +867,7 @@ static void test_precopy_unix(void)
 
     wait_for_migration_pass(from);
 
-    /* 300 ms should converge */
-    migrate_set_parameter_int(from, "downtime-limit", 300);
+    migrate_set_parameter_int(from, "downtime-limit", CONVERGE_DOWNTIME);
 
     if (!got_stop) {
         qtest_qmp_eventwait(from, "STOP");
@@ -946,10 +948,12 @@ static void test_xbzrle(const char *uri)
 
     migrate_qmp(from, uri, "{}");
 
+    wait_for_migration_pass(from);
+    /* Make sure we have 2 passes, so the xbzrle cache gets a workout */
     wait_for_migration_pass(from);
 
-    /* 300ms should converge */
-    migrate_set_parameter_int(from, "downtime-limit", 300);
+    /* 1000ms should converge */
+    migrate_set_parameter_int(from, "downtime-limit", 1000);
 
     if (!got_stop) {
         qtest_qmp_eventwait(from, "STOP");
@@ -999,8 +1003,7 @@ static void test_precopy_tcp(void)
 
     wait_for_migration_pass(from);
 
-    /* 300ms should converge */
-    migrate_set_parameter_int(from, "downtime-limit", 300);
+    migrate_set_parameter_int(from, "downtime-limit", CONVERGE_DOWNTIME);
 
     if (!got_stop) {
         qtest_qmp_eventwait(from, "STOP");
@@ -1068,8 +1071,7 @@ static void test_migrate_fd_proto(void)
 
     wait_for_migration_pass(from);
 
-    /* 300ms should converge */
-    migrate_set_parameter_int(from, "downtime-limit", 300);
+    migrate_set_parameter_int(from, "downtime-limit", CONVERGE_DOWNTIME);
 
     if (!got_stop) {
         qtest_qmp_eventwait(from, "STOP");
@@ -1304,8 +1306,7 @@ static void test_multifd_tcp(const char *method)
 
     wait_for_migration_pass(from);
 
-    /* 300ms it should converge */
-    migrate_set_parameter_int(from, "downtime-limit", 300);
+    migrate_set_parameter_int(from, "downtime-limit", CONVERGE_DOWNTIME);
 
     if (!got_stop) {
         qtest_qmp_eventwait(from, "STOP");
-- 
2.18.2


