Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAD2C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 21:11:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAF3C20665
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 21:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvZ2rAGw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF3C20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn8FY-0002Qq-As
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 17:11:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42260)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1hn8Cx-000895-Um
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 17:08:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1hn8Cw-0004kp-PL
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 17:08:27 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53614)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1hn8Cw-0004kT-Iu
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 17:08:26 -0400
Received: by mail-wm1-x341.google.com with SMTP id x15so16554789wmj.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 14:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rslzC2c2WDwNlJOxHo//ed6lLff8LJfI6lnQMj5SLIg=;
 b=gvZ2rAGwGYll66L2uA/1QnS11iJaBCA1qJo2e6uYzKPGd9S4ILkJDKaP0pMCSioonI
 F1Hd7Z8eLaHJgQPLg4f5FRIkTfJS4nl4kw1QKFRDDs9rPDcibxJmnJJbfhMts0A/ZPhp
 gqZBAmzTWTtMCA42th908CWCsv/mPVk4/5cw0zOOWFVvun0Z02gYth/v+EL1VTFDJsOs
 RVFha5twiN8cbhvl6uk8SXhqu/DxgNyyJpeAwiXRd71LNlNjjbQVNbFkQKVjNcVEJJtV
 Bx7fh/Gw2Q2xSi99wwwe6pZq2v8/pFr+93ag/ZYU/b73WMywAAw5LfY7ArksrNy/xpN5
 ImtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rslzC2c2WDwNlJOxHo//ed6lLff8LJfI6lnQMj5SLIg=;
 b=d4TSwLQd2QuDo/nGqHDqGmiO9t3GyrjZPjlV7zXpL7X+ERj9Na9kb4ploxYQ1OvT0Q
 oH+g+h3Dpy7eLyj+bVhQZQTzaENW2KRVL8KndJBxfBQ+IovjcpMGRUvoLCEMVFB7zMDn
 GOvWITUaDYk/CjnTIONqZmtHKUjVQk3Frdowzv1UInrYSgtc8J5J7OZTS/YaLUn+6BtZ
 4SE+dL5EIduFLd4MAUw5o+1OySFvzRPQ0V5Ne4TkPQRP7Phe4Ec4U/Ogv4Mj3heyZov9
 ug8KqBX+B/1chr9gx5vvdFI1VZx+9qTzDdTVnkUN8OoD4INl4FSseAEZ37q0CVBjiL+f
 a41w==
X-Gm-Message-State: APjAAAVwRD9CPik539crVzdLqraF+guZ8QhY6frgBFGOqKdqEUv/BOVp
 Tvd3ODyfS+d3bcm6oJPUHAcNGH9g
X-Google-Smtp-Source: APXvYqyOJUlXNNtbK2wCK55UL6/Stg6cgrvIWf9da4mbsh/Ed0s2mNhLODx5DIW8lrwhiJCzrIUvnA==
X-Received: by 2002:a1c:f61a:: with SMTP id w26mr27552781wmc.75.1563224905483; 
 Mon, 15 Jul 2019 14:08:25 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-31ca-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:31ca::5])
 by smtp.gmail.com with ESMTPSA id n8sm11513447wro.89.2019.07.15.14.08.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Jul 2019 14:08:25 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 15 Jul 2019 23:08:10 +0200
Message-Id: <e43ccb1b8f667dbbd383aa30f368f49cc731edba.1563224628.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1563224628.git.DirtY.iCE.hu@gmail.com>
References: <cover.1563224628.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v2 08/14] paaudio: properly disconnect streams
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


