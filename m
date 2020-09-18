Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EDFC43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 16:40:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8D9B2074B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 16:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZWI4eam0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8D9B2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJJQj-0005pp-LA
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 12:40:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kJJ84-0005Lj-BE
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 12:20:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45196)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kJJ7r-0005lY-J6
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 12:20:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600446034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yhYJpQzkvGCIJw31OhiepZGEIbut9i/93SgdsUTymmI=;
 b=ZWI4eam0w+U7GnfFapQwtdWynpUlKOuma6mYsIeID5qU16of/JbhLbHuLXwBUi1aPnyMlo
 gcSy9hYWpFHOEFvJxPwoBcfiHAByyEle25J2I/H1F1V60Kt3f+jOC6Vdb4Qzt0nLAZ35Gk
 YSXL1XnVLvjX7AMC5le2NXXaRJN/6/0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-9XVASeqeOcmugn6asB5n5A-1; Fri, 18 Sep 2020 12:20:32 -0400
X-MC-Unique: 9XVASeqeOcmugn6asB5n5A-1
Received: by mail-wr1-f71.google.com with SMTP id f18so2312437wrv.19
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 09:20:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yhYJpQzkvGCIJw31OhiepZGEIbut9i/93SgdsUTymmI=;
 b=ODIwM5HFkvKj6xGrf3h+ubFn6MIJTpkqRXMDIVx15hGzpMbefbq4rXKNpiIOphzM76
 6ZU9AEyVNy84ycFZ7lN7V/Gb5z3KAWC3QSyQvbVfp2zSHBXBW14KMd89Q1eeTVY+EzgJ
 YGgItPcv28S0D8tuuAVPD4UZO47ZlnYMWLvRmj23zZyBJ1TKYLbwcm+OIMAQbXmkI8DQ
 mMj2h0Qne0XUUVJegKJfaXXy4qgzXYpuL7nHcxzsIgbMTmhSpIuBMcPT+X7BtdkqSN6K
 WhecY2UxDvpEQKDcnZuVBaciudwcBUeBbfmqoP2SMgKRVCR6xYu1bQeH7X8WLWR1UTgd
 j83Q==
X-Gm-Message-State: AOAM532yanPpgaUKQZay6ADbAEyavvJ2iGuA1grOxHgFrPBl+Mq6e7Th
 YGchIvtWGhZCeKjpCAyfCT1f137CAN6DimAtnhBX+rRLurqTz06fy6SRx1XOMTMAb6nl9qd+1o2
 4ZqaDmEvw0DDcrCQ=
X-Received: by 2002:a7b:c76d:: with SMTP id x13mr2403534wmk.10.1600446030911; 
 Fri, 18 Sep 2020 09:20:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8K/a6NQ/rQ2eBRF9p9tNEmw+10DZnvLDnAMSu6HAxAYv6yW6sfQDoqAhwn6sKoMKzkLQlfA==
X-Received: by 2002:a7b:c76d:: with SMTP id x13mr2403512wmk.10.1600446030673; 
 Fri, 18 Sep 2020 09:20:30 -0700 (PDT)
Received: from redhat.com (bzq-109-65-116-225.red.bezeqint.net.
 [109.65.116.225])
 by smtp.gmail.com with ESMTPSA id g14sm6471301wrv.25.2020.09.18.09.20.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 09:20:29 -0700 (PDT)
Date: Fri, 18 Sep 2020 12:20:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 11/15] tests/qtest/vhost-user-test: add migrate_reconnect
 test
Message-ID: <20200918161836.318893-12-mst@redhat.com>
References: <20200918161836.318893-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200918161836.318893-1-mst@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 01:32:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Dima Stepanov <dimastep@yandex-team.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Dima Stepanov <dimastep@yandex-team.ru>

Add new migrate_reconnect test for the vhost-user-blk device. Perform a
disconnect after sending response for the VHOST_USER_SET_LOG_BASE
command.

Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Message-Id: <6f38139d24a1be703a6f1c7d983faccdf21d2a9a.1599813294.git.dimastep@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/vhost-user-test.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
index a8af6134e5..4b715d385e 100644
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
MST


