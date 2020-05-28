Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9134BC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 15:43:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EBB6207F9
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 15:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eT8WIMlo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EBB6207F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeKhI-0001Yw-JA
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 11:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jeKbm-00042u-20
 for qemu-devel@nongnu.org; Thu, 28 May 2020 11:38:14 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51256
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jeKbl-0003xw-4I
 for qemu-devel@nongnu.org; Thu, 28 May 2020 11:38:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590680292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dWhHjTxv0LMjafdz/vis6speUPBVM7Q+9lyx8nVmOeI=;
 b=eT8WIMlodZKFU1uSJ6Q1e4KrijPKd29henq3TZkxq01/4pREXlLUXxkOUONj7EYh+feJ5Q
 7QMLYV+TRbXX/gVp+ot/Kc/ydzUBQecirBM+zZqu0m21HrPopIJo2T9TSItw4Kjknym9BU
 1MKq5YRcdjzy3ph/JYaWn9WC2DZt3Ao=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-hAXqZRYjNI2mnBdH7r56iA-1; Thu, 28 May 2020 11:38:10 -0400
X-MC-Unique: hAXqZRYjNI2mnBdH7r56iA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4DBF800D24;
 Thu, 28 May 2020 15:38:09 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-117.ams2.redhat.com
 [10.36.114.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 180F310098AC;
 Thu, 28 May 2020 15:38:05 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v6 09/12] hmp: Add support for coroutine command handlers
Date: Thu, 28 May 2020 17:37:39 +0200
Message-Id: <20200528153742.274164-10-kwolf@redhat.com>
In-Reply-To: <20200528153742.274164-1-kwolf@redhat.com>
References: <20200528153742.274164-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 02:50:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Often, QMP command handlers are not only called to handle QMP commands,
but also from a corresponding HMP command handler. In order to give them
a consistent environment, optionally run HMP command handlers in a
coroutine, too.

The implementation is a lot simpler than in QMP because for HMP, we
still block the VM while the coroutine is running.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 monitor/monitor-internal.h |  1 +
 monitor/hmp.c              | 38 ++++++++++++++++++++++++++++++++------
 2 files changed, 33 insertions(+), 6 deletions(-)

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
index 3e73a4c3ce..ab0e3e279f 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1056,12 +1056,25 @@ fail:
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
 
@@ -1080,11 +1093,24 @@ void handle_hmp_command(MonitorHMP *mon, const char *cmdline)
         return;
     }
 
-    /* old_mon is non-NULL when called from qmp_human_monitor_command() */
-    old_mon = monitor_cur();
-    monitor_set_cur(qemu_coroutine_self(), &mon->common);
-    cmd->cmd(&mon->common, qdict);
-    monitor_set_cur(qemu_coroutine_self(), old_mon);
+    if (!cmd->coroutine) {
+        /* old_mon is non-NULL when called from qmp_human_monitor_command() */
+        Monitor *old_mon = monitor_cur();
+        monitor_set_cur(qemu_coroutine_self(), &mon->common);
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


