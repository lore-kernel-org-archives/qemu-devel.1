Return-Path: <SRS0=GetT=XK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8105C4CEC7
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 19:42:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 729FC20830
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2019 19:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Il6w6RJm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 729FC20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9aPa-0000DX-FA
	for qemu-devel@archiver.kernel.org; Sun, 15 Sep 2019 15:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40097)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i9a7o-0006C4-A4
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 15:23:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i9a7n-00021f-5d
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 15:23:56 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:37071)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i9a7m-00021S-Vn
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 15:23:55 -0400
Received: by mail-ed1-x541.google.com with SMTP id i1so31286823edv.4
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2019 12:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=i9UxN713GW0ghifGTVMxk9JG2fJFSnFStux97zyYILs=;
 b=Il6w6RJmjcY1DbvWm8CYqG0GqXDyz+V3wPqzVsDgH50YwuTmHGb37Zp5qpdIfn6mSR
 ssx6cy9G10fAvXfZWP9UmXItDT/YVBaKaHZo2v0DvBn2MOsXZc184q5hU0qrTkjNT1H3
 0NYgeW4CM7wH0S9zgdnu12opgjB+MfEWDlTEZwcIdOYUrwc4igPxDKMu9La+gA85YqgK
 Vj1K/m1uSy2twKqqB5eJRg5roODRZFNlmLwuup2urk0BtHjgonKXUrxre7TCLIullZZC
 QUWD8T2z08+jmnLNkgsWv2sDyyR+0k+7tE7pFoMN4zoHR2tXyfQqTfxaKR42HESfuXu/
 s/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=i9UxN713GW0ghifGTVMxk9JG2fJFSnFStux97zyYILs=;
 b=RVpcSUTfrrzSW1PXXuZy59k2+dsGOaoaneApbsPPV0pyGsfRptsErpP9xZnMmJSxIZ
 c3+HW2zPqOIdPGfAomaJExJXUDzpG/hpaM7CJ6ew4LN+na3E2VarGVWVNiEFw1JqiS6S
 lBbAU0yvqYLp7ndQVtFq0qXqs1UK+qrci+lpyh0MGx3Em3xD6WHmlLZL1P647axkMcSC
 SY37hq2aYMnNF2/Gc1ZJVk1e0AE64AwNhYcr+Rp4jdmdbI5CGR8t87uNbkJZaZNsb4+H
 UXQli8eEzsNyEF3asnkD/Kumyje01rLyHekJZcpudUh7eg/QOlYwtL2Ps3fR95qqFqQw
 86CQ==
X-Gm-Message-State: APjAAAWXls9FW2zZz0THCPY5vvbrSCCAVTYFLE5h3GH3vCgDP+V+ngP+
 Q1jGnFU8q0Pwt8IXQb/eUULtDT3s
X-Google-Smtp-Source: APXvYqy5YQWhLilq62yb04St/FCa5/CkhOB1svCFwfHrK/yTSYZLHSlMRtpevLT942R7IzytXZO4Ag==
X-Received: by 2002:a17:906:f283:: with SMTP id
 gu3mr11958078ejb.17.1568575433887; 
 Sun, 15 Sep 2019 12:23:53 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-74ef-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:74ef::5])
 by smtp.gmail.com with ESMTPSA id j20sm6480562edy.95.2019.09.15.12.23.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2019 12:23:53 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Sun, 15 Sep 2019 21:23:33 +0200
Message-Id: <4554ff54ad04f706ad0e9af87fe07650fd6d9ac1.1568574965.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568574965.git.DirtY.iCE.hu@gmail.com>
References: <cover.1568574965.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::541
Subject: [Qemu-devel] [PATCH v3 17/24] paaudio: get/put_buffer functions
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


