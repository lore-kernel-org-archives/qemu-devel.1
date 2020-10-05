Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D163C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:07:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EA7420663
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iod20w0B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EA7420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPT1Y-0002DK-8h
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 12:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kPStR-0000CK-GW
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:59:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42271)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kPStO-000288-9x
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601913553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6c3JTy10zVwmTkN/zW5dDg0rT+ZIfMNExw3tvGUTl3g=;
 b=iod20w0B+gPLzSauWGRsJedw2+gsP+q02iI46gX9bjHWPFACHHs2a45zEXF+ddYBkcDA6J
 EgcCma/ZQZJCLPLfBY1Q/eXuZMM5SYGwunjadgLNOXGOIJit5Q800/qzS4vkCXCoghS+z3
 glwbIyt5oIhXE2+GUmJ2J9CTWBydajU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-w6WFvOPzN-KWwIOZgApXSw-1; Mon, 05 Oct 2020 11:59:11 -0400
X-MC-Unique: w6WFvOPzN-KWwIOZgApXSw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC5011084D61;
 Mon,  5 Oct 2020 15:59:10 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-145.ams2.redhat.com
 [10.36.113.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7584D65F5E;
 Mon,  5 Oct 2020 15:59:09 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v8 02/14] monitor: Add Monitor parameter to
 monitor_get_cpu_index()
Date: Mon,  5 Oct 2020 17:58:43 +0200
Message-Id: <20201005155855.256490-3-kwolf@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 02:11:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
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
Cc: kwolf@redhat.com, marcandre.lureau@gmail.com, armbru@redhat.com,
 stefanha@redhat.com, qemu-devel@nongnu.org
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
index 04f472ac4f..93bedf0b75 100644
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
index f4092b98cc..6357be9c6b 100644
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
index 0c0a03f824..9789f4277f 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -1009,7 +1009,7 @@ void hmp_memsave(Monitor *mon, const QDict *qdict)
     const char *filename = qdict_get_str(qdict, "filename");
     uint64_t addr = qdict_get_int(qdict, "val");
     Error *err = NULL;
-    int cpu_index = monitor_get_cpu_index();
+    int cpu_index = monitor_get_cpu_index(mon);
 
     if (cpu_index < 0) {
         monitor_printf(mon, "No CPU available\n");
diff --git a/monitor/misc.c b/monitor/misc.c
index 25b42593cc..4ea575eea8 100644
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
index ac8940d52e..12e54f9010 100644
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


