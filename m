Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D91C43463
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 17:19:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA174207BB
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 17:19:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA174207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kK307-0005jb-RR
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 13:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1kK2yG-00042U-7J
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 13:17:57 -0400
Received: from mailout06.t-online.de ([194.25.134.19]:43574)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1kK2yD-0006GZ-Ls
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 13:17:51 -0400
Received: from fwd27.aul.t-online.de (fwd27.aul.t-online.de [172.20.26.132])
 by mailout06.t-online.de (Postfix) with SMTP id 58BC141F0588;
 Sun, 20 Sep 2020 19:17:47 +0200 (CEST)
Received: from linpower.localnet
 (GuSieTZO8h624ylxxBGzLYcCBWlfKRwK+Y1HqBxfKjpXjfmdBRGNUO8FypFXY8RwrV@[93.236.144.216])
 by fwd27.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1kK2y7-1SNadM0; Sun, 20 Sep 2020 19:17:43 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id 01503335508; Sun, 20 Sep 2020 19:17:29 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 6/9] audio: align audio_generic_write with audio_pcm_hw_run_out
Date: Sun, 20 Sep 2020 19:17:26 +0200
Message-Id: <20200920171729.15861-6-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <84f1c61a-8399-c75e-96c2-febfc2dd5fab@t-online.de>
References: <84f1c61a-8399-c75e-96c2-febfc2dd5fab@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ID: GuSieTZO8h624ylxxBGzLYcCBWlfKRwK+Y1HqBxfKjpXjfmdBRGNUO8FypFXY8RwrV
X-TOI-EXPURGATEID: 150726::1600622263-0000CED0-B7A38245/0/0 CLEAN NORMAL
X-TOI-MSGID: 57f6afda-8a5b-4104-bc58-a631ae4fcd07
Received-SPF: none client-ip=194.25.134.19;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout06.t-online.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/20 13:17:47
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?q?Zolt=C3=A1n=20K=C5=91v=C3=A1g=C3=B3?= <dirty.ice.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The function audio_generic_write should work exactly like
audio_pcm_hw_run_out. It's a very similar function working on a
different buffer.

This patch significantly reduces the number of drop-outs with
the DirectSound backend. To hear the difference start qemu with
-audiodev dsound,id=audio0,out.mixing-engine=off and play a
song in the guest with and without this patch.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 audio/audio.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index 75107a12d0..57eddb3324 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1484,12 +1484,34 @@ size_t audio_generic_put_buffer_out(HWVoiceOut *hw, void *buf, size_t size)
 
 size_t audio_generic_write(HWVoiceOut *hw, void *buf, size_t size)
 {
-    size_t dst_size, copy_size;
-    void *dst = hw->pcm_ops->get_buffer_out(hw, &dst_size);
-    copy_size = MIN(size, dst_size);
+    size_t total = 0;
+
+    while (total < size) {
+        size_t dst_size = size - total;
+        size_t copy_size, proc;
+        void *dst = hw->pcm_ops->get_buffer_out(hw, &dst_size);
 
-    memcpy(dst, buf, copy_size);
-    return hw->pcm_ops->put_buffer_out(hw, dst, copy_size);
+        if (dst_size == 0) {
+            break;
+        }
+
+        copy_size = MIN(size - total, dst_size);
+        if (dst) {
+            memcpy(dst, (char *)buf + total, copy_size);
+        }
+        proc = hw->pcm_ops->put_buffer_out(hw, dst, copy_size);
+        total += proc;
+
+        if (proc == 0 || proc < copy_size) {
+            break;
+        }
+    }
+
+    if (hw->pcm_ops->run_buffer_out) {
+        hw->pcm_ops->run_buffer_out(hw);
+    }
+
+    return total;
 }
 
 size_t audio_generic_read(HWVoiceIn *hw, void *buf, size_t size)
-- 
2.26.2


