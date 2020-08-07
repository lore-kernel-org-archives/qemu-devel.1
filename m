Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4F8C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 13:30:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 752792086A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 13:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BW4F8LUS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 752792086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k42Rk-0003zK-M4
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 09:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k42Qz-00032I-5R
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 09:29:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28439
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k42Qx-0006JQ-Ji
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 09:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596806959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gm1iYrs+Fz5HM+Qty5Uwe1XSDvd9vcYguvCzua0zjk0=;
 b=BW4F8LUSqKBrISfONg/odo63tTfuZn25xhA72GqmP/KP6PTEEg+NX+KW83mrh96q7KFgy/
 XFBFZ9zxAhPr8hF723B37xwnrkS+CNk+TVubB/SZm875O3//48UdYkUM348mt9pKYYCQa5
 /NS9+GZPb6P/dKg9FvPXfrBbEM6KIrw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-sFMkQd6LOySGZZYLXvTTvw-1; Fri, 07 Aug 2020 09:29:15 -0400
X-MC-Unique: sFMkQd6LOySGZZYLXvTTvw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F51B1800D42;
 Fri,  7 Aug 2020 13:29:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E4E9387A6F;
 Fri,  7 Aug 2020 13:29:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8185D1132801; Fri,  7 Aug 2020 15:29:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] Coroutine-aware monitor_cur() with coroutine-specific data
References: <20200528153742.274164-1-kwolf@redhat.com>
 <20200528153742.274164-7-kwolf@redhat.com>
 <87tuxia5a9.fsf@dusky.pond.sub.org>
 <20200804160604.GB4860@linux.fritz.box>
 <87sgd15z5w.fsf@dusky.pond.sub.org>
 <87a6z6wqkg.fsf_-_@dusky.pond.sub.org>
Date: Fri, 07 Aug 2020 15:29:12 +0200
In-Reply-To: <87a6z6wqkg.fsf_-_@dusky.pond.sub.org> (Markus Armbruster's
 message of "Fri, 07 Aug 2020 15:09:19 +0200")
Message-ID: <87mu36zis7.fsf_-_@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

This is just a sketch.  It needs comments and a real commit message.

As is, it goes on top of Kevin's series.  It is meant to be squashed
into PATCH 06.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qemu/coroutine.h     |  4 ++++
 include/qemu/coroutine_int.h |  2 ++
 monitor/monitor.c            | 36 +++++++++++++++---------------------
 util/qemu-coroutine.c        | 20 ++++++++++++++++++++
 4 files changed, 41 insertions(+), 21 deletions(-)

diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
index dfd261c5b1..11da47092c 100644
--- a/include/qemu/coroutine.h
+++ b/include/qemu/coroutine.h
@@ -65,6 +65,10 @@ typedef void coroutine_fn CoroutineEntry(void *opaque);
  */
 Coroutine *qemu_coroutine_create(CoroutineEntry *entry, void *opaque);
 
+Coroutine *qemu_coroutine_create_with_storage(CoroutineEntry *entry,
+                                              void *opaque, size_t storage);
+void *qemu_coroutine_local_storage(Coroutine *co);
+
 /**
  * Transfer control to a coroutine
  */
diff --git a/include/qemu/coroutine_int.h b/include/qemu/coroutine_int.h
index bd6b0468e1..7d7865a02f 100644
--- a/include/qemu/coroutine_int.h
+++ b/include/qemu/coroutine_int.h
@@ -41,6 +41,8 @@ struct Coroutine {
     void *entry_arg;
     Coroutine *caller;
 
+    void *coroutine_local_storage;
+
     /* Only used when the coroutine has terminated.  */
     QSLIST_ENTRY(Coroutine) pool_next;
 
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 50fb5b20d3..047a8fb380 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -82,38 +82,32 @@ bool qmp_dispatcher_co_shutdown;
  */
 bool qmp_dispatcher_co_busy;
 
-/*
- * Protects mon_list, monitor_qapi_event_state, coroutine_mon,
- * monitor_destroyed.
- */
+/* Protects mon_list, monitor_qapi_event_state, monitor_destroyed. */
 QemuMutex monitor_lock;
 static GHashTable *monitor_qapi_event_state;
-static GHashTable *coroutine_mon; /* Maps Coroutine* to Monitor* */
 
 MonitorList mon_list;
 int mon_refcount;
 static bool monitor_destroyed;
 
+static Monitor **monitor_curp(Coroutine *co)
+{
+    static __thread Monitor *global_cur_mon;
+
+    if (co == qmp_dispatcher_co) {
+        return qemu_coroutine_local_storage(co);
+    }
+    return &global_cur_mon;
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
@@ -666,14 +660,14 @@ void monitor_init_globals_core(void)
 {
     monitor_qapi_event_init();
     qemu_mutex_init(&monitor_lock);
-    coroutine_mon = g_hash_table_new(NULL, NULL);
 
     /*
      * The dispatcher BH must run in the main loop thread, since we
      * have commands assuming that context.  It would be nice to get
      * rid of those assumptions.
      */
-    qmp_dispatcher_co = qemu_coroutine_create(monitor_qmp_dispatcher_co, NULL);
+    qmp_dispatcher_co = qemu_coroutine_create_with_storage(
+        monitor_qmp_dispatcher_co, NULL, sizeof(Monitor **));
     atomic_mb_set(&qmp_dispatcher_co_busy, true);
     aio_co_schedule(iohandler_get_aio_context(), qmp_dispatcher_co);
 }
diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
index c3caa6c770..87bf7f0fc0 100644
--- a/util/qemu-coroutine.c
+++ b/util/qemu-coroutine.c
@@ -81,8 +81,28 @@ Coroutine *qemu_coroutine_create(CoroutineEntry *entry, void *opaque)
     return co;
 }
 
+Coroutine *qemu_coroutine_create_with_storage(CoroutineEntry *entry,
+                                              void *opaque, size_t storage)
+{
+    Coroutine *co = qemu_coroutine_create(entry, opaque);
+
+    if (!co) {
+        return NULL;
+    }
+
+    co->coroutine_local_storage = g_malloc0(storage);
+    return co;
+}
+
+void *qemu_coroutine_local_storage(Coroutine *co)
+{
+    return co->coroutine_local_storage;
+}
+
 static void coroutine_delete(Coroutine *co)
 {
+    g_free(co->coroutine_local_storage);
+    co->coroutine_local_storage = NULL;
     co->caller = NULL;
 
     if (CONFIG_COROUTINE_POOL) {
-- 
2.26.2


