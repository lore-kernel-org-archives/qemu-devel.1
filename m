Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=FROM_WSP_TRAIL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1211EC2D0C8
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 12:55:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF0C420663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 12:55:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF0C420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39993 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihCNf-0001hq-Ha
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 07:55:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1ihCMU-0000OR-0h
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 07:54:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1ihCMS-0001Bp-La
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 07:54:01 -0500
Received: from mga18.intel.com ([134.134.136.126]:49328)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1ihCMS-00018a-Dc
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 07:54:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Dec 2019 04:53:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,325,1571727600"; d="scan'208";a="209689636"
Received: from unknown (HELO localhost.localdomain) ([10.239.13.19])
 by orsmga008.jf.intel.com with ESMTP; 17 Dec 2019 04:53:57 -0800
From: Zhang Chen <chen.zhang@intel.com >
To: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-dev <qemu-devel@nongnu.org>
Subject: [PATCH V4 3/5] net/awd.c: Load advanced watch dog worker thread job
Date: Tue, 17 Dec 2019 20:45:52 +0800
Message-Id: <20191217124554.30818-4-chen.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191217124554.30818-1-chen.zhang@intel.com>
References: <20191217124554.30818-1-chen.zhang@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.126
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
Cc: Zhang Chen <chen.zhang@intel.com>, Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Zhang Chen <chen.zhang@intel.com>

This patch load pulse_timer and timeout_timer in the new iothread.
The pulse timer will send pulse info to awd_node, and the timeout timer
will check the reply pulse from awd_node. If timeout occur, it will send
opt_script's data to the notification_node.

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
---
 net/awd.c | 193 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 193 insertions(+)

diff --git a/net/awd.c b/net/awd.c
index ad3d39c982..04f40e7cc8 100644
--- a/net/awd.c
+++ b/net/awd.c
@@ -40,17 +40,137 @@ typedef struct AwdState {
     char *awd_node;
     char *notification_node;
     char *opt_script;
+    char *opt_script_data;
     uint32_t pulse_interval;
     uint32_t timeout;
     CharBackend chr_awd_node;
     CharBackend chr_notification_node;
+    SocketReadState awd_rs;
+
+    QEMUTimer *pulse_timer;
+    QEMUTimer *timeout_timer;
     IOThread *iothread;
+    GMainContext *worker_context;
 } AwdState;
 
 typedef struct AwdClass {
     ObjectClass parent_class;
 } AwdClass;
 
+static int awd_chr_send(AwdState *s,
+                        const uint8_t *buf,
+                        uint32_t size)
+{
+    int ret = 0;
+    uint32_t len = htonl(size);
+
+    if (!size) {
+        return 0;
+    }
+
+    ret = qemu_chr_fe_write_all(&s->chr_awd_node, (uint8_t *)&len,
+                                sizeof(len));
+    if (ret != sizeof(len)) {
+        goto err;
+    }
+
+    ret = qemu_chr_fe_write_all(&s->chr_awd_node, (uint8_t *)buf,
+                                size);
+    if (ret != size) {
+        goto err;
+    }
+
+    return 0;
+
+err:
+    return ret < 0 ? ret : -EIO;
+}
+
+static int awd_chr_can_read(void *opaque)
+{
+    return AWD_READ_LEN_MAX;
+}
+
+static void awd_node_in(void *opaque, const uint8_t *buf, int size)
+{
+    AwdState *s = AWD(opaque);
+    int ret;
+
+    ret = net_fill_rstate(&s->awd_rs, buf, size);
+    if (ret == -1) {
+        qemu_chr_fe_set_handlers(&s->chr_awd_node, NULL, NULL, NULL, NULL,
+                                 NULL, NULL, true);
+        error_report("advanced-watchdog get pulse error");
+    }
+}
+
+static void awd_send_pulse(void *opaque)
+{
+    AwdState *s = opaque;
+    char buf[] = "advanced-watchdog pulse";
+
+    awd_chr_send(s, (uint8_t *)buf, sizeof(buf));
+}
+
+static void awd_regular_pulse(void *opaque)
+{
+    AwdState *s = opaque;
+
+    awd_send_pulse(s);
+    timer_mod(s->pulse_timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
+              s->pulse_interval);
+}
+
+static void awd_timeout(void *opaque)
+{
+    AwdState *s = opaque;
+    int ret = 0;
+
+    ret = qemu_chr_fe_write_all(&s->chr_notification_node,
+                                (uint8_t *)s->opt_script_data,
+                                strlen(s->opt_script_data));
+    if (ret) {
+        error_report("advanced-watchdog notification failure");
+    }
+}
+
+static void awd_timer_init(AwdState *s)
+{
+    AioContext *ctx = iothread_get_aio_context(s->iothread);
+
+    s->timeout_timer = aio_timer_new(ctx, QEMU_CLOCK_VIRTUAL, SCALE_MS,
+                                     awd_timeout, s);
+
+    s->pulse_timer = aio_timer_new(ctx, QEMU_CLOCK_VIRTUAL, SCALE_MS,
+                                      awd_regular_pulse, s);
+
+    if (!s->pulse_interval) {
+        s->pulse_interval = AWD_PULSE_INTERVAL_DEFAULT;
+    }
+
+    if (!s->timeout) {
+        s->timeout = AWD_TIMEOUT_DEFAULT;
+    }
+
+    timer_mod(s->pulse_timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
+              s->pulse_interval);
+}
+
+static void awd_timer_del(AwdState *s)
+{
+    if (s->pulse_timer) {
+        timer_del(s->pulse_timer);
+        timer_free(s->pulse_timer);
+        s->pulse_timer = NULL;
+    }
+
+    if (s->timeout_timer) {
+        timer_del(s->timeout_timer);
+        timer_free(s->timeout_timer);
+        s->timeout_timer = NULL;
+    }
+ }
+
 static char *awd_get_node(Object *obj, Error **errp)
 {
     AwdState *s = AWD(obj);
@@ -177,6 +297,22 @@ out:
     error_propagate(errp, local_err);
 }
 
+static void awd_rs_finalize(SocketReadState *awd_rs)
+{
+    AwdState *s = container_of(awd_rs, AwdState, awd_rs);
+
+    if (!s->server) {
+        char buf[] = "advanced-watchdog reply pulse";
+
+        awd_chr_send(s, (uint8_t *)buf, sizeof(buf));
+    }
+
+    timer_mod(s->timeout_timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
+              s->timeout);
+
+    error_report("advanced-watchdog got message : %s", awd_rs->buf);
+}
+
 static int find_and_check_chardev(Chardev **chr,
                                   char *chr_name,
                                   Error **errp)
@@ -197,6 +333,46 @@ static int find_and_check_chardev(Chardev **chr,
     return 0;
 }
 
+static void awd_iothread(AwdState *s)
+{
+    object_ref(OBJECT(s->iothread));
+    s->worker_context = iothread_get_g_main_context(s->iothread);
+
+    qemu_chr_fe_set_handlers(&s->chr_awd_node, awd_chr_can_read,
+                             awd_node_in, NULL, NULL,
+                             s, s->worker_context, true);
+
+    awd_timer_init(s);
+}
+
+static int get_opt_script_data(AwdState *s)
+{
+    FILE *opt_fd;
+    long fsize;
+
+    opt_fd = fopen(s->opt_script, "r");
+    if (opt_fd == NULL) {
+        error_report("advanced-watchdog can't open "
+                     "opt_script: %s", s->opt_script);
+        return -1;
+    }
+
+    fseek(opt_fd, 0, SEEK_END);
+    fsize = ftell(opt_fd);
+    fseek(opt_fd, 0, SEEK_SET);
+    s->opt_script_data = malloc(fsize + 1);
+
+    if (!fread(s->opt_script_data, 1, fsize, opt_fd)) {
+        error_report("advanced-watchdog can't read "
+                     "opt_script: %s", s->opt_script);
+        return -1;
+    }
+
+    fclose(opt_fd);
+
+    return 0;
+}
+
 static void awd_complete(UserCreatable *uc, Error **errp)
 {
     AwdState *s = AWD(uc);
@@ -224,6 +400,16 @@ static void awd_complete(UserCreatable *uc, Error **errp)
         return;
     }
 
+    if (get_opt_script_data(s)) {
+        error_setg(errp, "advanced-watchdog can't get "
+                   "opt script data: %s", s->opt_script);
+        return;
+    }
+
+    net_socket_rs_init(&s->awd_rs, awd_rs_finalize, false);
+
+    awd_iothread(s);
+
     return;
 }
 
@@ -272,6 +458,13 @@ static void awd_finalize(Object *obj)
 {
     AwdState *s = AWD(obj);
 
+    qemu_chr_fe_deinit(&s->chr_awd_node, false);
+    qemu_chr_fe_deinit(&s->chr_notification_node, false);
+
+    if (s->iothread) {
+        awd_timer_del(s);
+    }
+
     g_free(s->awd_node);
     g_free(s->notification_node);
 }
-- 
2.17.1


