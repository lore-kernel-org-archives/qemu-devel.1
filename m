Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76573C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 15:39:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46A35207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 15:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FOHyoR0R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46A35207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeKce-0005Oy-DB
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 11:39:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jeKbZ-0003Uj-M1
 for qemu-devel@nongnu.org; Thu, 28 May 2020 11:38:01 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56318
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jeKbY-0003qL-4T
 for qemu-devel@nongnu.org; Thu, 28 May 2020 11:38:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590680279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4xw4rNKkRFEB5kYS1rc2u91qGGJz0iDVX3Kx3bds5YY=;
 b=FOHyoR0Rfqip9YOA01OZCsrxrT1diUkWKrzGXBXvwxVXsHEGl+is1/ojp4skh/UdT5oGou
 X0cgOYBaV9bGUPL65gIL0Y758B/2Bc9IDnapFbh30ws3eunC/Mb9+OWvA/qVcNHDmu1VT4
 4yObbIVUJarJIQBRRR/+HO63EkAK42Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-vLQkfjpEMu6gJq5c9b6jgQ-1; Thu, 28 May 2020 11:37:57 -0400
X-MC-Unique: vLQkfjpEMu6gJq5c9b6jgQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60D69C7464;
 Thu, 28 May 2020 15:37:48 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-117.ams2.redhat.com
 [10.36.114.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4187A10013C0;
 Thu, 28 May 2020 15:37:47 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v6 01/12] monitor: Add Monitor parameter to monitor_set_cpu()
Date: Thu, 28 May 2020 17:37:31 +0200
Message-Id: <20200528153742.274164-2-kwolf@redhat.com>
In-Reply-To: <20200528153742.274164-1-kwolf@redhat.com>
References: <20200528153742.274164-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 02:50:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Most callers actually don't have to rely on cur_mon, but already know
for which monitor they call monitor_set_cpu().

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/monitor/monitor.h |  2 +-
 monitor/hmp-cmds.c        |  2 +-
 monitor/misc.c            | 10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 1018d754a6..0dcaefd4f9 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -33,7 +33,7 @@ int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
     GCC_FMT_ATTR(2, 0);
 int monitor_printf(Monitor *mon, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
 void monitor_flush(Monitor *mon);
-int monitor_set_cpu(int cpu_index);
+int monitor_set_cpu(Monitor *mon, int cpu_index);
 int monitor_get_cpu_index(void);
 
 void monitor_read_command(MonitorHMP *mon, int show_prompt);
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 9c61e769ca..5e22ee2556 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -969,7 +969,7 @@ void hmp_cpu(Monitor *mon, const QDict *qdict)
     /* XXX: drop the monitor_set_cpu() usage when all HMP commands that
             use it are converted to the QAPI */
     cpu_index = qdict_get_int(qdict, "index");
-    if (monitor_set_cpu(cpu_index) < 0) {
+    if (monitor_set_cpu(mon, cpu_index) < 0) {
         monitor_printf(mon, "invalid CPU index\n");
     }
 }
diff --git a/monitor/misc.c b/monitor/misc.c
index f5207cd242..bdf49e49e5 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -130,7 +130,7 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
     cur_mon = &hmp.common;
 
     if (has_cpu_index) {
-        int ret = monitor_set_cpu(cpu_index);
+        int ret = monitor_set_cpu(&hmp.common, cpu_index);
         if (ret < 0) {
             cur_mon = old_mon;
             error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cpu-index",
@@ -256,7 +256,7 @@ static void monitor_init_qmp_commands(void)
 }
 
 /* Set the current CPU defined by the user. Callers must hold BQL. */
-int monitor_set_cpu(int cpu_index)
+int monitor_set_cpu(Monitor *mon, int cpu_index)
 {
     CPUState *cpu;
 
@@ -264,8 +264,8 @@ int monitor_set_cpu(int cpu_index)
     if (cpu == NULL) {
         return -1;
     }
-    g_free(cur_mon->mon_cpu_path);
-    cur_mon->mon_cpu_path = object_get_canonical_path(OBJECT(cpu));
+    g_free(mon->mon_cpu_path);
+    mon->mon_cpu_path = object_get_canonical_path(OBJECT(cpu));
     return 0;
 }
 
@@ -286,7 +286,7 @@ static CPUState *mon_get_cpu_sync(bool synchronize)
         if (!first_cpu) {
             return NULL;
         }
-        monitor_set_cpu(first_cpu->cpu_index);
+        monitor_set_cpu(cur_mon, first_cpu->cpu_index);
         cpu = first_cpu;
     }
     assert(cpu != NULL);
-- 
2.25.4


