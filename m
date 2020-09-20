Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10BFC43463
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 17:22:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1325E207BB
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 17:22:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1325E207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kK32N-0008O6-3K
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 13:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1kK2y8-00041R-3o
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 13:17:45 -0400
Received: from mailout11.t-online.de ([194.25.134.85]:50978)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1kK2y3-0006Fi-OY
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 13:17:43 -0400
Received: from fwd23.aul.t-online.de (fwd23.aul.t-online.de [172.20.26.128])
 by mailout11.t-online.de (Postfix) with SMTP id 110024227A3A;
 Sun, 20 Sep 2020 19:17:38 +0200 (CEST)
Received: from linpower.localnet
 (S+TPB6ZF8hyTWgWKs8RTEDB-qWhNOH3J1Hr3QLR2XNsvOS2Z0-rYyYW6LGiJ1CcQHH@[93.236.144.216])
 by fwd23.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1kK2xx-1mxmc40; Sun, 20 Sep 2020 19:17:33 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id EE572200618; Sun, 20 Sep 2020 19:17:29 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 2/9] audio/audio: fix video playback slowdown with spiceaudio
Date: Sun, 20 Sep 2020 19:17:22 +0200
Message-Id: <20200920171729.15861-2-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <84f1c61a-8399-c75e-96c2-febfc2dd5fab@t-online.de>
References: <84f1c61a-8399-c75e-96c2-febfc2dd5fab@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ID: S+TPB6ZF8hyTWgWKs8RTEDB-qWhNOH3J1Hr3QLR2XNsvOS2Z0-rYyYW6LGiJ1CcQHH
X-TOI-EXPURGATEID: 150726::1600622253-00017F06-698604E3/0/0 CLEAN NORMAL
X-TOI-MSGID: c6469676-489e-4bdc-8004-1bcce84d763c
Received-SPF: none client-ip=194.25.134.85;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout11.t-online.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/20 13:17:31
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

This patch allows the audio backends get_buffer_out() functions
to drop audio data and mitigates a bug reported on the qemu-devel
mailing list.

https://lists.nongnu.org/archive/html/qemu-devel/2020-09/msg03832.html

The new rules for the variables buf and size returned by
get_buffer_out() are:
size == 0: Downstream playback buffer is full. Retry later.
size > 0, buf != NULL: Copy size bytes to buf for playback.
size > 0, buf == NULL: Drop size bytes.

The audio playback rate with spiceaudio for the no audio case is
too fast, but that's what we had before commit fb35c2cec5
"audio/dsound: fix invalid parameters error". The complete fix
comes with the next patch.

Reported-by: Qi Zhou <atmgnd@outlook.com>
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 audio/audio.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index ce8c6dec5f..ad3f57b4c4 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1091,12 +1091,15 @@ static size_t audio_pcm_hw_run_out(HWVoiceOut *hw, size_t live)
     while (live) {
         size_t size, decr, proc;
         void *buf = hw->pcm_ops->get_buffer_out(hw, &size);
-        if (!buf || size == 0) {
+
+        if (size == 0) {
             break;
         }
 
         decr = MIN(size / hw->info.bytes_per_frame, live);
-        audio_pcm_hw_clip_out(hw, buf, decr);
+        if (buf) {
+            audio_pcm_hw_clip_out(hw, buf, decr);
+        }
         proc = hw->pcm_ops->put_buffer_out(hw, buf,
                                            decr * hw->info.bytes_per_frame) /
             hw->info.bytes_per_frame;
-- 
2.26.2


