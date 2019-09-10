Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A268BC49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 23:27:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 716D521A4C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 23:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZveI0hNH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 716D521A4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7pXh-0005vY-Ij
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 19:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37444)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i7pWm-00052o-UG
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 19:26:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1i7pWl-000521-Uz
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 19:26:28 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:34397)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1i7pWl-00051q-RZ
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 19:26:27 -0400
Received: by mail-qt1-x844.google.com with SMTP id j1so10224901qth.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 16:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QPvAIEyjbdHkgFa3D8BV/iy/+lVvKr2RpSl+66ez4lg=;
 b=ZveI0hNHksiNF9IdOHTlNSsfUaGFtEz4dwuFXR8UFDL9DB5cGxgrE/wR6FXXy79Pa+
 42BI4IszZWx2tZhFZ2GI/SLRwSwj9KciufaFEyYzT1AG/JjWX+kmF/TGq55bTRL64pOX
 nezPkQ3GrRtCuJ98Cz7ixHS8IVdOZ7aCQxdqWdf2k+oKPnzY/8WzvEQ/CtUOIOrhrlUZ
 V+WR7T7fgMAMbEZe/TpZyrQYoD9iCh6+aVK94zV4MjS8BW4AtQkFatQ93rtYUA6C9DKQ
 FAmL+WhHB6K27Ei/JUcVTGMjn4kAMcO1cXRK5gR7hjap7bGBCfjjTDvCZBeI8jte6Dvq
 YTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QPvAIEyjbdHkgFa3D8BV/iy/+lVvKr2RpSl+66ez4lg=;
 b=cSZxKvQzZTFORbvkZgD9QUereZEGMkgVyxfAP5ZDuIptY3TayAnQnibocOCxswnlWV
 7VNFOv64aWgS8rctp54qRxpTU40njMzVxjwH3hNuIRZRttVFsFRPBj1CsnSdb5KB95rs
 wcN+rVkTqAaPxzQ1sc5WYewtv8XwAja+YpNB3yK+UuIBgZwjIPOcvQT/asbj/O1v675m
 UuhLyckLPR5d8nuLxk66LsgEFZqs49zvQFt2B+T2x8lqHaj54c+1qzf1Ncnhcr8qZ6EF
 Fx9BPjWtem3c8RYBcnUMNxapt62y3SE/1LHEmXSq1H7KnBHhWoO9l2E2q3jGzH28cjsw
 2uNQ==
X-Gm-Message-State: APjAAAV2ev7G3qN/98r+1cXs3hZnirItyynAbdtGH6x83Nv/OWhfRV9c
 cjmbbI7mRqrPLCSeDxFf1Vw5DwR/
X-Google-Smtp-Source: APXvYqwzqJ8w+LK9f7Yiqd/p0i8LO6dbh9EP05vgwHTUzXiXscLJMC3iME0MbJtE1nktaszU/AQWbw==
X-Received: by 2002:ac8:6746:: with SMTP id n6mr32342947qtp.128.1568157987238; 
 Tue, 10 Sep 2019 16:26:27 -0700 (PDT)
Received: from decltype.home.dirty-ice.org
 (2a01-036c-0113-6ea8-0001-0000-0000-00d3.pool6.digikabel.hu.
 [2a01:36c:113:6ea8:1::d3])
 by smtp.gmail.com with ESMTPSA id z5sm8804535qki.55.2019.09.10.16.26.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 16:26:26 -0700 (PDT)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
 <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?=
 <DirtY.iCE.hu@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 11 Sep 2019 01:26:19 +0200
Message-Id: <3d139426031a400a68d440608ba5e43f0e116cd8.1568157545.git.DirtY.iCE.hu@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568157545.git.DirtY.iCE.hu@gmail.com>
References: <cover.1568157545.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
Subject: [Qemu-devel] [PATCH 2/3] audio: paaudio: fix connection and stream
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Connection name was previously erroneously set to the server socket
path, while connection names were simply "qemu".  After this patch, the
connection name will be the vm name (falling back to "qemu" if not
specified), while stream names will be the audiodev's id.

Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
---
 audio/paaudio.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/audio/paaudio.c b/audio/paaudio.c
index bfef9acaad..19b7e39092 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -2,6 +2,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/module.h"
+#include "qemu-common.h"
 #include "audio.h"
 #include "qapi/opts-visitor.h"
 
@@ -562,7 +563,7 @@ static int qpa_init_out(HWVoiceOut *hw, struct audsettings *as,
 
     pa->stream = qpa_simple_new (
         c,
-        "qemu",
+        g->dev->id,
         PA_STREAM_PLAYBACK,
         ppdo->has_name ? ppdo->name : NULL,
         &ss,
@@ -630,7 +631,7 @@ static int qpa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
 
     pa->stream = qpa_simple_new (
         c,
-        "qemu",
+        g->dev->id,
         PA_STREAM_RECORD,
         ppdo->has_name ? ppdo->name : NULL,
         &ss,
@@ -857,6 +858,7 @@ static int qpa_validate_per_direction_opts(Audiodev *dev,
 /* common */
 static void *qpa_conn_init(const char *server)
 {
+    const char *vm_name;
     PAConnection *c = g_malloc0(sizeof(PAConnection));
     QTAILQ_INSERT_TAIL(&pa_conns, c, list);
 
@@ -865,8 +867,9 @@ static void *qpa_conn_init(const char *server)
         goto fail;
     }
 
+    vm_name = qemu_get_vm_name();
     c->context = pa_context_new(pa_threaded_mainloop_get_api(c->mainloop),
-                                server);
+                                vm_name ? vm_name : "qemu");
     if (!c->context) {
         goto fail;
     }
-- 
2.23.0


