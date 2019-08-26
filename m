Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EC8C3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 20:01:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A05F206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 20:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eshfaByV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A05F206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2LBc-0006mQ-FB
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 16:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47133)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i2L8w-0004rU-IH
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 15:59:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i2L8v-0000k1-GY
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 15:59:10 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:33257)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i2L8v-0000je-Ce
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 15:59:09 -0400
Received: by mail-qk1-x741.google.com with SMTP id w18so15153254qki.0
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 12:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6vKc3KTMZLJZZmLzgCK03pmr6FwqF+2WsP7Qm1coCZg=;
 b=eshfaByV1dIgN+qbK35LY1YTWu5xITDr3OHBbFH/liNXxAnAh9kHbnj7llbgi8lbLj
 BrfE+171JvnoAdOaAps6gWh5sGHnA/XZpC4CIV6wjGmaLaknOqRRqbCNsJlfQzSi0I7f
 YyugO8PeIjYuVtuvj/5WY1cuEliRZZ+m8gP3xFvZaVgnu85emGsqIo8yjSAQ9zvdFnMI
 3cwKjB8R7iuwqc0QvsBjE/UiVoMp4CYeEa45Wk8P1HE11xfLL64ia96a8LZhHle1ze7x
 6mczqY+FYdis0PttDSuyisFq6+TQ/7wXq72jFAJ7rVPWk1lVNpk/WPBsYYz5vzt1QnDU
 PaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6vKc3KTMZLJZZmLzgCK03pmr6FwqF+2WsP7Qm1coCZg=;
 b=TLb+r9zWD+dNOAm3BcazdBSlVqoljeomLKSBd6/ZngZ1r+M7rY3UZWjvOAR5AmuXwG
 yXklO6SGzbiKMysAq6g9RQUilCRUHBrI4OV7Y6Nas/LCdwGP3eV2nGtSaG9uClZY3/BL
 Ai2Om5lSYkCiBRKYrkewXxAxs79QLv5QK4m6/SBh3/l+dc1VomlhXP+293bpgZ0e39zN
 eqZ/Wc4Za39DQrRyRlSm4oDQkDpNWrmm+LD1sNTPUDznVHnx8Gp3vMZ5T4dW0gttslf5
 byUrbJFx01PeDLTmplDuoDN9gPz3kGEcOi8HHYvoEZlGARkyb7UgUODNfMca7PHymt6p
 Zpug==
X-Gm-Message-State: APjAAAUloKKt3oHyQMcQNUue/IBwbVBekxmG1dC/kk/YOKAe6H2vWenx
 Hlf7VA1Q7MIHNs/TlMvB1oeqt74UaVA=
X-Google-Smtp-Source: APXvYqzaa22kZgnGLnDf+9v+3B1MLg0bzLxg1ecnhqVcmQmh9sM4VyJAqMwYZ/ky0KNQTzUVLSAkTw==
X-Received: by 2002:a05:620a:137b:: with SMTP id
 d27mr18842173qkl.161.1566849548777; 
 Mon, 26 Aug 2019 12:59:08 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-61b1-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:61b1::5])
 by smtp.gmail.com with ESMTPSA id v7sm6795459qte.86.2019.08.26.12.59.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 26 Aug 2019 12:59:08 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 26 Aug 2019 21:59:02 +0200
Message-Id: <02d4328c33455742d01e0b62395013e95293c3ba.1566847960.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566847960.git.DirtY.iCE.hu@gmail.com>
References: <cover.1566847960.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
Subject: [Qemu-devel] [PATCH v2 2/4] audio: omitting audiodev= parameter is
 only deprecated
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
Cc: "reviewer:Incompatible changes" <libvir-list@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Unfortunately, changes introduced in af2041ed2d "audio: audiodev=
parameters no longer optional when -audiodev present" breaks backward
compatibility.  This patch changes the error into a deprecation warning.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 qemu-deprecated.texi | 7 +++++++
 audio/audio.c        | 8 ++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 00a4b6f350..9d74a1cfc0 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -72,6 +72,13 @@ backend settings instead of environment variables.  To ease migration to
 the new format, the ``-audiodev-help'' option can be used to convert
 the current values of the environment variables to ``-audiodev'' options.
 
+@subsection Creating sound card devices and vnc without audiodev= property (since 4.2)
+
+When not using the deprecated legacy audio config, each sound card
+should specify an @code{audiodev=} property.  Additionally, when using
+vnc, you should specify an @code{audiodev=} propery if you plan to
+transmit audio through the VNC protocol.
+
 @subsection -mon ...,control=readline,pretty=on|off (since 4.1)
 
 The @code{pretty=on|off} switch has no effect for HMP monitors, but is
diff --git a/audio/audio.c b/audio/audio.c
index ae335dbebb..e99fcd0694 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1412,8 +1412,9 @@ static AudioState *audio_init(Audiodev *dev, const char *name)
         drvname = AudiodevDriver_str(dev->driver);
     } else if (!QTAILQ_EMPTY(&audio_states)) {
         if (!legacy_config) {
-            dolog("You must specify an audiodev= for the device %s\n", name);
-            exit(1);
+            dolog("Device %s: audiodev default parameter is deprecated, please "
+                  "specify audiodev=%s\n", name,
+                  QTAILQ_FIRST(&audio_states)->dev->id);
         }
         return QTAILQ_FIRST(&audio_states);
     } else {
@@ -1548,8 +1549,7 @@ CaptureVoiceOut *AUD_add_capture(
 
     if (!s) {
         if (!legacy_config) {
-            dolog("You must specify audiodev when trying to capture\n");
-            return NULL;
+            dolog("Capturing without setting an audiodev is deprecated\n");
         }
         s = audio_init(NULL, NULL);
     }
-- 
2.22.0


