Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B956DC43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:19:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3409C2388B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bqphy2uV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3409C2388B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJIAN-0004Fu-64
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 11:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kJHyA-0006eM-DP
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 11:06:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51238)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kJHy2-0000Zh-3U
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 11:06:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600441587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ChTCKXA6i09l/SD0XdTTHfgAwPsIIKbguO/mCSNhkkQ=;
 b=Bqphy2uV0d1wGyYRQql+qd8RfSLkQdxQWqb4FCnbuF7V3v6Rlvy0Ym5ty8ljZgby8EUPvQ
 aEmdFbyt/ZEP8hGOn0muDdZKR3zTEjn0w1VpfdGYFJj0yU+WozdW6UdMBky8+zTSTIwRhX
 JujmTmJ1EhUowHqgMPrdrlhiSk/kY8w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-Ji2_zXRONJqOECkBJPZYEg-1; Fri, 18 Sep 2020 11:06:22 -0400
X-MC-Unique: Ji2_zXRONJqOECkBJPZYEg-1
Received: by mail-wr1-f71.google.com with SMTP id i10so2238616wrq.5
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 08:06:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ChTCKXA6i09l/SD0XdTTHfgAwPsIIKbguO/mCSNhkkQ=;
 b=RzQI+JO2MAEA+Fi/j/t7YKsnmqOlvmAzFssOvazB4PKDTbpx2O9fxLd/cDeclPtqMT
 sXb/Kf5EWmv0QypKk8sg1f9Ky6Rtu4mwcWUb3GQ4ulDeDPSEHVupRmoz3SLYlbTd4Rii
 VtEx+DethVAXsxs/nnu3lsnIPghKAUUBEtAPrZo8hirRXeBLyi36HL0tXi6VQP8NH4OW
 kyENYHJ18arfLcmm63enh6SDDWe0Pw1u8rMYf0SMlv6GqcSgRpXKnHJTmASVdxyC+E0G
 kL9j2uE+IOp2P8IAKyI6jJtsOXdx+P0Ft4YQzm2IV3BK2++6Mjd1YC/2CLtzvvWbAXw8
 lEqA==
X-Gm-Message-State: AOAM532x6OdXSsvE1bgidrtG7ITT1H4eSql32vI7xxXJU8LFRXABTzY+
 o1Y3buFAUjkmm6VvYB3yh2yGCg6M429dPsIqtmRZEKub7LV29rUijKD33q3xeft7nsZwGy1K3lW
 vojtxKtYNd7mbfKg=
X-Received: by 2002:adf:aadb:: with SMTP id i27mr29617580wrc.258.1600441581164; 
 Fri, 18 Sep 2020 08:06:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLJAjEdMkeJzmqzsDojLLXhUuzTxXeP6ZZKRiuFd+/Lx4hvbShUdgyTehB+WYp/jnN4ayvrw==
X-Received: by 2002:adf:aadb:: with SMTP id i27mr29617553wrc.258.1600441580973; 
 Fri, 18 Sep 2020 08:06:20 -0700 (PDT)
Received: from redhat.com (bzq-109-65-116-225.red.bezeqint.net.
 [109.65.116.225])
 by smtp.gmail.com with ESMTPSA id d5sm6008343wrb.28.2020.09.18.08.06.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 08:06:20 -0700 (PDT)
Date: Fri, 18 Sep 2020 11:06:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/15] tests/qtest/vhost-user-test: add migrate_reconnect test
Message-ID: <20200918150506.286890-12-mst@redhat.com>
References: <20200918150506.286890-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200918150506.286890-1-mst@redhat.com>
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
 Dima Stepanov <dimastep@yandex-team.ru>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Dima Stepanov <dimastep@yandex-team.ru>

Add new migrate_reconnect test for the vhost-user-blk device. Perform a
disconnect after sending response for the VHOST_USER_SET_LOG_BASE
command.

Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
Message-Id: <a19c40a54e0c783e886a7324527ea8905647fb88.1598865610.git.dimastep@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/vhost-user-test.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
index 91f8cfda12..f8c74285c1 100644
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
@@ -1149,5 +1170,9 @@ static void register_vhost_user_test(void)
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


