Return-Path: <SRS0=aJdJ=WV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75828C3A5A1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 19:02:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 389A2206E0
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 19:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwEa2XbZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 389A2206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1xmK-0002Gs-RM
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 15:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57815)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i1xXP-0001NS-BF
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 14:46:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i1xXO-0004sa-0F
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 14:46:51 -0400
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b]:40971)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i1xXN-0004sI-Rq
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 14:46:49 -0400
Received: by mail-qk1-x72b.google.com with SMTP id g17so12419801qkk.8
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2019 11:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0IBDcNgUaCUEOu/+mgm+vaoXjgSqlVrIyze4WJP/5n8=;
 b=UwEa2XbZxKwznms3GmNwFewnrkdw7Nny/qmeWCQz2F/HGNBFFnoGLqnCEjV3Ispclz
 DnE5SMK/1Ez+J8+Ek+syYe2ClT7zj83ns4lNyzvKUxOht+WgZxCc1wxvSVPxbxNi28QY
 kByxYiKP2tZWgBElVYLUWpCvC0xe2HyhpMjzZf3ea2JehMwI6tM6mzDnktXvvJGPmaNd
 BTvw025Q6KUfyloI5H/zVWpl1jT2Hc1JZuOSSBKz5vN1L0f4GSgrj1bTEPxeTLhLzzx0
 IVcmSX0FOKByjmrs7fpEk0GVQiYX9Tb0L+I/hnY040iZF6i75ovaTtuSXtVlksTyErla
 P3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0IBDcNgUaCUEOu/+mgm+vaoXjgSqlVrIyze4WJP/5n8=;
 b=B5D8PmlzLIBAFWQ7ThLQQa3ihV3DbvPMrOLJz7M0WtRf4eL2Xm/OpJjHALylxWDHD6
 ykxtlt5vr2lTJAubEbT1129jHphGI+JfP730OFRL0myWjRElkXjP8pRHSxkDQ++fxjbt
 XrLSSTYFcNC8r0kKWqP5URqrNieUWe2MoKxpI5gAk0JXszDHYGKtpbs8AYF8eXx5RTvl
 d6x3W63rnRVmr9RlidqbGW0esONteNd0zHrdkNtVUVz74x6Ax+m38ZcQq7bTXYHqE18b
 MaySiqiO2vCjezKu29o2TNPrn0RAPb/o+aHQLs4Fm+Oj+mdqJFVRqRq2gju4U5XvDICI
 Z8AQ==
X-Gm-Message-State: APjAAAUpxpeEaYaOqGF6OZp29WbPWj6pWfW/qxWQkGkPpgiLey4tcOlY
 zGti9k46CfLVwWPo4xzv0tfbxwHkruE=
X-Google-Smtp-Source: APXvYqzBjbARFLS4pE+I4shYWeMO0twsQ0W8FUy+jsorS547pQBIAFwm/DK390xToACTrndCx+BYyQ==
X-Received: by 2002:a37:6243:: with SMTP id w64mr12718686qkb.444.1566758809213; 
 Sun, 25 Aug 2019 11:46:49 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-61b1-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:61b1::5])
 by smtp.gmail.com with ESMTPSA id d3sm5348870qtq.32.2019.08.25.11.46.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 25 Aug 2019 11:46:48 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Sun, 25 Aug 2019 20:46:18 +0200
Message-Id: <76a0c0fda2f78cfb5f2234aa7e28073aa3e8bd95.1566755452.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566755452.git.DirtY.iCE.hu@gmail.com>
References: <cover.1566755452.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::72b
Subject: [Qemu-devel] [PATCH 16/25] audio: add mixeng option (documentation)
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

However mixeng is not removed, only made optional, so this shouldn't be
a big concern.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 qapi/audio.json | 5 +++++
 qemu-options.hx | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/qapi/audio.json b/qapi/audio.json
index 9fefdf5186..dc7f9cb1e2 100644
--- a/qapi/audio.json
+++ b/qapi/audio.json
@@ -11,6 +11,10 @@
 # General audio backend options that are used for both playback and
 # recording.
 #
+# @mixeng: use QEMU's mixing engine to mix all streams inside QEMU. When set to
+#          off, fixed-settings must be also off. Not every backend compatible
+#          with the off setting (default on, since 4.2)
+#
 # @fixed-settings: use fixed settings for host input/output. When off,
 #                  frequency, channels and format must not be
 #                  specified (default true)
@@ -31,6 +35,7 @@
 ##
 { 'struct': 'AudiodevPerDirectionOptions',
   'data': {
+    '*mixeng':         'bool',
     '*fixed-settings': 'bool',
     '*frequency':      'uint32',
     '*channels':       'uint32',
diff --git a/qemu-options.hx b/qemu-options.hx
index ea0638e92d..8de6deb691 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -433,6 +433,7 @@ DEF("audiodev", HAS_ARG, QEMU_OPTION_audiodev,
     "                specifies the audio backend to use\n"
     "                id= identifier of the backend\n"
     "                timer-period= timer period in microseconds\n"
+    "                in|out.mixeng= use mixeng to mix streams inside QEMU\n"
     "                in|out.fixed-settings= use fixed settings for host audio\n"
     "                in|out.frequency= frequency to use with fixed settings\n"
     "                in|out.channels= number of channels to use with fixed settings\n"
@@ -503,6 +504,11 @@ Identifies the audio backend.
 Sets the timer @var{period} used by the audio subsystem in microseconds.
 Default is 10000 (10 ms).
 
+@item in|out.mixeng=on|off
+Use QEMU's mixing engine to mix all streams inside QEMU.  When off,
+@var{fixed-settings} must be off too.  Not every backend is fully
+compatible with the off setting.  Default is on.
+
 @item in|out.fixed-settings=on|off
 Use fixed settings for host audio.  When off, it will change based on
 how the guest opens the sound card.  In this case you must not specify
-- 
2.22.0


