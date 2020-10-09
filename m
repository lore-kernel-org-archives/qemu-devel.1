Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0912C43467
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 06:37:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38A3A22254
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 06:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GiAZM9i8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A3A22254
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQm1T-0003ve-Vz
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 02:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQlzH-0001xb-Rb
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 02:34:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51956)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQlzF-0008UQ-SR
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 02:34:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602225280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XdXfbd71VnvQSGDTayJ67mVOXGGwmcfjlhu8p5Zlhm0=;
 b=GiAZM9i8rXyjieuNiDWXgu7yLnqX3m0u6Bq+XX/6uesgWj1qRHUHRp5A1HNrwEWbVdmR0q
 pOHRyZp8Ejn6lw3ok2Pl2H3HLXPki8BljtPqJWcFGE0kbEHoY8Lfqqkgs7GzelxgyCKyVA
 PYYfNo/yB/N8DGj7oAdVELswZADVlNA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-Hz_ieRKTPGyfIbB3GXYYpA-1; Fri, 09 Oct 2020 02:34:38 -0400
X-MC-Unique: Hz_ieRKTPGyfIbB3GXYYpA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 053E218BA288
 for <qemu-devel@nongnu.org>; Fri,  9 Oct 2020 06:34:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9BF6460BFA;
 Fri,  9 Oct 2020 06:34:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0750F112CE12; Fri,  9 Oct 2020 08:34:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/14] monitor: Add Monitor parameter to monitor_set_cpu()
Date: Fri,  9 Oct 2020 08:34:19 +0200
Message-Id: <20201009063432.303441-2-armbru@redhat.com>
In-Reply-To: <20201009063432.303441-1-armbru@redhat.com>
References: <20201009063432.303441-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
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
Cc: kwolf@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kevin Wolf <kwolf@redhat.com>

Most callers actually don't have to rely on cur_mon, but already know
for which monitor they call monitor_set_cpu().

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20201005155855.256490-2-kwolf@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/monitor/monitor.h |  2 +-
 monitor/hmp-cmds.c        |  2 +-
 monitor/misc.c            | 10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index c0170773d4..04f472ac4f 100644
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
index dc0de39219..0c0a03f824 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -998,7 +998,7 @@ void hmp_cpu(Monitor *mon, const QDict *qdict)
     /* XXX: drop the monitor_set_cpu() usage when all HMP commands that
             use it are converted to the QAPI */
     cpu_index = qdict_get_int(qdict, "index");
-    if (monitor_set_cpu(cpu_index) < 0) {
+    if (monitor_set_cpu(mon, cpu_index) < 0) {
         monitor_printf(mon, "invalid CPU index\n");
     }
 }
diff --git a/monitor/misc.c b/monitor/misc.c
index 6e0da0cb96..25b42593cc 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -129,7 +129,7 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
     cur_mon = &hmp.common;
 
     if (has_cpu_index) {
-        int ret = monitor_set_cpu(cpu_index);
+        int ret = monitor_set_cpu(&hmp.common, cpu_index);
         if (ret < 0) {
             cur_mon = old_mon;
             error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cpu-index",
@@ -255,7 +255,7 @@ static void monitor_init_qmp_commands(void)
 }
 
 /* Set the current CPU defined by the user. Callers must hold BQL. */
-int monitor_set_cpu(int cpu_index)
+int monitor_set_cpu(Monitor *mon, int cpu_index)
 {
     CPUState *cpu;
 
@@ -263,8 +263,8 @@ int monitor_set_cpu(int cpu_index)
     if (cpu == NULL) {
         return -1;
     }
-    g_free(cur_mon->mon_cpu_path);
-    cur_mon->mon_cpu_path = object_get_canonical_path(OBJECT(cpu));
+    g_free(mon->mon_cpu_path);
+    mon->mon_cpu_path = object_get_canonical_path(OBJECT(cpu));
     return 0;
 }
 
@@ -285,7 +285,7 @@ static CPUState *mon_get_cpu_sync(bool synchronize)
         if (!first_cpu) {
             return NULL;
         }
-        monitor_set_cpu(first_cpu->cpu_index);
+        monitor_set_cpu(cur_mon, first_cpu->cpu_index);
         cpu = first_cpu;
     }
     assert(cpu != NULL);
-- 
2.26.2


