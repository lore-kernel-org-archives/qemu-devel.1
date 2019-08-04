Return-Path: <SRS0=5wN1=WA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAF0C19759
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2019 17:05:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A69B2070D
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2019 17:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEqVo2fK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A69B2070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huJwx-000479-NX
	for qemu-devel@archiver.kernel.org; Sun, 04 Aug 2019 13:05:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56698)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1huJw4-0002OC-T0
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 13:04:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1huJw2-00048H-KS
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 13:04:44 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34459)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1huJw1-0003ze-Fv
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 13:04:42 -0400
Received: by mail-wr1-x443.google.com with SMTP id 31so82085050wrm.1
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2019 10:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zmwu7QnhjoOubCcj+gXAWMt870pR20NYhJgBFOm+pcY=;
 b=jEqVo2fK+2u6XPFW8INx6LlrDfFO3fChm2iVibxrS0maywteoVZ+UFS2B+GeLNHL+H
 oiOakOtpquPjRzFZcv8Dx96mTL6UKBFwn7lN8P/lcYOPEooZg1fYRdHC8ykl7SCKqxS/
 90HzVoarARcEMCIgEFqDzKX6BhHH4jIByVTOhaMuuDbL5VdRhGiFflyolfGiNU8RGwdw
 qjwHpEaMYvR3A23NwAnfVC06Hh52Z7eaFj2NxrZeXRgGdV9IBZYKQnaVMFNs9xkAAyuc
 xiy0Qt6wSXpde57tgNbKZ61gdCZl/hYxU/BAmZAlnz6fYu0OVwVfOzAyavpqM0mmhIvW
 J/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zmwu7QnhjoOubCcj+gXAWMt870pR20NYhJgBFOm+pcY=;
 b=WrYCZ/tNHKuTX1JNcJZEopM64ekHDtEe2rR4BpI/JD3zFgKsolNcyj3yvwXbzpukOE
 s70SpE35Ypg2xA/yVwFnVkR7iFAjAebVJvIeLeFbiF3MFUc6IJLKXKpAJmFeCEHQu+3a
 IUGpC825+ukqQFj2/RnaPC2mfNCiJ6SWDMC0iF2p5UT3zqOZktL4QzFiy7YWzTWksPo/
 YkkVW+cNQHZ+TEy/8j+wYIs3FHzsSE1AhkKxCPfhj7dg5YClHCpXyujhNgSAM/eA6SnA
 h6n7B0BL3UMG24fQVT7Dr/EYA2VHCyNnWZSRMITdHlvze7vMVDcxQKbfLqSxLCIX5kvn
 pkYA==
X-Gm-Message-State: APjAAAXsLlCMsT9y5QUsBC3jSlDbuWVNpsfOQx6zEOhhsm2bpbvY+pC6
 xNdPiLV4v9WYYMoVPmgr8NJs2REs
X-Google-Smtp-Source: APXvYqyLclFUfHfrCqTS3tSz9ri/yc/kTX6beKbxSClOGZIZuosdye6wvqea+k/HfLrDQqvMb54WKA==
X-Received: by 2002:adf:cc85:: with SMTP id p5mr148494496wrj.47.1564938271149; 
 Sun, 04 Aug 2019 10:04:31 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-632c-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:632c::5])
 by smtp.gmail.com with ESMTPSA id s10sm104876106wmf.8.2019.08.04.10.04.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 04 Aug 2019 10:04:30 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Sun,  4 Aug 2019 19:04:15 +0200
Message-Id: <ff28a2d4a61be1e7150556342a5fb83aa818c439.1564925486.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1564925486.git.DirtY.iCE.hu@gmail.com>
References: <cover.1564925486.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v3 03/14] audio: add audiodev property to vnc
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
index 2f84db3142..6f54653455 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -183,6 +183,8 @@ struct VncDisplay
 #ifdef CONFIG_VNC_SASL
     VncDisplaySASL sasl;
 #endif
+
+    AudioState *audio_state;
 };
 
 typedef struct VncTight {
diff --git a/monitor/misc.c b/monitor/misc.c
index e393333a0e..bdf857555f 100644
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
index 140f364dda..24f9be5b5d 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1222,7 +1222,7 @@ static void audio_add(VncState *vs)
     ops.destroy = audio_capture_destroy;
     ops.capture = audio_capture;
 
-    vs->audio_cap = AUD_add_capture(NULL, &vs->as, &ops, vs);
+    vs->audio_cap = AUD_add_capture(vs->vd->audio_state, &vs->as, &ops, vs);
     if (!vs->audio_cap) {
         error_report("Failed to add audio capture");
     }
@@ -3369,6 +3369,9 @@ static QemuOptsList qemu_vnc_opts = {
         },{
             .name = "non-adaptive",
             .type = QEMU_OPT_BOOL,
+        },{
+            .name = "audiodev",
+            .type = QEMU_OPT_STRING,
         },
         { /* end of list */ }
     },
@@ -3806,6 +3809,7 @@ void vnc_display_open(const char *id, Error **errp)
     const char *saslauthz;
     int lock_key_sync = 1;
     int key_delay_ms;
+    const char *audiodev;
 
     if (!vd) {
         error_setg(errp, "VNC display not active");
@@ -3991,6 +3995,15 @@ void vnc_display_open(const char *id, Error **errp)
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


