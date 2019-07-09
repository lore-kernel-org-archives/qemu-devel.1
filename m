Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2548C73C53
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 18:53:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8784B20665
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 18:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="phqXkXhf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8784B20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkvFR-0006CN-SC
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 14:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36811)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1hkuyM-0004Cp-0q
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 14:36:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1hkuyJ-0003dA-IY
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 14:36:13 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46295)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1hkuyH-0003Vg-Iw
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 14:36:09 -0400
Received: by mail-wr1-x443.google.com with SMTP id z1so17477200wru.13
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 11:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=b0UIlwdOJH0003EaFwqDohvtU7bkw8Rr/9hyevQOR+E=;
 b=phqXkXhfheq993Oo9pjEzUo/ZSy2Mipud3u6zzjx5QUYgVAH/PTWBONRpz43cmk49V
 VMj5KaTOtHbjty+6M3MiwULJamdZnXqgNEM9mRA8IxroSRI4/p9cHKge4QtRg1Jjh6Nw
 nwav0Wg+SBadQfEWcfmcZGl4hm795dzYTXguQSUOg+rx9HKw6tzH7wo4odAK9NND+NCs
 DF5bT6mbKLpqNq2wskvgQsAaaH1aA0MmR7+SC+AzzBxpAm12Lk6trE21S+xi3C+Wc1sn
 EMEDW6/RZhwnC7SUMt3jmiXITPERrYFIVOt+WXFXzZOoMyN/hdXfUywa3kzHmkQammtp
 wP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=b0UIlwdOJH0003EaFwqDohvtU7bkw8Rr/9hyevQOR+E=;
 b=A3MkXZYfo4oyRw7qB1TW7DI+ZxIxY1z4TLlohvKd/o/xnBF1KEZJv+DkpbhBrHCXgs
 7h8mDmMhfBFoUontw4GvDK91ntuoLkAj8QYFd7bDLpPwCCAybT2gx65+NHEsAkpp6Ooy
 kBveZGJAOcWbVQ3nBdniLKl/CPovK+fSecK+IrQhj4QFMJeUAUUDpOrkeFMlh4kTddYn
 DXQH/RzpA8Jh6rEOV4LkqbZDGThZedVHkyl0uXRlXkLni62Sw7vrouw+P40CNoluDaKg
 iq2oBBICcKDv9c8DNKm+Tb1WbQIN9/pvSzzdj1EbrHYhAkgbarFKftvipl06Aw7i7P6A
 AxrQ==
X-Gm-Message-State: APjAAAWvrmA5rQx33mvL3GEC3DX/KJaB2GkGgPBhu22tMRwiGgb/N4jW
 3jQm1EAT2PNbwm72FOVuUtSnmUQ1
X-Google-Smtp-Source: APXvYqwCRGM3kKRYwxBuDgwT+rlCq9tla66HJtrxaKrOOIklkmPxTWuhF7UUV0K3daVF+NsHFCbwwQ==
X-Received: by 2002:a5d:53c1:: with SMTP id a1mr27231739wrw.185.1562697357505; 
 Tue, 09 Jul 2019 11:35:57 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-6e3f-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:6e3f::5])
 by smtp.gmail.com with ESMTPSA id c12sm20565042wrd.21.2019.07.09.11.35.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 09 Jul 2019 11:35:57 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 20:35:46 +0200
Message-Id: <02a720bfd7c6bb09c9cedb505516f07f0b395838.1562695780.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1562695780.git.DirtY.iCE.hu@gmail.com>
References: <cover.1562695780.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH 06/11] paaudio: properly disconnect streams in
 fini_*
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

Currently this needs a workaround due to bug #247 in pulseaudio.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/paaudio.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/audio/paaudio.c b/audio/paaudio.c
index 24d98b344a..490bcd770e 100644
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
+        dolog("Failed to dissconnect! err=%d\n", err);
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


