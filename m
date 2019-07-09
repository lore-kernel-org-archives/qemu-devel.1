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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA282C73C46
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 18:55:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F20720665
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 18:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnLwaeVF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F20720665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkvHD-0007d7-QB
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 14:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36807)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1hkuyL-0004Cd-Up
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 14:36:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1hkuyK-0003en-As
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 14:36:13 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38636)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1hkuyJ-0003VS-R9
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 14:36:12 -0400
Received: by mail-wr1-x441.google.com with SMTP id g17so11962029wrr.5
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 11:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ltlh1yijhRgVWTsTNrdWk8L+LDcH/2Yp9VpblYh/XoU=;
 b=CnLwaeVFF5UyXn115HNj5W23YmZD7Vhm/X8QZc+ptR7zQlwFbzzGZWFvrNFqa4RpGv
 FLIZAr/Rh10QKeH+x5oS4AuEFJxspx3F7BETy5XH6vHCL7jktyn7ro18Kym4iM5Cvy+d
 H/+9bUJcLjHbmqYjRCJ/MLuLRFzAT0k5ytOCzzQVLuI5JDxuZmYoS8Kq9KbO0vIKgGft
 8W3QnogLpHbaKPx/MhDycrbVXIRp4tEU550m/BA1O7ITS8NikvVumgNRqzspuWUDjn2I
 nvP1AoX6SZI4yi/5f+HqHOQ1X3OWwt1DAbuE9z39DGCCSejL8hmxFVYQuAHKv7tb232r
 f+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ltlh1yijhRgVWTsTNrdWk8L+LDcH/2Yp9VpblYh/XoU=;
 b=VgVEE93rrnEFg/d+cOE/BmnRqAv492n641oQF2Hy3WoTR5EZHZnUiJAhg+3RoY+SU0
 o6pcQ4s+Mm0gsDagKu81STfGcYukN+WkgNbK9zTGa5oA2T4DkhGIrFHEpiRU8fpabKLK
 qvdhK1qYZwbAGAoE2aAphxqC31XR174/27cbdtUPTlGqZJnrFVAZt26mGR6z1WJMf0vB
 BL/MQCvLUm6vvOcZPeQ75gMETZQ8xdEZCwwLvpzX8/Wb4nuecMk9/ijJtc00eUGOZu+X
 9LYf52bUcHBxtrYpzx1a0wn26fBYcW4jFeRMqrm7irYHKPBLzyo7cR7kEHLQpQERPir+
 KDcg==
X-Gm-Message-State: APjAAAU4Eol7P/gRXTbFNQTAinGE1ucwfyD4Aan0Nh2Ejv6ceXinFPQT
 QHSy6A38yaUdFlzdztu+6VEzN6rK
X-Google-Smtp-Source: APXvYqwfFCzZlVB3B0gWr40oqfsmrkVOpIN6fAZhmegloXWavqHgutLtGhCuqmiHtwpJdv96Xili7g==
X-Received: by 2002:a5d:4602:: with SMTP id t2mr26228409wrq.38.1562697356854; 
 Tue, 09 Jul 2019 11:35:56 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-6e3f-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:6e3f::5])
 by smtp.gmail.com with ESMTPSA id c12sm20565042wrd.21.2019.07.09.11.35.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 09 Jul 2019 11:35:56 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 20:35:45 +0200
Message-Id: <d4f8933c22ec6cce1ca0f65d01c42ef974aee9c9.1562695780.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1562695780.git.DirtY.iCE.hu@gmail.com>
References: <cover.1562695780.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH 05/11] paaudio: do not move stream when
 sink/source name is specified
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

Unless we disable stream moving, pulseaudio can easily move the stream
on connect, effectively ignoring the source/sink specified by the user.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/paaudio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/audio/paaudio.c b/audio/paaudio.c
index cc3a34c2ea..24d98b344a 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -517,6 +517,11 @@ static pa_stream *qpa_simple_new (
 #endif
         | PA_STREAM_AUTO_TIMING_UPDATE;
 
+    if (dev) {
+        /* don't move the stream if the user specified a sink/source */
+        flags |= PA_STREAM_DONT_MOVE;
+    }
+
     if (dir == PA_STREAM_PLAYBACK) {
         r = pa_stream_connect_playback(stream, dev, attr, flags, NULL, NULL);
     } else {
-- 
2.22.0


