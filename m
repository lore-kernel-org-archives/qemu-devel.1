Return-Path: <SRS0=Jehb=YG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0C1C4CECE
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 20:00:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D829B2053B
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 20:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acxTYtJ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D829B2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJk2H-00074p-Bt
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 16:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37221)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iJk0L-0005Rx-D2
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 15:58:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iJk0K-0003Dx-2W
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 15:58:13 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42907)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1iJk0J-0003Cc-Sd
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 15:58:12 -0400
Received: by mail-wr1-x441.google.com with SMTP id n14so17210503wrw.9
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2019 12:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=i9UxN713GW0ghifGTVMxk9JG2fJFSnFStux97zyYILs=;
 b=acxTYtJ3G8iRF1Ul0GcaXhNMFG+EBRGtgkeDqrRJBljer96HCCQ8E4e/X16aHRnpi4
 47S89VCg+/TK1MP4j4l1wYkFGME4Gc0t/ZzuAAxklRGDXKaQwZhZE8XKCx6sLrzejLFX
 dIbydwN0gzrkoADa7U++zWOs8lQFp5BYV1yY+eP7U0hfYDjeq8qaHitOts+iWMgMXWul
 dOu+IzVPkOm7oe21ZABVuYRlLwh6uszW2PdiSGBUYP1NIa9ES8f5sbkIgRwNkkmMCL6K
 t4GjCKw4ph/+NwybeKNC48X+OkAyVbk2Bwx0SAhiCljUQFgoyyeFqEn3N56bGB0Aohje
 w8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=i9UxN713GW0ghifGTVMxk9JG2fJFSnFStux97zyYILs=;
 b=UyMfU2YikX9erOWcklo3+aS7YMyqjA2XLgBDM787aUFrHN0DZw12VZlINZeIz0AFgy
 Y16FvnZuVX4Mu8EwPRprEFiNo6lHKc+jb7ZTL/utTxQEayA2+VCcXp0DP4a55EmpBb9C
 4oMOBHdOAIXcR8x8p05M7dfuP5NSKEd8D3tBEsGIAbtYEQckbODXIQ5zXTYxi2XQHlUK
 2Pff9Gjimum+8hR3epOQnnvJqj9ekLySnrhJ+N2gN76Tm+oZduCeN9oMQ3eSTxlqDtEg
 RcFnCK2o9I7eZpgurE5BQJ7zoUFv4ioN73PSW/fK3isUY2uSEN6c+o1JF76HCkN1L9Pk
 pelQ==
X-Gm-Message-State: APjAAAWYWeY/jM1wA+qTIaE5ZDlgX5DlUUzU8/d52kRAjaDKA2RsBtYt
 hWIlQR7MEHZsi9mVD3zTC1H7juES
X-Google-Smtp-Source: APXvYqwcXxP2/lBlsyPRPQBvmFAgOY1pUEeS6QLBHXReU7kAPfkbc8b5K8ukHj33+Vx4uS/YnFW6AQ==
X-Received: by 2002:adf:f64f:: with SMTP id x15mr2184659wrp.381.1570996690789; 
 Sun, 13 Oct 2019 12:58:10 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-0052-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:52::5])
 by smtp.gmail.com with ESMTPSA id x129sm29941857wmg.8.2019.10.13.12.58.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2019 12:58:10 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 03/10] paaudio: get/put_buffer functions
Date: Sun, 13 Oct 2019 21:58:00 +0200
Message-Id: <d03d30138b9b5a9681cc90cbfbfec0a197cac88c.1570996490.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570996490.git.DirtY.iCE.hu@gmail.com>
References: <cover.1570996490.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This lets us avoid some buffer copying when using mixeng.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/paaudio.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/audio/paaudio.c b/audio/paaudio.c
index ed31f863f7..6ccdf31415 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -98,6 +98,59 @@ static inline int PA_STREAM_IS_GOOD(pa_stream_state_t x)
         }                                                               \
     } while (0)
 
+static void *qpa_get_buffer_in(HWVoiceIn *hw, size_t *size)
+{
+    PAVoiceIn *p = (PAVoiceIn *) hw;
+    PAConnection *c = p->g->conn;
+    int r;
+
+    pa_threaded_mainloop_lock(c->mainloop);
+
+    CHECK_DEAD_GOTO(c, p->stream, unlock_and_fail,
+                    "pa_threaded_mainloop_lock failed\n");
+
+    if (!p->read_length) {
+        r = pa_stream_peek(p->stream, &p->read_data, &p->read_length);
+        CHECK_SUCCESS_GOTO(c, r == 0, unlock_and_fail,
+                           "pa_stream_peek failed\n");
+    }
+
+    *size = MIN(p->read_length, *size);
+
+    pa_threaded_mainloop_unlock(c->mainloop);
+    return (void *) p->read_data;
+
+unlock_and_fail:
+    pa_threaded_mainloop_unlock(c->mainloop);
+    *size = 0;
+    return NULL;
+}
+
+static void qpa_put_buffer_in(HWVoiceIn *hw, void *buf, size_t size)
+{
+    PAVoiceIn *p = (PAVoiceIn *) hw;
+    PAConnection *c = p->g->conn;
+    int r;
+
+    pa_threaded_mainloop_lock(c->mainloop);
+
+    CHECK_DEAD_GOTO(c, p->stream, unlock,
+                    "pa_threaded_mainloop_lock failed\n");
+
+    assert(buf == p->read_data && size <= p->read_length);
+
+    p->read_data += size;
+    p->read_length -= size;
+
+    if (size && !p->read_length) {
+        r = pa_stream_drop(p->stream);
+        CHECK_SUCCESS_GOTO(c, r == 0, unlock, "pa_stream_drop failed\n");
+    }
+
+unlock:
+    pa_threaded_mainloop_unlock(c->mainloop);
+}
+
 static size_t qpa_read(HWVoiceIn *hw, void *data, size_t length)
 {
     PAVoiceIn *p = (PAVoiceIn *) hw;
@@ -136,6 +189,32 @@ unlock_and_fail:
     return 0;
 }
 
+static void *qpa_get_buffer_out(HWVoiceOut *hw, size_t *size)
+{
+    PAVoiceOut *p = (PAVoiceOut *) hw;
+    PAConnection *c = p->g->conn;
+    void *ret;
+    int r;
+
+    pa_threaded_mainloop_lock(c->mainloop);
+
+    CHECK_DEAD_GOTO(c, p->stream, unlock_and_fail,
+                    "pa_threaded_mainloop_lock failed\n");
+
+    *size = -1;
+    r = pa_stream_begin_write(p->stream, &ret, size);
+    CHECK_SUCCESS_GOTO(c, r >= 0, unlock_and_fail,
+                       "pa_stream_begin_write failed\n");
+
+    pa_threaded_mainloop_unlock(c->mainloop);
+    return ret;
+
+unlock_and_fail:
+    pa_threaded_mainloop_unlock(c->mainloop);
+    *size = 0;
+    return NULL;
+}
+
 static size_t qpa_write(HWVoiceOut *hw, void *data, size_t length)
 {
     PAVoiceOut *p = (PAVoiceOut *) hw;
@@ -698,11 +777,15 @@ static struct audio_pcm_ops qpa_pcm_ops = {
     .init_out = qpa_init_out,
     .fini_out = qpa_fini_out,
     .write    = qpa_write,
+    .get_buffer_out = qpa_get_buffer_out,
+    .put_buffer_out = qpa_write, /* pa handles it */
     .volume_out = qpa_volume_out,
 
     .init_in  = qpa_init_in,
     .fini_in  = qpa_fini_in,
     .read     = qpa_read,
+    .get_buffer_in = qpa_get_buffer_in,
+    .put_buffer_in = qpa_put_buffer_in,
     .volume_in = qpa_volume_in
 };
 
-- 
2.23.0


