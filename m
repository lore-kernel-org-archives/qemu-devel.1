Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57601C33CA2
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:58:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 246D1206F0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoD84Moy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 246D1206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipAub-000679-Mx
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 07:58:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60733)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWn-0004QW-7P
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWm-0004bg-6b
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:37 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:54064)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ipAWm-0004bN-0f
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:36 -0500
Received: by mail-wm1-x334.google.com with SMTP id m24so2291877wmc.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 04:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nCFDvneHvDjWpyCU9KybmAmT/8/EAEw7mDdY8fjzHtg=;
 b=aoD84MoyXokD58csuHv96AC8jtTpWWB8KuAHrMgRBSvW/L6VqjvT12xqSrFzZQGPi2
 GAbuxkJrv2u1wOA+WEqhJtkBaYPP42Z5AUFVGoI0jrH2CKLRa9xrB51Dy0H10lSAhBav
 zmqOcg/dxkTfZHoMcRJ4mz2VXtkypKF2iNcjMkyz1FKIOTZbeUg1+e9CMQ0vOMcjD2QI
 f2mdUcSmH2xmcmpNHhOTJp2O+w9l+3eZac6eyvH7SDG5T051YjTdyJ0eAOZftrE3so4A
 6dJkySQFutYmo55HxBugEHAKg8sOtNYNlkYxmwtluBiGFac2w8CZoHYNkWJBsblzx9td
 TEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=nCFDvneHvDjWpyCU9KybmAmT/8/EAEw7mDdY8fjzHtg=;
 b=WV5FhVPx4QvMKkfsg+MbKaPPt/PskRQomkr5881JjzAjvOwFz5WA372fHDdE/vZCwa
 mM+tE46kxJ+Kh75kgayGGKc9DRzarY06cwlGA1yOXQRFfjmi15OUmBFv6uu+r/5qBlnV
 VlGrGpw4bf3vGj5b5QfpafqYV6C5xpu2HKIS4I2EkNZ7VSVRrT6LI8A0iEeOyMuBs5Sn
 6CMfvmPzkFiCs9WOShBTQAYlMsuXhQ5RT+0BEACxkqhiRusOaGGAdJOtatSm2YyZhuP/
 9miKVWWW0dBQ4Ch+sP9G8nZ6BVaf5rDbHScGThcA0zeoIh/e4WBffXe0EDJSxRSvBJnV
 7HTw==
X-Gm-Message-State: APjAAAV57D18cWFI8+3pqMeNj27kD5dQkPY7gFcmOkWy2qvOn18M8W55
 E5zT1YvCKVB6BWC5nvIayi0k4cb4
X-Google-Smtp-Source: APXvYqz0F9gRx/UG72fiEBZ+ZvwrgDolXMcfeXsQMcZhqAU3JmJCsYOSdSVbdy8s5OubTu2q7XIKag==
X-Received: by 2002:a7b:c389:: with SMTP id s9mr3618236wmj.7.1578486814862;
 Wed, 08 Jan 2020 04:33:34 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id o4sm4037750wrw.97.2020.01.08.04.33.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Jan 2020 04:33:34 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 35/38] monitor/hmp: Explicit we ignore a QEMUChrEvent in
 IOEventHandler
Date: Wed,  8 Jan 2020 13:32:52 +0100
Message-Id: <1578486775-52247-36-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
References: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The Chardev events are listed in the QEMUChrEvent enum. To be
able to use this enum in the IOEventHandler typedef, we need to
explicit an event ignored by this frontend, to silent the
following GCC warning:

    CC      monitor/hmp.o
  monitor/hmp.c: In function ‘monitor_event’:
  monitor/hmp.c:1330:5: error: enumeration value ‘CHR_EVENT_BREAK’ not handled in switch [-Werror=switch]
   1330 |     switch (event) {
        |     ^~~~~~
  cc1: all warnings being treated as errors

Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20191218172009.8868-13-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 monitor/hmp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/monitor/hmp.c b/monitor/hmp.c
index 8942e28..706ebe7 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1371,6 +1371,10 @@ static void monitor_event(void *opaque, int event)
         mon_refcount--;
         monitor_fdsets_cleanup();
         break;
+
+    case CHR_EVENT_BREAK:
+        /* Ignored */
+        break;
     }
 }
 
-- 
1.8.3.1



