Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AF8C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 11:02:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5328207BC
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 11:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="azUtOqwo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5328207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnKDZ-0002VW-5w
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 07:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jnJvX-0008E9-VE
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 06:43:47 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52770
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jnJvW-0005T6-BK
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 06:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592822625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=x0nKjkzEX7gjmZNlUti2WZLsamxndQTSZCGxYgQa2ps=;
 b=azUtOqwomdMwSG51UHfTx8mqSvjCNAaWdIRaXSREfnVRUmmDQqCiiGaXcCEmQ/S5glxdZe
 x2PswaFTqM2JS+6FLojrQ7NsYnon//lAg3ZV/xV4gqowL3yccn/x6iYqNK9xEnuqUraLns
 1iF9yq122nUbt6iM4fAA57X5AAPJuUQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-mG5sXHQ0P0KfIMDFNAorhw-1; Mon, 22 Jun 2020 06:43:44 -0400
X-MC-Unique: mG5sXHQ0P0KfIMDFNAorhw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3173D184D140
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 10:43:43 +0000 (UTC)
Received: from thuth.com (ovpn-112-125.ams2.redhat.com [10.36.112.125])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E895B5BAD6;
 Mon, 22 Jun 2020 10:43:41 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests/qtest: Unify the test for the xenfv and xenpv machines
Date: Mon, 22 Jun 2020 12:43:39 +0200
Message-Id: <20200622104339.21000-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 03:17:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have the same check in three places. Let's unify it in a central
place instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/device-introspect-test.c | 5 -----
 tests/qtest/libqtest.c               | 4 ++++
 tests/qtest/qom-test.c               | 5 -----
 tests/qtest/test-hmp.c               | 5 -----
 4 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/tests/qtest/device-introspect-test.c b/tests/qtest/device-introspect-test.c
index f2c1576cae..9abb5ec889 100644
--- a/tests/qtest/device-introspect-test.c
+++ b/tests/qtest/device-introspect-test.c
@@ -287,11 +287,6 @@ static void add_machine_test_case(const char *mname)
 {
     char *path, *args;
 
-    /* Ignore blacklisted machines */
-    if (!memcmp("xenfv", mname, 5) || g_str_equal("xenpv", mname)) {
-        return;
-    }
-
     path = g_strdup_printf("device/introspect/concrete/defaults/%s", mname);
     args = g_strdup_printf("-M %s", mname);
     qtest_add_data_func(path, args, test_device_intro_concrete);
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 49075b55a1..fd4680590d 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -1232,6 +1232,10 @@ void qtest_cb_for_every_machine(void (*cb)(const char *machine),
         qstr = qobject_to(QString, qobj);
         g_assert(qstr);
         mname = qstring_get_str(qstr);
+        /* Ignore machines that cannot be used for qtests */
+        if (!memcmp("xenfv", mname, 5) || g_str_equal("xenpv", mname)) {
+            continue;
+        }
         if (!skip_old_versioned || !qtest_is_old_versioned_machine(mname)) {
             cb(mname);
         }
diff --git a/tests/qtest/qom-test.c b/tests/qtest/qom-test.c
index e338a41194..1acf0d7369 100644
--- a/tests/qtest/qom-test.c
+++ b/tests/qtest/qom-test.c
@@ -81,11 +81,6 @@ static void add_machine_test_case(const char *mname)
 {
     char *path;
 
-    /* Ignore blacklisted machines that have known problems */
-    if (!memcmp("xenfv", mname, 5) || g_str_equal("xenpv", mname)) {
-        return;
-    }
-
     path = g_strdup_printf("qom/%s", mname);
     qtest_add_data_func(path, g_strdup(mname), test_machine);
     g_free(path);
diff --git a/tests/qtest/test-hmp.c b/tests/qtest/test-hmp.c
index b8b1271b9e..d5e7ebd176 100644
--- a/tests/qtest/test-hmp.c
+++ b/tests/qtest/test-hmp.c
@@ -143,11 +143,6 @@ static void add_machine_test_case(const char *mname)
 {
     char *path;
 
-    /* Ignore blacklisted machines that have known problems */
-    if (!memcmp("xenfv", mname, 5) || g_str_equal("xenpv", mname)) {
-        return;
-    }
-
     path = g_strdup_printf("hmp/%s", mname);
     qtest_add_data_func(path, g_strdup(mname), test_machine);
     g_free(path);
-- 
2.18.1


