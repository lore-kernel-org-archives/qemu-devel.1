Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945C3C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 15:24:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AD6920661
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 15:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Olp/L0E9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AD6920661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1ts4-0004zP-CV
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 10:24:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54156)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j1trT-0004ao-Hm
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 10:23:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j1trS-0004Qx-KR
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 10:23:35 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34863)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j1trS-0004QS-FG
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 10:23:34 -0500
Received: by mail-wr1-x444.google.com with SMTP id w12so2867718wrt.2
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 07:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=0KVa8dFcX9dZEaPZuajWt7yQlRiUOO7AefwWyVC4W9M=;
 b=Olp/L0E9Qt7y4qIWW2aPPYhUF7w0RMF8ilksW73I9DLShLHIKJcHs16ITtlRxhoKLE
 nIoKHp9gxhdQ5SNc6+jdjxLHkM/RUNNK3CZIvhGtVqJw7WD6KoCUPLgd4avXNSmJXP0z
 5lrdM39pmP6RhZkFUDH2L1RWzORazkLCOpYdWM3zx6fGgThkJXwqg7W0031tolf0pfqZ
 JiKQd+gDjLtXQeubycyPC7usoZUsvoU1VzlLT9VMBMJ0XpsLMlFwkocUsOMmPf5Nw+kR
 Qr7mMNOoIprBLQ5i9getxw9MWCyOSwrYd/mfYJRPWUHlkceAx5UdNB0X33qjA3ed3Af6
 KL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=0KVa8dFcX9dZEaPZuajWt7yQlRiUOO7AefwWyVC4W9M=;
 b=JZp9jFERakUjfvu436zhjfW74HX2lN6iV8rKz4P52Whbn3Pf4KU1/kUI+Fj4YhVFH6
 /TOpmTISaLpl7Y/gtL/9DW1JiK6N1wEAeOvSrltwZX9f8hHEiUX49ylccyQuktrU2sqh
 cs8ipbFOX6x1IB/Nzyg3H566zpAiYptGg0ASDQlyiZ0SW53wJPYr2q/O/uMttB+AWh9n
 HtxblBZLdcdJUzw0JaUf5VD3G4ARexX/3oYkILPHZg8GtbX+yPaJBfc3PfzLQAZOv/8R
 +esN7kgAUkftE14WMhOJIkqqAfnQPpI5szmrWIyjuVBHfOY804tI8wyh6BLWWwMgDMmw
 ONTg==
X-Gm-Message-State: APjAAAVHBuxVMppOWOyczbZje0Q9kNBf6a7H0wbKc4xzeFhurL38bona
 myv7rbSk70mgVkxK7Yru6lyT8yDO
X-Google-Smtp-Source: APXvYqz0nGDgu3rewB2yf5p3BVPTu2zjxi8mz818peVme+0KFU/venTGzJv7TNmIY8AbCq+4sGY6Sg==
X-Received: by 2002:adf:b352:: with SMTP id k18mr15437207wrd.242.1581521012925; 
 Wed, 12 Feb 2020 07:23:32 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id x6sm1003102wmi.44.2020.02.12.07.23.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Feb 2020 07:23:31 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/i386: enable monitor and ucode revision with -cpu max
Date: Wed, 12 Feb 2020 16:23:29 +0100
Message-Id: <1581521009-44121-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
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
Cc: ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These two features were incorrectly tied to host_cpuid_required rather than
cpu->max_features.  As a result, -cpu max was not enabling either MONITOR
features or ucode revision.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 32efa46..92fafa2 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6414,7 +6414,9 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
             error_setg(&local_err, "CPU model '%s' requires KVM", name);
             goto out;
         }
+    }
 
+    if (cpu->max_features && accel_uses_host_cpuid()) {
         if (enable_cpu_pm) {
             host_cpuid(5, 0, &cpu->mwait.eax, &cpu->mwait.ebx,
                        &cpu->mwait.ecx, &cpu->mwait.edx);
-- 
1.8.3.1


