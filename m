Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55387C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 07:02:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DDB9206F4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 07:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QWSqR+Dt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DDB9206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZUMS-0001lQ-Ao
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 03:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jZUKg-00082G-44
 for qemu-devel@nongnu.org; Fri, 15 May 2020 03:00:34 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37059
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jZUKc-0003IP-KM
 for qemu-devel@nongnu.org; Fri, 15 May 2020 03:00:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589526028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=aC8pWJBY6ijAmmCp4CjAAiCuwem6djCmzySsAduGvbE=;
 b=QWSqR+Dtvd2nWYTSusGI7SU8YVs5oU6ozgIyO1Cb5TH48qqV/qtcIGhQkYTtqiYuWpkssk
 A5tR76LMcKtZ+cLSF+Req0qbEzaNJRNF/pVPzBI4IpKxNiYhkQEmc1XaCOc/o2/TKFH4zG
 ZUdJxY5uPozwD/MDEozU2fHv8WGY1qA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401--Yh1VvTFPum-tLa4pnvYtQ-1; Fri, 15 May 2020 03:00:27 -0400
X-MC-Unique: -Yh1VvTFPum-tLa4pnvYtQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F13FBFC6
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 07:00:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3BF342E16C;
 Fri, 15 May 2020 07:00:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BAF9111358BC; Fri, 15 May 2020 09:00:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] trace/simple: Fix unauthorized enable
Date: Fri, 15 May 2020 09:00:21 +0200
Message-Id: <20200515070021.20811-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:39:12
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
Cc: stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

st_set_trace_file() accidentally enables tracing.  It's called
unconditionally during startup, which is why QEMU built with the
simple trace backend always writes a trace file "trace-$PID".

This has been broken for quite a while.  I didn't track down the exact
commit.

Fix st_set_trace_file() to restore the state.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 trace/simple.h |  2 +-
 trace/simple.c | 13 +++++++------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/trace/simple.h b/trace/simple.h
index 5771a0634f..26ccbc8b8a 100644
--- a/trace/simple.h
+++ b/trace/simple.h
@@ -12,7 +12,7 @@
 #define TRACE_SIMPLE_H
 
 void st_print_trace_file_status(void);
-void st_set_trace_file_enabled(bool enable);
+bool st_set_trace_file_enabled(bool enable);
 void st_set_trace_file(const char *file);
 bool st_init(void);
 void st_flush_trace_buffer(void);
diff --git a/trace/simple.c b/trace/simple.c
index fc7106ec49..906391538f 100644
--- a/trace/simple.c
+++ b/trace/simple.c
@@ -302,10 +302,10 @@ static int st_write_event_mapping(void)
     return 0;
 }
 
-void st_set_trace_file_enabled(bool enable)
+bool st_set_trace_file_enabled(bool enable)
 {
     if (enable == !!trace_fp) {
-        return; /* no change */
+        return enable;          /* no change */
     }
 
     /* Halt trace writeout */
@@ -323,14 +323,14 @@ void st_set_trace_file_enabled(bool enable)
 
         trace_fp = fopen(trace_file_name, "wb");
         if (!trace_fp) {
-            return;
+            return !enable;
         }
 
         if (fwrite(&header, sizeof header, 1, trace_fp) != 1 ||
             st_write_event_mapping() < 0) {
             fclose(trace_fp);
             trace_fp = NULL;
-            return;
+            return !enable;
         }
 
         /* Resume trace writeout */
@@ -340,6 +340,7 @@ void st_set_trace_file_enabled(bool enable)
         fclose(trace_fp);
         trace_fp = NULL;
     }
+    return !enable;
 }
 
 /**
@@ -350,7 +351,7 @@ void st_set_trace_file_enabled(bool enable)
  */
 void st_set_trace_file(const char *file)
 {
-    st_set_trace_file_enabled(false);
+    bool saved_enable = st_set_trace_file_enabled(false);
 
     g_free(trace_file_name);
 
@@ -361,7 +362,7 @@ void st_set_trace_file(const char *file)
         trace_file_name = g_strdup_printf("%s", file);
     }
 
-    st_set_trace_file_enabled(true);
+    st_set_trace_file_enabled(saved_enable);
 }
 
 void st_print_trace_file_status(void)
-- 
2.21.1


