Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F12C55178
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:08:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00AFC223EA
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EpIR0FiC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00AFC223EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWzQN-00045l-IQ
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 06:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWzOn-0002P8-DT
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:06:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20865)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWzOl-0006ZR-2u
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:06:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603706800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=U/8TwMow7JFz41G6l7+MQj+1KDG2MIh2y51jl6IvirY=;
 b=EpIR0FiCSEaBA+mAv9OJRIidiFHLkKasEA3TWpqV3yiz+Prsz9UfMlENqI5Yf2lV2ogqjl
 Iavvd5ssF1kMX3MqE5K2HFrfb2nlcBHz2c5h2LutDjmqnIMbR+thKJucHFcK9lVS01I4/A
 eDtNJ4Yk5QiWHoe+u5lNcTFBqtLu1rM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-TA7i9RzbMiWUjGe8AM3IIw-1; Mon, 26 Oct 2020 06:06:38 -0400
X-MC-Unique: TA7i9RzbMiWUjGe8AM3IIw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6FB031882FA7;
 Mon, 26 Oct 2020 10:06:37 +0000 (UTC)
Received: from thuth.com (ovpn-112-104.ams2.redhat.com [10.36.112.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5E28E8B849;
 Mon, 26 Oct 2020 10:06:36 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 01/31] tests/migration: fix memleak in
 wait_command/wait_command_fd
Date: Mon, 26 Oct 2020 11:06:02 +0100
Message-Id: <20201026100632.212530-2-thuth@redhat.com>
In-Reply-To: <20201026100632.212530-1-thuth@redhat.com>
References: <20201026100632.212530-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chen Qun <kuhn.chenqun@huawei.com>

Properly free each command resp to avoid memory leak.
ASAN shows memory leak stack:

Indirect leak of 2352520 byte(s) in 571 object(s) allocated from:
    #0 0x7f6ca3308d4e in __interceptor_calloc (/lib64/libasan.so.5+0x112d4e)
    #1 0x7f6ca3127a50 in g_malloc0 (/lib64/libglib-2.0.so.0+0x55a50)
    #2 0x557bf3c71d2b in qdict_new ../qobject/qdict.c:29
    #3 0x557bf3c9caba in parse_object ../qobject/json-parser.c:318
    #4 0x557bf3c9ce75 in json_parser_parse ../qobject/json-parser.c:580
    #5 0x557bf3c8c8cf in json_message_process_token ../qobject/json-streamer.c:92
    #6 0x557bf3c9ea59 in json_lexer_feed_char ../qobject/json-lexer.c:313
    #7 0x557bf3c9eeb5 in json_lexer_feed ../qobject/json-lexer.c:350
    #8 0x557bf3c4793a in qmp_fd_receive ../tests/qtest/libqtest.c:608
    #9 0x557bf3c47b58 in qtest_qmp_receive ../tests/qtest/libqtest.c:618
    #10 0x557bf3c44245 in wait_command ../tests/qtest/migration-helpers.c:59
    #11 0x557bf3c445cb in migrate_query_status ../tests/qtest/migration-helpers.c:108
    #12 0x557bf3c44642 in check_migration_status ../tests/qtest/migration-helpers.c:124
    #13 0x557bf3c447e7 in wait_for_migration_status ../tests/qtest/migration-helpers.c:148
    #14 0x557bf3c43b8f in test_migrate_auto_converge ../tests/qtest/migration-test.c:1243
    ......

Fix: 5e34005571af5

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
Message-Id: <20201023061218.2080844-2-kuhn.chenqun@huawei.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/migration-helpers.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index b799dbafb7..4ee26014b7 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -32,7 +32,7 @@ static void check_stop_event(QTestState *who)
 QDict *wait_command_fd(QTestState *who, int fd, const char *command, ...)
 {
     va_list ap;
-    QDict *resp;
+    QDict *resp, *ret;
 
     va_start(ap, command);
     qtest_qmp_vsend_fds(who, &fd, 1, command, ap);
@@ -44,7 +44,11 @@ QDict *wait_command_fd(QTestState *who, int fd, const char *command, ...)
     g_assert(!qdict_haskey(resp, "error"));
     g_assert(qdict_haskey(resp, "return"));
 
-    return qdict_get_qdict(resp, "return");
+    ret = qdict_get_qdict(resp, "return");
+    qobject_ref(ret);
+    qobject_unref(resp);
+
+    return ret;
 }
 
 /*
@@ -53,7 +57,7 @@ QDict *wait_command_fd(QTestState *who, int fd, const char *command, ...)
 QDict *wait_command(QTestState *who, const char *command, ...)
 {
     va_list ap;
-    QDict *resp;
+    QDict *resp, *ret;
 
     va_start(ap, command);
     resp = qtest_vqmp(who, command, ap);
@@ -64,7 +68,11 @@ QDict *wait_command(QTestState *who, const char *command, ...)
     g_assert(!qdict_haskey(resp, "error"));
     g_assert(qdict_haskey(resp, "return"));
 
-    return qdict_get_qdict(resp, "return");
+    ret = qdict_get_qdict(resp, "return");
+    qobject_ref(ret);
+    qobject_unref(resp);
+
+    return ret;
 }
 
 /*
-- 
2.18.2


