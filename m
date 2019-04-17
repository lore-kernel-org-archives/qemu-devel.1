Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BECC282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 19:24:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8BBF20656
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 19:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8BBF20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58369 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGqAN-0004Nv-TT
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 15:24:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGq4Q-0008Nf-TR
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:18:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGq4O-0008NH-L8
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:18:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hGq4O-0008LO-7t
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:18:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 34DE681F12
	for <qemu-devel@nongnu.org>; Wed, 17 Apr 2019 19:18:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id F0FE05C22D;
	Wed, 17 Apr 2019 19:18:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 738351132BD3; Wed, 17 Apr 2019 21:18:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 17 Apr 2019 21:17:50 +0200
Message-Id: <20190417191805.28198-3-armbru@redhat.com>
In-Reply-To: <20190417191805.28198-1-armbru@redhat.com>
References: <20190417191805.28198-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Wed, 17 Apr 2019 19:18:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 02/17] trace: Simplify how
 st_print_trace_file_status() prints
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
Message-ID: <20190417191750.k3gpwOEMf2eS1YRhuAaPAWQU7rpZLUPBtylbXGmmkoY@z>

st_print_trace_file_status() takes an fprintf()-like callback and a
FILE * to pass to it.

Its only caller hmp_trace_file() passes monitor_fprintf() and the
current monitor cast to FILE *.  monitor_fprintf() casts it right
back, and is otherwise identical to monitor_printf().  The
type-punning is ugly.

Drop the callback, and call qemu_printf() instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 monitor.c      | 2 +-
 trace/simple.c | 7 ++++---
 trace/simple.h | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/monitor.c b/monitor.c
index 10be8bdb86..a3e66b7159 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1056,7 +1056,7 @@ static void hmp_trace_file(Monitor *mon, const QDict *qdict)
     const char *arg = qdict_get_try_str(qdict, "arg");
 
     if (!op) {
-        st_print_trace_file_status((FILE *)mon, &monitor_fprintf);
+        st_print_trace_file_status();
     } else if (!strcmp(op, "on")) {
         st_set_trace_file_enabled(true);
     } else if (!strcmp(op, "off")) {
diff --git a/trace/simple.c b/trace/simple.c
index ac904eca91..fc7106ec49 100644
--- a/trace/simple.c
+++ b/trace/simple.c
@@ -16,6 +16,7 @@
 #include "trace/control.h"
 #include "trace/simple.h"
 #include "qemu/error-report.h"
+#include "qemu/qemu-print.h"
 
 /** Trace file header event ID, picked to avoid conflict with real event IDs */
 #define HEADER_EVENT_ID (~(uint64_t)0)
@@ -363,10 +364,10 @@ void st_set_trace_file(const char *file)
     st_set_trace_file_enabled(true);
 }
 
-void st_print_trace_file_status(FILE *stream, int (*stream_printf)(FILE *stream, const char *fmt, ...))
+void st_print_trace_file_status(void)
 {
-    stream_printf(stream, "Trace file \"%s\" %s.\n",
-                  trace_file_name, trace_fp ? "on" : "off");
+    qemu_printf("Trace file \"%s\" %s.\n",
+                trace_file_name, trace_fp ? "on" : "off");
 }
 
 void st_flush_trace_buffer(void)
diff --git a/trace/simple.h b/trace/simple.h
index 9931808c05..5771a0634f 100644
--- a/trace/simple.h
+++ b/trace/simple.h
@@ -11,7 +11,7 @@
 #ifndef TRACE_SIMPLE_H
 #define TRACE_SIMPLE_H
 
-void st_print_trace_file_status(FILE *stream, fprintf_function stream_printf);
+void st_print_trace_file_status(void);
 void st_set_trace_file_enabled(bool enable);
 void st_set_trace_file(const char *file);
 bool st_init(void);
-- 
2.17.2


