Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9307AC3F68F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:09:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 635BB2467F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIn8b5Ye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 635BB2467F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuf2T-0001qu-1G
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:09:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrG-0004p2-Ex
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrF-0003CO-CN
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:18 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:51541)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iucrF-0003B8-5C
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:17 -0500
Received: by mail-wm1-x32a.google.com with SMTP id t23so2642432wmi.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 05:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DTyTmB3blHTLxdPGZH2ZkYa27bOTCp2Z3S4ce3QZa2c=;
 b=EIn8b5YebcmW98vsvO39G/qlI5u91D2kFfdrrVHgpybuzsBU+3yZnDpvMzTZcpi2gk
 pbk4l3Gv/7ObCgfaZmAbwjj3nichZZciHFpBIGRefWqSyl2q5StyCCaBE2rXq1+NkSds
 s5yKVmzfs7BVl2BElJNuIDYurVEV6sgKhx1TMZsPpp0vivWBkM3UHVxV2UcamhlvwJGt
 cXCWo7RNrJQoQ3k92s/Ng/d9o+3zubguA/+QBVuazi2nqEQliEA5eduV6v3z45h4joHc
 0Caw2Px87RNkjis5jJPYbAwRqUnwNh4tzBOGnxuAiEINKeuPOTH7FdwT23jlbl04ApP3
 2VhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=DTyTmB3blHTLxdPGZH2ZkYa27bOTCp2Z3S4ce3QZa2c=;
 b=fhLsIQ34ZpmOG4cXe6ZJXQ985rmR4/enkhoRvhjl0Cj/Oo8Lep9nZ9NUzQ+cNh1GOl
 PjzhiQzEWjjm/X9DgjXT3hdX+gpaJJj23kkpqpxc9oX7D8nEFdxMSDGffXRiHN7iTjrO
 pyor5YPHhEuHqpfSc4DAUo9Mo8YInwB8oi0T1Gh6Z+p8QE200s/Ii0UoHu0UksZCFVRJ
 8C8knlpFBBesj5CtB9JbeNHcy2n21C4bnMj+Vz0B0jrS55vQfmKCNMKPUlDog0aJIcvv
 7+oG9Vn7AwCLzgGTbr8pD/b6+tqbc4mSsR3DOKgJKvXrYyBBWLxcYJQT5JZ5yON+dRwS
 pkYA==
X-Gm-Message-State: APjAAAVknUrPC23D8wsuSg73zQF0gQwF+z4gntHt7OIZcvBskbjcd+Ub
 Eu3u/w4czJ1whzMfN+T1ABVD3jri
X-Google-Smtp-Source: APXvYqzWYAnYKW9YyXXtZuk1DIGIrPuTfAk0yvx2v3EWW85t4sJ3lUBH+8MTPJBerfcmS7LiSD1zlw==
X-Received: by 2002:a1c:5f8a:: with SMTP id t132mr4365554wmb.162.1579787356090; 
 Thu, 23 Jan 2020 05:49:16 -0800 (PST)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s15sm3073171wrp.4.2020.01.23.05.49.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jan 2020 05:49:15 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/59] hw/pci-host/designware: Remove unuseful FALLTHROUGH
 comment
Date: Thu, 23 Jan 2020 14:48:14 +0100
Message-Id: <1579787342-27146-12-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
References: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
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

We don't need to explicit this obvious switch fall through.
Stay consistent with the rest of the codebase.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20191218192526.13845-7-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/pci-host/designware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index 71e9b0d..dd24551 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -182,7 +182,7 @@ designware_pcie_root_config_read(PCIDevice *d, uint32_t address, int len)
         break;
 
     case DESIGNWARE_PCIE_ATU_CR1:
-    case DESIGNWARE_PCIE_ATU_CR2:          /* FALLTHROUGH */
+    case DESIGNWARE_PCIE_ATU_CR2:
         val = viewport->cr[(address - DESIGNWARE_PCIE_ATU_CR1) /
                            sizeof(uint32_t)];
         break;
-- 
1.8.3.1



