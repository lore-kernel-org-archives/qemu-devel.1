Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358B9C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 15:20:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A310422286
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 15:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ir+7FuWx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A310422286
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG1ta-0005cD-Mh
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 11:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kG1lb-00013B-TQ
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 11:12:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22012)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kG1lZ-0003lP-Sc
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 11:12:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599664328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8EXGXnlOMCYuzVZ0885U5nv9lmo4TUQHX2VTkm7nf10=;
 b=Ir+7FuWxcP4ksnTiHDuB7qt0yiURJes4Rc143bFkZGppylvkKtQrIvLbnyeLT+LcJK8ACh
 tK8NzfZLbQ4QVhGbuEE+KYNeTf+gEtMl15u3P/Fe4z4reFvr+hS5IfI4zbp19g8+zlsTh4
 TaVhKTi/DnCKiOdbJM0tOGIkDTqIbZ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-XtGRFi6oO16zoCwmHnyfrQ-1; Wed, 09 Sep 2020 11:12:06 -0400
X-MC-Unique: XtGRFi6oO16zoCwmHnyfrQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2B0C8015A4;
 Wed,  9 Sep 2020 15:12:05 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-221.ams2.redhat.com
 [10.36.113.221])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2F15C60C07;
 Wed,  9 Sep 2020 15:12:04 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v7 04/13] hmp: Update current monitor only in
 handle_hmp_command()
Date: Wed,  9 Sep 2020 17:11:40 +0200
Message-Id: <20200909151149.490589-5-kwolf@redhat.com>
In-Reply-To: <20200909151149.490589-1-kwolf@redhat.com>
References: <20200909151149.490589-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:25:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 marcandre.lureau@gmail.com, stefanha@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The current monitor is updated relatively early in the command handling
code even though only the command handler actually needs it.

The current monitor will become coroutine-local later, so we can only
update it when we know in which coroutine the command will be exectued.
Move it to handle_hmp_command() where this information will be
available.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 monitor/hmp.c  | 10 +++++-----
 monitor/misc.c |  5 -----
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/monitor/hmp.c b/monitor/hmp.c
index 561e32d02f..896c670183 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1061,6 +1061,7 @@ void handle_hmp_command(MonitorHMP *mon, const char *cmdline)
     QDict *qdict;
     const HMPCommand *cmd;
     const char *cmd_start = cmdline;
+    Monitor *old_mon;
 
     trace_handle_hmp_command(mon, cmdline);
 
@@ -1079,7 +1080,11 @@ void handle_hmp_command(MonitorHMP *mon, const char *cmdline)
         return;
     }
 
+    /* old_mon is non-NULL when called from qmp_human_monitor_command() */
+    old_mon = monitor_set_cur(&mon->common);
     cmd->cmd(&mon->common, qdict);
+    monitor_set_cur(old_mon);
+
     qobject_unref(qdict);
 }
 
@@ -1301,11 +1306,8 @@ cleanup:
 static void monitor_read(void *opaque, const uint8_t *buf, int size)
 {
     MonitorHMP *mon = container_of(opaque, MonitorHMP, common);
-    Monitor *old_mon;
     int i;
 
-    old_mon = monitor_set_cur(&mon->common);
-
     if (mon->rs) {
         for (i = 0; i < size; i++) {
             readline_handle_byte(mon->rs, buf[i]);
@@ -1317,8 +1319,6 @@ static void monitor_read(void *opaque, const uint8_t *buf, int size)
             handle_hmp_command(mon, (char *)buf);
         }
     }
-
-    monitor_set_cur(old_mon);
 }
 
 static void monitor_event(void *opaque, QEMUChrEvent event)
diff --git a/monitor/misc.c b/monitor/misc.c
index a5eb3025f8..ba1063024c 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -120,17 +120,13 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
                                 int64_t cpu_index, Error **errp)
 {
     char *output = NULL;
-    Monitor *old_mon;
     MonitorHMP hmp = {};
 
     monitor_data_init(&hmp.common, false, true, false);
 
-    old_mon = monitor_set_cur(&hmp.common);
-
     if (has_cpu_index) {
         int ret = monitor_set_cpu(&hmp.common, cpu_index);
         if (ret < 0) {
-            monitor_set_cur(old_mon);
             error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cpu-index",
                        "a CPU number");
             goto out;
@@ -138,7 +134,6 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
     }
 
     handle_hmp_command(&hmp, command_line);
-    monitor_set_cur(old_mon);
 
     qemu_mutex_lock(&hmp.common.mon_lock);
     if (qstring_get_length(hmp.common.outbuf) > 0) {
-- 
2.25.4


