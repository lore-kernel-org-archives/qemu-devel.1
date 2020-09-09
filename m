Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F69C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 15:18:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69A5222284
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 15:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PsA4wsf+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69A5222284
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG1s3-00036M-EB
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 11:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kG1la-0000xX-16
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 11:12:10 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51705
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kG1lY-0003lI-E8
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 11:12:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599664327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4YY/hDRmj2Wi2iM+XoQYflo+4uFEGUMSQ1k4k6cc6qo=;
 b=PsA4wsf+8uzxYWhQzrHYxBbl4nt988M0Oyxomdi0XH9cNNlxfjXawaEQJPsYgR/+GAAQ5U
 Jr2mziEedrJIbUeQ9lp4s7f84/lQ2LV6LF2SdDnXAnbI3g5PnCtDTuh2xqSa9q1LH72EX6
 BB2xTKUqqTfYdHly5t9mwfgQN9XBMPM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-8AkW2gnTM0CaTJdMbhTtxw-1; Wed, 09 Sep 2020 11:12:03 -0400
X-MC-Unique: 8AkW2gnTM0CaTJdMbhTtxw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0270801AE5;
 Wed,  9 Sep 2020 15:12:01 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-221.ams2.redhat.com
 [10.36.113.221])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7E13260BEC;
 Wed,  9 Sep 2020 15:12:00 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v7 02/13] monitor: Add Monitor parameter to
 monitor_get_cpu_index()
Date: Wed,  9 Sep 2020 17:11:38 +0200
Message-Id: <20200909151149.490589-3-kwolf@redhat.com>
In-Reply-To: <20200909151149.490589-1-kwolf@redhat.com>
References: <20200909151149.490589-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 02:43:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Most callers actually don't have to rely on cur_mon, but already know
for which monitor they call monitor_get_cpu_index().

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/monitor/monitor.h  |  2 +-
 hw/core/machine-hmp-cmds.c |  2 +-
 monitor/hmp-cmds.c         |  2 +-
 monitor/misc.c             | 20 ++++++++++----------
 softmmu/cpus.c             |  2 +-
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 0dcaefd4f9..a64502fbb2 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -34,7 +34,7 @@ int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
 int monitor_printf(Monitor *mon, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
 void monitor_flush(Monitor *mon);
 int monitor_set_cpu(Monitor *mon, int cpu_index);
-int monitor_get_cpu_index(void);
+int monitor_get_cpu_index(Monitor *mon);
 
 void monitor_read_command(MonitorHMP *mon, int show_prompt);
 int monitor_read_password(MonitorHMP *mon, ReadLineFunc *readline_func,
diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
index 39999c47c5..da7d2e27b6 100644
--- a/hw/core/machine-hmp-cmds.c
+++ b/hw/core/machine-hmp-cmds.c
@@ -34,7 +34,7 @@ void hmp_info_cpus(Monitor *mon, const QDict *qdict)
     for (cpu = cpu_list; cpu; cpu = cpu->next) {
         int active = ' ';
 
-        if (cpu->value->cpu_index == monitor_get_cpu_index()) {
+        if (cpu->value->cpu_index == monitor_get_cpu_index(mon)) {
             active = '*';
         }
 
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index f608b5b27b..1e5e611ed9 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -1007,7 +1007,7 @@ void hmp_memsave(Monitor *mon, const QDict *qdict)
     const char *filename = qdict_get_str(qdict, "filename");
     uint64_t addr = qdict_get_int(qdict, "val");
     Error *err = NULL;
-    int cpu_index = monitor_get_cpu_index();
+    int cpu_index = monitor_get_cpu_index(mon);
 
     if (cpu_index < 0) {
         monitor_printf(mon, "No CPU available\n");
diff --git a/monitor/misc.c b/monitor/misc.c
index b4f779b8d3..972726061c 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -269,23 +269,23 @@ int monitor_set_cpu(Monitor *mon, int cpu_index)
 }
 
 /* Callers must hold BQL. */
-static CPUState *mon_get_cpu_sync(bool synchronize)
+static CPUState *mon_get_cpu_sync(Monitor *mon, bool synchronize)
 {
     CPUState *cpu = NULL;
 
-    if (cur_mon->mon_cpu_path) {
-        cpu = (CPUState *) object_resolve_path_type(cur_mon->mon_cpu_path,
+    if (mon->mon_cpu_path) {
+        cpu = (CPUState *) object_resolve_path_type(mon->mon_cpu_path,
                                                     TYPE_CPU, NULL);
         if (!cpu) {
-            g_free(cur_mon->mon_cpu_path);
-            cur_mon->mon_cpu_path = NULL;
+            g_free(mon->mon_cpu_path);
+            mon->mon_cpu_path = NULL;
         }
     }
-    if (!cur_mon->mon_cpu_path) {
+    if (!mon->mon_cpu_path) {
         if (!first_cpu) {
             return NULL;
         }
-        monitor_set_cpu(cur_mon, first_cpu->cpu_index);
+        monitor_set_cpu(mon, first_cpu->cpu_index);
         cpu = first_cpu;
     }
     assert(cpu != NULL);
@@ -297,7 +297,7 @@ static CPUState *mon_get_cpu_sync(bool synchronize)
 
 CPUState *mon_get_cpu(void)
 {
-    return mon_get_cpu_sync(true);
+    return mon_get_cpu_sync(cur_mon, true);
 }
 
 CPUArchState *mon_get_cpu_env(void)
@@ -307,9 +307,9 @@ CPUArchState *mon_get_cpu_env(void)
     return cs ? cs->env_ptr : NULL;
 }
 
-int monitor_get_cpu_index(void)
+int monitor_get_cpu_index(Monitor *mon)
 {
-    CPUState *cs = mon_get_cpu_sync(false);
+    CPUState *cs = mon_get_cpu_sync(mon, false);
 
     return cs ? cs->cpu_index : UNASSIGNED_CPU_INDEX;
 }
diff --git a/softmmu/cpus.c b/softmmu/cpus.c
index e3b98065c9..ae643447e9 100644
--- a/softmmu/cpus.c
+++ b/softmmu/cpus.c
@@ -2224,7 +2224,7 @@ exit:
 
 void qmp_inject_nmi(Error **errp)
 {
-    nmi_monitor_handle(monitor_get_cpu_index(), errp);
+    nmi_monitor_handle(monitor_get_cpu_index(cur_mon), errp);
 }
 
 void dump_drift_info(void)
-- 
2.25.4


