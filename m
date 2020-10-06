Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B3FC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 08:07:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29724206F4
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 08:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCO4XVTg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29724206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPi0r-0001kr-4i
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 04:07:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQP-0003DH-1d
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:30:17 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:51964)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQM-0001UL-P9
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:30:16 -0400
Received: by mail-wm1-x335.google.com with SMTP id d81so1836303wmc.1
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 00:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NxHtyaguhmZyrZzSrjBoVZDX5Qr8ne7K4mckqDbFwHo=;
 b=eCO4XVTgwP8Vd4y/uHgwpLxmjs3MNVtDdZ0vF/SFUi4ldO8H/JHAtsPfVIpPZliZdk
 b5BWfnwo7j0b7nE5zslvfrYHb3/PD8xWjbR/eF2p121r+IAd3F7qX0D97Ejvbxor9mld
 YOgAPGl6XWDbb5Vjy2K/4Lz03BsZCcvoXUFFu/fBxzPFJiY5ASUToM1xC+HOmGmMGYf9
 rf3g5YTKcD1XK7cxHoHOwOBxL67pyIvkoHHuDlJRmCk4fTvYzBIOlhC7pEBFoWHRI3PO
 IhUiciKDX6GqP6FvhfgapJRP092DFdpdOtkDgw+XZLQ3KSUU7OAaLGYv7AH+oa+VJUA3
 pYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=NxHtyaguhmZyrZzSrjBoVZDX5Qr8ne7K4mckqDbFwHo=;
 b=MBtysHnOvuQqLQxEQheMyK0/9jnRM9jp2GNMMpAeT0XBX2NtDfyWsw+1/AXDpQy/+w
 Yd2EK8OVGlHdLAYyoUl9Hly7S+waKv3PDtaHZm6fX601VPH5UlbOi8QMjzdhcYUYZZUL
 pjz0jwNPuhTEMf+CJ8fPJBCtUOy2Ecq1yBWO7RaLcvzwCj7hTXbO7Fm7UBXRuq+g+Nb5
 lWSb6mCri6DD8BrqJowqIHAbJjwjlW335cvDmnzqxQsdMIyPf2fafYZT0UyoeUw/2Hk9
 /kdxO5De7+IP0+X18ULpP8GMBcP+Y8NozJVOAIl+sGLqs7Msvr4SUdCqhPJ4iPncBPAW
 OUHw==
X-Gm-Message-State: AOAM5335m3dBPbNZBPPrRFUq8uPGfKJRJLTNFATelC0Mu8Dr+ffhu7IP
 KZFQ9rvUzTKAL5tUVLRovKCAS17cjY0=
X-Google-Smtp-Source: ABdhPJzWE1aPmN94PEgA04c32Pi52Vmgl4vusjWNYLXDNQvOwTZcB7i9E3ednZRl1ZBri+2q7DDn6A==
X-Received: by 2002:a1c:9e0e:: with SMTP id h14mr3186823wme.18.1601969412602; 
 Tue, 06 Oct 2020 00:30:12 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e])
 by smtp.gmail.com with ESMTPSA id i9sm2576329wma.47.2020.10.06.00.30.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 00:30:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 29/37] replay: introduce info hmp/qmp command
Date: Tue,  6 Oct 2020 09:29:39 +0200
Message-Id: <20201006072947.487729-30-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006072947.487729-1-pbonzini@redhat.com>
References: <20201006072947.487729-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x335.google.com
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
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

This patch introduces 'info replay' monitor command and
corresponding qmp request.
These commands request the current record/replay mode, replay log file
name, and the instruction count (number of recorded/replayed
instructions).  The instruction count can be used with the
replay_seek/replay_break commands added in the next two patches.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <160174520026.12451.13112161947433306561.stgit@pasha-ThinkPad-X280>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hmp-commands-info.hx      | 11 ++++++++++
 include/monitor/hmp.h     |  1 +
 qapi/block-core.json      |  3 ++-
 qapi/replay.json          | 39 +++++++++++++++++++++++++++++++++++
 replay/meson.build        |  1 +
 replay/replay-debugging.c | 43 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 97 insertions(+), 1 deletion(-)
 create mode 100644 replay/replay-debugging.c

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 30209e3903..117ba25f91 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -881,4 +881,15 @@ SRST
     Show SEV information.
 ERST
 
+    {
+        .name       = "replay",
+        .args_type  = "",
+        .params     = "",
+        .help       = "show record/replay information",
+        .cmd        = hmp_info_replay,
+    },
 
+SRST
+  ``info replay``
+    Display the record/replay information: mode and the current icount.
+ERST
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index 642e9e91f9..f297fccce8 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -129,5 +129,6 @@ void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict);
 void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
 void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict);
 void hmp_info_sev(Monitor *mon, const QDict *qdict);
+void hmp_info_replay(Monitor *mon, const QDict *qdict);
 
 #endif
diff --git a/qapi/block-core.json b/qapi/block-core.json
index fdc2e5cb28..3758ea9912 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -29,7 +29,8 @@
 #
 # @icount: Current instruction count. Appears when execution record/replay
 #          is enabled. Used for "time-traveling" to match the moment
-#          in the recorded execution with the snapshots. (since 5.2)
+#          in the recorded execution with the snapshots. This counter may
+#          be obtained through @query-replay command (since 5.2)
 #
 # Since: 1.3
 #
diff --git a/qapi/replay.json b/qapi/replay.json
index 9e13551d20..e6b3f6001d 100644
--- a/qapi/replay.json
+++ b/qapi/replay.json
@@ -24,3 +24,42 @@
 ##
 { 'enum': 'ReplayMode',
   'data': [ 'none', 'record', 'play' ] }
+
+##
+# @ReplayInfo:
+#
+# Record/replay information.
+#
+# @mode: current mode.
+#
+# @filename: name of the record/replay log file.
+#            It is present only in record or replay modes, when the log
+#            is recorded or replayed.
+#
+# @icount: current number of executed instructions.
+#
+# Since: 5.2
+#
+##
+{ 'struct': 'ReplayInfo',
+  'data': { 'mode': 'ReplayMode', '*filename': 'str', 'icount': 'int' } }
+
+##
+# @query-replay:
+#
+# Retrieve the record/replay information.
+# It includes current instruction count which may be used for
+# @replay-break and @replay-seek commands.
+#
+# Returns: record/replay information.
+#
+# Since: 5.2
+#
+# Example:
+#
+# -> { "execute": "query-replay" }
+# <- { "return": { "mode": "play", "filename": "log.rr", "icount": 220414 } }
+#
+##
+{ 'command': 'query-replay',
+  'returns': 'ReplayInfo' }
diff --git a/replay/meson.build b/replay/meson.build
index 8783aea7c8..f91163fb1e 100644
--- a/replay/meson.build
+++ b/replay/meson.build
@@ -9,4 +9,5 @@ softmmu_ss.add(files(
   'replay-net.c',
   'replay-audio.c',
   'replay-random.c',
+  'replay-debugging.c',
 ))
diff --git a/replay/replay-debugging.c b/replay/replay-debugging.c
new file mode 100644
index 0000000000..51a6de4e81
--- /dev/null
+++ b/replay/replay-debugging.c
@@ -0,0 +1,43 @@
+/*
+ * replay-debugging.c
+ *
+ * Copyright (c) 2010-2020 Institute for System Programming
+ *                         of the Russian Academy of Sciences.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "sysemu/replay.h"
+#include "replay-internal.h"
+#include "monitor/hmp.h"
+#include "monitor/monitor.h"
+#include "qapi/qapi-commands-replay.h"
+
+void hmp_info_replay(Monitor *mon, const QDict *qdict)
+{
+    if (replay_mode == REPLAY_MODE_NONE) {
+        monitor_printf(mon, "Record/replay is not active\n");
+    } else {
+        monitor_printf(mon,
+            "%s execution '%s': instruction count = %"PRId64"\n",
+            replay_mode == REPLAY_MODE_RECORD ? "Recording" : "Replaying",
+            replay_get_filename(), replay_get_current_icount());
+    }
+}
+
+ReplayInfo *qmp_query_replay(Error **errp)
+{
+    ReplayInfo *retval = g_new0(ReplayInfo, 1);
+
+    retval->mode = replay_mode;
+    if (replay_get_filename()) {
+        retval->filename = g_strdup(replay_get_filename());
+        retval->has_filename = true;
+    }
+    retval->icount = replay_get_current_icount();
+    return retval;
+}
-- 
2.26.2



