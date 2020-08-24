Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FE0C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 08:43:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E60962087D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 08:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="ZM5/PiAs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E60962087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA84d-0006iL-7t
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 04:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1kA825-00024h-47; Mon, 24 Aug 2020 04:40:49 -0400
Received: from forwardcorp1o.mail.yandex.net ([2a02:6b8:0:1a2d::193]:60064)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1kA822-0004yU-Tv; Mon, 24 Aug 2020 04:40:48 -0400
Received: from myt5-23f0be3aa648.qloud-c.yandex.net
 (myt5-23f0be3aa648.qloud-c.yandex.net
 [IPv6:2a02:6b8:c12:3e29:0:640:23f0:be3a])
 by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 041EE2E15D5;
 Mon, 24 Aug 2020 11:40:45 +0300 (MSK)
Received: from myt4-18a966dbd9be.qloud-c.yandex.net
 (myt4-18a966dbd9be.qloud-c.yandex.net [2a02:6b8:c00:12ad:0:640:18a9:66db])
 by myt5-23f0be3aa648.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id
 C6NFGpzPhY-egvKwCiq; Mon, 24 Aug 2020 11:40:44 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1598258444; bh=q0+U/QfA4vXjDbbbTSlxDOvBDrzv7zTyuZdj9kiei3s=;
 h=In-Reply-To:In-Reply-To:Message-Id:References:References:Date:
 Subject:To:From:Cc;
 b=ZM5/PiAsRzOcn62ngg0MKB7uIeI/pG7FBSg2r2hBQq/KF/5FN0ZyF78G6/pYGqXF+
 jugxSiKeTdSAgZ+IQdjWiwKZ1VTyKZc1nzJxcQyR9BWJGLe/xCaOO3Vaz9IS9Jo0Yz
 1tsKRtqzUsbjYbrAZke+BhAOlVa31UbxXmu2PcWo=
Authentication-Results: myt5-23f0be3aa648.qloud-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b080:6622::1:7])
 by myt4-18a966dbd9be.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 B7dErHoRhW-egl46IZD; Mon, 24 Aug 2020 11:40:42 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (Client certificate not present)
From: Dima Stepanov <dimastep@yandex-team.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 6/7] tests/qtest/vhost-user-test: add migrate_reconnect test
Date: Mon, 24 Aug 2020 11:39:31 +0300
Message-Id: <7f5dfc30dcad34a7e2e7525e833e76ac6bfeef81.1598257839.git.dimastep@yandex-team.ru>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1598257838.git.dimastep@yandex-team.ru>
References: <cover.1598257838.git.dimastep@yandex-team.ru>
In-Reply-To: <cover.1598257838.git.dimastep@yandex-team.ru>
References: <cover.1598257838.git.dimastep@yandex-team.ru>
Received-SPF: pass client-ip=2a02:6b8:0:1a2d::193;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1o.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
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
index 9b6e202..6b4c147 100644
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
@@ -1151,5 +1172,9 @@ static void register_vhost_user_test(void)
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


