Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC93C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:31:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4FEE20756
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cMSlLV9K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4FEE20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPTOO-0001Kd-1E
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 12:31:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kPSu0-00017H-8t
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:59:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21075)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kPStm-0002Cm-TB
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601913575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6ZjZhemmDoBPobZjr0Mun7AKS1/kDn0uStrhxG0IEZw=;
 b=cMSlLV9KCrhzmaAI2cGG4SDTkz5sQH4Muur078wDWv1JyaNsxtLA4T1sExnj3zfMuRanlM
 1gzw38xvH3YskJhDN6HpY2yml9lJTDGWNXxzvr5Nm1ctpW2NPO+SBk1GGj/5gMwYsSJ4QV
 FxHdSZw3TzioYpy/mF7odQEYDQu68uw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-325-NNUrMj2lbdV3OPgM0g-1; Mon, 05 Oct 2020 11:59:33 -0400
X-MC-Unique: 325-NNUrMj2lbdV3OPgM0g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDE96107ACF7;
 Mon,  5 Oct 2020 15:59:32 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-145.ams2.redhat.com
 [10.36.113.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 76B9960C11;
 Mon,  5 Oct 2020 15:59:31 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v8 10/14] hmp: Add support for coroutine command handlers
Date: Mon,  5 Oct 2020 17:58:51 +0200
Message-Id: <20201005155855.256490-11-kwolf@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 01:25:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Often, QMP command handlers are not only called to handle QMP commands,
but also from a corresponding HMP command handler. In order to give them
a consistent environment, optionally run HMP command handlers in a
coroutine, too.

The implementation is a lot simpler than in QMP because for HMP, we
still block the VM while the coroutine is running.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 docs/devel/qapi-code-gen.txt |  4 ++--
 monitor/monitor-internal.h   |  1 +
 monitor/hmp.c                | 37 +++++++++++++++++++++++++++++++-----
 3 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 4a41e36a75..c6438c6aa9 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -617,8 +617,8 @@ pitfalls are:
 
 Since the command handler may assume coroutine context, any callers
 other than the QMP dispatcher must also call it in coroutine context.
-In particular, HMP commands calling such a QMP command handler must
-enter coroutine context before calling the handler.
+In particular, HMP commands calling such a QMP command handler must be
+marked .coroutine = true in hmp-commands.hx.
 
 It is an error to specify both 'coroutine': true and 'allow-oob': true
 for a command.  We don't currently have a use case for both together and
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index b55d6df07f..ad2e64be13 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -74,6 +74,7 @@ typedef struct HMPCommand {
     const char *help;
     const char *flags; /* p=preconfig */
     void (*cmd)(Monitor *mon, const QDict *qdict);
+    bool coroutine;
     /*
      * @sub_table is a list of 2nd level of commands. If it does not exist,
      * cmd should be used. If it exists, sub_table[?].cmd should be
diff --git a/monitor/hmp.c b/monitor/hmp.c
index abaf939b2d..c5cd9d372b 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1056,12 +1056,26 @@ fail:
     return NULL;
 }
 
+typedef struct HandleHmpCommandCo {
+    Monitor *mon;
+    const HMPCommand *cmd;
+    QDict *qdict;
+    bool done;
+} HandleHmpCommandCo;
+
+static void handle_hmp_command_co(void *opaque)
+{
+    HandleHmpCommandCo *data = opaque;
+    data->cmd->cmd(data->mon, data->qdict);
+    monitor_set_cur(qemu_coroutine_self(), NULL);
+    data->done = true;
+}
+
 void handle_hmp_command(MonitorHMP *mon, const char *cmdline)
 {
     QDict *qdict;
     const HMPCommand *cmd;
     const char *cmd_start = cmdline;
-    Monitor *old_mon;
 
     trace_handle_hmp_command(mon, cmdline);
 
@@ -1080,10 +1094,23 @@ void handle_hmp_command(MonitorHMP *mon, const char *cmdline)
         return;
     }
 
-    /* old_mon is non-NULL when called from qmp_human_monitor_command() */
-    old_mon = monitor_set_cur(qemu_coroutine_self(), &mon->common);
-    cmd->cmd(&mon->common, qdict);
-    monitor_set_cur(qemu_coroutine_self(), old_mon);
+    if (!cmd->coroutine) {
+        /* old_mon is non-NULL when called from qmp_human_monitor_command() */
+        Monitor *old_mon = monitor_set_cur(qemu_coroutine_self(), &mon->common);
+        cmd->cmd(&mon->common, qdict);
+        monitor_set_cur(qemu_coroutine_self(), old_mon);
+    } else {
+        HandleHmpCommandCo data = {
+            .mon = &mon->common,
+            .cmd = cmd,
+            .qdict = qdict,
+            .done = false,
+        };
+        Coroutine *co = qemu_coroutine_create(handle_hmp_command_co, &data);
+        monitor_set_cur(co, &mon->common);
+        aio_co_enter(qemu_get_aio_context(), co);
+        AIO_WAIT_WHILE(qemu_get_aio_context(), !data.done);
+    }
 
     qobject_unref(qdict);
 }
-- 
2.25.4


