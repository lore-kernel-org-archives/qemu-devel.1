Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD91C33CA1
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:51:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1629F206F0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvGuTorw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1629F206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipAo6-0004iF-SC
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 07:51:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60595)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWd-00049B-ES
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWc-0004VQ-DL
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:27 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:42671)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ipAWc-0004Uk-7J
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:26 -0500
Received: by mail-wr1-x42f.google.com with SMTP id q6so3158691wro.9
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 04:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dVYlivSLcVgxjDh0k8Ch66Ht/NuPzIrFxYhvD6Dg4w8=;
 b=PvGuTorwHy7q+rkb5gBmB87gUPgp2T8danLORidRv6qGzwRKsvUvtzxjGictt2zzFO
 EssczltVXHPB265uyntrC2baxpAP0RqIJMtRcrJBWmN/NcE3G14Y8F4ir1n0IrVzb0o0
 TrLAPSl8jzboDOp2B3iqS1U0iOaRKxTnQZpAbczgUHmZQ95OJQw9gGOuVhcEEmve35Qc
 +0w8HZ7pbj35lesFl0tPSHZHcNtrvMhWiFfb4yxwEelMra257X3Au9SntMhs6O6Q0gLP
 3t1RsE1030G3YECrpb3kTExslmBv/kvFmoSGAructCfM6dcCPSL007R92zUIDA4vG0E1
 t+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=dVYlivSLcVgxjDh0k8Ch66Ht/NuPzIrFxYhvD6Dg4w8=;
 b=IZBWmK//dyivo8iqhPUsqCNBtui+JdgD9dTBt1j5ZZSAFR0e6rcXD/PAAG9KafpVQB
 NvNPIvwQEFuwVKh3ztcn1TiOGzYvGUcRW60S0+yTYcXRfjm72wMI6uuRh026aSNDU1+P
 vRgmOK6SUqdwdxkxfQY8AQehEPi3guOXjdMk5C5ro6NmgWHkJcgvj9nEbVlA+rnMXwMU
 1Ki1E5VC3kcdWcG6dKEnctFHxnlbAI0r9UptlTpOvLBEdDTrjUwKecszIzhxtz/FrxY+
 W+IA5P9yfiQkByKu04wn0F10e7xLlIvGngG+z4HQnkyH5ZSESC49f1jLSnIuRjlI3tUe
 FpeA==
X-Gm-Message-State: APjAAAUgNha5J0vVBNnRlPdUgKG277vdD8l8ZUl25ruSplPuAAWzT7WE
 fPgrrit5yekisL/DHUKdTyIozvA+
X-Google-Smtp-Source: APXvYqz7W1D6Je64+ZXLIqJoGYFzJc/kRDyl6qL7tqwAEDqTCxjeLXeS/fA4fPiCfEjBJ+xrXQFB1A==
X-Received: by 2002:a5d:4b47:: with SMTP id w7mr4575350wrs.276.1578486804998; 
 Wed, 08 Jan 2020 04:33:24 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id o4sm4037750wrw.97.2020.01.08.04.33.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Jan 2020 04:33:24 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 26/38] hw/char/terminal3270: Explicit ignored QEMUChrEvent in
 IOEventHandler
Date: Wed,  8 Jan 2020 13:32:43 +0100
Message-Id: <1578486775-52247-27-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
References: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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
explicit all the events ignored by this frontend, to silent the
following GCC warning:

    CC      s390x-softmmu/hw/char/terminal3270.o
  hw/char/terminal3270.c: In function ‘chr_event’:
  hw/char/terminal3270.c:156:5: error: enumeration value ‘CHR_EVENT_BREAK’ not handled in switch [-Werror=switch]
    156 |     switch (event) {
        |     ^~~~~~
  hw/char/terminal3270.c:156:5: error: enumeration value ‘CHR_EVENT_MUX_IN’ not handled in switch [-Werror=switch]
  hw/char/terminal3270.c:156:5: error: enumeration value ‘CHR_EVENT_MUX_OUT’ not handled in switch [-Werror=switch]
  cc1: all warnings being treated as errors

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20191218172009.8868-4-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/char/terminal3270.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/char/terminal3270.c b/hw/char/terminal3270.c
index 6859c1b..2aab04f 100644
--- a/hw/char/terminal3270.c
+++ b/hw/char/terminal3270.c
@@ -166,6 +166,11 @@ static void chr_event(void *opaque, int event)
         sch->curr_status.scsw.dstat = SCSW_DSTAT_DEVICE_END;
         css_conditional_io_interrupt(sch);
         break;
+    case CHR_EVENT_BREAK:
+    case CHR_EVENT_MUX_IN:
+    case CHR_EVENT_MUX_OUT:
+        /* Ignore */
+        break;
     }
 }
 
-- 
1.8.3.1



