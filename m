Return-Path: <SRS0=PtAT=XD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E0DC433EF
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 21:40:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 632AC218AE
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 21:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oDzsAZEx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 632AC218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i74vD-0005BK-CK
	for qemu-devel@archiver.kernel.org; Sun, 08 Sep 2019 17:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46411)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i74dy-0005Xv-Rt
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 17:22:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i74dx-0005rE-3U
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 17:22:46 -0400
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732]:41470)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i74dw-0005qr-Sb
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 17:22:45 -0400
Received: by mail-qk1-x732.google.com with SMTP id o11so11110699qkg.8
 for <qemu-devel@nongnu.org>; Sun, 08 Sep 2019 14:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2ggo5gaMxU2L823vMOykdg4XPI1AKBEfEFOZrBLT+nk=;
 b=oDzsAZExyWm1/DX5oKn9/Vw4+1ufhOfQKKEiMlt2B1A75g4ScP7meyFMOIJVw2+5wJ
 XTKzK6BfVaz+zU6GEmWJxkmNDaDmSvUaBqwoTa+lNwE+u/UN6liUReUwL0i/6RLmexhZ
 WfVgiO7rajAlGm9MdE2NV7s1fPBl+UQ3VWOsd7W3zC8vyw2NOZvJTIEyZ/dQfvAz5uxa
 TQ7QKL/qj7qyTiTT80HzbiL5rySFapbOvOvUBbEi8pwdUWugawAFfYQSi7J6yPcbUJze
 dM9nnAw8xqZe6NCKRGWK1TsIqZN/z6Q/NovM1EIFhFVFIBlZF8KVF0727K05IyPd22P/
 9pLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2ggo5gaMxU2L823vMOykdg4XPI1AKBEfEFOZrBLT+nk=;
 b=XyHcNpvlkm0LnqkYyH9mhsJIy7w9s9LAxL98/IA3Sv0GtrAoj+6Wt+5hv5WE1vV6h8
 5Mlemtcqafp4IHFr6SLcM2UurDPId3/Ya65D/w2N/aBoCddGZE0dPK6HMNUfroOrFIDP
 XxqKBIIvy9kIsdmxE47vT4NH+XtXDkRzmIO5AWsICMhjhn70yMuK2f5/o8GLi+VvbJDE
 T7Ych7zQwr2vcW19xV3xoqtWWctX5GZ2tIqhYKuY5a+gbkVrzWnnqSapqcnK+CW6tiTB
 DlbQDczgamVEcoQ2M23j2cTOgCqaQredhMYfPDWrhbH2SGceZbcqDhffAm9D1YN4wmop
 i1EQ==
X-Gm-Message-State: APjAAAWC/lsCkfv2Pb5KmnRMQorgqo6mDFGR7TM1XdPAYCFSvD3eyOM7
 rk4uem/Y1KZpDJjepcSauHeNjfhz
X-Google-Smtp-Source: APXvYqzAunCarz+v9DgOhaPDUkZZWH7yA7AYFj7/Fikh+lpJ6drTEZWtH1fcqg2EHBFH1izdZbrgrg==
X-Received: by 2002:ae9:f305:: with SMTP id p5mr19192188qkg.439.1567977764254; 
 Sun, 08 Sep 2019 14:22:44 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-6ea8-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:6ea8::5])
 by smtp.gmail.com with ESMTPSA id e2sm5488112qkg.38.2019.09.08.14.22.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Sep 2019 14:22:43 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Sun,  8 Sep 2019 23:22:15 +0200
Message-Id: <60c9d168dfef599b00b134b124fea9e8ba5e6efc.1567965065.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1567965065.git.DirtY.iCE.hu@gmail.com>
References: <cover.1567965065.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::732
Subject: [Qemu-devel] [PATCH v2 15/24] audio: add mixeng option
 (documentation)
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

Notes:
    Changes from v1:
    
    * renamed mixeng to mixing-engine

 qapi/audio.json | 5 +++++
 qemu-options.hx | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/qapi/audio.json b/qapi/audio.json
index 9fefdf5186..0535eff794 100644
--- a/qapi/audio.json
+++ b/qapi/audio.json
@@ -11,6 +11,10 @@
 # General audio backend options that are used for both playback and
 # recording.
 #
+# @mixing-engine: use QEMU's mixing engine to mix all streams inside QEMU. When
+#                 set to off, fixed-settings must be also off. Not every backend
+#                 compatible with the off setting (default on, since 4.2)
+#
 # @fixed-settings: use fixed settings for host input/output. When off,
 #                  frequency, channels and format must not be
 #                  specified (default true)
@@ -31,6 +35,7 @@
 ##
 { 'struct': 'AudiodevPerDirectionOptions',
   'data': {
+    '*mixing-engine':  'bool',
     '*fixed-settings': 'bool',
     '*frequency':      'uint32',
     '*channels':       'uint32',
diff --git a/qemu-options.hx b/qemu-options.hx
index bbfd936d29..734a3b5d65 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -433,6 +433,7 @@ DEF("audiodev", HAS_ARG, QEMU_OPTION_audiodev,
     "                specifies the audio backend to use\n"
     "                id= identifier of the backend\n"
     "                timer-period= timer period in microseconds\n"
+    "                in|out.mixing-engineeng= use mixing engine to mix streams inside QEMU\n"
     "                in|out.fixed-settings= use fixed settings for host audio\n"
     "                in|out.frequency= frequency to use with fixed settings\n"
     "                in|out.channels= number of channels to use with fixed settings\n"
@@ -503,6 +504,11 @@ Identifies the audio backend.
 Sets the timer @var{period} used by the audio subsystem in microseconds.
 Default is 10000 (10 ms).
 
+@item in|out.mixing-engine=on|off
+Use QEMU's mixing engine to mix all streams inside QEMU.  When off,
+@var{fixed-settings} must be off too.  Not every backend is fully
+compatible with the off setting.  Default is on.
+
 @item in|out.fixed-settings=on|off
 Use fixed settings for host audio.  When off, it will change based on
 how the guest opens the sound card.  In this case you must not specify
-- 
2.23.0


