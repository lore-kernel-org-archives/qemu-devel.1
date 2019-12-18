Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6345DC2D0C3
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:44:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31487218AC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QzapCugb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31487218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYgT-000554-P5
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:44:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3f-00072h-2S
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3e-0002WA-2M
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:02 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42121)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY3d-0002ST-5G
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:01 -0500
Received: by mail-wr1-x442.google.com with SMTP id q6so1981486wro.9
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RhBoR/tLrwpSdP9TuRs6Sxp42lksgrEoIqiHxg6Q7mo=;
 b=QzapCugbnZ8RmTONGSO8ow5T/IxVty+EpyHLZj1QfrWXEZ7o2Uqz8e0yOGdJEQYhKl
 5FJGd8q6xbaH1gQNyWVbL2EwOEoqtvGeLIH9oVqbnT9EAjXUZAW34mJsKi8ebzRxxYdt
 3CYRu4LKeO1QotnWlM3w91fYZ11SMwBbdfcYXZzRtvpryznd9EXVtPFUTqv8uxy93rCE
 2/T7I6bRJRZBf+ZIPocyamRk6PI5Y+r+GVA8KEJlHYSjEbaPgkB6nr6058sVcSlklcir
 eeKNCQQk2WDE1IOfrB7rxifA0jLtvCf0CL2KX9/fTCG0jkcj+tGYXlAwRPwxdjN6wrN2
 f86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=RhBoR/tLrwpSdP9TuRs6Sxp42lksgrEoIqiHxg6Q7mo=;
 b=RVq9/Uuk5Z1TVOxLq4bR66ueXgl7603bACGnpzYUg7n1OFZTPteMtFK+tLmFCoQLsm
 LWSNQGrI85P+nZQsyqoGHLiAbh/vGto+mbwxlJmDZnOAC23u3+AvqM3WyEiFPRFOoNFo
 jGWcW92tKHG3nWB0orMmk5owEGikNHOia2LKFpFwUNpbNkPzXASoaOX+qHrElTarrw0A
 hzGpN0igXcLUW7aoAtcneKeJazDrPNWI3baxVJHX9n8bZPd458kjBIUkNbhEd3LnWtut
 hhLwLprXcR/faKqL39WDM9fHYhrIAnvvcpCVuVbl0S3jQjKFMM3AXIjxJlyKB0E1uVXm
 5hgA==
X-Gm-Message-State: APjAAAU7vCqBSiE13+Jv6/69q8a0v0lY+jcNO+3jiq8bnRu0tl+q7XVS
 t/FaPbJ/O3y8yrZGcwrHlywQwYpU
X-Google-Smtp-Source: APXvYqxZmMlcnGWQHdUKFl8p/uoimCk0WeRdjCKxmPWqCd4pU326UY22JXJxU2Pq+kJJG+27cIxqQA==
X-Received: by 2002:adf:f605:: with SMTP id t5mr2408374wrp.282.1576670639901; 
 Wed, 18 Dec 2019 04:03:59 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.03.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:03:59 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 56/87] hw/i386/pc: Use TYPE_PORT92 instead of hardcoded string
Date: Wed, 18 Dec 2019 13:02:22 +0100
Message-Id: <1576670573-48048-57-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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

By using the TYPE_* definitions for devices, we can:
- quickly find where devices are used with 'git-grep'
- easily rename a device (one-line change).

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index ea7320b..67fddcc 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1278,7 +1278,7 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl, bool no_vmport)
         qdev_prop_set_ptr(dev, "ps2_mouse", i8042);
         qdev_init_nofail(dev);
     }
-    port92 = isa_create_simple(isa_bus, "port92");
+    port92 = isa_create_simple(isa_bus, TYPE_PORT92);
 
     a20_line = qemu_allocate_irqs(handle_a20_line_change, first_cpu, 2);
     i8042_setup_a20_line(i8042, a20_line[0]);
-- 
1.8.3.1



