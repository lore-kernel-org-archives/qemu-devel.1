Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068E3C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 15:30:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C71D72083E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 15:30:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C71D72083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50743 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEbek-0001NO-RQ
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 11:30:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hEbZv-0005f8-Cl
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:25:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hEbZs-0006Y3-LE
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:25:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hEbZs-0006Va-9r
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:25:24 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9325A307AD04
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 15:25:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6086C19C58;
	Thu, 11 Apr 2019 15:25:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 8C0E01132B38; Thu, 11 Apr 2019 17:25:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Apr 2019 17:25:08 +0200
Message-Id: <20190411152520.10061-6-armbru@redhat.com>
In-Reply-To: <20190411152520.10061-1-armbru@redhat.com>
References: <20190411152520.10061-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Thu, 11 Apr 2019 15:25:23 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 05/17] tcg: Simplify how dump_drift_info()
 prints
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
Message-ID: <20190411152508.wpriC6POFeW6RRjSQFRZqPND5Tsgk7KSL_8gdYtgRlk@z>

dump_drift_info() takes an fprintf()-like callback and a FILE * to pass
to it.

Its only caller hmp_info_jit() passes monitor_fprintf() and a Monitor
* cast to FILE *.  monitor_fprintf() casts it right back, and is
otherwise identical to monitor_printf().  The type-punning is ugly.

Drop the callback, and call qemu_printf() instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 cpus.c                | 15 +++++++++------
 include/sysemu/cpus.h |  2 +-
 monitor.c             |  2 +-
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/cpus.c b/cpus.c
index e83f72b48b..684aa9679a 100644
--- a/cpus.c
+++ b/cpus.c
@@ -31,6 +31,7 @@
 #include "qapi/qapi-events-run-state.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
+#include "qemu/qemu-print.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/block-backend.h"
 #include "exec/gdbstub.h"
@@ -2454,19 +2455,21 @@ void qmp_inject_nmi(Error **errp)
     nmi_monitor_handle(monitor_get_cpu_index(), errp);
 }
 
-void dump_drift_info(FILE *f, fprintf_function cpu_fprintf)
+void dump_drift_info(void)
 {
     if (!use_icount) {
         return;
     }
 
-    cpu_fprintf(f, "Host - Guest clock  %"PRIi64" ms\n",
+    qemu_printf("Host - Guest clock  %"PRIi64" ms\n",
                 (cpu_get_clock() - cpu_get_icount())/SCALE_MS);
     if (icount_align_option) {
-        cpu_fprintf(f, "Max guest delay     %"PRIi64" ms\n", -max_delay/SCALE_MS);
-        cpu_fprintf(f, "Max guest advance   %"PRIi64" ms\n", max_advance/SCALE_MS);
+        qemu_printf("Max guest delay     %"PRIi64" ms\n",
+                    -max_delay / SCALE_MS);
+        qemu_printf("Max guest advance   %"PRIi64" ms\n",
+                    max_advance / SCALE_MS);
     } else {
-        cpu_fprintf(f, "Max guest delay     NA\n");
-        cpu_fprintf(f, "Max guest advance   NA\n");
+        qemu_printf("Max guest delay     NA\n");
+        qemu_printf("Max guest advance   NA\n");
     }
 }
diff --git a/include/sysemu/cpus.h b/include/sysemu/cpus.h
index eea0010b53..ef13a120cc 100644
--- a/include/sysemu/cpus.h
+++ b/include/sysemu/cpus.h
@@ -19,7 +19,7 @@ extern int icount_align_option;
 /* drift information for info jit command */
 extern int64_t max_delay;
 extern int64_t max_advance;
-void dump_drift_info(FILE *f, fprintf_function cpu_fprintf);
+void dump_drift_info(void);
 
 /* Unblock cpu */
 void qemu_cpu_kick_self(void);
diff --git a/monitor.c b/monitor.c
index 24e4d49d11..7573689585 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1319,7 +1319,7 @@ static void hmp_info_jit(Monitor *mon, const QDict *qdict)
     }
 
     dump_exec_info();
-    dump_drift_info((FILE *)mon, monitor_fprintf);
+    dump_drift_info();
 }
 
 static void hmp_info_opcount(Monitor *mon, const QDict *qdict)
-- 
2.17.2


