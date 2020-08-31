Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B927EC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 09:31:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80B2C206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 09:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="A+RUBWRm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80B2C206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCgA3-0006er-NS
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 05:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1kCg6i-0001p5-3g; Mon, 31 Aug 2020 05:28:08 -0400
Received: from forwardcorp1o.mail.yandex.net ([2a02:6b8:0:1a2d::193]:40616)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1kCg6g-00050w-4C; Mon, 31 Aug 2020 05:28:07 -0400
Received: from sas1-ec30c78b6c5b.qloud-c.yandex.net
 (sas1-ec30c78b6c5b.qloud-c.yandex.net
 [IPv6:2a02:6b8:c14:2704:0:640:ec30:c78b])
 by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 4631A2E1752;
 Mon, 31 Aug 2020 12:28:04 +0300 (MSK)
Received: from sas1-58a37b48fb94.qloud-c.yandex.net
 (sas1-58a37b48fb94.qloud-c.yandex.net [2a02:6b8:c08:1d1b:0:640:58a3:7b48])
 by sas1-ec30c78b6c5b.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id
 t8pPA2lpZk-S3vGTJ9j; Mon, 31 Aug 2020 12:28:04 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1598866084; bh=q/BEie8WWdulCQ+K3Z9sfH9Ao00pTgDfrRPfxe/FziU=;
 h=In-Reply-To:In-Reply-To:Message-Id:References:References:Date:
 Subject:To:From:Cc;
 b=A+RUBWRmPpoOPbcH489bv4wTKKdCdf5YLSxuNPIHEfaHFUAQ9MtqyuN+y5T0zY2vv
 8AEL940BrcwYxypx6Sepu8X4f9dzpz9wakvljv9ilWRM7K+nFVHxOxhXDKRnxxja/I
 2K/ub1tgVvMVPk1y+WyRWVEkIH66AO1VbDA+lg+4=
Authentication-Results: sas1-ec30c78b6c5b.qloud-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b081:216::1:a])
 by sas1-58a37b48fb94.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 yaozkQMlmT-S3m8NKJw; Mon, 31 Aug 2020 12:28:03 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (Client certificate not present)
From: Dima Stepanov <dimastep@yandex-team.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 7/7] tests/qtest/vhost-user-test: enable the reconnect tests
Date: Mon, 31 Aug 2020 12:27:23 +0300
Message-Id: <ecd8b3820dd95175bd2a4a34484713eeba1aa930.1598865610.git.dimastep@yandex-team.ru>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1598865610.git.dimastep@yandex-team.ru>
References: <cover.1598865610.git.dimastep@yandex-team.ru>
In-Reply-To: <cover.1598865610.git.dimastep@yandex-team.ru>
References: <cover.1598865610.git.dimastep@yandex-team.ru>
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
index 4b715d3..4b96312 100644
--- a/tests/qtest/vhost-user-test.c
+++ b/tests/qtest/vhost-user-test.c
@@ -1140,20 +1140,17 @@ static void register_vhost_user_test(void)
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


