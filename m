Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F72C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:52:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF85A224FE
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHQeeonu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF85A224FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iF2el-0007bK-WE
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 16:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45718)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iF2HZ-0003uD-CZ
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:28:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iF2HY-0002Pl-2B
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:28:33 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:37110)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1iF2HX-0002O5-Re
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:28:32 -0400
Received: by mail-wm1-x32d.google.com with SMTP id f22so836368wmc.2
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 13:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Gi6tqrqwXbuZC6QjPDbutYBMsb5dVHxRt4y2Z1LxG9o=;
 b=LHQeeonu+UaERht6lIMhJK4jRh7bNV1Gsf3JjSST+XuhSYk2l19t7Q7X8oXMir0OPU
 RP4dGNtTrw1sY++rtg1/thjalbb0WCYYEdsJuanotRzxtMV7c/S8M57Y2JIxu+VSLEBz
 /Zoa9Cie7jE/j4Pehi4dKO16Cz1rUoKDJH1M790dN+6W+Rr0mZxZVKtLlO6xkPWi0g+y
 ifcR9yk2a8p46O61ARMy0Yo0hnCR7+2kHqKfke+y5rkoTFTNzS7A8qRE/fbXa6+vj2AG
 TSxEROTcq1WgEVOtI4ja2/uxX3xvdb0qocd5wP+QZAbI1AM9aAKD5adjtO8pgczZo3sK
 s5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Gi6tqrqwXbuZC6QjPDbutYBMsb5dVHxRt4y2Z1LxG9o=;
 b=EnpBbqeGXG6xkgUOOAMewObQS+NYHkRy2b9rZHbnTiKKNjzLpmd/xlYoLIctVhL7Q0
 nMmSC3ZdzsQZCAvxIOhHmIY0ChexLastJDEygnLOayemDlTe4TqJTSxYg3TxMOt7/Zgx
 EYyq4i7DwCloy7jBm7azyaJCDjsQ0dNPsDzFlMXVgr/4Le0qf4807rZtjkALpZ6/wSRU
 7qh4C8mmJP4H2hjPMAswNL8Rp6rNTtuuAbod06VNH4vy8NhMvjx35yZq1ou2DLh2pt5s
 W3TpntWaYeUx548A6NtL8vblWFQThirQ3r3Rhry1WnpEgZgiNyd3oEPwFIuq95q5589v
 27ag==
X-Gm-Message-State: APjAAAVxmliU1NZ3EIOhnkir78VfJpfIOMoNuBRGmeu6WhuNDsz4MgVU
 7tC01vOwa7QUr8UtTzScakTtAMl1
X-Google-Smtp-Source: APXvYqxVWOgy2+OXMRbM2Q9Ny2Obpiy1mZGZ0ZdHd9W7ycj+eW/B81J3A5n6vHGX5Bra9h9LCDuF/A==
X-Received: by 2002:a05:600c:2059:: with SMTP id
 p25mr799742wmg.50.1569875310676; 
 Mon, 30 Sep 2019 13:28:30 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-e8f4-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:e8f4::5])
 by smtp.gmail.com with ESMTPSA id o9sm34402911wrh.46.2019.09.30.13.28.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2019 13:28:30 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 01/10] audio: add mixing-engine option (documentation)
Date: Mon, 30 Sep 2019 22:28:54 +0200
Message-Id: <a0bb28b8124d0dce39890f7a3214fd450c7d63fc.1569874641.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1569874641.git.DirtY.iCE.hu@gmail.com>
References: <cover.1569874641.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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
index 9fefdf5186..0996705954 100644
--- a/qapi/audio.json
+++ b/qapi/audio.json
@@ -11,6 +11,10 @@
 # General audio backend options that are used for both playback and
 # recording.
 #
+# @mixing-engine: use QEMU's mixing engine to mix all streams inside QEMU. When
+#                 set to off, fixed-settings must be also off. Not every backend
+#                 is compatible with the off setting (default on, since 4.2)
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
index 2a04ca6ac5..3e50956f48 100644
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


