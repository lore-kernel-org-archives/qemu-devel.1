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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70787C3A5A1
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 00:33:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B67C22D37
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 00:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3LE/T/Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B67C22D37
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i22xB-0005q0-Es
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 20:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48788)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i22sm-0002UF-Tz
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 20:29:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i22sl-00021L-TE
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 20:29:16 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40674)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i22sl-00020J-Nh
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 20:29:15 -0400
Received: by mail-wm1-x342.google.com with SMTP id c5so13927346wmb.5
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2019 17:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kzgx2650E0fVXX9zEvy6QLqOBlzWHa5+1jbkOPeTG2o=;
 b=X3LE/T/Y1k/8LVPIz/GohuMKAx45ghAfZbU5yXV+ZSXqSno7pvh+tFl6DmnoLS2wmr
 NHmg0iW2BUc4oe8ZaSu7P8uOS2dey2rVks/RKqc05uguIHy+8RN+JeNjKfI1C7iMX3cg
 eF/5CsNSufgYWsInYiG+Hja5/NiQr4JAv3JEznJjEB4MUR/P5qPgeOeDRgZKx5iq/3Mw
 vVi9FoKnmMXu5nJUtLF+LTScVA2cQe6flBzq7TGFINn36vwJgcDi2Mdzc3lo4MC1PCtQ
 D4uxWvWYg/n8uLcAoUpx7iJDPvRU/KNVgPjFS8GC/olrksdHXZeoweWD6c3mSf3PiHMA
 LouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kzgx2650E0fVXX9zEvy6QLqOBlzWHa5+1jbkOPeTG2o=;
 b=a4974qUhmTXoZePWdTM9nUBgS5mtHq7wovPERxQrTWODGa07NFbtKZdyXc4G9Q26v6
 gQaQplVN+3NMpuXRcw6MDaSZJ0mQbCngxcSbVIT1TsSzRAQpJoYbshU2qAIqxP4HCVG4
 pjSbHqU6Q019eoLjJDzh18TKcVuv+Tutf7fH84xH8sYEXtVgwUlyJCQTnxJnrZdvkmNJ
 SRJ8V41t3bzYraEgHI/UMDgOup19M1K9vPHgx7olO13Lz+FsOurXn4i/u8w3kPfT0Z8q
 Z4DCPvLHHpUuXpjELVJ9PKB5TKsBv6NMCHiufbmIFIosPVXCzpAIZdGHVqGbILRzT9SS
 2gCA==
X-Gm-Message-State: APjAAAV09wUj+iQWkJ3OXCxgQGhXdzFSBiDnFRI6gc+DMrkHJdaTnZ6A
 Za9N2RtMG3h8swvAR+nRmeNnNLReB1A=
X-Google-Smtp-Source: APXvYqxCrdClo0IEeC5gKB/BMDsKgv5CDVKqv9tK53F2pKp1NHOCb1mN56HplDplcKUwuX9d0ZfeQA==
X-Received: by 2002:a1c:804b:: with SMTP id b72mr18103789wmd.139.1566779354532; 
 Sun, 25 Aug 2019 17:29:14 -0700 (PDT)
Received: from decltype.home.dirty-ice.org
 (2a01-036c-0113-61b1-0001-0000-0000-00d3.pool6.digikabel.hu.
 [2a01:36c:113:61b1:1::d3])
 by smtp.gmail.com with ESMTPSA id c19sm8662339wml.13.2019.08.25.17.29.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 25 Aug 2019 17:29:14 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 26 Aug 2019 02:29:09 +0200
Message-Id: <5206082e64b6d7b9194e9076180399e5c5183650.1566779143.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566779143.git.DirtY.iCE.hu@gmail.com>
References: <cover.1566779143.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH 3/3] audio: paaudio: ability to specify stream
 name
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
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This can be used to identify stream in tools like pavucontrol when one
creates multiple -audiodevs or runs multiple qemu instances.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 qapi/audio.json | 6 ++++++
 audio/paaudio.c | 4 ++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/qapi/audio.json b/qapi/audio.json
index 9fefdf5186..a433b3c9d7 100644
--- a/qapi/audio.json
+++ b/qapi/audio.json
@@ -206,6 +206,11 @@
 #
 # @name: name of the sink/source to use
 #
+# @stream-name: name of the PulseAudio stream created by qemu.  Can be
+#               used to identify the stream in PulseAudio when you
+#               create multiple PulseAudio devices or run multiple qemu
+#               instances (default "qemu", since 4.2)
+#
 # @latency: latency you want PulseAudio to achieve in microseconds
 #           (default 15000)
 #
@@ -215,6 +220,7 @@
   'base': 'AudiodevPerDirectionOptions',
   'data': {
     '*name': 'str',
+    '*stream-name': 'str',
     '*latency': 'uint32' } }
 
 ##
diff --git a/audio/paaudio.c b/audio/paaudio.c
index 777b8e4718..827f442b6e 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -562,7 +562,7 @@ static int qpa_init_out(HWVoiceOut *hw, struct audsettings *as,
 
     pa->stream = qpa_simple_new (
         c,
-        "qemu",
+        ppdo->has_stream_name ? ppdo->stream_name : "qemu",
         PA_STREAM_PLAYBACK,
         ppdo->has_name ? ppdo->name : NULL,
         &ss,
@@ -630,7 +630,7 @@ static int qpa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
 
     pa->stream = qpa_simple_new (
         c,
-        "qemu",
+        ppdo->has_stream_name ? ppdo->stream_name : "qemu",
         PA_STREAM_RECORD,
         ppdo->has_name ? ppdo->name : NULL,
         &ss,
-- 
2.22.0


