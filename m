Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5165FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 06:57:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C8B3207CB
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 06:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PzV93t1G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C8B3207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdpzw-00029v-83
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 02:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jdpzE-0001D0-5Y
 for qemu-devel@nongnu.org; Wed, 27 May 2020 02:56:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34775
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jdpzC-0005Rv-P8
 for qemu-devel@nongnu.org; Wed, 27 May 2020 02:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590562581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6nR2rOkgw/C8QMrv3BnydfPOBJsah/0konKWMPr7DkA=;
 b=PzV93t1GBwn1DhCjCjZZCMZFGD3oq+MYZWeaCPfbHyX03OanxXNybhVCbDUZKyuzb8redD
 uNP2xS3Q4A4dcyUC6Tl93hZBcz56hCvM4vDUU9TSPIGcVpk5mgcCednSv/ePvJfmanXkrM
 NFZcqCy35zIoxR+HT23C1h6Fehq0IIY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-i9NzYUKIPRm3ChYN9LvoQQ-1; Wed, 27 May 2020 02:56:19 -0400
X-MC-Unique: i9NzYUKIPRm3ChYN9LvoQQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5989F460
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 06:56:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 795065D9C9;
 Wed, 27 May 2020 06:56:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EB259113864A; Wed, 27 May 2020 08:56:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] trace/simple: Fix unauthorized enable
Date: Wed, 27 May 2020 08:56:13 +0200
Message-Id: <20200527065613.25322-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 01:25:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
v2: Make st_set_trace_file() less confusing [Stefan]

 trace/simple.h |  2 +-
 trace/simple.c | 20 ++++++++++++++------
 2 files changed, 15 insertions(+), 7 deletions(-)

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
index fc7106ec49..9cd2ed1fb3 100644
--- a/trace/simple.c
+++ b/trace/simple.c
@@ -302,10 +302,17 @@ static int st_write_event_mapping(void)
     return 0;
 }
 
-void st_set_trace_file_enabled(bool enable)
+/**
+ * Enable / disable tracing, return whether it was enabled.
+ *
+ * @enable: enable if %true, else disable.
+ */
+bool st_set_trace_file_enabled(bool enable)
 {
+    bool was_enabled = trace_fp;
+
     if (enable == !!trace_fp) {
-        return; /* no change */
+        return was_enabled;     /* no change */
     }
 
     /* Halt trace writeout */
@@ -323,14 +330,14 @@ void st_set_trace_file_enabled(bool enable)
 
         trace_fp = fopen(trace_file_name, "wb");
         if (!trace_fp) {
-            return;
+            return was_enabled;
         }
 
         if (fwrite(&header, sizeof header, 1, trace_fp) != 1 ||
             st_write_event_mapping() < 0) {
             fclose(trace_fp);
             trace_fp = NULL;
-            return;
+            return was_enabled;
         }
 
         /* Resume trace writeout */
@@ -340,6 +347,7 @@ void st_set_trace_file_enabled(bool enable)
         fclose(trace_fp);
         trace_fp = NULL;
     }
+    return was_enabled;
 }
 
 /**
@@ -350,7 +358,7 @@ void st_set_trace_file_enabled(bool enable)
  */
 void st_set_trace_file(const char *file)
 {
-    st_set_trace_file_enabled(false);
+    bool saved_enable = st_set_trace_file_enabled(false);
 
     g_free(trace_file_name);
 
@@ -361,7 +369,7 @@ void st_set_trace_file(const char *file)
         trace_file_name = g_strdup_printf("%s", file);
     }
 
-    st_set_trace_file_enabled(true);
+    st_set_trace_file_enabled(saved_enable);
 }
 
 void st_print_trace_file_status(void)
-- 
2.21.3


