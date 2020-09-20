Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E923C43463
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 17:23:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E805C207BB
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 17:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E805C207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kK33Y-0001JC-51
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 13:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1kK2yA-00041v-23
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 13:17:47 -0400
Received: from mailout10.t-online.de ([194.25.134.21]:34852)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1kK2y5-0006Fv-MU
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 13:17:45 -0400
Received: from fwd11.aul.t-online.de (fwd11.aul.t-online.de [172.20.27.152])
 by mailout10.t-online.de (Postfix) with SMTP id 32E8C41FA028;
 Sun, 20 Sep 2020 19:17:39 +0200 (CEST)
Received: from linpower.localnet
 (bHcoO0Z1rh1GoyJ8wscsfcqD8h1sQY0m0g7Jt9tWyNtN4NA7AzN7T5g7yXaQaGhwPy@[93.236.144.216])
 by fwd11.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1kK2y2-2mMujg0; Sun, 20 Sep 2020 19:17:38 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id F1159335505; Sun, 20 Sep 2020 19:17:29 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 4/9] audio: align audio_generic_read with audio_pcm_hw_run_in
Date: Sun, 20 Sep 2020 19:17:24 +0200
Message-Id: <20200920171729.15861-4-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <84f1c61a-8399-c75e-96c2-febfc2dd5fab@t-online.de>
References: <84f1c61a-8399-c75e-96c2-febfc2dd5fab@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ID: bHcoO0Z1rh1GoyJ8wscsfcqD8h1sQY0m0g7Jt9tWyNtN4NA7AzN7T5g7yXaQaGhwPy
X-TOI-EXPURGATEID: 150726::1600622258-000007DF-30300D69/0/0 CLEAN NORMAL
X-TOI-MSGID: 83c6d6a8-7864-42c3-99d8-9fda084f3b49
Received-SPF: none client-ip=194.25.134.21;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout10.t-online.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/20 13:17:39
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

The function audio_generic_read should work exactly like
audio_pcm_hw_run_in. It's a very similar function working
on a different buffer.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 audio/audio.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index ba52259050..f1f0d72389 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1495,12 +1495,23 @@ size_t audio_generic_write(HWVoiceOut *hw, void *buf, size_t size)
 
 size_t audio_generic_read(HWVoiceIn *hw, void *buf, size_t size)
 {
-    void *src = hw->pcm_ops->get_buffer_in(hw, &size);
+    size_t total = 0;
 
-    memcpy(buf, src, size);
-    hw->pcm_ops->put_buffer_in(hw, src, size);
+    while (total < size) {
+        size_t src_size = size - total;
+        void *src = hw->pcm_ops->get_buffer_in(hw, &src_size);
 
-    return size;
+        if (src_size == 0) {
+            hw->pcm_ops->put_buffer_in(hw, src, src_size);
+            break;
+        }
+
+        memcpy((char *)buf + total, src, src_size);
+        hw->pcm_ops->put_buffer_in(hw, src, src_size);
+        total += src_size;
+    }
+
+    return total;
 }
 
 static int audio_driver_init(AudioState *s, struct audio_driver *drv,
-- 
2.26.2


