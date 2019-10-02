Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016DBC10F14
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:08:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDDD82086A
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ko81eOA4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDDD82086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFi75-0006We-9R
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 13:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35392)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhrJ-0005M9-Ov
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhrH-0003L0-M0
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:12 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53245)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iFhrH-0003K3-Fo
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:11 -0400
Received: by mail-wm1-x343.google.com with SMTP id r19so7971807wmh.2
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 09:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+WoidffDv7dztB6biS4Cazx9LEmSg+eKdaHtEuHIgho=;
 b=Ko81eOA4vN4HlZEfnv5+DmLU6K0OFaHc9nt4EO7Kt7/E1UPEstQuKX0cEFxgUJfBds
 TKDK0wl2wbiB4IScynGrRt6HvkQf1lGgIOxGQIi2DpIAy62JDt9Erfs6JKEZyq7v/UjZ
 MfDxrCQt8HJ5kKKFbp0iyF+SFktSc/m88S3xcOjtth9vCq+koWb9RKtABV7QYPfMmjkT
 mj9vMZk1YvT1DuJ80U6wgJ52YiJ0ZLrzXszXzg/+w1tU0QOSKX+iGDDwKIM6JPW2axzA
 Im+AnAX7V1iXaAtmnOE7n26ogKMnKGrof/kv9CR2bWHBKh7M/BoDAXm0YH+DxAKhyOWb
 UxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=+WoidffDv7dztB6biS4Cazx9LEmSg+eKdaHtEuHIgho=;
 b=EzwbkYLGw97PH0vdT9lQJ9VullbCudffmRfOGK6/9bBEX+Ecw+dNpwZwIg6jar/Dbe
 L2s0yR3swMSHyVkqGSoL7Jmczk9gTU76iMLozqfttyY+myusDjHObecNBoFhsaiBxKi4
 4IDpUJ4sCDCZYIFtsJtVV4SNcohwGupEmv/O04sBRwmFuceb8ilbBUJHcj+AV8IQUHYc
 n6z8M5NPGIkIwZ1JI69wYGsYLMuxXsseMubRP16VoX8pdvlGv6+/3mmKR5OzJDURQJR4
 3FMcrJFoTS/WeDCIFqR7SPlm64ZZ53IYObFlJghsIxtf7gn7bBOGe2Gy4brHY1IuB6Tj
 S7Gw==
X-Gm-Message-State: APjAAAVZTXOfBK7MtsBknb/JmVVP/fGXNGmqC8+65ms4H4phHLsNCNLw
 3t/ozCBQLypO2XyEe15Lb+/1Io3J
X-Google-Smtp-Source: APXvYqyw7eIRYDlkp4E1IB3NzsMgZlO1HTVH4dlVNE5TeH6UPFIG/X0DolIToGGcwx5CnOUVW4GtqQ==
X-Received: by 2002:a7b:c5c2:: with SMTP id n2mr3554008wmk.20.1570035130240;
 Wed, 02 Oct 2019 09:52:10 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g4sm27303990wrw.9.2019.10.02.09.52.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 02 Oct 2019 09:52:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/30] microblaze: fix leak of fdevice tree blob
Date: Wed,  2 Oct 2019 18:51:38 +0200
Message-Id: <1570035113-56848-16-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
References: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The device tree blob returned by load_device_tree is malloced.
Free it before returning.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/microblaze/boot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/microblaze/boot.c b/hw/microblaze/boot.c
index bade4d2..d1d7dfb 100644
--- a/hw/microblaze/boot.c
+++ b/hw/microblaze/boot.c
@@ -100,6 +100,7 @@ static int microblaze_load_dtb(hwaddr addr,
     }
 
     cpu_physical_memory_write(addr, fdt, fdt_size);
+    g_free(fdt);
     return fdt_size;
 }
 
-- 
1.8.3.1



