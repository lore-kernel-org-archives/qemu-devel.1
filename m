Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159A6C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 15:39:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA483207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 15:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EWQa5oU4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA483207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeKch-0005ZT-Ut
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 11:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jeKba-0003VX-30
 for qemu-devel@nongnu.org; Thu, 28 May 2020 11:38:02 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57294
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jeKbY-0003rd-Ul
 for qemu-devel@nongnu.org; Thu, 28 May 2020 11:38:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590680280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IaYfUg0LoZ4HbRDH1lcQFLzl/VwdwL4XsBE6SSYAbK8=;
 b=EWQa5oU4jNY4E8Ds92fRbUEq+PupUj/ydCMEJoUalBeeD6RJNAFTQHI9uyFqsVDUo3s+pc
 UThpBpsUa2npRetqQKCV/FVVFMwZvLHOr+L9pIyWMv0yuOouo1m/fbgpdCBT1jHjV6mc6A
 +ahqOe2oeFm/DKAnL7sb3JL9+vtoUxU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-WnekTmMBOri-NMyeoBePxQ-1; Thu, 28 May 2020 11:37:58 -0400
X-MC-Unique: WnekTmMBOri-NMyeoBePxQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69D97EC1C9;
 Thu, 28 May 2020 15:37:51 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-117.ams2.redhat.com
 [10.36.114.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 48C1410013C0;
 Thu, 28 May 2020 15:37:50 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v6 03/12] hmp: Set cur_mon only in handle_hmp_command()
Date: Thu, 28 May 2020 17:37:33 +0200
Message-Id: <20200528153742.274164-4-kwolf@redhat.com>
In-Reply-To: <20200528153742.274164-1-kwolf@redhat.com>
References: <20200528153742.274164-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 06:31:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

cur_mon is updated relatively early in the command handling code even
though only the command handler actually needs it. Move it to
handle_hmp_command().

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 monitor/hmp.c  | 23 ++++++++++++-----------
 monitor/misc.c |  7 -------
 2 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/monitor/hmp.c b/monitor/hmp.c
index f609fcf75b..79be6f26de 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1061,6 +1061,7 @@ void handle_hmp_command(MonitorHMP *mon, const char *cmdline)
     QDict *qdict;
     const HMPCommand *cmd;
     const char *cmd_start = cmdline;
+    Monitor *old_mon;
 
     trace_handle_hmp_command(mon, cmdline);
 
@@ -1079,7 +1080,12 @@ void handle_hmp_command(MonitorHMP *mon, const char *cmdline)
         return;
     }
 
+    /* old_mon is non-NULL when called from qmp_human_monitor_command() */
+    old_mon = monitor_cur();
+    monitor_set_cur(&mon->common);
     cmd->cmd(&mon->common, qdict);
+    monitor_set_cur(old_mon);
+
     qobject_unref(qdict);
 }
 
@@ -1300,26 +1306,21 @@ cleanup:
 
 static void monitor_read(void *opaque, const uint8_t *buf, int size)
 {
-    MonitorHMP *mon;
-    Monitor *old_mon = monitor_cur();
+    Monitor *mon = opaque;
+    MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, common);
     int i;
 
-    monitor_set_cur(opaque);
-    mon = container_of(monitor_cur(), MonitorHMP, common);
-
-    if (mon->rs) {
+    if (hmp_mon->rs) {
         for (i = 0; i < size; i++) {
-            readline_handle_byte(mon->rs, buf[i]);
+            readline_handle_byte(hmp_mon->rs, buf[i]);
         }
     } else {
         if (size == 0 || buf[size - 1] != 0) {
-            monitor_printf(&mon->common, "corrupted command\n");
+            monitor_printf(mon, "corrupted command\n");
         } else {
-            handle_hmp_command(mon, (char *)buf);
+            handle_hmp_command(hmp_mon, (char *)buf);
         }
     }
-
-    monitor_set_cur(old_mon);
 }
 
 static void monitor_event(void *opaque, QEMUChrEvent event)
diff --git a/monitor/misc.c b/monitor/misc.c
index 6cf7f60872..e0ab265726 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -121,18 +121,13 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
                                 int64_t cpu_index, Error **errp)
 {
     char *output = NULL;
-    Monitor *old_mon;
     MonitorHMP hmp = {};
 
     monitor_data_init(&hmp.common, false, true, false);
 
-    old_mon = monitor_cur();
-    monitor_set_cur(&hmp.common);
-
     if (has_cpu_index) {
         int ret = monitor_set_cpu(&hmp.common, cpu_index);
         if (ret < 0) {
-            monitor_set_cur(old_mon);
             error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cpu-index",
                        "a CPU number");
             goto out;
@@ -140,7 +135,6 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
     }
 
     handle_hmp_command(&hmp, command_line);
-    monitor_set_cur(old_mon);
 
     qemu_mutex_lock(&hmp.common.mon_lock);
     if (qstring_get_length(hmp.common.outbuf) > 0) {
@@ -258,7 +252,6 @@ static void monitor_init_qmp_commands(void)
 /* Set the current CPU defined by the user. Callers must hold BQL. */
 int monitor_set_cpu(Monitor *mon, int cpu_index)
 {
-    Monitor *cur_mon = monitor_cur();
     CPUState *cpu;
 
     cpu = qemu_get_cpu(cpu_index);
-- 
2.25.4


