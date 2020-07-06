Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E954C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 07:33:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47D79206CD
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 07:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dLFjaNQq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47D79206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsLcp-0000MD-Je
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 03:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jsLYa-0003Pp-7T
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 03:28:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42364
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jsLYW-0004Je-HG
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 03:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594020527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cOkxXc0ueiZaRz5g1RX9AYMF0NElufVcQ7OAgBddovc=;
 b=dLFjaNQqXbFCEls8Ds234g97NOV8hbzE+8i9SBbnn35bV4nCeZqxszbzViVIxDLyCREqTm
 7xAYoFeA6dU6eRtW/rLEzNMvR3kLct+S4CIFxvdOjOhxAEGuvhceveKLFhUKfkKDICWlhW
 Q2NEVJyWvJcBKNtGUwfll++cVpkbUr0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-a0KkDMrvMJyprIJimDnk8A-1; Mon, 06 Jul 2020 03:28:43 -0400
X-MC-Unique: a0KkDMrvMJyprIJimDnk8A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC1A980183C;
 Mon,  6 Jul 2020 07:28:42 +0000 (UTC)
Received: from thuth.com (ovpn-112-144.ams2.redhat.com [10.36.112.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1FB4A5D9CC;
 Mon,  6 Jul 2020 07:28:41 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 3/6] tests/qtest: Unify the test for the xenfv and xenpv
 machines
Date: Mon,  6 Jul 2020 09:28:32 +0200
Message-Id: <20200706072835.23582-4-thuth@redhat.com>
In-Reply-To: <20200706072835.23582-1-thuth@redhat.com>
References: <20200706072835.23582-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:52:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have the same check in three places. Let's unify it in a central
place instead.

Message-Id: <20200622104339.21000-1-thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
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


