Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE38AC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:12:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A59C2137B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fzRnQyMK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A59C2137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL0op-0001Fi-IR
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 05:12:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kL0n5-0007rw-3r
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:10:19 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49784
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kL0n3-00023f-2v
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:10:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600852215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hz6vgAXVN+6iymYK2FXK3DUNVOmvhLDNkub3oy/OyYc=;
 b=fzRnQyMKXItPQS4QY0UYCsTlt8oUMG11kbZsDIQC4u6Sw88NsEPB2DXIk95ijU6w0hNXld
 nPXpvTwuIbEjPSrTQbFhc+LN6g3vXkqvq9mG1XDcvhRnFszz9EsK4Uh9btKevIuyjQ555O
 5Yxg6bPruk2rjTKOiNoSAEOzETe1biY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-Ye_emMwYMi-aVKwGzrastw-1; Wed, 23 Sep 2020 05:10:13 -0400
X-MC-Unique: Ye_emMwYMi-aVKwGzrastw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A224B190A3EC;
 Wed, 23 Sep 2020 09:10:12 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-85.ams2.redhat.com
 [10.36.112.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 936B21002C0B;
 Wed, 23 Sep 2020 09:10:02 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id D31631FCF6; Wed, 23 Sep 2020 11:10:01 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/9] audio/spiceaudio: always rate limit playback stream
Date: Wed, 23 Sep 2020 11:09:55 +0200
Message-Id: <20200923091001.20814-4-kraxel@redhat.com>
In-Reply-To: <20200923091001.20814-1-kraxel@redhat.com>
References: <20200923091001.20814-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 03:55:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Volker Rümelin <vr_qemu@t-online.de>

The playback rate with the spiceaudio backend is currently too
fast if there's no spice client connected or the spice client
can't play audio. Rate limit the audio playback stream in all
cases. To calculate the rate correctly the limiter has to know
the maximum buffer size.

Fixes: 8c198ff065 ("spiceaudio: port to the new audio backend api")
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Message-id: 20200920171729.15861-3-vr_qemu@t-online.de
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/audio.c      |  3 ++-
 audio/spiceaudio.c | 10 ++++------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index 7b660dd0c4d0..d5891e1928bc 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1089,7 +1089,8 @@ static size_t audio_pcm_hw_run_out(HWVoiceOut *hw, size_t live)
     size_t clipped = 0;
 
     while (live) {
-        size_t size, decr, proc;
+        size_t size = live * hw->info.bytes_per_frame;
+        size_t decr, proc;
         void *buf = hw->pcm_ops->get_buffer_out(hw, &size);
 
         if (size == 0) {
diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index c8d81ba44290..c062742622e4 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -130,13 +130,11 @@ static void *line_out_get_buffer(HWVoiceOut *hw, size_t *size)
     }
 
     if (out->frame) {
-        *size = audio_rate_get_bytes(
-            &hw->info, &out->rate,
-            (out->fsize - out->fpos) * hw->info.bytes_per_frame);
-    } else {
-        audio_rate_start(&out->rate);
-        *size = LINE_OUT_SAMPLES << 2;
+        *size = MIN((out->fsize - out->fpos) << 2, *size);
     }
+
+    *size = audio_rate_get_bytes(&hw->info, &out->rate, *size);
+
     return out->frame + out->fpos;
 }
 
-- 
2.27.0


