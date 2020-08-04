Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9E6C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 10:40:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FB0B2070A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 10:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="WmYYb+XS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB0B2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2uMh-0003jg-Lh
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 06:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1k2uKn-0001rw-Po; Tue, 04 Aug 2020 06:38:17 -0400
Received: from forwardcorp1o.mail.yandex.net ([2a02:6b8:0:1a2d::193]:41102)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1k2uKl-0002P8-Pm; Tue, 04 Aug 2020 06:38:17 -0400
Received: from iva8-d077482f1536.qloud-c.yandex.net
 (iva8-d077482f1536.qloud-c.yandex.net
 [IPv6:2a02:6b8:c0c:2f26:0:640:d077:482f])
 by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id BAF2F2E1906;
 Tue,  4 Aug 2020 13:38:13 +0300 (MSK)
Received: from iva8-88b7aa9dc799.qloud-c.yandex.net
 (iva8-88b7aa9dc799.qloud-c.yandex.net [2a02:6b8:c0c:77a0:0:640:88b7:aa9d])
 by iva8-d077482f1536.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id
 3bysB47OtS-cAt8lAti; Tue, 04 Aug 2020 13:38:13 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1596537493; bh=qZtCbGhJqHabu/WbWL7vzAIYFZMpA47m/YOq18cRKO0=;
 h=In-Reply-To:In-Reply-To:Message-Id:References:References:Date:
 Subject:To:From:Cc;
 b=WmYYb+XSWgtKiFZN8qTFnk4rsYHmtWp4191KFYhYJtgJEGuGqIeiSRNjmVzYpPIRV
 nRaTqtleA7PJx1HYRWNGU/nP/2pUPtgdO7EQ1TU2JJ4q2iVS4ZXfkj7aqnSigelhVX
 lC74Yx+ePy+K5EjcbZbFJQWlxaxP7yz4I+tXkO/Y=
Authentication-Results: iva8-d077482f1536.qloud-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b081:2::1:a])
 by iva8-88b7aa9dc799.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 ZZLKBSFEhl-cAiWYiYN; Tue, 04 Aug 2020 13:38:10 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (Client certificate not present)
From: Dima Stepanov <dimastep@yandex-team.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 7/7] tests/qtest/vhost-user-test: enable the reconnect tests
Date: Tue,  4 Aug 2020 13:36:52 +0300
Message-Id: <dc89de88d1261ebeef0e9f560da17a7c634f6ffd.1596536559.git.dimastep@yandex-team.ru>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1596536559.git.dimastep@yandex-team.ru>
References: <cover.1596536559.git.dimastep@yandex-team.ru>
In-Reply-To: <cover.1596536559.git.dimastep@yandex-team.ru>
References: <cover.1596536559.git.dimastep@yandex-team.ru>
Received-SPF: pass client-ip=2a02:6b8:0:1a2d::193;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1o.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

For now a QTEST_VHOST_USER_FIXME environment variable is used to
separate reconnect tests for the vhost-user-net device. Looks like the
reconnect functionality is pretty stable, so this separation is
deprecated.
Remove it and enable these tests for the default run.

Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
---
 tests/qtest/vhost-user-test.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
index 6b4c147..5fbfa02 100644
--- a/tests/qtest/vhost-user-test.c
+++ b/tests/qtest/vhost-user-test.c
@@ -1141,20 +1141,17 @@ static void register_vhost_user_test(void)
                  "virtio-net",
                  test_migrate, &opts);
 
-    /* keeps failing on build-system since Aug 15 2017 */
-    if (getenv("QTEST_VHOST_USER_FIXME")) {
-        opts.before = vhost_user_test_setup_reconnect;
-        qos_add_test("vhost-user/reconnect", "virtio-net",
-                     test_reconnect, &opts);
-
-        opts.before = vhost_user_test_setup_connect_fail;
-        qos_add_test("vhost-user/connect-fail", "virtio-net",
-                     test_vhost_user_started, &opts);
-
-        opts.before = vhost_user_test_setup_flags_mismatch;
-        qos_add_test("vhost-user/flags-mismatch", "virtio-net",
-                     test_vhost_user_started, &opts);
-    }
+    opts.before = vhost_user_test_setup_reconnect;
+    qos_add_test("vhost-user/reconnect", "virtio-net",
+                 test_reconnect, &opts);
+
+    opts.before = vhost_user_test_setup_connect_fail;
+    qos_add_test("vhost-user/connect-fail", "virtio-net",
+                 test_vhost_user_started, &opts);
+
+    opts.before = vhost_user_test_setup_flags_mismatch;
+    qos_add_test("vhost-user/flags-mismatch", "virtio-net",
+                 test_vhost_user_started, &opts);
 
     opts.before = vhost_user_test_setup_multiqueue;
     opts.edge.extra_device_opts = "mq=on";
-- 
2.7.4


