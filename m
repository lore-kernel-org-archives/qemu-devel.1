Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4839BC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:28:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACE9C20756
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WD7kcIve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACE9C20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPTLi-0007Mk-RZ
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 12:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kPStZ-0000dm-UP
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:59:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33202)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kPStX-0002A6-5A
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601913562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KOAkHdpteTM/75ZBBWzAK2DQW7fqPdAc3IHnSx/whg8=;
 b=WD7kcIveTAuvJ9k9E+g7xv8DrhAtV/fNv7Q/8/i6cwXfei0VWrK4Xi6ykIHSpT0oCrblmw
 LPrRVSLpUZ8xGFxC6EUHEsMaXzPncB+2EovN2Vopc7hkheubHDbsyCwtMFYyP4cJs6k6Cl
 8EzdAFIICnUQlfsg4KJh//5Dwbnt7Tw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-lqyKYqGONCqGr9nthRn-4w-1; Mon, 05 Oct 2020 11:59:20 -0400
X-MC-Unique: lqyKYqGONCqGr9nthRn-4w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71D2D1085954;
 Mon,  5 Oct 2020 15:59:19 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-145.ams2.redhat.com
 [10.36.113.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E7F2560C11;
 Mon,  5 Oct 2020 15:59:17 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v8 07/14] monitor: Make current monitor a per-coroutine
 property
Date: Mon,  5 Oct 2020 17:58:48 +0200
Message-Id: <20201005155855.256490-8-kwolf@redhat.com>
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

This way, a monitor command handler will still be able to access the
current monitor, but when it yields, all other code code will correctly
get NULL from monitor_cur().

This uses a hash table to map the coroutine pointer to the current
monitor of that coroutine.  Outside of coroutine context, we associate
the current monitor with the leader coroutine of the current thread.

Approaches to implement some form of coroutine local storage directly in
the coroutine core code have been considered and discarded because they
didn't end up being much more generic than the hash table and their
performance impact on coroutines not using coroutine local storage was
unclear. As the block layer uses a coroutine per I/O request, this is a
fast path and we have to be careful. It's safest to just stay out of
this path with code only used by the monitor.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/monitor/monitor.h |  2 +-
 monitor/hmp.c             |  4 ++--
 monitor/monitor.c         | 34 +++++++++++++++++++++++++++-------
 qapi/qmp-dispatch.c       |  4 ++--
 stubs/monitor-core.c      |  2 +-
 5 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 543eafcb76..348bfad3d5 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -13,7 +13,7 @@ typedef struct MonitorOptions MonitorOptions;
 extern QemuOptsList qemu_mon_opts;
 
 Monitor *monitor_cur(void);
-Monitor *monitor_set_cur(Monitor *mon);
+Monitor *monitor_set_cur(Coroutine *co, Monitor *mon);
 bool monitor_cur_is_qmp(void);
 
 void monitor_init_globals(void);
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 560ec98e7b..abaf939b2d 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1081,9 +1081,9 @@ void handle_hmp_command(MonitorHMP *mon, const char *cmdline)
     }
 
     /* old_mon is non-NULL when called from qmp_human_monitor_command() */
-    old_mon = monitor_set_cur(&mon->common);
+    old_mon = monitor_set_cur(qemu_coroutine_self(), &mon->common);
     cmd->cmd(&mon->common, qdict);
-    monitor_set_cur(old_mon);
+    monitor_set_cur(qemu_coroutine_self(), old_mon);
 
     qobject_unref(qdict);
 }
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 099c164c6d..ef68ca9d21 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -58,29 +58,48 @@ IOThread *mon_iothread;
 /* Bottom half to dispatch the requests received from I/O thread */
 QEMUBH *qmp_dispatcher_bh;
 
-/* Protects mon_list, monitor_qapi_event_state, monitor_destroyed.  */
+/*
+ * Protects mon_list, monitor_qapi_event_state, coroutine_mon,
+ * monitor_destroyed.
+ */
 QemuMutex monitor_lock;
 static GHashTable *monitor_qapi_event_state;
+static GHashTable *coroutine_mon; /* Maps Coroutine* to Monitor* */
 
 MonitorList mon_list;
 int mon_refcount;
 static bool monitor_destroyed;
 
-static __thread Monitor *cur_monitor;
-
 Monitor *monitor_cur(void)
 {
-    return cur_monitor;
+    Monitor *mon;
+
+    qemu_mutex_lock(&monitor_lock);
+    mon = g_hash_table_lookup(coroutine_mon, qemu_coroutine_self());
+    qemu_mutex_unlock(&monitor_lock);
+
+    return mon;
 }
 
 /**
  * Sets a new current monitor and returns the old one.
+ *
+ * If a non-NULL monitor is set for a coroutine, another call
+ * resetting it to NULL is required before the coroutine terminates,
+ * otherwise a stale entry would remain in the hash table.
  */
-Monitor *monitor_set_cur(Monitor *mon)
+Monitor *monitor_set_cur(Coroutine *co, Monitor *mon)
 {
-    Monitor *old_monitor = cur_monitor;
+    Monitor *old_monitor = monitor_cur();
+
+    qemu_mutex_lock(&monitor_lock);
+    if (mon) {
+        g_hash_table_replace(coroutine_mon, co, mon);
+    } else {
+        g_hash_table_remove(coroutine_mon, co);
+    }
+    qemu_mutex_unlock(&monitor_lock);
 
-    cur_monitor = mon;
     return old_monitor;
 }
 
@@ -623,6 +642,7 @@ void monitor_init_globals_core(void)
 {
     monitor_qapi_event_init();
     qemu_mutex_init(&monitor_lock);
+    coroutine_mon = g_hash_table_new(NULL, NULL);
 
     /*
      * The dispatcher BH must run in the main loop thread, since we
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index 2fdbc0fba4..5677ba92ca 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -154,11 +154,11 @@ QDict *qmp_dispatch(const QmpCommandList *cmds, QObject *request,
     }
 
     assert(monitor_cur() == NULL);
-    monitor_set_cur(cur_mon);
+    monitor_set_cur(qemu_coroutine_self(), cur_mon);
 
     cmd->fn(args, &ret, &err);
 
-    monitor_set_cur(NULL);
+    monitor_set_cur(qemu_coroutine_self(), NULL);
     qobject_unref(args);
     if (err) {
         /* or assert(!ret) after reviewing all handlers: */
diff --git a/stubs/monitor-core.c b/stubs/monitor-core.c
index dc1748bf13..d058a2a00d 100644
--- a/stubs/monitor-core.c
+++ b/stubs/monitor-core.c
@@ -8,7 +8,7 @@ Monitor *monitor_cur(void)
     return NULL;
 }
 
-Monitor *monitor_set_cur(Monitor *mon)
+Monitor *monitor_set_cur(Coroutine *co, Monitor *mon)
 {
     return NULL;
 }
-- 
2.25.4


