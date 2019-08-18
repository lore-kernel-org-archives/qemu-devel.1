Return-Path: <SRS0=DeAR=WO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB23C3A589
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 23:10:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7441021852
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 23:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSAnI6Tm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7441021852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzUK2-0001M2-6o
	for qemu-devel@archiver.kernel.org; Sun, 18 Aug 2019 19:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49675)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1hzUGP-0006Oq-Lx
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 19:07:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1hzUGO-0005GG-1k
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 19:07:05 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:56228)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1hzUGN-0005Ff-Qs
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 19:07:03 -0400
Received: by mail-wm1-x344.google.com with SMTP id f72so3485wmf.5
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2019 16:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QXktBjDIkU004GPPN3Dzwd8YTk78iS8o8SEmh2y6abE=;
 b=TSAnI6TmWwSVHa0ZK8rclNaFLqdpgAhVmsUuDktkqMDrpTFb98DRnTjU1ZdNoqRE50
 ISydPtcMOjz+BZaIc9Sjdrz56tf3bTNZy5WdVnB2VmXWesPJHWWnqhZn5wy6XcIWfEup
 X5xC/ykPLIq6Sxw756o7kehcXpqSI9JIFNUBcIqntmkU8GFeJcRO30+M2jd0T7kOG/Dy
 FamC5Vkrwt/j+KYOtlhg4jxEZxlAc655qnKMlA+HcFbBfS+YIV/sc2QRurabkdh39Icg
 CsYOklJTHcek+juDVSb4A4rUJRTfpfRuDa6jNuUEA85wxFzd94Mkc0RoUeYuwTbeRfBA
 ETrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QXktBjDIkU004GPPN3Dzwd8YTk78iS8o8SEmh2y6abE=;
 b=tXdoozrrQR0XwpdwwC142KBo82R5NIDnHiM3eteuZq1hm462RXw2CG5kU9PXGvRTEc
 PPb58FWyWraiNE/OZXg3H/U6yS0px6fi8q0oFjh7jpkY/OizBRTjQcN9DY3pTmAE/uC7
 2Pd0/HqPUP3zTQh51I3dsNpjlHFX4YeYNM+2K4GzaD42GBlvmF3guZpjt6hEu6lJnRO5
 YRfDiP5vxAxK7OaGEG+u5Bj10tr+RKzv3hNICl57W3/AR++JPMkVvHJVrpYTWx+YC8up
 zKST4ohQVBLLjepEafHP5zEU1+5Zno0ckiqtG99PsGroD5xRsKgVA+oepaq4Ykg20WHM
 E6yQ==
X-Gm-Message-State: APjAAAUBgZuUrYAV70UdT8JuhhTlH4O4bmUOIe+XGTevVWMJbf+Jo63V
 HAw1Pfem/21OEZewD+sGF2U5tFDZ
X-Google-Smtp-Source: APXvYqw50wn7TewekKsWI7pPt43LUxlGZyjuXJXlCn3ew8rjP+b9/EFVLFcYNLCsyWF87g9AvIUyjA==
X-Received: by 2002:a1c:f20a:: with SMTP id s10mr17732870wmc.145.1566169622716; 
 Sun, 18 Aug 2019 16:07:02 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-49c9-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:49c9::5])
 by smtp.gmail.com with ESMTPSA id c15sm33657152wrb.80.2019.08.18.16.07.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 18 Aug 2019 16:07:02 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 01:06:48 +0200
Message-Id: <8cbc9e865bbf40850c14340fc0549e6ac2d5fe9c.1566168923.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566168923.git.DirtY.iCE.hu@gmail.com>
References: <cover.1566168923.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v4 03/14] audio: add audiodev property to vnc
 and wav_capture
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
Cc: Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---

Notes:
    Changes from v2:
    
    * audiodev parameter for wavcapture is now mandatory.
    * removed some unnecessary qdict_haskey calls from hmp_wavcapture

 ui/vnc.h        |  2 ++
 monitor/misc.c  | 22 +++++++++++-----------
 ui/vnc.c        | 15 ++++++++++++++-
 hmp-commands.hx | 11 ++++++-----
 qemu-options.hx |  6 ++++++
 5 files changed, 39 insertions(+), 17 deletions(-)

diff --git a/ui/vnc.h b/ui/vnc.h
index 18f1b1d6d0..8643860967 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -182,6 +182,8 @@ struct VncDisplay
 #ifdef CONFIG_VNC_SASL
     VncDisplaySASL sasl;
 #endif
+
+    AudioState *audio_state;
 };
 
 typedef struct VncTight {
diff --git a/monitor/misc.c b/monitor/misc.c
index 6b71059739..aef16f6cfb 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -1142,21 +1142,21 @@ static void hmp_stopcapture(Monitor *mon, const QDict *qdict)
 static void hmp_wavcapture(Monitor *mon, const QDict *qdict)
 {
     const char *path = qdict_get_str(qdict, "path");
-    int has_freq = qdict_haskey(qdict, "freq");
-    int freq = qdict_get_try_int(qdict, "freq", -1);
-    int has_bits = qdict_haskey(qdict, "bits");
-    int bits = qdict_get_try_int(qdict, "bits", -1);
-    int has_channels = qdict_haskey(qdict, "nchannels");
-    int nchannels = qdict_get_try_int(qdict, "nchannels", -1);
+    int freq = qdict_get_try_int(qdict, "freq", 44100);
+    int bits = qdict_get_try_int(qdict, "bits", 16);
+    int nchannels = qdict_get_try_int(qdict, "nchannels", 2);
+    const char *audiodev = qdict_get_str(qdict, "audiodev");
     CaptureState *s;
+    AudioState *as = audio_state_by_name(audiodev);
+
+    if (!as) {
+        monitor_printf(mon, "Audiodev '%s' not found\n", audiodev);
+        return;
+    }
 
     s = g_malloc0 (sizeof (*s));
 
-    freq = has_freq ? freq : 44100;
-    bits = has_bits ? bits : 16;
-    nchannels = has_channels ? nchannels : 2;
-
-    if (wav_start_capture(NULL, s, path, freq, bits, nchannels)) {
+    if (wav_start_capture(as, s, path, freq, bits, nchannels)) {
         monitor_printf(mon, "Failed to add wave capture\n");
         g_free (s);
         return;
diff --git a/ui/vnc.c b/ui/vnc.c
index ed5e8aa5f8..649ce93cd2 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1224,7 +1224,7 @@ static void audio_add(VncState *vs)
     ops.destroy = audio_capture_destroy;
     ops.capture = audio_capture;
 
-    vs->audio_cap = AUD_add_capture(NULL, &vs->as, &ops, vs);
+    vs->audio_cap = AUD_add_capture(vs->vd->audio_state, &vs->as, &ops, vs);
     if (!vs->audio_cap) {
         error_report("Failed to add audio capture");
     }
@@ -3371,6 +3371,9 @@ static QemuOptsList qemu_vnc_opts = {
         },{
             .name = "non-adaptive",
             .type = QEMU_OPT_BOOL,
+        },{
+            .name = "audiodev",
+            .type = QEMU_OPT_STRING,
         },
         { /* end of list */ }
     },
@@ -3808,6 +3811,7 @@ void vnc_display_open(const char *id, Error **errp)
     const char *saslauthz;
     int lock_key_sync = 1;
     int key_delay_ms;
+    const char *audiodev;
 
     if (!vd) {
         error_setg(errp, "VNC display not active");
@@ -3993,6 +3997,15 @@ void vnc_display_open(const char *id, Error **errp)
     }
     vd->ledstate = 0;
 
+    audiodev = qemu_opt_get(opts, "audiodev");
+    if (audiodev) {
+        vd->audio_state = audio_state_by_name(audiodev);
+        if (!vd->audio_state) {
+            error_setg(errp, "Audiodev '%s' not found", audiodev);
+            goto fail;
+        }
+    }
+
     device_id = qemu_opt_get(opts, "display");
     if (device_id) {
         int head = qemu_opt_get_number(opts, "head", 0);
diff --git a/hmp-commands.hx b/hmp-commands.hx
index bfa5681dd2..cfcc044ce4 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -819,16 +819,17 @@ ETEXI
 
     {
         .name       = "wavcapture",
-        .args_type  = "path:F,freq:i?,bits:i?,nchannels:i?",
-        .params     = "path [frequency [bits [channels]]]",
+        .args_type  = "path:F,audiodev:s,freq:i?,bits:i?,nchannels:i?",
+        .params     = "path audiodev [frequency [bits [channels]]]",
         .help       = "capture audio to a wave file (default frequency=44100 bits=16 channels=2)",
         .cmd        = hmp_wavcapture,
     },
 STEXI
-@item wavcapture @var{filename} [@var{frequency} [@var{bits} [@var{channels}]]]
+@item wavcapture @var{filename} @var{audiodev} [@var{frequency} [@var{bits} [@var{channels}]]]
 @findex wavcapture
-Capture audio into @var{filename}. Using sample rate @var{frequency}
-bits per sample @var{bits} and number of channels @var{channels}.
+Capture audio into @var{filename} from @var{audiodev}, using sample rate
+@var{frequency} bits per sample @var{bits} and number of channels
+@var{channels}.
 
 Defaults:
 @itemize @minus
diff --git a/qemu-options.hx b/qemu-options.hx
index 9621e934c0..a308e5f5aa 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1978,6 +1978,12 @@ can help the device and guest to keep up and not lose events in case
 events are arriving in bulk.  Possible causes for the latter are flaky
 network connections, or scripts for automated testing.
 
+@item audiodev=@var{audiodev}
+
+Use the specified @var{audiodev} when the VNC client requests audio
+transmission. When not using an -audiodev argument, this option must
+be omitted, otherwise is must be present and specify a valid audiodev.
+
 @end table
 ETEXI
 
-- 
2.22.0


