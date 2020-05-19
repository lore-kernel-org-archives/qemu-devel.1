Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57522C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 10:44:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A1C920674
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 10:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A1C920674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jazjS-0000hi-Bt
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 06:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pavel.Dovgaluk@gmail.com>)
 id 1jaziV-0008FJ-4v
 for qemu-devel@nongnu.org; Tue, 19 May 2020 06:43:23 -0400
Received: from mail.ispras.ru ([83.149.199.45]:58358)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Pavel.Dovgaluk@gmail.com>) id 1jaziU-0005kS-BR
 for qemu-devel@nongnu.org; Tue, 19 May 2020 06:43:22 -0400
Received: from [127.0.1.1] (unknown [62.118.151.149])
 by mail.ispras.ru (Postfix) with ESMTPSA id C0336CD46B;
 Tue, 19 May 2020 13:43:20 +0300 (MSK)
Subject: [PATCH] icount: fix shift=auto for record/replay
From: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue, 19 May 2020 13:43:20 +0300
Message-ID: <158988500050.15192.692077802469400393.stgit@pasha-ThinkPad-X280>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: softfail client-ip=83.149.199.45;
 envelope-from=Pavel.Dovgaluk@gmail.com; helo=mail.ispras.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 06:21:18
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_ADSP_CUSTOM_MED=0.001,
 FORGED_GMAIL_RCVD=1, FREEMAIL_FROM=0.001, NML_ADSP_CUSTOM_MED=0.9,
 SPF_SOFTFAIL=0.665, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, rth@twiddle.net, alex.bennee@linaro.org,
 pavel.dovgaluk@ispras.ru, dovgaluk@ispras.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch fixes shift=auto when record/replay is enabled.
Now user does not need to guess the best shift value.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

--

v2:
  moved icount_time_shift to vmstate subsection
---
 cpus.c |   20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/cpus.c b/cpus.c
index 5670c96bcf..7ce0d569b3 100644
--- a/cpus.c
+++ b/cpus.c
@@ -379,7 +379,8 @@ static void icount_adjust(void)
 
     seqlock_write_lock(&timers_state.vm_clock_seqlock,
                        &timers_state.vm_clock_lock);
-    cur_time = cpu_get_clock_locked();
+    cur_time = REPLAY_CLOCK_LOCKED(REPLAY_CLOCK_VIRTUAL_RT,
+                                   cpu_get_clock_locked());
     cur_icount = cpu_get_icount_locked();
 
     delta = cur_icount - cur_time;
@@ -647,6 +648,11 @@ static bool adjust_timers_state_needed(void *opaque)
     return s->icount_rt_timer != NULL;
 }
 
+static bool shift_state_needed(void *opaque)
+{
+    return use_icount == 2;
+}
+
 /*
  * Subsection for warp timer migration is optional, because may not be created
  */
@@ -674,6 +680,17 @@ static const VMStateDescription icount_vmstate_adjust_timers = {
     }
 };
 
+static const VMStateDescription icount_vmstate_shift = {
+    .name = "timer/icount/shift",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = shift_state_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_INT16(icount_time_shift, TimersState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 /*
  * This is a subsection for icount migration.
  */
@@ -690,6 +707,7 @@ static const VMStateDescription icount_vmstate_timers = {
     .subsections = (const VMStateDescription*[]) {
         &icount_vmstate_warp_timer,
         &icount_vmstate_adjust_timers,
+        &icount_vmstate_shift,
         NULL
     }
 };


