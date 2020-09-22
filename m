Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30F2C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 12:30:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D83D20B1F
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 12:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D83D20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKhQp-0006J9-5f
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 08:30:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1kKhEH-0001XZ-6X
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 08:17:05 -0400
Received: from mail.ispras.ru ([83.149.199.84]:47752)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1kKhED-0006VU-5O
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 08:17:04 -0400
Received: from [127.0.1.1] (unknown [62.118.151.149])
 by mail.ispras.ru (Postfix) with ESMTPSA id 03B6F40A2071;
 Tue, 22 Sep 2020 12:16:58 +0000 (UTC)
Subject: [PATCH v5 14/15] replay: create temporary snapshot at debugger
 connection
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
To: qemu-devel@nongnu.org
Date: Tue, 22 Sep 2020 15:16:58 +0300
Message-ID: <160077701869.10249.1932448449161159554.stgit@pasha-ThinkPad-X280>
In-Reply-To: <160077693745.10249.9707329107813662236.stgit@pasha-ThinkPad-X280>
References: <160077693745.10249.9707329107813662236.stgit@pasha-ThinkPad-X280>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 08:15:38
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, wrampazz@redhat.com, pavel.dovgalyuk@ispras.ru,
 ehabkost@redhat.com, alex.bennee@linaro.org, mtosatti@redhat.com,
 armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, crosa@redhat.com,
 pbonzini@redhat.com, philmd@redhat.com, zhiwei_liu@c-sky.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When record/replay does not uses overlays for storing the snapshots,
user is not capable of issuing reverse debugging commands.
This patch adds creation of the VM snapshot on the temporary
overlay image, when the debugger connects to QEMU.
Therefore the execution can be rewind to the moment
of the debugger connection while debugging the virtual machine.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
---
 gdbstub.c                 |    1 +
 include/sysemu/replay.h   |    2 ++
 replay/replay-debugging.c |   16 ++++++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/gdbstub.c b/gdbstub.c
index ac92273018..f19f98ab1a 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -3321,6 +3321,7 @@ static void gdb_chr_event(void *opaque, QEMUChrEvent event)
         s->g_cpu = s->c_cpu;
 
         vm_stop(RUN_STATE_PAUSED);
+        replay_gdb_attached();
         gdb_has_xml = false;
         break;
     default:
diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index b6cac175c4..2aa34b8919 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -94,6 +94,8 @@ bool replay_reverse_continue(void);
 bool replay_running_debug(void);
 /* Called in reverse debugging mode to collect breakpoint information */
 void replay_breakpoint(void);
+/* Called when gdb is attached to gdbstub */
+void replay_gdb_attached(void);
 
 /* Processing the instructions */
 
diff --git a/replay/replay-debugging.c b/replay/replay-debugging.c
index d02d4e0766..bb9110707a 100644
--- a/replay/replay-debugging.c
+++ b/replay/replay-debugging.c
@@ -316,3 +316,19 @@ void replay_breakpoint(void)
     assert(replay_mode == REPLAY_MODE_PLAY);
     replay_last_breakpoint = replay_get_current_icount();
 }
+
+void replay_gdb_attached(void)
+{
+    /*
+     * Create VM snapshot on temporary overlay to allow reverse
+     * debugging even if snapshots were not enabled.
+     */
+    if (replay_mode == REPLAY_MODE_PLAY
+        && !replay_snapshot) {
+        Error *err = NULL;
+        if (save_snapshot("start_debugging", &err) != 0) {
+            /* Can't create the snapshot. Continue conventional debugging. */
+            error_free(err);
+        }
+    }
+}


