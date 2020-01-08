Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE59C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:57:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9CFF20720
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uf3xqS+4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9CFF20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipAtk-0004an-Ok
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 07:57:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60609)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWe-0004AT-5c
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWd-0004Vv-4M
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:28 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:32788)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ipAWc-0004VI-UZ
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:27 -0500
Received: by mail-wm1-x334.google.com with SMTP id d139so16419636wmd.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 04:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2fCObtda3dtFVMnkAjzfMw4PP0ps8t+z4lqGgFq4nFE=;
 b=Uf3xqS+4ELIJpm7ViawxoTE+qT9ahInu+fbcyEW3Ck9w9w1xHM9+ChUYGqVOY9aOS1
 xi/wROEpGfxawIkMWgSRaxtCRAIGkNFlYIEI2Jf+3ysA4JX1MWJ04rPTkRLY+CQE6yIB
 HukPc9MIYRDXyDgtXeK/HoL070yz1DzAV73QU7un61OYR63wwwyQX1sDnLlLZh304c+U
 ZxxPoeJcgYlToe5c4YqQhi9QktPf329wwqC9KvIdLGB6CnEWmMY5qYx5AWZTtyAPxB5p
 PgGBe852HAL4ZbtUT5stxeN4R7eFZnP/oUmTKgEZwzihudUzbD1yIAy9f9Ey01iE7D/u
 e25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=2fCObtda3dtFVMnkAjzfMw4PP0ps8t+z4lqGgFq4nFE=;
 b=kg4MqQs7UJz5pVHp5fUFnORidNBxgdI6CJTc0eCVvqcuTy+HlskQ3hcNgRIsok10D2
 eDU/LFkhBYVcqy86kUD8dysn5j5C9QlwuiwX4ZWZxJJG4FqXLU9meOwGXQZgA1QfIoXd
 JaeMmVnAYCTSnzToX6XqSL4qJxQHVY/CutdZwCyy//er3MuxY9FDNIKLP0K4/boynxk9
 ADc4s0tGKaisoib7PsviTfin1dy0xD9VkMxdSv+oXnJfywTahGYeIUdM46YpskNT/W39
 pUdHqdwlVRgNDN3cH94U7SV4ipMnLYKM/SEty+b0bdRBu8nSkICVjrcONeZU4ozvxFXH
 cwKA==
X-Gm-Message-State: APjAAAVBJibkb2exZYrmD3lEqWmW0y1x7HHDu0u/iGchS1xjSXI5i7gv
 e/nJFH2GRfeQ15knIaacMgyrhr5I
X-Google-Smtp-Source: APXvYqyA0b4mNM98RcHV53YUofbTs2+iVKgTTeOzjZqgiLC7LaWjw3mgLUqntSVcudvVygctM6fhiQ==
X-Received: by 2002:a7b:cfc2:: with SMTP id f2mr3626384wmm.44.1578486805742;
 Wed, 08 Jan 2020 04:33:25 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id o4sm4037750wrw.97.2020.01.08.04.33.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Jan 2020 04:33:25 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 27/38] hw/usb/dev-serial: Explicit we ignore few QEMUChrEvent
 in IOEventHandler
Date: Wed,  8 Jan 2020 13:32:44 +0100
Message-Id: <1578486775-52247-28-git-send-email-pbonzini@redhat.com>
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
explicit all the events ignored by this frontend, to silent the
following GCC warning:

  hw/usb/dev-serial.c: In function ‘usb_serial_event’:
  hw/usb/dev-serial.c:468:5: error: enumeration value ‘CHR_EVENT_MUX_IN’ not handled in switch [-Werror=switch]
    468 |     switch (event) {
        |     ^~~~~~
  hw/usb/dev-serial.c:468:5: error: enumeration value ‘CHR_EVENT_MUX_OUT’ not handled in switch [-Werror=switch]
  cc1: all warnings being treated as errors

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20191218172009.8868-5-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/usb/dev-serial.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index 45cc741..2ba6870 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -479,6 +479,10 @@ static void usb_serial_event(void *opaque, int event)
                 usb_device_detach(&s->dev);
             }
             break;
+        case CHR_EVENT_MUX_IN:
+        case CHR_EVENT_MUX_OUT:
+            /* Ignore */
+            break;
     }
 }
 
-- 
1.8.3.1



