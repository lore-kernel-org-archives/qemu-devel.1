Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A53C3A5A8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 17:21:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D71EA21726
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 17:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlOwBBa3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D71EA21726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5YyA-0007G5-Ch
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 13:21:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48379)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i5YqT-0001JZ-Hj
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 13:13:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i5YqS-00070K-GE
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 13:13:25 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35713)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i5YqS-0006zr-9F; Wed, 04 Sep 2019 13:13:24 -0400
Received: by mail-wr1-x442.google.com with SMTP id g7so22152408wrx.2;
 Wed, 04 Sep 2019 10:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1lvnZRDBY+QqCszElvqzfXUD36KMQAFLJctTSYyNnFw=;
 b=KlOwBBa3KvDzeE+NmXwIAS0i/EzRwkIeqV1tPmVMLEkp6M+CsD4POgqa0w1//AkBni
 ILUQOnqULXbfmkxVvQx72WeOAnKZfa8bJeVwc1S/P7hL3NrvrZMw2AvRnAK7c3dCSOjK
 jFnY4elPjAq3xiUrVdA0s85uoGU/V3pgl8mujkNhcZ7ec0NLX+fVOthI91yZCYYbdBg+
 h9HUHJb5vLlPWm3DN2ERtAueQ/7tNVAsInUWuC29gTim2kGPpmgvgNh8uOIcgUfLe6XV
 SlAxUytVnmUA76m3cVjcKbd/M2rqYMGbnftWTl+NXxrNSLeuueAsX0iO77obYfquTi4h
 aqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=1lvnZRDBY+QqCszElvqzfXUD36KMQAFLJctTSYyNnFw=;
 b=cWZwUtIg1wN8VVX8Kidz46S5jUhpsldiciQOg2vVE9Sc9TD7HQvUsmvhjKZjV9sHQB
 Swx+ISGSt/pFUDFgnRjBTrmiteGBXszNuxnkdGjayacX+fx1VLEbm0fott9QFNezFcna
 Y6paHa+WqCuDGQmLWdblIb4QujsMzWRuTmrvT8lKxBkhkKbNSC8Ihjnp3+JNUNeZvm0L
 tfhFOTVZ+L/68U60pWa7g6BltAnzzqa+AfywbO7XFa9LqsYM8meYhL43JrROncJlygTK
 mecu1FzW3oOa4F19SnRDpg2iPcOKwzMJF4qzvPu7Kw6RAGeP9x4pszaTnOLaVQwd7Bit
 Ol4g==
X-Gm-Message-State: APjAAAVfj0WlpFS8aQMSd/Bu6nBXIj71Qq6hT20ec59FHTbZGE+bhHXd
 ajR1E0ocYQkblHywyhEsXGc=
X-Google-Smtp-Source: APXvYqzThQn47wJCegsxynyHpCYZJmgM6G5mxlXjZV51xLk8Uj3Kl4rUmS5bDoM6m/QmmzJdz/fXwg==
X-Received: by 2002:adf:f48e:: with SMTP id l14mr32580480wro.234.1567617203331; 
 Wed, 04 Sep 2019 10:13:23 -0700 (PDT)
Received: from x1w.redhat.com ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id p19sm2339512wmg.31.2019.09.04.10.13.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 10:13:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Peter Maydell <peter.maydell@linaro.org>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-devel@nongnu.org,
 Pekka Enberg <penberg@iki.fi>,
 =?UTF-8?q?Zolt=C3=A1n=20Baldaszti?= <bztemail@gmail.com>
Date: Wed,  4 Sep 2019 19:13:04 +0200
Message-Id: <20190904171315.8354-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904171315.8354-1-f4bug@amsat.org>
References: <20190904171315.8354-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [RFC PATCH 03/14] hw/misc/bcm2835_property: Handle the
 'domain state' property
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, Clement Deschamps <clement.deschamps@antfield.fr>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The kernel is happy with this change, so we don't need
to do anything more sophisticated.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/bcm2835_property.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index 399f0d9dd5..d8eb28f267 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -127,6 +127,14 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
             resplen = 8;
             break;
 
+        case 0x00030030: /* Get domain state */
+            qemu_log_mask(LOG_UNIMP,
+                          "bcm2835_property: 0x%08x get domain state NYI\n",
+                          tag);
+            /* FIXME returning uninitialized memory */
+            resplen = 8;
+            break;
+
         case 0x00038002: /* Set clock rate */
         case 0x00038004: /* Set max clock rate */
         case 0x00038007: /* Set min clock rate */
-- 
2.20.1


