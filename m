Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62F4C46466
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:43:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BB1620760
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 07:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGNlu6zx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB1620760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPhct-0004Oy-DK
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 03:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQP-0003EL-F1
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:30:17 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37488)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQN-0001Ub-87
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:30:17 -0400
Received: by mail-wr1-x443.google.com with SMTP id h7so8607896wre.4
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 00:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Lx7aepaU4oeb9uUi81d1ARWCm8iq4HU6ykoV7TnaemU=;
 b=PGNlu6zxpVH14oq6A36NwLzFob6q8ObPwMOZKYwfy657B/3WxmKcl4OOgnkm4HU0vo
 ci8hNFDElMIGDzjI8hicitGOF4TKsm/HPB7ufH6KkxpZkl4GautPNiIoIezXf3cXT1Uy
 7sqX/q2p9dUk9b9DW94C/pL1FEb6AuxLj3f1/hiD62OJ8sGMY0s+MA3pZaF1f0V0EU1s
 P7wQVBYFhpfCSEZfvqEmGhc2Bjy586Ay9BU6vk8T8FLN+XrGtWu5F4KDqDBCoCFazbGR
 EJpbvDPOz7TfRAEjHdtgMxBHfuNRHQuvod5gv1WRA7CAgfO4Wu7bfb14vJjUscR7f78n
 cMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Lx7aepaU4oeb9uUi81d1ARWCm8iq4HU6ykoV7TnaemU=;
 b=MIQf7RJhmo6i4aTq2zs9m2QcRaI3KU4TfrIyPiCtWymHRbckaaDv9dFdmqLPwrwnFn
 SjWANEpsijhLV46etJ+Pyts/bU+eHzDMb4TuFG/5UUp443VL0T0XcSmqUixd7cxVlSsB
 SZN5RyD/lt84WBI5NJCjtpXfQWEsojq66QgqNVaANqVXax579I1I2IP6fev/mT/T2CZA
 ccEeMwqUNo9DyWSPqUJhJuGV9j96vnIBcbckxyJvGk/Pf6JhsNYvt2Af426adMeijQ46
 5YiKBPmOYWzoNxgvV5TWmNUo4xpj0ywIg9znJJg+1Ov/9u6ie7uD/Ul3KdOKY/gyqNMQ
 RpCg==
X-Gm-Message-State: AOAM531kH4dF3+gdtpN6OB+JU8ylxhq8ljqbfLTScvvB3juqYDwqbu25
 FLlElU4qFpKF9tISSg4tjnH+SU3BSqk=
X-Google-Smtp-Source: ABdhPJy+Sbx6KKFR+eYAA3jYg/j5sbjECPkJcQa5kwUdxXkckbqvC/4hVAh8IqUc133BAYQ9aeNChg==
X-Received: by 2002:adf:ecc1:: with SMTP id s1mr3289616wro.120.1601969413371; 
 Tue, 06 Oct 2020 00:30:13 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e])
 by smtp.gmail.com with ESMTPSA id i9sm2576329wma.47.2020.10.06.00.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 00:30:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 30/37] replay: introduce breakpoint at the specified step
Date: Tue,  6 Oct 2020 09:29:40 +0200
Message-Id: <20201006072947.487729-31-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006072947.487729-1-pbonzini@redhat.com>
References: <20201006072947.487729-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Markus Armbruster <armbru@redhat.com>,
 Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

This patch introduces replay_break, replay_delete_break
qmp and hmp commands.
These commands allow stopping at the specified instruction.
It may be useful for debugging when there are some known
events that should be investigated.
replay_break command has one argument - number of instructions
executed since the start of the replay.
replay_delete_break removes previously set breakpoint.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Acked-by: Markus Armbruster <armbru@redhat.com>

--

v4 changes:
 - removed useless error_free call
Message-Id: <160174520606.12451.7056879546045599378.stgit@pasha-ThinkPad-X280>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hmp-commands.hx           | 32 +++++++++++++++
 include/monitor/hmp.h     |  2 +
 qapi/replay.json          | 36 +++++++++++++++++
 replay/replay-debugging.c | 84 +++++++++++++++++++++++++++++++++++++++
 replay/replay-internal.h  |  4 ++
 replay/replay.c           | 17 ++++++++
 6 files changed, 175 insertions(+)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 1088d64503..7680d0b380 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1804,6 +1804,38 @@ SRST
   Set QOM property *property* of object at location *path* to value *value*
 ERST
 
+    {
+        .name       = "replay_break",
+        .args_type  = "icount:i",
+        .params     = "icount",
+        .help       = "set breakpoint at the specified instruction count",
+        .cmd        = hmp_replay_break,
+    },
+
+SRST
+``replay_break`` *icount*
+  Set replay breakpoint at instruction count *icount*.
+  Execution stops when the specified instruction is reached.
+  There can be at most one breakpoint. When breakpoint is set, any prior
+  one is removed.  The breakpoint may be set only in replay mode and only
+  "in the future", i.e. at instruction counts greater than the current one.
+  The current instruction count can be observed with ``info replay``.
+ERST
+
+    {
+        .name       = "replay_delete_break",
+        .args_type  = "",
+        .params     = "",
+        .help       = "remove replay breakpoint",
+        .cmd        = hmp_replay_delete_break,
+    },
+
+SRST
+``replay_delete_break``
+  Remove replay breakpoint which was previously set with ``replay_break``.
+  The command is ignored when there are no replay breakpoints.
+ERST
+
     {
         .name       = "info",
         .args_type  = "item:s?",
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index f297fccce8..809ad638bb 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -130,5 +130,7 @@ void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
 void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict);
 void hmp_info_sev(Monitor *mon, const QDict *qdict);
 void hmp_info_replay(Monitor *mon, const QDict *qdict);
+void hmp_replay_break(Monitor *mon, const QDict *qdict);
+void hmp_replay_delete_break(Monitor *mon, const QDict *qdict);
 
 #endif
diff --git a/qapi/replay.json b/qapi/replay.json
index e6b3f6001d..173ba76107 100644
--- a/qapi/replay.json
+++ b/qapi/replay.json
@@ -63,3 +63,39 @@
 ##
 { 'command': 'query-replay',
   'returns': 'ReplayInfo' }
+
+##
+# @replay-break:
+#
+# Set replay breakpoint at instruction count @icount.
+# Execution stops when the specified instruction is reached.
+# There can be at most one breakpoint. When breakpoint is set, any prior
+# one is removed.  The breakpoint may be set only in replay mode and only
+# "in the future", i.e. at instruction counts greater than the current one.
+# The current instruction count can be observed with @query-replay.
+#
+# @icount: instruction count to stop at
+#
+# Since: 5.2
+#
+# Example:
+#
+# -> { "execute": "replay-break", "data": { "icount": 220414 } }
+#
+##
+{ 'command': 'replay-break', 'data': { 'icount': 'int' } }
+
+##
+# @replay-delete-break:
+#
+# Remove replay breakpoint which was set with @replay-break.
+# The command is ignored when there are no replay breakpoints.
+#
+# Since: 5.2
+#
+# Example:
+#
+# -> { "execute": "replay-delete-break" }
+#
+##
+{ 'command': 'replay-delete-break' }
diff --git a/replay/replay-debugging.c b/replay/replay-debugging.c
index 51a6de4e81..3dc23b84fc 100644
--- a/replay/replay-debugging.c
+++ b/replay/replay-debugging.c
@@ -12,10 +12,13 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "sysemu/replay.h"
+#include "sysemu/runstate.h"
 #include "replay-internal.h"
 #include "monitor/hmp.h"
 #include "monitor/monitor.h"
 #include "qapi/qapi-commands-replay.h"
+#include "qapi/qmp/qdict.h"
+#include "qemu/timer.h"
 
 void hmp_info_replay(Monitor *mon, const QDict *qdict)
 {
@@ -41,3 +44,84 @@ ReplayInfo *qmp_query_replay(Error **errp)
     retval->icount = replay_get_current_icount();
     return retval;
 }
+
+static void replay_break(uint64_t icount, QEMUTimerCB callback, void *opaque)
+{
+    assert(replay_mode == REPLAY_MODE_PLAY);
+    assert(replay_mutex_locked());
+    assert(replay_break_icount >= replay_get_current_icount());
+    assert(callback);
+
+    replay_break_icount = icount;
+
+    if (replay_break_timer) {
+        timer_del(replay_break_timer);
+    }
+    replay_break_timer = timer_new_ns(QEMU_CLOCK_REALTIME,
+                                      callback, opaque);
+}
+
+static void replay_delete_break(void)
+{
+    assert(replay_mode == REPLAY_MODE_PLAY);
+    assert(replay_mutex_locked());
+
+    if (replay_break_timer) {
+        timer_del(replay_break_timer);
+        timer_free(replay_break_timer);
+        replay_break_timer = NULL;
+    }
+    replay_break_icount = -1ULL;
+}
+
+static void replay_stop_vm(void *opaque)
+{
+    vm_stop(RUN_STATE_PAUSED);
+    replay_delete_break();
+}
+
+void qmp_replay_break(int64_t icount, Error **errp)
+{
+    if (replay_mode == REPLAY_MODE_PLAY) {
+        if (icount >= replay_get_current_icount()) {
+            replay_break(icount, replay_stop_vm, NULL);
+        } else {
+            error_setg(errp,
+                "cannot set breakpoint at the instruction in the past");
+        }
+    } else {
+        error_setg(errp, "setting the breakpoint is allowed only in play mode");
+    }
+}
+
+void hmp_replay_break(Monitor *mon, const QDict *qdict)
+{
+    int64_t icount = qdict_get_try_int(qdict, "icount", -1LL);
+    Error *err = NULL;
+
+    qmp_replay_break(icount, &err);
+    if (err) {
+        error_report_err(err);
+        return;
+    }
+}
+
+void qmp_replay_delete_break(Error **errp)
+{
+    if (replay_mode == REPLAY_MODE_PLAY) {
+        replay_delete_break();
+    } else {
+        error_setg(errp, "replay breakpoints are allowed only in play mode");
+    }
+}
+
+void hmp_replay_delete_break(Monitor *mon, const QDict *qdict)
+{
+    Error *err = NULL;
+
+    qmp_replay_delete_break(&err);
+    if (err) {
+        error_report_err(err);
+        return;
+    }
+}
diff --git a/replay/replay-internal.h b/replay/replay-internal.h
index 33ac551e78..2f6145ec7c 100644
--- a/replay/replay-internal.h
+++ b/replay/replay-internal.h
@@ -94,6 +94,10 @@ extern ReplayState replay_state;
 
 /* File for replay writing */
 extern FILE *replay_file;
+/* Instruction count of the replay breakpoint */
+extern uint64_t replay_break_icount;
+/* Timer for the replay breakpoint callback */
+extern QEMUTimer *replay_break_timer;
 
 void replay_put_byte(uint8_t byte);
 void replay_put_event(uint8_t event);
diff --git a/replay/replay.c b/replay/replay.c
index 797b6a5b15..d4c228ab28 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -34,6 +34,10 @@ static char *replay_filename;
 ReplayState replay_state;
 static GSList *replay_blockers;
 
+/* Replay breakpoints */
+uint64_t replay_break_icount = -1ULL;
+QEMUTimer *replay_break_timer;
+
 bool replay_next_event_is(int event)
 {
     bool res = false;
@@ -73,6 +77,13 @@ int replay_get_instructions(void)
     replay_mutex_lock();
     if (replay_next_event_is(EVENT_INSTRUCTION)) {
         res = replay_state.instruction_count;
+        if (replay_break_icount != -1LL) {
+            uint64_t current = replay_get_current_icount();
+            assert(replay_break_icount >= current);
+            if (current + res > replay_break_icount) {
+                res = replay_break_icount - current;
+            }
+        }
     }
     replay_mutex_unlock();
     return res;
@@ -99,6 +110,12 @@ void replay_account_executed_instructions(void)
                    will be read from the log. */
                 qemu_notify_event();
             }
+            /* Execution reached the break step */
+            if (replay_break_icount == replay_state.current_icount) {
+                /* Cannot make callback directly from the vCPU thread */
+                timer_mod_ns(replay_break_timer,
+                    qemu_clock_get_ns(QEMU_CLOCK_REALTIME));
+            }
         }
     }
 }
-- 
2.26.2



