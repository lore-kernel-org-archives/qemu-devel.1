Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFB8C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 13:29:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46CE12086A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 13:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aViTq7mg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46CE12086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k42R6-0002zC-Hk
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 09:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k42QI-0002CI-Eu
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 09:28:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32920
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k42Pa-0006Aq-3E
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 09:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596806873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YYNzDHS2Wg/kSlhPatXdLhMG8iweCjsmw46TzaGxCew=;
 b=aViTq7mgUtGKDkx5wseLzmCji59yDDfZudWDrWFKXgVPxoG7s8toIKsXZgDbLqs4CHNCaB
 jq9scma3Lm15EQFwllMD95AKDaDwS3Nma0nVqzao2LVLIbslaogb30uB3mB6FRK2/545Ga
 QDT0wIKA7Kb5VOhKLM5SNtUO1ZO7RGY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-HFf8O7uqN_a311_RdwDIqA-1; Fri, 07 Aug 2020 09:27:50 -0400
X-MC-Unique: HFf8O7uqN_a311_RdwDIqA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04036193249C;
 Fri,  7 Aug 2020 13:27:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C5E9F60C4F;
 Fri,  7 Aug 2020 13:27:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 573C71132801; Fri,  7 Aug 2020 15:27:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] Simple & stupid coroutine-aware monitor_cur()
References: <20200528153742.274164-1-kwolf@redhat.com>
 <20200528153742.274164-7-kwolf@redhat.com>
 <87tuxia5a9.fsf@dusky.pond.sub.org>
 <20200804160604.GB4860@linux.fritz.box>
 <87sgd15z5w.fsf@dusky.pond.sub.org>
 <87a6z6wqkg.fsf_-_@dusky.pond.sub.org>
Date: Fri, 07 Aug 2020 15:27:46 +0200
In-Reply-To: <87a6z6wqkg.fsf_-_@dusky.pond.sub.org> (Markus Armbruster's
 message of "Fri, 07 Aug 2020 15:09:19 +0200")
Message-ID: <87sgcyziul.fsf_-_@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 04:00:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 marcandre.lureau@gmail.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is just a sketch.  It's incomplete, needs comments and a real
commit message.

Support for "[PATCH v6 09/12] hmp: Add support for coroutine command
handlers" is missing.  Marked FIXME.

As is, it goes on top of Kevin's series.  It is meant to be squashed
into PATCH 06, except for the FIXME, which needs to be resolved in PATCH
09 instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 monitor/monitor.c | 35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/monitor/monitor.c b/monitor/monitor.c
index 50fb5b20d3..8601340285 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -82,38 +82,34 @@ bool qmp_dispatcher_co_shutdown;
  */
 bool qmp_dispatcher_co_busy;
 
-/*
- * Protects mon_list, monitor_qapi_event_state, coroutine_mon,
- * monitor_destroyed.
- */
+/* Protects mon_list, monitor_qapi_event_state, * monitor_destroyed. */
 QemuMutex monitor_lock;
 static GHashTable *monitor_qapi_event_state;
-static GHashTable *coroutine_mon; /* Maps Coroutine* to Monitor* */
 
 MonitorList mon_list;
 int mon_refcount;
 static bool monitor_destroyed;
 
+static Monitor **monitor_curp(Coroutine *co)
+{
+    static __thread Monitor *thread_local_mon;
+    static Monitor *qmp_dispatcher_co_mon;
+
+    if (qemu_coroutine_self() == qmp_dispatcher_co) {
+        return &qmp_dispatcher_co_mon;
+    }
+    /* FIXME the coroutine hidden in handle_hmp_command() */
+    return &thread_local_mon;
+}
+
 Monitor *monitor_cur(void)
 {
-    Monitor *mon;
-
-    qemu_mutex_lock(&monitor_lock);
-    mon = g_hash_table_lookup(coroutine_mon, qemu_coroutine_self());
-    qemu_mutex_unlock(&monitor_lock);
-
-    return mon;
+    return *monitor_curp(qemu_coroutine_self());
 }
 
 void monitor_set_cur(Coroutine *co, Monitor *mon)
 {
-    qemu_mutex_lock(&monitor_lock);
-    if (mon) {
-        g_hash_table_replace(coroutine_mon, co, mon);
-    } else {
-        g_hash_table_remove(coroutine_mon, co);
-    }
-    qemu_mutex_unlock(&monitor_lock);
+    *monitor_curp(co) = mon;
 }
 
 /**
@@ -666,7 +662,6 @@ void monitor_init_globals_core(void)
 {
     monitor_qapi_event_init();
     qemu_mutex_init(&monitor_lock);
-    coroutine_mon = g_hash_table_new(NULL, NULL);
 
     /*
      * The dispatcher BH must run in the main loop thread, since we
-- 
2.26.2


