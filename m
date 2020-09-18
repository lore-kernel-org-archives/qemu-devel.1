Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78201C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 16:49:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAEB020848
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 16:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OrLZX9Ze"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAEB020848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJJZD-0005tm-Rw
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 12:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kJJ7d-000577-FK
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 12:20:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23065
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kJJ7b-0005ht-7U
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 12:20:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600446025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gyuuZ4Sz8ayGeGEwQkqastteCZWQE5SL9GYanhN/cu8=;
 b=OrLZX9ZeotS65ZTVm4bFsdaK+NmbiOxQvMyNvP8pygqchqgJwb98CFW659V5TEPUnhktoF
 iPgywb8J/qg7jdWCKICnsdwygXmtiTQ+rRB/vj269rxxj7LelcYpE+3uEqYS1ZNWx9m6fy
 gvXfu6j0wa3CQwLI1AnTVizYnUo4Zg4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-xz13OE5bPjOvSq9Gfkg1EA-1; Fri, 18 Sep 2020 12:20:23 -0400
X-MC-Unique: xz13OE5bPjOvSq9Gfkg1EA-1
Received: by mail-wm1-f69.google.com with SMTP id w3so2242905wmg.4
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 09:20:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=gyuuZ4Sz8ayGeGEwQkqastteCZWQE5SL9GYanhN/cu8=;
 b=slJoRpNEduXK+JkdngMcHdX1e5bacWu91IhFKECBhNmJl/65H9kBes9APE3E+OH2yM
 DrXFDVIVyr6g/CFu2k8PSa7zubF3iY9J5ZPcFcrrFdaJdyj8O/mxqW/E9Wi0W8/Lh4us
 DPH8e8i00JbCeWp9W7Qg0MSGJXJFJao8/ryceHSpKI3UyH7q6AoJ4hpcECQeIZLUOLgF
 T7xifK4jESM7D1ftxFqrsKIwReMFb7utOTjlvJ+ibxKqyB9WaWTdiW9U0VjAW35AB/Te
 NRw70zoFxXZivEjBK0NYqFIE4PX/PpzYzGQ0y6z3ibHGg7JNTeCSb7LHb4LGASpLUikc
 4GTQ==
X-Gm-Message-State: AOAM530gkYSpk3pcz+rfUWfFRd24jXvMw1s9Km2t5TGwjtqX9eti+vLR
 UOOpTaorAdqsXmKcfGckrCCVR6bLa0E0b2FoqA37KU8wbep/+nGHtRym0iNoE5793x6ar9jRy+Z
 yrK9E5JplLJiyPY8=
X-Received: by 2002:a1c:96:: with SMTP id 144mr16465888wma.84.1600446022151;
 Fri, 18 Sep 2020 09:20:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCnd1cPN5DzXVivE9FUlCePK5vrajlZZl8i/znXLCpZyPK+3qNcJZgb27qyKuMBuQH/S85+Q==
X-Received: by 2002:a1c:96:: with SMTP id 144mr16465862wma.84.1600446021864;
 Fri, 18 Sep 2020 09:20:21 -0700 (PDT)
Received: from redhat.com (bzq-109-65-116-225.red.bezeqint.net.
 [109.65.116.225])
 by smtp.gmail.com with ESMTPSA id o15sm5604768wmh.29.2020.09.18.09.20.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 09:20:21 -0700 (PDT)
Date: Fri, 18 Sep 2020 12:20:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 08/15] tests/qtest/vhost-user-test: prepare the tests for
 adding new dev class
Message-ID: <20200918161836.318893-9-mst@redhat.com>
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
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 03:47:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

For now only vhost-user-net device is supported by the test. Other
vhost-user devices are not tested. As a first step make source code
refactoring so new devices can reuse the same test routines. To make
this provide a new vhost_user_ops structure with the methods to
initialize device, its command line or make a proper vhost-user
responses.

Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Message-Id: <a48b60fb96fef230b75fff72a2d77040dcb5ef7c.1599813294.git.dimastep@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/vhost-user-test.c | 105 ++++++++++++++++++++++++----------
 1 file changed, 76 insertions(+), 29 deletions(-)

diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
index 9ee0f1e4fd..3df5322614 100644
--- a/tests/qtest/vhost-user-test.c
+++ b/tests/qtest/vhost-user-test.c
@@ -135,6 +135,10 @@ enum {
     TEST_FLAGS_END,
 };
 
+enum {
+    VHOST_USER_NET,
+};
+
 typedef struct TestServer {
     gchar *socket_path;
     gchar *mig_path;
@@ -154,10 +158,25 @@ typedef struct TestServer {
     bool test_fail;
     int test_flags;
     int queues;
+    struct vhost_user_ops *vu_ops;
 } TestServer;
 
+struct vhost_user_ops {
+    /* Device types. */
+    int type;
+    void (*append_opts)(TestServer *s, GString *cmd_line,
+            const char *chr_opts);
+
+    /* VHOST-USER commands. */
+    void (*set_features)(TestServer *s, CharBackend *chr,
+            VhostUserMsg *msg);
+    void (*get_protocol_features)(TestServer *s,
+            CharBackend *chr, VhostUserMsg *msg);
+};
+
 static const char *init_hugepagefs(void);
-static TestServer *test_server_new(const gchar *name);
+static TestServer *test_server_new(const gchar *name,
+        struct vhost_user_ops *ops);
 static void test_server_free(TestServer *server);
 static void test_server_listen(TestServer *server);
 
@@ -167,7 +186,7 @@ enum test_memfd {
     TEST_MEMFD_NO,
 };
 
-static void append_vhost_opts(TestServer *s, GString *cmd_line,
+static void append_vhost_net_opts(TestServer *s, GString *cmd_line,
                              const char *chr_opts)
 {
     g_string_append_printf(cmd_line, QEMU_CMD_CHR QEMU_CMD_NETDEV,
@@ -332,25 +351,15 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
         break;
 
     case VHOST_USER_SET_FEATURES:
-        g_assert_cmpint(msg.payload.u64 & (0x1ULL << VHOST_USER_F_PROTOCOL_FEATURES),
-                        !=, 0ULL);
-        if (s->test_flags == TEST_FLAGS_DISCONNECT) {
-            qemu_chr_fe_disconnect(chr);
-            s->test_flags = TEST_FLAGS_BAD;
+        if (s->vu_ops->set_features) {
+            s->vu_ops->set_features(s, chr, &msg);
         }
         break;
 
     case VHOST_USER_GET_PROTOCOL_FEATURES:
-        /* send back features to qemu */
-        msg.flags |= VHOST_USER_REPLY_MASK;
-        msg.size = sizeof(m.payload.u64);
-        msg.payload.u64 = 1 << VHOST_USER_PROTOCOL_F_LOG_SHMFD;
-        msg.payload.u64 |= 1 << VHOST_USER_PROTOCOL_F_CROSS_ENDIAN;
-        if (s->queues > 1) {
-            msg.payload.u64 |= 1 << VHOST_USER_PROTOCOL_F_MQ;
+        if (s->vu_ops->get_protocol_features) {
+            s->vu_ops->get_protocol_features(s, chr, &msg);
         }
-        p = (uint8_t *) &msg;
-        qemu_chr_fe_write_all(chr, p, VHOST_USER_HDR_SIZE + msg.size);
         break;
 
     case VHOST_USER_GET_VRING_BASE:
@@ -467,7 +476,8 @@ static const char *init_hugepagefs(void)
 #endif
 }
 
-static TestServer *test_server_new(const gchar *name)
+static TestServer *test_server_new(const gchar *name,
+        struct vhost_user_ops *ops)
 {
     TestServer *server = g_new0(TestServer, 1);
     char template[] = "/tmp/vhost-test-XXXXXX";
@@ -495,6 +505,7 @@ static TestServer *test_server_new(const gchar *name)
 
     server->log_fd = -1;
     server->queues = 1;
+    server->vu_ops = ops;
 
     return server;
 }
@@ -669,11 +680,11 @@ static void vhost_user_test_cleanup(void *s)
 
 static void *vhost_user_test_setup(GString *cmd_line, void *arg)
 {
-    TestServer *server = test_server_new("vhost-user-test");
+    TestServer *server = test_server_new("vhost-user-test", arg);
     test_server_listen(server);
 
     append_mem_opts(server, cmd_line, 256, TEST_MEMFD_AUTO);
-    append_vhost_opts(server, cmd_line, "");
+    server->vu_ops->append_opts(server, cmd_line, "");
 
     g_test_queue_destroy(vhost_user_test_cleanup, server);
 
@@ -682,11 +693,11 @@ static void *vhost_user_test_setup(GString *cmd_line, void *arg)
 
 static void *vhost_user_test_setup_memfd(GString *cmd_line, void *arg)
 {
-    TestServer *server = test_server_new("vhost-user-test");
+    TestServer *server = test_server_new("vhost-user-test", arg);
     test_server_listen(server);
 
     append_mem_opts(server, cmd_line, 256, TEST_MEMFD_YES);
-    append_vhost_opts(server, cmd_line, "");
+    server->vu_ops->append_opts(server, cmd_line, "");
 
     g_test_queue_destroy(vhost_user_test_cleanup, server);
 
@@ -720,7 +731,7 @@ static void test_migrate(void *obj, void *arg, QGuestAllocator *alloc)
         return;
     }
 
-    dest = test_server_new("dest");
+    dest = test_server_new("dest", s->vu_ops);
     dest_cmdline = g_string_new(qos_get_current_command_line());
     uri = g_strdup_printf("%s%s", "unix:", dest->mig_path);
 
@@ -730,7 +741,7 @@ static void test_migrate(void *obj, void *arg, QGuestAllocator *alloc)
     test_server_listen(dest);
     g_string_append_printf(dest_cmdline, " -incoming %s", uri);
     append_mem_opts(dest, dest_cmdline, 256, TEST_MEMFD_AUTO);
-    append_vhost_opts(dest, dest_cmdline, "");
+    dest->vu_ops->append_opts(dest, dest_cmdline, "");
     to = qtest_init(dest_cmdline->str);
 
     /* This would be where you call qos_allocate_objects(to, NULL), if you want
@@ -831,11 +842,11 @@ connect_thread(gpointer data)
 
 static void *vhost_user_test_setup_reconnect(GString *cmd_line, void *arg)
 {
-    TestServer *s = test_server_new("reconnect");
+    TestServer *s = test_server_new("reconnect", arg);
 
     g_thread_new("connect", connect_thread, s);
     append_mem_opts(s, cmd_line, 256, TEST_MEMFD_AUTO);
-    append_vhost_opts(s, cmd_line, ",server");
+    s->vu_ops->append_opts(s, cmd_line, ",server");
 
     g_test_queue_destroy(vhost_user_test_cleanup, s);
 
@@ -866,13 +877,13 @@ static void test_reconnect(void *obj, void *arg, QGuestAllocator *alloc)
 
 static void *vhost_user_test_setup_connect_fail(GString *cmd_line, void *arg)
 {
-    TestServer *s = test_server_new("connect-fail");
+    TestServer *s = test_server_new("connect-fail", arg);
 
     s->test_fail = true;
 
     g_thread_new("connect", connect_thread, s);
     append_mem_opts(s, cmd_line, 256, TEST_MEMFD_AUTO);
-    append_vhost_opts(s, cmd_line, ",server");
+    s->vu_ops->append_opts(s, cmd_line, ",server");
 
     g_test_queue_destroy(vhost_user_test_cleanup, s);
 
@@ -881,13 +892,13 @@ static void *vhost_user_test_setup_connect_fail(GString *cmd_line, void *arg)
 
 static void *vhost_user_test_setup_flags_mismatch(GString *cmd_line, void *arg)
 {
-    TestServer *s = test_server_new("flags-mismatch");
+    TestServer *s = test_server_new("flags-mismatch", arg);
 
     s->test_flags = TEST_FLAGS_DISCONNECT;
 
     g_thread_new("connect", connect_thread, s);
     append_mem_opts(s, cmd_line, 256, TEST_MEMFD_AUTO);
-    append_vhost_opts(s, cmd_line, ",server");
+    s->vu_ops->append_opts(s, cmd_line, ",server");
 
     g_test_queue_destroy(vhost_user_test_cleanup, s);
 
@@ -924,11 +935,47 @@ static void test_multiqueue(void *obj, void *arg, QGuestAllocator *alloc)
     wait_for_rings_started(s, s->queues * 2);
 }
 
+static void vu_net_set_features(TestServer *s, CharBackend *chr,
+        VhostUserMsg *msg)
+{
+    g_assert_cmpint(msg->payload.u64 &
+            (0x1ULL << VHOST_USER_F_PROTOCOL_FEATURES), !=, 0ULL);
+    if (s->test_flags == TEST_FLAGS_DISCONNECT) {
+        qemu_chr_fe_disconnect(chr);
+        s->test_flags = TEST_FLAGS_BAD;
+    }
+}
+
+static void vu_net_get_protocol_features(TestServer *s, CharBackend *chr,
+        VhostUserMsg *msg)
+{
+    /* send back features to qemu */
+    msg->flags |= VHOST_USER_REPLY_MASK;
+    msg->size = sizeof(m.payload.u64);
+    msg->payload.u64 = 1 << VHOST_USER_PROTOCOL_F_LOG_SHMFD;
+    msg->payload.u64 |= 1 << VHOST_USER_PROTOCOL_F_CROSS_ENDIAN;
+    if (s->queues > 1) {
+        msg->payload.u64 |= 1 << VHOST_USER_PROTOCOL_F_MQ;
+    }
+    qemu_chr_fe_write_all(chr, (uint8_t *)msg, VHOST_USER_HDR_SIZE + msg->size);
+}
+
+/* Each VHOST-USER device should have its ops structure defined. */
+static struct vhost_user_ops g_vu_net_ops = {
+    .type = VHOST_USER_NET,
+
+    .append_opts = append_vhost_net_opts,
+
+    .set_features = vu_net_set_features,
+    .get_protocol_features = vu_net_get_protocol_features,
+};
+
 static void register_vhost_user_test(void)
 {
     QOSGraphTestOptions opts = {
         .before = vhost_user_test_setup,
         .subprocess = true,
+        .arg = &g_vu_net_ops,
     };
 
     qemu_add_opts(&qemu_chardev_opts);
-- 
MST


