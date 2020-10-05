Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D86EC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:06:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3BF220663
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BkUzzi9H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3BF220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPT0k-0001Ev-To
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 12:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kPStU-0000LF-4t
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:59:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33318)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kPStS-00028x-8y
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:59:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601913557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gt32NBO3sXET1DxWl+fYeN2DGnRXHsVKHZKbDzzHXFY=;
 b=BkUzzi9Hqo8GuA+1T0tI3j9MaTv8JZ5qKMY2iIbqCCCfqtUiqgWNkV7+49Wjg2W2SRmcB2
 6dqewR5tE4udaExNTPNIMGQdHtuSp6UgwBwHaYm28SFwgccsV0nt6FqGCIpPcrMeL1wTsd
 rvIdE49j1k+loetOSvbEreeztyrf1mE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-bhMgweZuOt2-ZoRy0FihJQ-1; Mon, 05 Oct 2020 11:59:15 -0400
X-MC-Unique: bhMgweZuOt2-ZoRy0FihJQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5302E64085;
 Mon,  5 Oct 2020 15:59:14 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-145.ams2.redhat.com
 [10.36.113.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC3CE65F5E;
 Mon,  5 Oct 2020 15:59:12 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v8 04/14] hmp: Update current monitor only in
 handle_hmp_command()
Date: Mon,  5 Oct 2020 17:58:45 +0200
Message-Id: <20201005155855.256490-5-kwolf@redhat.com>
In-Reply-To: <20201005155855.256490-1-kwolf@redhat.com>
References: <20201005155855.256490-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 01:25:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
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
Cc: kwolf@redhat.com, marcandre.lureau@gmail.com, armbru@redhat.com,
 stefanha@redhat.com, qemu-devel@nongnu.org
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
index e0cc9e65dd..560ec98e7b 100644
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
index ee8db45094..4a859fb24a 100644
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
 
     WITH_QEMU_LOCK_GUARD(&hmp.common.mon_lock) {
         if (qstring_get_length(hmp.common.outbuf) > 0) {
-- 
2.25.4


