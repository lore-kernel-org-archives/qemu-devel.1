Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C62BC433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 09:36:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B07B20791
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 09:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="VBd68Vsj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B07B20791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE892-0007Gy-AG
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 05:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1kE84f-0008A6-BU; Fri, 04 Sep 2020 05:32:01 -0400
Received: from forwardcorp1p.mail.yandex.net
 ([2a02:6b8:0:1472:2741:0:8b6:217]:34352)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1kE84X-0005mK-Ei; Fri, 04 Sep 2020 05:32:00 -0400
Received: from vla1-fdfb804fb3f3.qloud-c.yandex.net
 (vla1-fdfb804fb3f3.qloud-c.yandex.net
 [IPv6:2a02:6b8:c0d:3199:0:640:fdfb:804f])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 8C2AA2E1792;
 Fri,  4 Sep 2020 12:31:51 +0300 (MSK)
Received: from vla1-81430ab5870b.qloud-c.yandex.net
 (vla1-81430ab5870b.qloud-c.yandex.net [2a02:6b8:c0d:35a1:0:640:8143:ab5])
 by vla1-fdfb804fb3f3.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id
 RmOyWvEL00-Vpw0Ni3e; Fri, 04 Sep 2020 12:31:51 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1599211911; bh=+qjcP8GjY4KQVRU34GsQvdwzzL2IhmdJebgwakks6KM=;
 h=In-Reply-To:In-Reply-To:Message-Id:References:References:Date:
 Subject:To:From:Cc;
 b=VBd68Vsjo+RENZydp1orNDnp9V7DfG0+zOT3bi0LHkt6UZxF/fss2AmjFlT2VQXb9
 7VhUZ00v5qLb7tIep0T2+t1aG+aD2s4ObknPAFEAxkflunJajMENl6VOVdgYjpMrCX
 r250uSS3eeL/t4G/niYUV9Kn6GacWyDysyD5N30c=
Authentication-Results: vla1-fdfb804fb3f3.qloud-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b080:8005::1:b])
 by vla1-81430ab5870b.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 roLfhSDnvO-VolGUsMo; Fri, 04 Sep 2020 12:31:51 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (Client certificate not present)
From: Dima Stepanov <dimastep@yandex-team.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 6/7] tests/qtest/vhost-user-test: add migrate_reconnect test
Date: Fri,  4 Sep 2020 12:31:18 +0300
Message-Id: <e7c62e6286f6199b1c3caf60cbe225f10ed04846.1599211479.git.dimastep@yandex-team.ru>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1599211479.git.dimastep@yandex-team.ru>
References: <cover.1599211479.git.dimastep@yandex-team.ru>
In-Reply-To: <cover.1599211479.git.dimastep@yandex-team.ru>
References: <cover.1599211479.git.dimastep@yandex-team.ru>
Received-SPF: pass client-ip=2a02:6b8:0:1472:2741:0:8b6:217;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1p.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 05:31:42
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, lvivier@redhat.com, thuth@redhat.com,
 qemu-block@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 dgilbert@redhat.com, mreitz@redhat.com, fengli@smartx.com,
 yc-core@yandex-team.ru, pbonzini@redhat.com, raphael.norwitz@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add new migrate_reconnect test for the vhost-user-blk device. Perform a
disconnect after sending response for the VHOST_USER_SET_LOG_BASE
command.

Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
---
 tests/qtest/vhost-user-test.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
index a8af613..4b715d3 100644
--- a/tests/qtest/vhost-user-test.c
+++ b/tests/qtest/vhost-user-test.c
@@ -146,6 +146,7 @@ static VhostUserMsg m __attribute__ ((unused));
 enum {
     TEST_FLAGS_OK,
     TEST_FLAGS_DISCONNECT,
+    TEST_FLAGS_MIGRATE_DISCONNECT,
     TEST_FLAGS_BAD,
     TEST_FLAGS_END,
 };
@@ -436,6 +437,15 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
         qemu_chr_fe_write_all(chr, p, VHOST_USER_HDR_SIZE);
 
         g_cond_broadcast(&s->data_cond);
+        /*
+         * Perform disconnect after sending a response. In this
+         * case the next write command on the QEMU side (for now
+         * it is SET_FEATURES will return -1, because of disconnect.
+         */
+        if (s->test_flags == TEST_FLAGS_MIGRATE_DISCONNECT) {
+            qemu_chr_fe_disconnect(chr);
+            s->test_flags = TEST_FLAGS_BAD;
+        }
         break;
 
     case VHOST_USER_SET_VRING_BASE:
@@ -737,6 +747,17 @@ static void *vhost_user_test_setup_memfd(GString *cmd_line, void *arg)
     return server;
 }
 
+static void *vhost_user_test_setup_migrate_reconnect(GString *cmd_line,
+        void *arg)
+{
+    TestServer *server;
+
+    server = vhost_user_test_setup_memfd(cmd_line, arg);
+    server->test_flags = TEST_FLAGS_MIGRATE_DISCONNECT;
+
+    return server;
+}
+
 static void test_read_guest_mem(void *obj, void *arg, QGuestAllocator *alloc)
 {
     TestServer *server = arg;
@@ -1150,5 +1171,9 @@ static void register_vhost_user_test(void)
     opts.before = vhost_user_test_setup_memfd;
     qos_add_test("migrate", "vhost-user-blk",
                  test_migrate, &opts);
+
+    opts.before = vhost_user_test_setup_migrate_reconnect;
+    qos_add_test("migrate_reconnect", "vhost-user-blk",
+                 test_migrate, &opts);
 }
 libqos_init(register_vhost_user_test);
-- 
2.7.4


