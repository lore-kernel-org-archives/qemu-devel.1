Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E281FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 15:41:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2DBB2073B
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 15:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mx+zedPV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2DBB2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeKed-0002yO-Qp
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 11:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jeKbd-0003dJ-0g
 for qemu-devel@nongnu.org; Thu, 28 May 2020 11:38:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51177
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jeKba-0003tM-PY
 for qemu-devel@nongnu.org; Thu, 28 May 2020 11:38:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590680282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WiSPCp13UGRzy7IvL67HlfHcthifFpQiSk7BKE1sZPM=;
 b=Mx+zedPVo0PUh/EcOWa43e52fW7dvNv9FxJp4hHecbv9AAsmnY+1rmgCY+rdmmLxQNRarW
 meI/aoerT+KO0DKtz4Ga1G+g0IOBDWw2RVuXFZMHtfrenBpzuvi47Kze08J4J8HldWsALn
 ulmiYlzhfvrblHmjCqJMGBDGOJESwqo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-VrNrRcTwNNWnFhozHrJYbg-1; Thu, 28 May 2020 11:37:58 -0400
X-MC-Unique: VrNrRcTwNNWnFhozHrJYbg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29082102C874;
 Thu, 28 May 2020 15:37:57 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-117.ams2.redhat.com
 [10.36.114.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 924F21001B07;
 Thu, 28 May 2020 15:37:54 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v6 06/12] monitor: Make current monitor a per-coroutine
 property
Date: Thu, 28 May 2020 17:37:36 +0200
Message-Id: <20200528153742.274164-7-kwolf@redhat.com>
In-Reply-To: <20200528153742.274164-1-kwolf@redhat.com>
References: <20200528153742.274164-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 03:11:04
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
Cc: kwolf@redhat.com, marcandre.lureau@gmail.com, armbru@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This way, a monitor command handler will still be able to access the
current monitor, but when it yields, all other code code will correctly
get NULL from monitor_cur().

Outside of coroutine context, qemu_coroutine_self() returns the leader
coroutine of the current thread.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/monitor/monitor.h |  2 +-
 monitor/hmp.c             |  4 ++--
 monitor/monitor.c         | 27 +++++++++++++++++++++------
 qapi/qmp-dispatch.c       |  4 ++--
 stubs/monitor-core.c      |  2 +-
 5 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 43cc746078..16072e325c 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -13,7 +13,7 @@ typedef struct MonitorOptions MonitorOptions;
 extern QemuOptsList qemu_mon_opts;
 
 Monitor *monitor_cur(void);
-void monitor_set_cur(Monitor *mon);
+void monitor_set_cur(Coroutine *co, Monitor *mon);
 bool monitor_cur_is_qmp(void);
 
 void monitor_init_globals(void);
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 79be6f26de..3e73a4c3ce 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1082,9 +1082,9 @@ void handle_hmp_command(MonitorHMP *mon, const char *cmdline)
 
     /* old_mon is non-NULL when called from qmp_human_monitor_command() */
     old_mon = monitor_cur();
-    monitor_set_cur(&mon->common);
+    monitor_set_cur(qemu_coroutine_self(), &mon->common);
     cmd->cmd(&mon->common, qdict);
-    monitor_set_cur(old_mon);
+    monitor_set_cur(qemu_coroutine_self(), old_mon);
 
     qobject_unref(qdict);
 }
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 182ba136b4..35003bb486 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -58,24 +58,38 @@ IOThread *mon_iothread;
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
 
-void monitor_set_cur(Monitor *mon)
+void monitor_set_cur(Coroutine *co, Monitor *mon)
 {
-    cur_monitor = mon;
+    qemu_mutex_lock(&monitor_lock);
+    if (mon) {
+        g_hash_table_replace(coroutine_mon, co, mon);
+    } else {
+        g_hash_table_remove(coroutine_mon, co);
+    }
+    qemu_mutex_unlock(&monitor_lock);
 }
 
 /**
@@ -613,6 +627,7 @@ void monitor_init_globals_core(void)
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
index e493df1027..635e37a6ba 100644
--- a/stubs/monitor-core.c
+++ b/stubs/monitor-core.c
@@ -8,7 +8,7 @@ Monitor *monitor_cur(void)
     return NULL;
 }
 
-void monitor_set_cur(Monitor *mon)
+void monitor_set_cur(Coroutine *co, Monitor *mon)
 {
 }
 
-- 
2.25.4


