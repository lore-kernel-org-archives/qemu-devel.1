Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B906ECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 13:40:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37B8B20815
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 13:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmJrF8Sj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37B8B20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFION-00024O-2L
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 09:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58049)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFIKR-00064x-9L
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:36:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFIKQ-0001dk-CI
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:36:35 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40940)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iFIKQ-0001d2-6D
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:36:34 -0400
Received: by mail-wr1-x444.google.com with SMTP id l3so15558208wru.7
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 06:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=1pkb/xxA0Q1jhhvqUg4yWzv1bTQ2+Quoe621ugFPlfQ=;
 b=SmJrF8SjcrcfJRtHSwE0H73LcQWxRbQdy3gsljzTtZRg5IeliTCSQ57dQLtJ1a8sID
 UGPY8Zcx+XzPSMSu05lqynPPEPruUJ86jlkQUhB9hAsqV7rgySJ7NV7s+bZyLoL6quME
 mLiW93ZGaqF1OBuz/NCOCGpFUROUvBfslZlv1vNwFzrGbJSmJcM27aqwn9eN9TX8horK
 w9mRUdsbL/tMT+rQEPyJeQZWDU3IXlvml+IFon1HRcMXEewfUG3oL1rYaYBNlUL/byPm
 +N7Mh6+cnf2Q1N4/nhs+vZ3w+NLvpi4jKUly1JLuJrcTkjjNPHmbArsBRQPfshZJUAoL
 9jow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=1pkb/xxA0Q1jhhvqUg4yWzv1bTQ2+Quoe621ugFPlfQ=;
 b=pqK6K3O3zFhrFrQVJFlZbzT1qKIT1EyUXKHOp8xkWK3XAw2tBWO0aIkLQt0FPZYt72
 TMvL6O3spQ7DAXFrtvbOGXc9GU02W/g3GnGrH0gV8Ceype0z6Tqx+2AGTLut4FFR3MK7
 bGvjXaJsOkOLLGNGNskRB4mrdQYQbd0fNfGPEB9CwjuzEnJCHD92mJkNrw2fe4OT+s5q
 nokAJsv8lAB/yvjBWRXWMhl/abtG/nG3RTlC1Z+9RQNzIe2GdCUIKTUduCGOp1TpuBmr
 OYghRjZtYm9Gev/YThkqsOO0LZoVW4cDwQLE9nu52TwOUoAfB3nKB1LeBihwTYp5Pfw5
 hMMw==
X-Gm-Message-State: APjAAAXt69rdmGnRo8Z1sE0F9gHqBmHrNDh/MGwQrR4PWQ0HpQJ5OaqY
 nKOFl9uQ4E0M8tc9j7+u3uuLHX63
X-Google-Smtp-Source: APXvYqxmsbUj1UX0DV/N62uUEhdPZqJ9rU1FvXkwiS3SN165fxB727/d6jfDlDRBmCA42DOo+uUKog==
X-Received: by 2002:adf:cf0e:: with SMTP id o14mr17627408wrj.277.1569936992349; 
 Tue, 01 Oct 2019 06:36:32 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q192sm4424575wme.23.2019.10.01.06.36.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 01 Oct 2019 06:36:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/8] microblaze: fix leak of fdevice tree blob
Date: Tue,  1 Oct 2019 15:36:22 +0200
Message-Id: <1569936988-635-3-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1569936988-635-1-git-send-email-pbonzini@redhat.com>
References: <1569936988-635-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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



