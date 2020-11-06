Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C52C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 12:48:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51F35206B7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 12:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51F35206B7
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb1AG-000317-B5
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 07:48:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kb15O-00034n-Be; Fri, 06 Nov 2020 07:43:22 -0500
Received: from relay.sw.ru ([185.231.240.75]:48318 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kb15K-0001Tf-EK; Fri, 06 Nov 2020 07:43:21 -0500
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.94)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kb14r-007cZw-Fg; Fri, 06 Nov 2020 15:42:49 +0300
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, jcody@redhat.com, kwolf@redhat.com,
 mreitz@redhat.com, armbru@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, marcandre.lureau@redhat.com,
 den@openvz.org, vsementsov@virtuozzo.com, andrey.shinkevich@virtuozzo.com
Subject: [PATCH 2/2] monitor: increase amount of data for monitor to read
Date: Fri,  6 Nov 2020 15:42:02 +0300
Message-Id: <1604666522-545580-3-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1604666522-545580-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1604666522-545580-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Received-SPF: pass client-ip=185.231.240.75;
 envelope-from=andrey.shinkevich@virtuozzo.com; helo=relay3.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 07:42:29
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
From: Andrey Shinkevich via <qemu-devel@nongnu.org>

QMP and HMP monitors read one byte at a time from the socket or stdin,
which is very inefficient. With 100+ VMs on the host, this results in
multiple extra system calls and CPU overuse.
This patch increases the amount of read data up to 4096 bytes that fits
the buffer size on the channel level.

Suggested-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 chardev/char-fd.c          | 64 +++++++++++++++++++++++++++++++++++++++++++++-
 chardev/char-socket.c      | 54 +++++++++++++++++++++++++++-----------
 chardev/char.c             | 40 +++++++++++++++++++++++++++++
 include/chardev/char.h     | 15 +++++++++++
 monitor/monitor.c          |  2 +-
 tests/qemu-iotests/247.out |  2 +-
 6 files changed, 159 insertions(+), 18 deletions(-)

diff --git a/chardev/char-fd.c b/chardev/char-fd.c
index 1cd62f2..6194fe6 100644
--- a/chardev/char-fd.c
+++ b/chardev/char-fd.c
@@ -33,6 +33,8 @@
 #include "chardev/char-fd.h"
 #include "chardev/char-io.h"
 
+#include "monitor/monitor-internal.h"
+
 /* Called with chr_write_lock held.  */
 static int fd_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
@@ -41,7 +43,7 @@ static int fd_chr_write(Chardev *chr, const uint8_t *buf, int len)
     return io_channel_send(s->ioc_out, buf, len);
 }
 
-static gboolean fd_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
+static gboolean fd_chr_read_hmp(QIOChannel *chan, void *opaque)
 {
     Chardev *chr = CHARDEV(opaque);
     FDChardev *s = FD_CHARDEV(opaque);
@@ -71,6 +73,66 @@ static gboolean fd_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
     return TRUE;
 }
 
+static gboolean fd_chr_read_qmp(QIOChannel *chan, void *opaque)
+{
+    static JSONthrottle thl = {0};
+    uint8_t *start;
+    Chardev *chr = CHARDEV(opaque);
+    FDChardev *s = FD_CHARDEV(opaque);
+    int len, size, pos;
+    ssize_t ret;
+
+    if (!thl.load) {
+        len = sizeof(thl.buf);
+        if (len > s->max_size) {
+            len = s->max_size;
+        }
+        if (len == 0) {
+            return TRUE;
+        }
+
+        ret = qio_channel_read(
+            chan, (gchar *)thl.buf, len, NULL);
+        if (ret == 0) {
+            remove_fd_in_watch(chr);
+            qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
+            thl = (const JSONthrottle){0};
+            return FALSE;
+        }
+        if (ret < 0) {
+            return TRUE;
+        }
+        thl.load = ret;
+        thl.cursor = 0;
+    }
+
+    size = thl.load;
+    start = thl.buf + thl.cursor;
+    pos = qemu_chr_end_position((const char *) start, size, &thl);
+    if (pos >= 0) {
+        size = pos + 1;
+    }
+
+    qemu_chr_be_write(chr, start, size);
+    thl.cursor += size;
+    thl.load -= size;
+
+    return TRUE;
+}
+
+static gboolean fd_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
+{
+    Chardev *chr = CHARDEV(opaque);
+    CharBackend *be = chr->be;
+    Monitor *mon = (Monitor *)be->opaque;
+
+    if (monitor_is_qmp(mon)) {
+        return fd_chr_read_qmp(chan, opaque);
+    }
+
+    return fd_chr_read_hmp(chan, opaque);
+}
+
 static int fd_chr_read_poll(void *opaque)
 {
     Chardev *chr = CHARDEV(opaque);
diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 213a4c8..8335e8c 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -520,30 +520,54 @@ static void tcp_chr_disconnect(Chardev *chr)
 
 static gboolean tcp_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
 {
+    static JSONthrottle thl = {0};
+    uint8_t *start;
     Chardev *chr = CHARDEV(opaque);
     SocketChardev *s = SOCKET_CHARDEV(opaque);
-    uint8_t buf[CHR_READ_BUF_LEN];
-    int len, size;
+    int len, size, pos;
 
     if ((s->state != TCP_CHARDEV_STATE_CONNECTED) ||
         s->max_size <= 0) {
         return TRUE;
     }
-    len = sizeof(buf);
-    if (len > s->max_size) {
-        len = s->max_size;
-    }
-    size = tcp_chr_recv(chr, (void *)buf, len);
-    if (size == 0 || (size == -1 && errno != EAGAIN)) {
-        /* connection closed */
-        tcp_chr_disconnect(chr);
-    } else if (size > 0) {
-        if (s->do_telnetopt) {
-            tcp_chr_process_IAC_bytes(chr, s, buf, &size);
+
+    if (!thl.load) {
+        len = sizeof(thl.buf);
+        if (len > s->max_size) {
+            len = s->max_size;
+        }
+        size = tcp_chr_recv(chr, (void *)thl.buf, len);
+        if (size == 0 || (size == -1 && errno != EAGAIN)) {
+            /* connection closed */
+            tcp_chr_disconnect(chr);
+            thl = (const JSONthrottle){0};
+            return TRUE;
         }
-        if (size > 0) {
-            qemu_chr_be_write(chr, buf, size);
+        if (size < 0) {
+            return TRUE;
         }
+        thl.load = size;
+        thl.cursor = 0;
+    }
+
+    size = thl.load;
+    start = thl.buf + thl.cursor;
+    pos = qemu_chr_end_position((const char *) start, size, &thl);
+    if (pos >= 0) {
+        size = pos + 1;
+    }
+    len = size;
+
+    if (s->do_telnetopt) {
+        tcp_chr_process_IAC_bytes(chr, s, start, &size);
+    }
+    if (size > 0) {
+        qemu_chr_be_write(chr, start, size);
+        thl.cursor += size;
+        thl.load -= size;
+    } else {
+        thl.cursor += len;
+        thl.load -= len;
     }
 
     return TRUE;
diff --git a/chardev/char.c b/chardev/char.c
index aa42821..251c97c 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -1178,6 +1178,46 @@ GSource *qemu_chr_timeout_add_ms(Chardev *chr, guint ms,
     return source;
 }
 
+/*
+ * Split the incoming buffered stream so that the QMP monitor queue is not
+ * overwhelmed with requests. The function looks for the last paired
+ * brace/bracket in a JSON command.
+ */
+int qemu_chr_end_position(const char *buf, int size, JSONthrottle *thl)
+{
+    int i;
+
+    for (i = 0; i < size; i++) {
+        switch (buf[i]) {
+        case ' ':
+        case '\n':
+        case '\r':
+            continue;
+        case '{':
+            thl->brace_count++;
+            break;
+        case '}':
+            thl->brace_count--;
+            break;
+        case '[':
+            thl->bracket_count++;
+            break;
+        case ']':
+            thl->bracket_count--;
+            break;
+        default:
+            break;
+        }
+        /* The same condition as it is in the json_message_process_token() */
+        if ((thl->brace_count > 0 || thl->bracket_count > 0)
+            && thl->brace_count >= 0 && thl->bracket_count >= 0) {
+            continue;
+        }
+        return i;
+    }
+    return -1;
+}
+
 void qemu_chr_cleanup(void)
 {
     object_unparent(get_chardevs_root());
diff --git a/include/chardev/char.h b/include/chardev/char.h
index db42f0a..5f02731 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -70,6 +70,14 @@ struct Chardev {
     DECLARE_BITMAP(features, QEMU_CHAR_FEATURE_LAST);
 };
 
+typedef struct {
+    uint8_t buf[CHR_READ_BUF_LEN];
+    int load;
+    int cursor;
+    int brace_count;
+    int bracket_count;
+} JSONthrottle;
+
 /**
  * qemu_chr_new_from_opts:
  * @opts: see qemu-config.c for a list of valid options
@@ -141,6 +149,13 @@ Chardev *qemu_chr_new_mux_mon(const char *label, const char *filename,
 void qemu_chr_change(QemuOpts *opts, Error **errp);
 
 /**
+ * Split the incoming buffered stream so that the QMP monitor queue is not
+ * overwhelmed with requests. The function looks for the last paired
+ * brace/bracket in a JSON command.
+ */
+int qemu_chr_end_position(const char *buf, int size, JSONthrottle *thl);
+
+/**
  * qemu_chr_cleanup:
  *
  * Delete all chardevs (when leaving qemu)
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 84222cd..43d2d3b 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -566,7 +566,7 @@ int monitor_can_read(void *opaque)
 {
     Monitor *mon = opaque;
 
-    return !qatomic_mb_read(&mon->suspend_cnt);
+    return !qatomic_mb_read(&mon->suspend_cnt) ? CHR_READ_BUF_LEN : 0;
 }
 
 void monitor_list_append(Monitor *mon)
diff --git a/tests/qemu-iotests/247.out b/tests/qemu-iotests/247.out
index 13d9547..2758662 100644
--- a/tests/qemu-iotests/247.out
+++ b/tests/qemu-iotests/247.out
@@ -12,12 +12,12 @@ QMP_VERSION
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
 {"return": {}}
+{"return": {"status": "running", "singlestep": false, "running": true}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "job0", "len": 134217728, "offset": 134217728, "speed": 0, "type": "commit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job0"}}
-{"return": {"status": "running", "singlestep": false, "running": true}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 *** done
-- 
1.8.3.1


