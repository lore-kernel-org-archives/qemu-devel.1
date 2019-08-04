Return-Path: <SRS0=5wN1=WA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6D3C433FF
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2019 17:07:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3933A206C1
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2019 17:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMbEHk6h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3933A206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huJz0-0001BB-Hc
	for qemu-devel@archiver.kernel.org; Sun, 04 Aug 2019 13:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56686)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1huJw4-0002O8-PL
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 13:04:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1huJw2-00048N-KD
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 13:04:44 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37667)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1huJw1-00040h-GX
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 13:04:42 -0400
Received: by mail-wm1-x341.google.com with SMTP id f17so70837785wme.2
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2019 10:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rslzC2c2WDwNlJOxHo//ed6lLff8LJfI6lnQMj5SLIg=;
 b=EMbEHk6h6pQNZwGzxGYAtxbS5OwGqmB7zIC6lQTqkNqIGbXv1jlnYU1cNpkuNDN/18
 m29tip//zh0qgVM0V/cajWI1knBCAnZ0a8zmd+3VOf49ihcGvr5f83DyJkgVFrs170Gq
 m1b1Ulj+E2/CT/0xqd0Bim+F/oazvCPG4PjljnvQupIELKxaRhFI2LMzrV1QhDyy09Pj
 p6KYeVcSe19tLfTGnFCpWLZ6sh8tLpCmSfoXBT0D/VKua46HoFoMNMitFx/gXsxrx9Oy
 bmqKWkBudatCp7Dur3KvvYqafJNIjv4+7boKg9Du+QO9Tgr5B6VEWBeHkQzUFt+yL74d
 5OfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rslzC2c2WDwNlJOxHo//ed6lLff8LJfI6lnQMj5SLIg=;
 b=eUgu95HlzxML0kWYRdhgfFihT0gpFAFdDeH2sjp0VtYlCur5Bl7FZF1fWmWgxYvvWi
 cB6VS8QFukprPhzRxPzW5S0OfFYvOghJi2iJJDNLaC1QQ/8kq5JrMWYo9xuaVX0K+zK2
 c+/wg+jOHMFcJQw9BcVkVFNcYiBcToVlzd3eVqfSAsrxqrmsVxXrDmkbUdbi3F2Zvpxu
 cJklZrr5M8eTqWeYkBOagJ2MINlfm2RTBUbzqmbD10mXinliyeDSaNJMRCMy299ZS6E3
 JjwFa+u/xRcf0fQ05Fx8B+cD7m4I7SMV1yeiPKB04L56eQC+A0UacMQUUbKFW6PXMnBc
 QFeA==
X-Gm-Message-State: APjAAAVIHliXNSY3AevnOye2/26NN7SY9ai7iUwArJ7v96ga5Tm//6La
 dRQlHmawOb3LT4BtDrxCoic/uug7IFc=
X-Google-Smtp-Source: APXvYqyudTjPiWYkD0+gxZ7Smp2oZ/xvd8PoPP4b8/5c4Tsahce7Sbg+XBtlKhMktnyL3MBI5Ob2yA==
X-Received: by 2002:a7b:c195:: with SMTP id y21mr14002063wmi.16.1564938275570; 
 Sun, 04 Aug 2019 10:04:35 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-632c-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:632c::5])
 by smtp.gmail.com with ESMTPSA id s10sm104876106wmf.8.2019.08.04.10.04.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 04 Aug 2019 10:04:35 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Sun,  4 Aug 2019 19:04:20 +0200
Message-Id: <d1085ec6129416705b2cb65737e510ec9ffec508.1564925486.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1564925486.git.DirtY.iCE.hu@gmail.com>
References: <cover.1564925486.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v3 08/14] paaudio: properly disconnect streams
 in fini_*
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently this needs a workaround due to bug #247 in pulseaudio.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/paaudio.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/audio/paaudio.c b/audio/paaudio.c
index 24d98b344a..1d68173636 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -685,6 +685,27 @@ static int qpa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
     return -1;
 }
 
+static void qpa_simple_disconnect(PAConnection *c, pa_stream *stream)
+{
+    int err;
+
+    pa_threaded_mainloop_lock(c->mainloop);
+    /*
+     * wait until actually connects. workaround pa bug #247
+     * https://gitlab.freedesktop.org/pulseaudio/pulseaudio/issues/247
+     */
+    while (pa_stream_get_state(stream) == PA_STREAM_CREATING) {
+        pa_threaded_mainloop_wait(c->mainloop);
+    }
+
+    err = pa_stream_disconnect(stream);
+    if (err != 0) {
+        dolog("Failed to disconnect! err=%d\n", err);
+    }
+    pa_stream_unref(stream);
+    pa_threaded_mainloop_unlock(c->mainloop);
+}
+
 static void qpa_fini_out (HWVoiceOut *hw)
 {
     void *ret;
@@ -696,7 +717,7 @@ static void qpa_fini_out (HWVoiceOut *hw)
     audio_pt_join(&pa->pt, &ret, __func__);
 
     if (pa->stream) {
-        pa_stream_unref (pa->stream);
+        qpa_simple_disconnect(pa->g->conn, pa->stream);
         pa->stream = NULL;
     }
 
@@ -716,7 +737,7 @@ static void qpa_fini_in (HWVoiceIn *hw)
     audio_pt_join(&pa->pt, &ret, __func__);
 
     if (pa->stream) {
-        pa_stream_unref (pa->stream);
+        qpa_simple_disconnect(pa->g->conn, pa->stream);
         pa->stream = NULL;
     }
 
-- 
2.22.0


