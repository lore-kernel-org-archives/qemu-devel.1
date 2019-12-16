Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0307C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:07:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70CDC20717
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6CPYHGh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70CDC20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igtqA-00021l-5W
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 12:07:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57473)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFj-0005yF-Lk
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFi-0000bL-MX
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:47 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37668)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtFh-0000W9-6B
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:45 -0500
Received: by mail-wr1-x444.google.com with SMTP id w15so8066676wru.4
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=D41f9AHtUnFEFhVN7otZyXIWZtbVHADUeBM3ruO23wc=;
 b=d6CPYHGhF+6RiAhXrHnw1lnXnK6hCY7QgwUydGGVpawmLCidVeYcd3i4yehLdu5LUv
 Lw2ZuR+7W9kWlBnfsk1iZ3eVdFfuoByPXS/LtMWc3dRFJ9RayF7zIbZV52OCBByYWpcI
 XR+3ysRqm0W7rIzqY/dxovdoC2HQnQkjpeASXtgM97AIPhqf9gs5Nx6FkNHkS8MJtKD7
 cntg165gqLZp53C9flcgB+LT+JXyJvysO8M6i0zHh2HtvtCgxTG1kuvj3Ufc/BQPpTc1
 u3Pa81jSa7VFh5uEKH/jS1ORdsdtnv11q4ZtwaK2VBP201y/r9hcJ4qLNJN22ImO18YX
 glmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=D41f9AHtUnFEFhVN7otZyXIWZtbVHADUeBM3ruO23wc=;
 b=GhHf+WnEhbXXS2k2v/Env9c+2kTvN4rCJ0Z+uZoPlnK5LT1K60ovU32aa7TwWcdZPe
 S9daguF1bOh4nDuW9T77QyVkLnfbPTkmc51fIRHK0/wlOgUfyfPdHQ+jvbrBC8xnYLq4
 8tWoHqc9rqY/jzUG3oPDbkMY8d2spC0Y0IJqk1JTZ2sNfhd8XZ6fDKqxgnJ+Oxs7D/x7
 oRg9Qc3DrjJIZTJttaGZ0bfT/ZdYwbkQ1R6tBZL5hIZ+K1BWcwZI4SX5zHqyhYfVA7bR
 dLp/AMH/VKtUo5FbRbLMVKctg0mquYxPmFHRbyQ7glLxi3muLAvaJuTrAYjU2/KEKEa4
 P0gQ==
X-Gm-Message-State: APjAAAXsdUN8h04YqYj+zDZ7GARDQz/TenQgd3YCP6usYlzxqkBGfAhg
 1zkUIPE0McyerjJiVhDaqOPnS9L2
X-Google-Smtp-Source: APXvYqyyBGXRtw8sJf+T/A8U4cJfI0zB+bLW4Zk5Ca6sRAs2eMtS2F2bUXfo120Dc08yXN4YxeZHVg==
X-Received: by 2002:a5d:68cf:: with SMTP id p15mr31613088wrw.31.1576513783877; 
 Mon, 16 Dec 2019 08:29:43 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.29.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:29:43 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 56/62] hw/i386/pc: Use TYPE_PORT92 instead of hardcoded string
Date: Mon, 16 Dec 2019 17:28:40 +0100
Message-Id: <1576513726-53700-57-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
index d706b98..8752840 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1275,7 +1275,7 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl, bool no_vmport)
         qdev_prop_set_ptr(dev, "ps2_mouse", i8042);
         qdev_init_nofail(dev);
     }
-    port92 = isa_create_simple(isa_bus, "port92");
+    port92 = isa_create_simple(isa_bus, TYPE_PORT92);
 
     a20_line = qemu_allocate_irqs(handle_a20_line_change, first_cpu, 2);
     i8042_setup_a20_line(i8042, a20_line[0]);
-- 
1.8.3.1



