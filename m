Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017BFC2D0C1
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 16:09:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4D6E206D8
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 16:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="OopHGsxZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4D6E206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihyMr-0005J3-N9
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 11:09:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41120)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1ihyLc-0003uS-Na
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 11:08:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1ihyLZ-0006Fl-Ns
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 11:08:19 -0500
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:46866)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
 id 1ihyLZ-000615-3b
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 11:08:17 -0500
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net
 [IPv6:2a02:6b8:0:1a2d::301])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 81BF52E1493;
 Thu, 19 Dec 2019 19:08:14 +0300 (MSK)
Received: from vla5-58875c36c028.qloud-c.yandex.net
 (vla5-58875c36c028.qloud-c.yandex.net [2a02:6b8:c18:340b:0:640:5887:5c36])
 by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 0yeyPctI5T-8DHaLskw; Thu, 19 Dec 2019 19:08:14 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1576771694; bh=z2hT4uxB4lgvxQPgqzPtE0H3GBeW1yfyZNoga34aikw=;
 h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
 b=OopHGsxZLH5Gp5DC6zKNHy/fW949kWjMzxzYet1qIeni5M4XxQUqOuyXMX7bJ9M2x
 VzIsP/xNXjBeQipuKiS9YHLwLEQJywc8LxgP1wpFtSF+pHmZlr202RpNoWYiGWCERq
 +nIDwqyO6vi+8S9iQWFPJJXbiZWetZgDWBAQ3rbM=
Authentication-Results: mxbackcorp1o.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
 [2a02:6b8:0:408:9915:7a93:bd7b:686c])
 by vla5-58875c36c028.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 FfZMqtXGzo-8DWengHw; Thu, 19 Dec 2019 19:08:13 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] monitor: Add an input buffer for QMP reading
Date: Thu, 19 Dec 2019 19:07:56 +0300
Message-Id: <20191219160756.22389-3-yury-kotov@yandex-team.ru>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219160756.22389-1-yury-kotov@yandex-team.ru>
References: <20191219160756.22389-1-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 77.88.29.217
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
Cc: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, yc-core@yandex-team.ru,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The monitor_qmp_can_read (as a callback of qemu_chr_fe_set_handlers)
should return size of buffer which monitor_qmp_read can process.
Currently, monitor_can_read returns 1, because it guarantees that
only one QMP command can be handled at a time.
Thus, for each QMP command, len(QMD) iterations of the main loop
are required to handle a command.

This patch adds an input buffer to speed up reading and to keep
the guarantee of executing one command at a time.

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
---
 monitor/monitor-internal.h | 11 +++++++++++
 monitor/monitor.c          | 27 +++++++++++++++++++++++++++
 monitor/qmp.c              | 17 +++++++++++++++--
 3 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index c0ba29abf1..22983b9dda 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -32,6 +32,8 @@
 #include "qemu/readline.h"
 #include "sysemu/iothread.h"
=20
+#define MON_INPUT_BUFFER_SIZE   1024
+
 /*
  * Supported types:
  *
@@ -93,6 +95,11 @@ struct Monitor {
     gchar *mon_cpu_path;
     QTAILQ_ENTRY(Monitor) entry;
=20
+    /* Must be accessed only by monitor's iothread */
+    char inbuf[MON_INPUT_BUFFER_SIZE];
+    int inbuf_pos;
+    int inbuf_len;
+
     /*
      * The per-monitor lock. We can't access guest memory when holding
      * the lock.
@@ -169,9 +176,13 @@ void monitor_data_destroy(Monitor *mon);
 void monitor_list_append(Monitor *mon);
 void monitor_fdsets_cleanup(void);
=20
+void monitor_inbuf_write(Monitor *mon, const char *buf, int size);
+int monitor_inbuf_read(Monitor *mon, char *buf, int size);
+
 void qmp_send_response(MonitorQMP *mon, const QDict *rsp);
 void monitor_data_destroy_qmp(MonitorQMP *mon);
 void monitor_qmp_bh_dispatcher(void *data);
+void monitor_qmp_handle_inbuf(Monitor *mon);
=20
 int get_monitor_def(int64_t *pval, const char *name);
 void help_cmd(Monitor *mon, const char *name);
diff --git a/monitor/monitor.c b/monitor/monitor.c
index d25cc8ea4a..9eb258ac2f 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -440,6 +440,29 @@ static gboolean qapi_event_throttle_equal(const void=
 *a, const void *b)
     return TRUE;
 }
=20
+void monitor_inbuf_write(Monitor *mon, const char *buf, int size)
+{
+    int pos =3D mon->inbuf_pos + mon->inbuf_len;
+
+    assert(size <=3D sizeof(mon->inbuf) - mon->inbuf_len);
+    while (size-- > 0) {
+        mon->inbuf[pos++ % sizeof(mon->inbuf)] =3D *buf++;
+        mon->inbuf_len++;
+    }
+}
+
+int monitor_inbuf_read(Monitor *mon, char *buf, int size)
+{
+    int read_bytes =3D 0;
+
+    while (read_bytes < size && mon->inbuf_len > 0) {
+        buf[read_bytes++] =3D mon->inbuf[mon->inbuf_pos++];
+        mon->inbuf_pos %=3D sizeof(mon->inbuf);
+        mon->inbuf_len--;
+    }
+    return read_bytes;
+}
+
 int monitor_suspend(Monitor *mon)
 {
     if (monitor_is_hmp_non_interactive(mon)) {
@@ -465,6 +488,10 @@ static void monitor_accept_input(void *opaque)
     Monitor *mon =3D opaque;
=20
     qemu_chr_fe_accept_input(&mon->chr);
+
+    if (mon->is_qmp) {
+        monitor_qmp_handle_inbuf(mon);
+    }
 }
=20
 void monitor_resume(Monitor *mon)
diff --git a/monitor/qmp.c b/monitor/qmp.c
index 37884c6c43..9d2634eeb3 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -315,14 +315,27 @@ static int monitor_qmp_can_read(void *opaque)
 {
     Monitor *mon =3D opaque;
=20
-    return !atomic_mb_read(&mon->suspend_cnt);
+    return sizeof(mon->inbuf) - mon->inbuf_len;
+}
+
+void monitor_qmp_handle_inbuf(Monitor *mon)
+{
+    MonitorQMP *mon_qmp =3D container_of(mon, MonitorQMP, common);
+    char ch;
+
+    /* Handle only one byte at a time, because monitor may become suspen=
ed */
+    while (!atomic_mb_read(&mon->suspend_cnt) &&
+           monitor_inbuf_read(mon, &ch, 1)) {
+        json_message_parser_feed(&mon_qmp->parser, &ch, 1);
+    }
 }
=20
 static void monitor_qmp_read(void *opaque, const uint8_t *buf, int size)
 {
     MonitorQMP *mon =3D opaque;
=20
-    json_message_parser_feed(&mon->parser, (const char *) buf, size);
+    monitor_inbuf_write(&mon->common, (const char *)buf, size);
+    monitor_qmp_handle_inbuf(&mon->common);
 }
=20
 static QDict *qmp_greeting(MonitorQMP *mon)
--=20
2.24.1


