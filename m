Return-Path: <SRS0=Jehb=YG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53095C4CECE
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 20:00:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A59A2053B
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 20:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdbT2xQo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A59A2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJk2O-0007B2-8O
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 16:00:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37213)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iJk0L-0005Rv-0H
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 15:58:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iJk0J-0003Cx-CO
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 15:58:12 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:38046)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1iJk0J-0003Ao-5R
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 15:58:11 -0400
Received: by mail-wm1-x32e.google.com with SMTP id 3so14699635wmi.3
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2019 12:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=O2uLlaB2iMQO6FRsn1QrUOJ58Hsp0rMaMzhWkW836BQ=;
 b=mdbT2xQobZMzb6qaSiPo9omprrYjacleWt4K1NetJdPntOUMEhiMNURRubrFuf0cC2
 Jkn7ng31clHRMvLmi93J9R2ttQeM9RnUGoZ4c231PEqH5nSQs5Cd9ZXeN6mlqvrOBYtn
 bBouOEIzK9dEkgHvYYDURpi7xAZQKr+1YpdUl1BQeHQROHVSHqwkQabKC1J4EEf1tInz
 0mwCUIWrm+/z236gAOaFFVEjmV/kU87zXWCtV0OCtE/BJA4VNhb7DbNdM9Y1FevAPDJ8
 FhhedYExGxKF35DxYRhQOrO8fsoWVu2NiWEqKUFG9/qiwiCgDZgmOEssB0SGZXKRLv/N
 LQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=O2uLlaB2iMQO6FRsn1QrUOJ58Hsp0rMaMzhWkW836BQ=;
 b=VXwfenNJLIOxQmNoqIO7HGANqR2gtaV9ZbljC+gXt69vlaB6zC+lBhRCqS8vundSQG
 PwIgGlgyoCJRAvdXJWYPX4fsy71mEW7lcnJlSi/qO/vkZ0muQsG1h8imSGXQTRjTVPzU
 PTQRx8xJ3XBFSpx6KxObGxaWRKL1v2Aj9PUwseRJV2qFq7jr4lvxlx4kh+G6MEI+4eVV
 zcwXIgMeqSn6dypkGf9UCloHNTILRe9dg2yC+CQmnyKE7PpSQiC8jz6ZIOoPqvEW6d8B
 ng37koCElPXgEpTMXBlA9yd/loCaC6RyDWXBIwCE0lFe6O9pUsfQu4YXufNXA+wp7Ypx
 Da4Q==
X-Gm-Message-State: APjAAAXU6V441QVrLQJquH9tfijnxVHYgeIw7GAHY9roEaHpyTYo4hj+
 O6Prdk5FbPEFDtZnIMN8i1ssfhmC
X-Google-Smtp-Source: APXvYqynUB3SzIhGUhXpYrvOJpQWhbjdoCmV7TPWg+eCG/txhdLNF43i0USbC6MLpJaTRc9/w8+lnw==
X-Received: by 2002:a1c:bc07:: with SMTP id m7mr12459476wmf.103.1570996689319; 
 Sun, 13 Oct 2019 12:58:09 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-0052-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:52::5])
 by smtp.gmail.com with ESMTPSA id x129sm29941857wmg.8.2019.10.13.12.58.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2019 12:58:09 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 01/10] audio: add mixing-engine option (documentation)
Date: Sun, 13 Oct 2019 21:57:58 +0200
Message-Id: <5765186a7aadd51a72bc7d3e804307f0ee8a34ce.1570996490.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570996490.git.DirtY.iCE.hu@gmail.com>
References: <cover.1570996490.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will allow us to disable mixeng when we use a decent backend.

Disabling mixeng have a few advantages:
* we no longer convert the audio output from one format to another, when
  the underlying audio system would just convert it to a third format.
  We no longer convert, only the underlying system, when needed.
* the underlying system probably has better resampling and sample format
  converting methods anyway...
* we may support formats that the mixeng currently does not support (S24
  or float samples, more than two channels)
* when using an audio server (like pulseaudio) different sound card
  outputs will show up as separate streams, even if we use only one
  backend

Disadvantages:
* audio capturing no longer works (wavcapture, and vnc audio extension)
* some backends only support a single playback stream or very picky
  about the audio format.  In this case we can't disable mixeng.

Originally thw two main use cases of the disabled option was: using
unsupported audio formats (5.1 and 7.1 audio) and having different
pulseaudio streams per audio frontend.  Since we can have multiple
-audiodevs, the latter is not that important, so currently you only need
this option if you want to use 5.1 or 7.1 audio (implemented in a later
patch), otherwise it's probably better to stick to the old and tried
mixeng, since it's less picky about the backends.

The ideal solution would be to port as much as possible to gstreamer,
but this is currently out of scope:
https://wiki.qemu.org/Internships/ProjectIdeas/AudioGStreamer

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---

Notes:
    Changes from v1:
    
    * renamed mixeng to mixing-engine
    
    Changes from v5:
    
    * better documentation
    
    Changes from v1:
    
    * renamed mixeng to mixing-engine

 qapi/audio.json |  6 ++++++
 qemu-options.hx | 15 +++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/qapi/audio.json b/qapi/audio.json
index 9fefdf5186..23bbbe4b6a 100644
--- a/qapi/audio.json
+++ b/qapi/audio.json
@@ -11,6 +11,11 @@
 # General audio backend options that are used for both playback and
 # recording.
 #
+# @mixing-engine: use QEMU's mixing engine to mix all streams inside QEMU and
+#                 convert audio formats when not supported by the backend. When
+#                 set to off, fixed-settings must be also off (default on,
+#                 since 4.2)
+#
 # @fixed-settings: use fixed settings for host input/output. When off,
 #                  frequency, channels and format must not be
 #                  specified (default true)
@@ -31,6 +36,7 @@
 ##
 { 'struct': 'AudiodevPerDirectionOptions',
   'data': {
+    '*mixing-engine':  'bool',
     '*fixed-settings': 'bool',
     '*frequency':      'uint32',
     '*channels':       'uint32',
diff --git a/qemu-options.hx b/qemu-options.hx
index 2a04ca6ac5..3f2aecc99c 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -433,6 +433,7 @@ DEF("audiodev", HAS_ARG, QEMU_OPTION_audiodev,
     "                specifies the audio backend to use\n"
     "                id= identifier of the backend\n"
     "                timer-period= timer period in microseconds\n"
+    "                in|out.mixing-engine= use mixing engine to mix streams inside QEMU\n"
     "                in|out.fixed-settings= use fixed settings for host audio\n"
     "                in|out.frequency= frequency to use with fixed settings\n"
     "                in|out.channels= number of channels to use with fixed settings\n"
@@ -493,6 +494,10 @@ output's property with @code{out.@var{prop}}. For example:
 -audiodev alsa,id=example,out.channels=1 # leaves in.channels unspecified
 @end example
 
+NOTE: parameter validation is known to be incomplete, in many cases
+specifying an invalid option causes QEMU to print an error message and
+continue emulation without sound.
+
 Valid global options are:
 
 @table @option
@@ -503,6 +508,16 @@ Identifies the audio backend.
 Sets the timer @var{period} used by the audio subsystem in microseconds.
 Default is 10000 (10 ms).
 
+@item in|out.mixing-engine=on|off
+Use QEMU's mixing engine to mix all streams inside QEMU and convert
+audio formats when not supported by the backend.  When off,
+@var{fixed-settings} must be off too.  Note that disabling this option
+means that the selected backend must support multiple streams and the
+audio formats used by the virtual cards, otherwise you'll get no sound.
+It's not recommended to disable this option unless you want to use 5.1
+or 7.1 audio, as mixing engine only supports mono and stereo audio.
+Default is on.
+
 @item in|out.fixed-settings=on|off
 Use fixed settings for host audio.  When off, it will change based on
 how the guest opens the sound card.  In this case you must not specify
-- 
2.23.0


