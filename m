Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C7CC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 04:58:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85A4820BED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 04:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BVel3+qc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85A4820BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaAs3-0007PY-E7
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 23:58:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAnG-00013J-IV
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 23:53:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53577)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAnE-00059T-IU
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 23:53:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604465588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vTElEagYE/6ac5+wAhrYnP4rDr3IItx6R4ENpWim+c0=;
 b=BVel3+qcD8bGABB76IKiia+1oS9ud82v/aWjJLavovEkcFg+Z+sSXt32OR76M64OWQSFrO
 IMx6HXDkIJaN8UwktL8rnhE4U+ccJX6sOtu+akg+YjTnqme6q1xTJYQfYsRZlDYAjsJ/TC
 QZFBRfMqo0Z5dtMCuUzaUYf8rP0Z7Hs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-73DlCkPuOiCrp7xYZALQ_w-1; Tue, 03 Nov 2020 23:52:28 -0500
X-MC-Unique: 73DlCkPuOiCrp7xYZALQ_w-1
Received: by mail-wr1-f72.google.com with SMTP id 31so8705010wrg.12
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 20:52:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=vTElEagYE/6ac5+wAhrYnP4rDr3IItx6R4ENpWim+c0=;
 b=QD+NzqknctZj5/tfyC5xGQlPnpq/+rfGkq1Fx+IJk1sEQdzECW09O4UZ0l1o4O35ZG
 K+jewIFSj58RUTM8Y1vuDjKY7f3uYk0A2yueYxCUl41IvQluiiwYWWD8B4cBiH/1izcA
 DU/15TN5BD6NSDi5UBpPCBrwqGupO/GumcIyR8i2AHtbrO6nXvC/XiLZueOFKbNRDGc0
 8SYAwdjYrL5To5/aqhDMOkfwbjDyz3RgRhChTFuvZ0jKwtdB3BTCQxOahBG9DaMF3ASx
 EiZ5m8p3ueTJ0uzdXGDhH2eZO9o8Vgz4MDaXMRMYhOXDh1pgyOVU8N6zNccdW5OH5BNP
 nBlA==
X-Gm-Message-State: AOAM532vWNKuUGBb2FFLx/ViBrdG/pNAApIthDZQLJn1AStkTgn3M4y+
 Xm0S6zBPKGwaffNBGECz68pOupx/Dj85sPkraeioBg1zGZ7q1KpXVy/CBXuP1//tdVfJKoSFjwv
 qqZB6gkxJ/Rq3ZLM=
X-Received: by 2002:a1c:9e12:: with SMTP id h18mr2416221wme.11.1604465546652; 
 Tue, 03 Nov 2020 20:52:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyB5fJrYJcvdt2gVZYrFdnFKns8iyxs/fmgC7mXHBu7gSHzpe+xqaLyJNwwuulO3JRUyY526A==
X-Received: by 2002:a1c:9e12:: with SMTP id h18mr2416203wme.11.1604465546492; 
 Tue, 03 Nov 2020 20:52:26 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id v8sm830659wmg.28.2020.11.03.20.52.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 20:52:25 -0800 (PST)
Date: Tue, 3 Nov 2020 23:52:24 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 38/38] vhost-user-blk-test: fix races by using fd passing
Message-ID: <20201104044937.226370-39-mst@redhat.com>
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

Pass the QMP and vhost-user-blk server sockets as file descriptors. That
way the sockets are already open and in a listen state when the QEMU
process is launched.

This solves the race with qemu-storage-daemon startup where the UNIX
domain sockets may not be ready yet when QEMU attempts to connect. It
also saves us sleeping for 1 second if the qemu-storage-daemon QMP
socket is not ready yet.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20201027173528.213464-13-stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/vhost-user-blk-test.c | 42 +++++++++++++++++++------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/tests/qtest/vhost-user-blk-test.c b/tests/qtest/vhost-user-blk-test.c
index 0d056cc189..9589f90b14 100644
--- a/tests/qtest/vhost-user-blk-test.c
+++ b/tests/qtest/vhost-user-blk-test.c
@@ -683,8 +683,22 @@ static char *drive_create(void)
     return t_path;
 }
 
-static char sock_path_tempate[] = "/tmp/qtest.vhost_user_blk.XXXXXX";
-static char qmp_sock_path_tempate[] = "/tmp/qtest.vhost_user_blk.qmp.XXXXXX";
+static char *create_listen_socket(int *fd)
+{
+    int tmp_fd;
+    char *path;
+
+    /* No race because our pid makes the path unique */
+    path = g_strdup_printf("/tmp/qtest-%d-sock.XXXXXX", getpid());
+    tmp_fd = mkstemp(path);
+    g_assert_cmpint(tmp_fd, >=, 0);
+    close(tmp_fd);
+    unlink(path);
+
+    *fd = qtest_socket_server(path);
+    g_test_queue_destroy(destroy_file, path);
+    return path;
+}
 
 static void quit_storage_daemon(void *qmp_test_state)
 {
@@ -709,37 +723,33 @@ static void start_vhost_user_blk(GString *cmd_line, int vus_instances,
                                  int num_queues)
 {
     const char *vhost_user_blk_bin = qtest_qemu_storage_daemon_binary();
-    int fd, qmp_fd, i;
+    int qmp_fd, i;
     QTestState *qmp_test_state;
     gchar *img_path;
-    char *sock_path = NULL;
-    char *qmp_sock_path = g_strdup(qmp_sock_path_tempate);
+    char *qmp_sock_path;
     GString *storage_daemon_command = g_string_new(NULL);
 
-    qmp_fd = mkstemp(qmp_sock_path);
-    g_assert_cmpint(qmp_fd, >=, 0);
-    g_test_queue_destroy(destroy_file, qmp_sock_path);
+    qmp_sock_path = create_listen_socket(&qmp_fd);
 
     g_string_append_printf(storage_daemon_command,
             "exec %s "
-            "--chardev socket,id=qmp,path=%s,server,nowait --monitor chardev=qmp ",
-            vhost_user_blk_bin, qmp_sock_path);
+            "--chardev socket,id=qmp,fd=%d,server,nowait --monitor chardev=qmp ",
+            vhost_user_blk_bin, qmp_fd);
 
     g_string_append_printf(cmd_line,
             " -object memory-backend-memfd,id=mem,size=256M,share=on -M memory-backend=mem ");
 
     for (i = 0; i < vus_instances; i++) {
-        sock_path = g_strdup(sock_path_tempate);
-        fd = mkstemp(sock_path);
-        g_assert_cmpint(fd, >=, 0);
-        g_test_queue_destroy(drive_file, sock_path);
+        int fd;
+        char *sock_path = create_listen_socket(&fd);
+
         /* create image file */
         img_path = drive_create();
         g_string_append_printf(storage_daemon_command,
             "--blockdev driver=file,node-name=disk%d,filename=%s "
-            "--export type=vhost-user-blk,id=disk%d,addr.type=unix,addr.path=%s,"
+            "--export type=vhost-user-blk,id=disk%d,addr.type=fd,addr.str=%d,"
             "node-name=disk%i,writable=on,num-queues=%d ",
-            i, img_path, i, sock_path, i, num_queues);
+            i, img_path, i, fd, i, num_queues);
 
         g_string_append_printf(cmd_line, "-chardev socket,id=char%d,path=%s ",
                                i + 1, sock_path);
-- 
MST


