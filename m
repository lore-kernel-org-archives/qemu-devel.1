Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA7EC4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 09:54:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2A0221670
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 09:54:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2A0221670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAACC-0001Sv-Sp
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 05:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39255)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1iAABW-0000yi-By
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 05:54:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1iAABV-0006uQ-5j
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 05:54:10 -0400
Received: from mail.ispras.ru ([83.149.199.45]:52182)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1iAABU-0006ta-To
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 05:54:09 -0400
Received: from [127.0.1.1] (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id E416E5400C2;
 Tue, 17 Sep 2019 12:54:06 +0300 (MSK)
From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue, 17 Sep 2019 12:54:06 +0300
Message-ID: <156871404669.31913.13609976778909645749.stgit@pasha-Precision-3630-Tower>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 83.149.199.45
Subject: [Qemu-devel] [PATCH] replay: don't synchronize memory operations in
 replay mode
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
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, pavel.dovgaluk@ispras.ru,
 dovgaluk@ispras.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 9458a9a1df1a4c719e24512394d548c1fc7abd22 added synchronization
of vCPU and migration operations through calling run_on_cpu operation.
However, in replay mode this synchronization is unneeded, because
I/O and vCPU threads are already synchronized.
This patch disables such synchronization for record/replay mode.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 exec.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/exec.c b/exec.c
index be8b2b7c06..a69745811f 100644
--- a/exec.c
+++ b/exec.c
@@ -3177,8 +3177,17 @@ static void tcg_log_global_after_sync(MemoryListener *listener)
      * by pushing the migration thread's memory read after the vCPU thread has
      * written the memory.
      */
-    cpuas = container_of(listener, CPUAddressSpace, tcg_as_listener);
-    run_on_cpu(cpuas->cpu, do_nothing, RUN_ON_CPU_NULL);
+    if (replay_mode == REPLAY_MODE_NONE) {
+        /*
+         * VGA can make calls to this function while updating the screen.
+         * In record/replay mode this causes a deadlock, because
+         * run_on_cpu waits for rr mutex. Therefore no races are possible
+         * in this case and no need for making run_on_cpu when
+         * record/replay is not enabled.
+         */
+        cpuas = container_of(listener, CPUAddressSpace, tcg_as_listener);
+        run_on_cpu(cpuas->cpu, do_nothing, RUN_ON_CPU_NULL);
+    }
 }
 
 static void tcg_commit(MemoryListener *listener)


