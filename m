Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3385CC282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:37:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F126E206DA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qG6So0vT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F126E206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipAaQ-0000h6-Lg
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 07:37:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60326)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWM-0003jc-7P
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWL-0004Iy-5e
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:10 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:39180)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ipAWK-0004Hi-W0
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:09 -0500
Received: by mail-wm1-x330.google.com with SMTP id 20so2309129wmj.4
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 04:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9PjzHiXwj1KdaDnPbGNelnRbOtkZ/aefiRl2myJ+BXU=;
 b=qG6So0vTYWa8iEipqHSW/GMHxSRvAPLp+/DMdd3nP/LiDn3/96/+9pSiH5fuLymK15
 NTRWF4wfyq2RXShDKap9rNDY55q4As8+U/bicuF2PNwlxlTTCAUEqeD1/pn9Big+XjdP
 W7IkJETfB5i5rjO0+27KR8BafoHwVcLjeacRmfAyWpiN7oyelRFQpRQtBi7cuFOUnAmR
 66M6PKSkucXlWDo8FNji8k+LSEZzt9jKJqGVSy1rV8Aa0/P0XHCRlQZMfm9Q9tJnu5ZM
 Dy4RoLuEQMlC3P5V0lApjJ/r7dZ4n47zsQadZ5GDmYinunaqaWfzWLH4XuIr9O9FI+Gw
 AgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=9PjzHiXwj1KdaDnPbGNelnRbOtkZ/aefiRl2myJ+BXU=;
 b=KfcYQhep/rhcpfFy6UY0lvQMvvs1PMjQ3rGX+kn1jEYulbuUVN416hTRQxbixWrYS3
 9DTyMdOJJaxYiBu1sSA9sQM1n6UcOvGK7Mdwf18oREFWkDdghh+rbv32p6mdx6o2ibVZ
 FNWtBsGfKYQ0DiPmmiKLeqnmM5x7rWA6eUEzQTVE1zi5uOpx4SJ01RVkAiQsx4TI19pS
 3YplthEk2RMpoE4OHUnnVeHcuR52flJ+/1XkpBgNBehGluElpPxmaJoMNn7l9P298nas
 lOmmPUqfGyUG6oimFbvrrFYj5z6RVDlA5axUvGTX+6APaeJD+qmeti1nqkjJt64gMmry
 wwgg==
X-Gm-Message-State: APjAAAU4tW1oTGEd02dNZNpEzNdARxcWJ/VQcDG65I3pqSiISbLxqDnd
 gwRZJ8c81pPE1kazaBXqEmqQl+Cc
X-Google-Smtp-Source: APXvYqwnr9EgKFTIZwRM1eZSGaYf/HS5mTKgumPV9FVDnZWvJwv/VbGA1gybr6iSyYtMM4Uy3wwO7w==
X-Received: by 2002:a7b:cfc2:: with SMTP id f2mr3624754wmm.44.1578486787776;
 Wed, 08 Jan 2020 04:33:07 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id o4sm4037750wrw.97.2020.01.08.04.33.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Jan 2020 04:33:07 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/38] hw/i386/Kconfig: Let the MicroVM machine select the
 SERIAL_ISA config
Date: Wed,  8 Jan 2020 13:32:28 +0100
Message-Id: <1578486775-52247-12-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
References: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
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

When configured with --without-default-devices, the build fails:

     LINK    x86_64-softmmu/qemu-system-x86_64
  /usr/bin/ld: hw/i386/microvm.o: in function `microvm_devices_init':
  hw/i386/microvm.c:157: undefined reference to `serial_hds_isa_init'
  collect2: error: ld returned 1 exit status
  make[1]: *** [Makefile:206: qemu-system-x86_64] Error 1
  make: *** [Makefile:483: x86_64-softmmu/all] Error 2

While the MicroVM machine only uses the ISA serial port when the
MICROVM_MACHINE_ISA_SERIAL property is set, it has to be linked
with it. Replace the 'imply' Kconfig rule by a 'select'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191231183216.6781-4-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 91cf584..cdc8515 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -95,7 +95,7 @@ config Q35
 
 config MICROVM
     bool
-    imply SERIAL_ISA
+    select SERIAL_ISA # for serial_hds_isa_init()
     select ISA_BUS
     select APIC
     select IOAPIC
-- 
1.8.3.1



