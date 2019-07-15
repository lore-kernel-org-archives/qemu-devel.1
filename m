Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC91FC76191
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 21:10:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B872320665
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 21:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDs0Qpy4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B872320665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn8Em-0007Bx-GK
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 17:10:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42292)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1hn8D1-0008N5-7H
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 17:08:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1hn8Cz-0004mV-5U
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 17:08:31 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45085)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1hn8Cy-0004m1-Ve
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 17:08:29 -0400
Received: by mail-wr1-x442.google.com with SMTP id f9so18541119wre.12
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 14:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KkJvtrc3QrV2I7WYyibxflgUNfu3hfn3RhzurnFS0ws=;
 b=GDs0Qpy48j+fWFjAOJq+Z+M3HF7RS/rQA/oUG0yDaLj8EiQuEI+YFLt7FVFdejdCms
 MaMnELG75Nhtd6puW7yTjRQyb2qOOsLwrPM/hACfhVHd/h2AZXhKOG+pLA97ppxJbf3/
 QQzwG7yxJFwyzRQMStIMJcoo1RRl9eyt44CZNE0GoyvOhfoeq5d8xF3o3VLbWPHcpLOh
 YvKr6jtZUiz1vHjZ4LSYWBqvF6maSYU0Wylhx/dRDqbejFYexi40g3mL+J33QVYQMnOS
 Gu42scSW5E7iUzMDzMQjDPloVkAain9CRaefdfFxVNV1o6VZSEvSqWh/JvIX82Mfuc3D
 TBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KkJvtrc3QrV2I7WYyibxflgUNfu3hfn3RhzurnFS0ws=;
 b=ctOnGtaNqrw7zdy5pE8jrsxBMByg6F7C8TZyAaTsZJghFDWXU3adFv+icV9z17zpYK
 nt0AjExII7QWCoQm8zbllJYvAOO281Fb196gt03+MltDIOdborarGBNh7k4yBAw5+eKF
 LGNGlDBkMUOZ59+D3OWV22H9Ohqlg7n4bqGM4knnRJeb2MlB5u5WyGevpzyy3JKWcuaP
 vulkVbY33/Gl7xsMwtSNLbrehAAHeWxgviNXck1p3uclUVNWILld32W0thVkTUO5ssO4
 nUyipBUrSPd0b9/E8k6JYNYWmk8uyPjRnS4Ji3jUgo8CArt/YB75bHk9/+4yj2cbUrmF
 SZeg==
X-Gm-Message-State: APjAAAV/I1Mh8kB8g2wbu9+ImYInqN6w4kADj8rwvQwzSc/hEzwgoGRb
 jOuUAW84lromcUOe/GJGlylzw/S2
X-Google-Smtp-Source: APXvYqy8GIUMuqEr6cQ0g0AQPqxo0EKxob3kDirgMDYzaD9XCY70lK+67Ebrh/uaSJINzAGy4e38hg==
X-Received: by 2002:adf:e28a:: with SMTP id v10mr31600071wri.178.1563224907943; 
 Mon, 15 Jul 2019 14:08:27 -0700 (PDT)
Received: from nullptr.home.dirty-ice.org
 (2a01-036c-0113-31ca-0000-0000-0000-0005.pool6.digikabel.hu.
 [2a01:36c:113:31ca::5])
 by smtp.gmail.com with ESMTPSA id n8sm11513447wro.89.2019.07.15.14.08.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Jul 2019 14:08:27 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 15 Jul 2019 23:08:13 +0200
Message-Id: <807236d168f1c69d19d62e4a3b0f5472fc0d7d26.1563224628.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1563224628.git.DirtY.iCE.hu@gmail.com>
References: <cover.1563224628.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v2 11/14] paaudio: fix playback glitches
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

Pulseaudio normally assumes that when the server wants it, the client
can generate the audio samples and send it right away.  Unfortunately
this is not the case with QEMU -- it's up to the emulated system when
does it generate the samples.  Buffering the samples and sending them
from a background thread is just a workaround, that doesn't work too
well.  Instead enable pa's compatibility support and let pa worry about
the details.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/paaudio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/audio/paaudio.c b/audio/paaudio.c
index f3864e1d50..c8ae1a6eca 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -512,10 +512,8 @@ static pa_stream *qpa_simple_new (
 
     flags =
         PA_STREAM_INTERPOLATE_TIMING
-#ifdef PA_STREAM_ADJUST_LATENCY
-        | PA_STREAM_ADJUST_LATENCY
-#endif
-        | PA_STREAM_AUTO_TIMING_UPDATE;
+        | PA_STREAM_AUTO_TIMING_UPDATE
+        | PA_STREAM_EARLY_REQUESTS;
 
     if (dev) {
         /* don't move the stream if the user specified a sink/source */
-- 
2.22.0


