Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774C0C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 15:36:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B54B2083E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 15:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B54B2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50866 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEbkn-0006wL-If
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 11:36:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hEbZz-0005ku-65
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:25:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hEbZx-0006hk-5V
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:25:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hEbZv-0006Zl-Cp
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:25:28 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 02686307AD04
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 15:25:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C66BA608A5;
	Thu, 11 Apr 2019 15:25:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id BD1DA1132783; Thu, 11 Apr 2019 17:25:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Apr 2019 17:25:18 +0200
Message-Id: <20190411152520.10061-16-armbru@redhat.com>
In-Reply-To: <20190411152520.10061-1-armbru@redhat.com>
References: <20190411152520.10061-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Thu, 11 Apr 2019 15:25:25 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 15/17] monitor: Clean up how monitor_disas()
 funnels output to monitor
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190411152518.CHr6mrVLlTgQOzPAgStt4vT038gtx0W4vqoNybtEVfs@z>

INIT_DISASSEMBLE_INFO() takes an fprintf()-like callback and a FILE *
to pass to it.  monitor_disas() passes monitor_fprintf() and the
current monitor cast to FILE *.  monitor_fprintf() casts it right
back, and is otherwise identical to monitor_printf().  The
type-pinning is ugly.

Pass qemu_fprintf() and NULL instead.

monitor_fprintf() is now unused; delete it.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 disas.c                   |  3 ++-
 include/monitor/monitor.h |  1 -
 monitor.c                 | 11 -----------
 3 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/disas.c b/disas.c
index d9aa713a40..d15cceb863 100644
--- a/disas.c
+++ b/disas.c
@@ -3,6 +3,7 @@
 #include "qemu-common.h"
 #include "disas/bfd.h"
 #include "elf.h"
+#include "qemu/qemu-print.h"
 
 #include "cpu.h"
 #include "disas/disas.h"
@@ -609,7 +610,7 @@ void monitor_disas(Monitor *mon, CPUState *cpu,
     int count, i;
     CPUDebug s;
 
-    INIT_DISASSEMBLE_INFO(s.info, (FILE *)mon, monitor_fprintf);
+    INIT_DISASSEMBLE_INFO(s.info, NULL, qemu_fprintf);
 
     s.cpu = cpu;
     s.info.read_memory_func
diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 316a168c41..86656297f1 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -31,7 +31,6 @@ int monitor_fd_param(Monitor *mon, const char *fdname, Error **errp);
 int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
     GCC_FMT_ATTR(2, 0);
 int monitor_printf(Monitor *mon, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
-int monitor_fprintf(FILE *stream, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
 void monitor_flush(Monitor *mon);
 int monitor_set_cpu(int cpu_index);
 int monitor_get_cpu_index(void);
diff --git a/monitor.c b/monitor.c
index ad6cec54a1..9b5f10b475 100644
--- a/monitor.c
+++ b/monitor.c
@@ -480,17 +480,6 @@ int monitor_printf(Monitor *mon, const char *fmt, ...)
     return ret;
 }
 
-int monitor_fprintf(FILE *stream, const char *fmt, ...)
-{
-    int ret;
-
-    va_list ap;
-    va_start(ap, fmt);
-    ret = monitor_vprintf((Monitor *)stream, fmt, ap);
-    va_end(ap);
-    return ret;
-}
-
 static void qmp_send_response(Monitor *mon, const QDict *rsp)
 {
     const QObject *data = QOBJECT(rsp);
-- 
2.17.2


