Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFB8C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:55:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37809206F0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKQYfVei"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37809206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipArS-0001Im-Ko
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 07:54:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60572)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWc-00047S-C6
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWb-0004UP-7H
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:26 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:35590)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ipAWb-0004Tv-1U
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:25 -0500
Received: by mail-wm1-x32e.google.com with SMTP id p17so2338075wmb.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 04:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tU6eadOpHxdCLO2/As2DBQQOOukvsgPCPd77EIUHGOo=;
 b=fKQYfVeiqIzIF9umosjm6GyV5t7AsbxwOW1Btwi1N/+3mKnwbcA6LxJM2rK6WgC/8j
 ZRfxLcA1dwMaOkZlgthhQCHDIscdTtRnXR2Uwy0Tw3m4OPjWBm9RATmGTJPhrI6TjaVK
 K1YIErnCO35gHvVU15n/pxFbyjTvRs0n/N+gzKnyftwrOYakg5mJuOEh2gUpF/D9kfv1
 COtGLt2shB2hUa9OO+Awc6Yec17TTnDwkAvX2vo+bDQLH2sHN+qGkVuk3BOsa/LYbSN3
 w/9CwaMq9HGpiuaPrAzFceruqtDU3FdUag3tWQz9dnmxee1Vmoa7DgazSsfoz6L3+J/Z
 pIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=tU6eadOpHxdCLO2/As2DBQQOOukvsgPCPd77EIUHGOo=;
 b=mvEVf2dy7M4IL+4j3aPBEMJZDKocA6b2EcyUCffAHVWjP1lr9kHgPvmdQqZ+s/tD6n
 FoDjfs89yBQuoHNHjuzkm5W1k5AYOQqnN3HUxi3Vv83xXQ8DDE5lnqDz5HeDZIrxFTIj
 4VG+QJqK1nNqF1twxyYN0EC6HJOYl7BwzxbUaPs3FQtKFfCCUI56S5W8IHKOEfXXI3yy
 LD75V/w2d7OZdSFrdtcRPPvs9UGlBUjNSPaTO1chgEu87Euo8lxN3gZLYJ7gq3vtBqev
 9W0JczwrH0Vgd+nnP1CiY5Uo9MKsoiH/n92sXTOvhUosJObF3bRqSttsBC4OfQWhgeTK
 5Qsg==
X-Gm-Message-State: APjAAAXBt4ultTP0J67vbx6XxvigWcuWRDQ91TS8qmxs88OFM8k/a50I
 L7tJ9ql4LtWVDszPBkni7ejDJisZ
X-Google-Smtp-Source: APXvYqwXilYPPA/5J97+42APDOl8pjk8bA1FK3bWCLj5mvWtst3d8Sc7hCeWklPJsNg5MwVHZYiPWg==
X-Received: by 2002:a7b:cb01:: with SMTP id u1mr3180513wmj.156.1578486803861; 
 Wed, 08 Jan 2020 04:33:23 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id o4sm4037750wrw.97.2020.01.08.04.33.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Jan 2020 04:33:22 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 25/38] hw/ipmi: Explicit we ignore some QEMUChrEvent in
 IOEventHandler
Date: Wed,  8 Jan 2020 13:32:42 +0100
Message-Id: <1578486775-52247-26-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
References: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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

  hw/ipmi/ipmi_bmc_extern.c: In function ‘chr_event’:
  hw/ipmi/ipmi_bmc_extern.c:389:5: error: enumeration value ‘CHR_EVENT_BREAK’ not handled in switch [-Werror=switch]
    389 |     switch (event) {
        |     ^~~~~~
  hw/ipmi/ipmi_bmc_extern.c:389:5: error: enumeration value ‘CHR_EVENT_MUX_IN’ not handled in switch [-Werror=switch]
  hw/ipmi/ipmi_bmc_extern.c:389:5: error: enumeration value ‘CHR_EVENT_MUX_OUT’ not handled in switch [-Werror=switch]
  cc1: all warnings being treated as errors

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Corey Minyard <cminyard@mvista.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20191218172009.8868-3-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/ipmi/ipmi_bmc_extern.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index 450926e..adf2afe 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -435,6 +435,12 @@ static void chr_event(void *opaque, int event)
             k->handle_rsp(s, ibe->outbuf[0], ibe->inbuf + 1, 3);
         }
         break;
+
+    case CHR_EVENT_BREAK:
+    case CHR_EVENT_MUX_IN:
+    case CHR_EVENT_MUX_OUT:
+        /* Ignore */
+        break;
     }
 }
 
-- 
1.8.3.1



