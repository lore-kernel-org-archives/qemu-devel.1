Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6833CC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 05:12:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD57720BED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 05:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="duFbm/0+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD57720BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaB6F-0003lq-KW
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 00:12:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAmW-0007aB-VQ
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 23:52:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24630)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAmU-0004tB-Tj
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 23:52:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604465542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oAjLZ11EwsHXoMOOACL8j6jIH95zMRiiieEROhG5SCc=;
 b=duFbm/0+hrycbDX3+0N2et41xH2XKmjPhbFoVVKtAtI/Tx3j9YCOiaJXJCxxCnfYtMwzRE
 jKkoj9UwmuHb8ymCilmJ4AX++WOi3vrFyBarIS2ZUCfcZmSJt0rt2HRcG2adAqjy3Qx+6H
 eJQOkSpu0uGRwTLk4BQfxyMyLGyxeAc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-tmEaLNRfP86qUFm6ZqeJiw-1; Tue, 03 Nov 2020 23:52:20 -0500
X-MC-Unique: tmEaLNRfP86qUFm6ZqeJiw-1
Received: by mail-wr1-f69.google.com with SMTP id 33so8659315wrf.22
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 20:52:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=oAjLZ11EwsHXoMOOACL8j6jIH95zMRiiieEROhG5SCc=;
 b=lzQLPxSjRPg4IENnPsmvEadgQyhRQAHB2esuKLdSuDC5gjns5ZZIEu+P5c3HlkWp8D
 g8buzEGfcKEKEZ4WfHMuq7hV34xqzfcrCJJjCxCYCMmdk3T08R4EXZOvh8BmeL0Le0sh
 rLGUfmer5e9h6MjKlEsLxIpwXWsuW0mVe8tKy2WvYN0OaqD/7cXSD6RqwlAT0m88Hudf
 IBzJW7JhglRhusnEI2OP0ZeDTt8ZBRBRSQr7ZmLemCqNk7oaOdECYJ1qiNrasQOvmaCF
 +Ue7hZklv9WMzsPwdmxvWyxheWhu4VpIB0RBA8lshCbsnRttDMHNUvVzGqM1OKbUEbL6
 RTqQ==
X-Gm-Message-State: AOAM533Z7ZqbxyErTza6vXMuif3Yu/8dEYDQJRAIc5Ret5icaZeE6TL8
 aZt1Bnd+fHH+F9LIbqKCnT7loZyxUrvX53u6HDupp+iJRYOxFcnqCzLGcpTFz7I+VjgobUwmIYd
 T0TLealfu8ZJm8hc=
X-Received: by 2002:a5d:4581:: with SMTP id p1mr29642591wrq.353.1604465538923; 
 Tue, 03 Nov 2020 20:52:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxigAe3jPW7Tu6L2pCxoUsdnY8FVMxv/V0FS0A0KvMatcvOkpmVmV6WMKV0cyS8drKtRm3csw==
X-Received: by 2002:a5d:4581:: with SMTP id p1mr29642576wrq.353.1604465538803; 
 Tue, 03 Nov 2020 20:52:18 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id u15sm853127wrm.77.2020.11.03.20.52.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 20:52:18 -0800 (PST)
Date: Tue, 3 Nov 2020 23:52:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 35/38] vhost-user-blk-test: rename destroy_drive() to
 destroy_file()
Message-ID: <20201104044937.226370-36-mst@redhat.com>
References: <20201104044937.226370-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201104044937.226370-1-mst@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

The function is used not just for image files but also for UNIX domain
sockets (QMP monitor and vhost-user-blk). Reflect that in the name.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20201027173528.213464-10-stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/vhost-user-blk-test.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/vhost-user-blk-test.c b/tests/qtest/vhost-user-blk-test.c
index 31f2335f97..f05f14c192 100644
--- a/tests/qtest/vhost-user-blk-test.c
+++ b/tests/qtest/vhost-user-blk-test.c
@@ -658,7 +658,8 @@ static const char *qtest_qemu_storage_daemon_binary(void)
     return qemu_storage_daemon_bin;
 }
 
-static void drive_destroy(void *path)
+/* g_test_queue_destroy() cleanup function for files */
+static void destroy_file(void *path)
 {
     unlink(path);
     g_free(path);
@@ -678,7 +679,7 @@ static char *drive_create(void)
     g_assert_cmpint(ret, ==, 0);
     close(fd);
 
-    g_test_queue_destroy(drive_destroy, t_path);
+    g_test_queue_destroy(destroy_file, t_path);
     return t_path;
 }
 
@@ -717,7 +718,7 @@ static char *start_vhost_user_blk(GString *cmd_line, int vus_instances,
 
     qmp_fd = mkstemp(qmp_sock_path);
     g_assert_cmpint(qmp_fd, >=, 0);
-    g_test_queue_destroy(drive_destroy, qmp_sock_path);
+    g_test_queue_destroy(destroy_file, qmp_sock_path);
 
     g_string_append_printf(storage_daemon_command,
             "exec %s "
@@ -731,7 +732,7 @@ static char *start_vhost_user_blk(GString *cmd_line, int vus_instances,
         sock_path = g_strdup(sock_path_tempate);
         fd = mkstemp(sock_path);
         g_assert_cmpint(fd, >=, 0);
-        g_test_queue_destroy(drive_destroy, sock_path);
+        g_test_queue_destroy(drive_file, sock_path);
         /* create image file */
         img_path = drive_create();
         g_string_append_printf(storage_daemon_command,
-- 
MST


