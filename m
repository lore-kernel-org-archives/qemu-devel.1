Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8B2C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 08:09:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59C4F207E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 08:09:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59C4F207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57272 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hayJY-00066K-IJ
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 04:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50087)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hayHe-0004JM-Nr
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 04:07:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hayG2-0003b4-Jp
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 04:05:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50837)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1hayG0-0003Z5-Ra; Wed, 12 Jun 2019 04:05:21 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1D25B30F1BA4;
 Wed, 12 Jun 2019 08:05:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
 [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E2396A483;
 Wed, 12 Jun 2019 08:05:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 21B371138648; Wed, 12 Jun 2019 10:05:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 12 Jun 2019 10:05:17 +0200
Message-Id: <20190612080518.11597-1-armbru@redhat.com>
In-Reply-To: <20190611134043.9524-4-kwolf@redhat.com>
References: <20190611134043.9524-4-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Wed, 12 Jun 2019 08:05:20 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2.1 02.5/11] monitor: Restrict use of Monitor
 member qmp to actual QMP monitors
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
Cc: kwolf@redhat.com, berrange@redhat.com, dgilbert@redhat.com,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kevin Wolf <kwolf@redhat.com>

We currently use Monitor member qmp even in HMP monitors.  Harmless,
but it's in the next commit's way.  Restrict its use to QMP monitors.

Several functions have a tacit "is a QMP monitor" precondition.  Add
explicit assertions there.  The next commit will replace most of them
by compile-time type checks.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 monitor.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/monitor.c b/monitor.c
index bb23cc0450..0e145959d7 100644
--- a/monitor.c
+++ b/monitor.c
@@ -357,6 +357,8 @@ static void qmp_request_free(QMPRequest *req)
 /* Caller must hold mon->qmp.qmp_queue_lock */
 static void monitor_qmp_cleanup_req_queue_locked(Monitor *mon)
 {
+    assert(monitor_is_qmp(mon));
+
     while (!g_queue_is_empty(mon->qmp.qmp_requests)) {
         qmp_request_free(g_queue_pop_head(mon->qmp.qmp_requests));
     }
@@ -364,6 +366,8 @@ static void monitor_qmp_cleanup_req_queue_locked(Moni=
tor *mon)
=20
 static void monitor_qmp_cleanup_queues(Monitor *mon)
 {
+    assert(monitor_is_qmp(mon));
+
     qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
     monitor_qmp_cleanup_req_queue_locked(mon);
     qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
@@ -710,29 +714,32 @@ static void monitor_data_init(Monitor *mon, int fla=
gs, bool skip_flush,
     }
     memset(mon, 0, sizeof(Monitor));
     qemu_mutex_init(&mon->mon_lock);
-    qemu_mutex_init(&mon->qmp.qmp_queue_lock);
     mon->outbuf =3D qstring_new();
     /* Use *mon_cmds by default. */
     mon->cmd_table =3D mon_cmds;
     mon->skip_flush =3D skip_flush;
     mon->use_io_thread =3D use_io_thread;
-    mon->qmp.qmp_requests =3D g_queue_new();
     mon->flags =3D flags;
 }
=20
+static void monitor_data_destroy_qmp(Monitor *mon)
+{
+    json_message_parser_destroy(&mon->qmp.parser);
+    qemu_mutex_destroy(&mon->qmp.qmp_queue_lock);
+    monitor_qmp_cleanup_req_queue_locked(mon);
+    g_queue_free(mon->qmp.qmp_requests);
+}
+
 static void monitor_data_destroy(Monitor *mon)
 {
     g_free(mon->mon_cpu_path);
     qemu_chr_fe_deinit(&mon->chr, false);
     if (monitor_is_qmp(mon)) {
-        json_message_parser_destroy(&mon->qmp.parser);
+        monitor_data_destroy_qmp(mon);
     }
     readline_free(mon->rs);
     qobject_unref(mon->outbuf);
     qemu_mutex_destroy(&mon->mon_lock);
-    qemu_mutex_destroy(&mon->qmp.qmp_queue_lock);
-    monitor_qmp_cleanup_req_queue_locked(mon);
-    g_queue_free(mon->qmp.qmp_requests);
 }
=20
 char *qmp_human_monitor_command(const char *command_line, bool has_cpu_i=
ndex,
@@ -1086,6 +1093,7 @@ CommandInfoList *qmp_query_commands(Error **errp)
 {
     CommandInfoList *list =3D NULL;
=20
+    assert(monitor_is_qmp(cur_mon));
     qmp_for_each_command(cur_mon->qmp.commands, query_commands_cb, &list=
);
=20
     return list;
@@ -1155,11 +1163,13 @@ static void monitor_init_qmp_commands(void)
=20
 static bool qmp_oob_enabled(Monitor *mon)
 {
+    assert(monitor_is_qmp(mon));
     return mon->qmp.capab[QMP_CAPABILITY_OOB];
 }
=20
 static void monitor_qmp_caps_reset(Monitor *mon)
 {
+    assert(monitor_is_qmp(mon));
     memset(mon->qmp.capab_offered, 0, sizeof(mon->qmp.capab_offered));
     memset(mon->qmp.capab, 0, sizeof(mon->qmp.capab));
     mon->qmp.capab_offered[QMP_CAPABILITY_OOB] =3D mon->use_io_thread;
@@ -1176,6 +1186,7 @@ static bool qmp_caps_accept(Monitor *mon, QMPCapabi=
lityList *list,
     GString *unavailable =3D NULL;
     bool capab[QMP_CAPABILITY__MAX];
=20
+    assert(monitor_is_qmp(mon));
     memset(capab, 0, sizeof(capab));
=20
     for (; list; list =3D list->next) {
@@ -1203,6 +1214,7 @@ static bool qmp_caps_accept(Monitor *mon, QMPCapabi=
lityList *list,
 void qmp_qmp_capabilities(bool has_enable, QMPCapabilityList *enable,
                           Error **errp)
 {
+    assert(monitor_is_qmp(cur_mon));
     if (cur_mon->qmp.commands =3D=3D &qmp_commands) {
         error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
                   "Capabilities negotiation is already complete, command=
 "
@@ -4134,6 +4146,7 @@ static void monitor_qmp_dispatch(Monitor *mon, QObj=
ect *req)
     QDict *rsp;
     QDict *error;
=20
+    assert(monitor_is_qmp(mon));
     old_mon =3D cur_mon;
     cur_mon =3D mon;
=20
@@ -4177,6 +4190,9 @@ static QMPRequest *monitor_qmp_requests_pop_any_wit=
h_lock(void)
     qemu_mutex_lock(&monitor_lock);
=20
     QTAILQ_FOREACH(mon, &mon_list, entry) {
+        if (!monitor_is_qmp(mon)) {
+            continue;
+        }
         qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
         req_obj =3D g_queue_pop_head(mon->qmp.qmp_requests);
         if (req_obj) {
@@ -4212,6 +4228,7 @@ static void monitor_qmp_bh_dispatcher(void *data)
     }
=20
     mon =3D req_obj->mon;
+    assert(monitor_is_qmp(mon));
     /*  qmp_oob_enabled() might change after "qmp_capabilities" */
     need_resume =3D !qmp_oob_enabled(mon) ||
         mon->qmp.qmp_requests->length =3D=3D QMP_REQ_QUEUE_LEN_MAX - 1;
@@ -4395,6 +4412,8 @@ static QDict *qmp_greeting(Monitor *mon)
     QObject *ver =3D NULL;
     QMPCapability cap;
=20
+    assert(monitor_is_qmp(mon));
+
     qmp_marshal_query_version(NULL, &ver, NULL);
=20
     for (cap =3D 0; cap < QMP_CAPABILITY__MAX; cap++) {
@@ -4612,6 +4631,9 @@ static void monitor_init_qmp(Chardev *chr, int flag=
s)
     monitor_data_init(mon, flags, false,
                       qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_GCONTE=
XT));
=20
+    qemu_mutex_init(&mon->qmp.qmp_queue_lock);
+    mon->qmp.qmp_requests =3D g_queue_new();
+
     qemu_chr_fe_init(&mon->chr, chr, &error_abort);
     qemu_chr_fe_set_echo(&mon->chr, true);
=20
--=20
2.21.0


