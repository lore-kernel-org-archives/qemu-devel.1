Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A67EC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:55:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2A702076E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a8a8qtXb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A702076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZxiF-0005mc-Ns
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 09:55:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZxPc-0005mt-8R
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:35:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50081)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZxPQ-0006ul-6h
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:35:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604414139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oAjLZ11EwsHXoMOOACL8j6jIH95zMRiiieEROhG5SCc=;
 b=a8a8qtXb/f+L4JFh2dWjR/dVtSmXARhBRxYzdeCDbV7K0G8UWcsNHooUIy081EhxYXGuPm
 XFH2zg6YJ1t+9RsvaG5J7I83A1LmZGeCiQrYwGR1/kmGSdiTo6V7YigUTlfv8bN/iSf8qh
 gwO9zCmpQhUnr5bepmLC1pC4g5gZ5EE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-mmGjxVFvN6-tbNL8oTFi1A-1; Tue, 03 Nov 2020 09:35:35 -0500
X-MC-Unique: mmGjxVFvN6-tbNL8oTFi1A-1
Received: by mail-wm1-f72.google.com with SMTP id t21so2696092wmt.8
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 06:35:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=oAjLZ11EwsHXoMOOACL8j6jIH95zMRiiieEROhG5SCc=;
 b=uOnzlmpOfMAfd7nVaM4lkmtsOLJzJmE7NTd2Gmb8cSh+35GrLFWwAGFFu1uI64/5UF
 Uk4n/kPLXZvjmPTQl1XybtgzAIUo6totZKLV0UXcy6z70Ee4kCEk3DsIpW2N77xaRFhU
 +iXJ0xt/1u9yJ7fuTECjnOiKiHIXg4gMox9YbOF/fM1titi+2xs1Hkl4DpPxt5SkKHJA
 cG0T8vCUoQU5fzIK/5HrZC6A04Qc8xIDwsYLTIZEGfcyVVG9VmQ26+AMJKk3QDoVqGnR
 3gEgzf453NVcsdg9F67lExelDHdMFRWccATy5/84nB/xFr51h4+Pp8LXkkZca05Tb+x3
 pvmg==
X-Gm-Message-State: AOAM5326YGiS0s9bzMoMENVoMy5ZG/thr3+PiQymLqZrf9eveG3gZWz6
 aN5SrSyrVuEeshFSGaU351nzRCD8cK/4+fWG9xhl8yd6VBYb1FsDzyp+4c9Wwp1jaREyQ5kaTkH
 pcObD84onVek167o=
X-Received: by 2002:a1c:2583:: with SMTP id l125mr80540wml.50.1604414133758;
 Tue, 03 Nov 2020 06:35:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyyANNMlJ4QNIKoDRnB7sRi+l/PB/29ywBQgYzrmXnCllCcepBuvfnXCC8D391ReiOBPZ87gw==
X-Received: by 2002:a1c:2583:: with SMTP id l125mr80523wml.50.1604414133600;
 Tue, 03 Nov 2020 06:35:33 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id a199sm3293038wmd.8.2020.11.03.06.35.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 06:35:32 -0800 (PST)
Date: Tue, 3 Nov 2020 09:35:31 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 35/38] vhost-user-blk-test: rename destroy_drive() to
 destroy_file()
Message-ID: <20201103142306.71782-36-mst@redhat.com>
References: <20201103142306.71782-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201103142306.71782-1-mst@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


