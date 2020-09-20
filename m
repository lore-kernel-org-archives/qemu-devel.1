Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BFEC43465
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 17:19:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A946C207BB
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 17:19:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A946C207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kK303-0005Zt-NZ
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 13:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1kK2xz-000404-Qx
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 13:17:35 -0400
Received: from mailout11.t-online.de ([194.25.134.85]:50884)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1kK2xy-0006FR-2G
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 13:17:35 -0400
Received: from fwd13.aul.t-online.de (fwd13.aul.t-online.de [172.20.27.62])
 by mailout11.t-online.de (Postfix) with SMTP id 40457425E999;
 Sun, 20 Sep 2020 19:17:31 +0200 (CEST)
Received: from linpower.localnet
 (JbTBTgZ1wh5e1YUvG8omkAi00eJ6ksRPSWkzSvHvuJpzQ7vTc-3D2ESCnrNWnBQw+q@[93.236.144.216])
 by fwd13.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1kK2xu-08uzLs0; Sun, 20 Sep 2020 19:17:30 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id EC356200613; Sun, 20 Sep 2020 19:17:29 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 1/9] audio: handle buf == NULL in put_buffer_out()
Date: Sun, 20 Sep 2020 19:17:21 +0200
Message-Id: <20200920171729.15861-1-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <84f1c61a-8399-c75e-96c2-febfc2dd5fab@t-online.de>
References: <84f1c61a-8399-c75e-96c2-febfc2dd5fab@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ID: JbTBTgZ1wh5e1YUvG8omkAi00eJ6ksRPSWkzSvHvuJpzQ7vTc-3D2ESCnrNWnBQw+q
X-TOI-EXPURGATEID: 150726::1600622250-00003E0D-CF49BECB/0/0 CLEAN NORMAL
X-TOI-MSGID: 40b6d91d-6ee8-420f-b398-9d75a203800e
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

With the next patch all audio backends put_buffer_out() functions
have to handle the buf == NULL case, provided the get_buffer_out()
function may return buf = NULL and size > 0.

It turns out that all audio backends get_buffer_out() functions
either can't return buf = NULL or return buf = NULL and size = 0
at the same time. The only exception is the spiceaudio backend
where size may be uninitialized.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 audio/spiceaudio.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index b6b5da4812..c8d81ba442 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -135,6 +135,7 @@ static void *line_out_get_buffer(HWVoiceOut *hw, size_t *size)
             (out->fsize - out->fpos) * hw->info.bytes_per_frame);
     } else {
         audio_rate_start(&out->rate);
+        *size = LINE_OUT_SAMPLES << 2;
     }
     return out->frame + out->fpos;
 }
@@ -143,12 +144,14 @@ static size_t line_out_put_buffer(HWVoiceOut *hw, void *buf, size_t size)
 {
     SpiceVoiceOut *out = container_of(hw, SpiceVoiceOut, hw);
 
-    assert(buf == out->frame + out->fpos && out->fpos <= out->fsize);
-    out->fpos += size >> 2;
+    if (buf) {
+        assert(buf == out->frame + out->fpos && out->fpos <= out->fsize);
+        out->fpos += size >> 2;
 
-    if (out->fpos == out->fsize) { /* buffer full */
-        spice_server_playback_put_samples(&out->sin, out->frame);
-        out->frame = NULL;
+        if (out->fpos == out->fsize) { /* buffer full */
+            spice_server_playback_put_samples(&out->sin, out->frame);
+            out->frame = NULL;
+        }
     }
 
     return size;
-- 
2.26.2


