Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CACC43464
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 11:46:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5800620EDD
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 11:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VTR5ePTu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5800620EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKKHa-0004Hl-F2
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 07:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kKK1S-0003BX-Su
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 07:30:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39064)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kKK1Q-0000mj-Ur
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 07:30:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600687816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KU3CQZix1HzPA27WzsYYTB+dAz58fIp+8wyLXMfCqA0=;
 b=VTR5ePTuNEMlO7Ni//5btI5nCnEgvfAi2oVmSdbkyLceTKlTZwyIOL5eWcSnSknQIG7ONU
 oYslXhupEXZK6Zgt0LTqGe+LmfsvyWHPalPYoZ+wVgwC8FFhtumZb0Tq1pAp9OA18XD5uc
 sIHxm120FA0u3YEcwLatndjcKfPHAD4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-9N1ZMDAVMHGJQNdSIuahpA-1; Mon, 21 Sep 2020 07:30:13 -0400
X-MC-Unique: 9N1ZMDAVMHGJQNdSIuahpA-1
Received: by mail-wr1-f70.google.com with SMTP id n15so5714452wrv.23
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 04:30:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KU3CQZix1HzPA27WzsYYTB+dAz58fIp+8wyLXMfCqA0=;
 b=sfH9YK+UGkQqfaYBFGPCYvf1kbF/Mbmu1Zv0z8yfbAWSXJiNRh5Q2BAqL6t/sNZzaL
 CxxJY2JWOPWslFfChk3YGmC+W7iT+QZBRspoIQwnwwYi1qfbebgr/1khVAQ/bGqUXWaG
 ZkzRkrvU0SPEHhjx3Pef8Ih+tTegr3zG4gZPTGm81azeuci4d7lRhulsKwHcx+xEkfb8
 f3fNrH8F0VQVn5s9SXtcOux0sjExMiYBXxTJsarzg9seioPoSPTTCjAslq0A5S0sDs8v
 tHdYMGe2YzYEaPGdfiFegT9I4UzBCaU0iGsDygttP1/RF4GWOFOBI0WAeCZ/+a7s6uat
 r5CA==
X-Gm-Message-State: AOAM5322yNV8Qw+pzxnoisrZawxRZK3TQO2eRxe3EqF88mT6AC0lcREa
 k6jp98oDzYp/CNChkvp9WbLWw/MnRoEBNXv+goJ0JfZQbiezJWqB1Tfv4WyLkvwMxgrn54GPlRa
 rtWVX4MaLnT8NlhM=
X-Received: by 2002:adf:8544:: with SMTP id 62mr51629620wrh.262.1600687811902; 
 Mon, 21 Sep 2020 04:30:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzojiz9irGa+Z5d09e363yKQDPo18DTjLQtL2ERELXhj+qIAOq2A+fJBzNIYQkqEfIvjTARXw==
X-Received: by 2002:adf:8544:: with SMTP id 62mr51629602wrh.262.1600687811713; 
 Mon, 21 Sep 2020 04:30:11 -0700 (PDT)
Received: from redhat.com (bzq-109-65-116-225.red.bezeqint.net.
 [109.65.116.225])
 by smtp.gmail.com with ESMTPSA id u12sm21010496wrt.81.2020.09.21.04.30.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 04:30:11 -0700 (PDT)
Date: Mon, 21 Sep 2020 07:30:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 12/15] tests/qtest/vhost-user-test: enable the reconnect
 tests
Message-ID: <20200921112913.555392-13-mst@redhat.com>
References: <20200921112913.555392-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200921112913.555392-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:43:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Dima Stepanov <dimastep@yandex-team.ru>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Dima Stepanov <dimastep@yandex-team.ru>

For now a QTEST_VHOST_USER_FIXME environment variable is used to
separate reconnect tests for the vhost-user-net device. Looks like the
reconnect functionality is pretty stable, so this separation is
deprecated.
Remove it and enable these tests for the default run.

Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
Message-Id: <9fee5b17c7940f9126ba7cc014b09106c98118db.1599813294.git.dimastep@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/vhost-user-test.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
index 6e64df7a45..1fc5dd6584 100644
--- a/tests/qtest/vhost-user-test.c
+++ b/tests/qtest/vhost-user-test.c
@@ -1139,20 +1139,17 @@ static void register_vhost_user_test(void)
                  "virtio-net",
                  test_migrate, &opts);
 
-    /* keeps failing on build-system since Aug 15 2017 */
-    if (getenv("QTEST_VHOST_USER_FIXME")) {
-        opts.before = vhost_user_test_setup_reconnect;
-        qos_add_test("vhost-user/reconnect", "virtio-net",
-                     test_reconnect, &opts);
+    opts.before = vhost_user_test_setup_reconnect;
+    qos_add_test("vhost-user/reconnect", "virtio-net",
+                 test_reconnect, &opts);
 
-        opts.before = vhost_user_test_setup_connect_fail;
-        qos_add_test("vhost-user/connect-fail", "virtio-net",
-                     test_vhost_user_started, &opts);
+    opts.before = vhost_user_test_setup_connect_fail;
+    qos_add_test("vhost-user/connect-fail", "virtio-net",
+                 test_vhost_user_started, &opts);
 
-        opts.before = vhost_user_test_setup_flags_mismatch;
-        qos_add_test("vhost-user/flags-mismatch", "virtio-net",
-                     test_vhost_user_started, &opts);
-    }
+    opts.before = vhost_user_test_setup_flags_mismatch;
+    qos_add_test("vhost-user/flags-mismatch", "virtio-net",
+                 test_vhost_user_started, &opts);
 
     opts.before = vhost_user_test_setup_multiqueue;
     opts.edge.extra_device_opts = "mq=on";
-- 
MST


