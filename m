Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49891ECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 13:38:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F7492086A
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 13:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRiO+Yiu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F7492086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFIM7-0007bP-Uw
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 09:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58032)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFIKQ-00063r-Fb
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:36:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFIKP-0001cq-D8
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:36:34 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55337)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iFIKP-0001c6-69
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:36:33 -0400
Received: by mail-wm1-x344.google.com with SMTP id a6so3404342wma.5
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 06:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=Zbk9ADfv/aZgjm2FIWSRUDzxAC8QdUqG74XPrXDWpjM=;
 b=NRiO+YiugOugcCGtjhMlcCXn0xz7uf/peQ5Gv8iBxErVhxlY8funZ05y7nDCiBnvoS
 jUK+RgfwmxyPc+UWKZrez3nj3UrhUCkW8yE+CIByGQdIm0UGqelK9tZX667kAsMUfmka
 3YF8hvX2gFgYvnOId3xLxJObGccs1pELRmy1NOhas//Nv//4jAUeXRVUXBdtH/hQUVmo
 bMJZAUOKggMQeGWTUwt15nTIMp3BrTVXk0v8dxxWwKfx+Am6cDXVaClWnAoIUDtbELOt
 SVhPc58tF7cB6EqI+HKhybQWNUlu9smHjzT8zOotb8hiVDL81OcIrDgzICXMxBwSg/0r
 KKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=Zbk9ADfv/aZgjm2FIWSRUDzxAC8QdUqG74XPrXDWpjM=;
 b=Xv3Ila/Oewn3c3OED6IVL5veo49r+rEdYK9d0NRXaxSsJAyoXt8A1gh6xnqpUggLmZ
 Ct6AohVEdA+2qVXpnxbZ6+qYxJb/TgvoGdGijH0XjXRP8uUDdSQR8sUlHOo/BIUnalE+
 2HPqXh5CD9ZgCbWJfjXhZtRe4cT1ny3DBhuXA9ktne5gcqFFV+LEFa8pb2EAQsEO9baL
 RfkhVboSuVhZ+gqI5p1lEJ801Eo0Uvqud3nU2uYSPDKmgx6qWYcVdZbsh0Xu9HyDHEMp
 Vb9t5SN6TZXXzKhXAc+24XG45M1aUFmXPx4EjX1PMrLRFGh6s9SUyGphInUzZRHZkweh
 I3WQ==
X-Gm-Message-State: APjAAAVdemAzS2om8d/rsd0aWyVzwLWZxQirVH5TDbbqA/OR80u20lCn
 TytAuleWoTKiRC3GdLOZX0K7O2R0
X-Google-Smtp-Source: APXvYqy9f7n9GXVYFrXQLtjDSwIhKlhKTbQS5FeFOEfpD2BRmB26bw0U9lBE3u8OkD+mtwkoe4jHFg==
X-Received: by 2002:a1c:3904:: with SMTP id g4mr4021048wma.116.1569936991624; 
 Tue, 01 Oct 2019 06:36:31 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q192sm4424575wme.23.2019.10.01.06.36.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 01 Oct 2019 06:36:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/8] ide: fix leak from qemu_allocate_irqs
Date: Tue,  1 Oct 2019 15:36:21 +0200
Message-Id: <1569936988-635-2-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1569936988-635-1-git-send-email-pbonzini@redhat.com>
References: <1569936988-635-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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

The array returned by qemu_allocate_irqs is malloced, free it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/ide/cmd646.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
index f3ccd11..19984d2 100644
--- a/hw/ide/cmd646.c
+++ b/hw/ide/cmd646.c
@@ -300,6 +300,7 @@ static void pci_cmd646_ide_realize(PCIDevice *dev, Error **errp)
         d->bmdma[i].bus = &d->bus[i];
         ide_register_restart_cb(&d->bus[i]);
     }
+    g_free(irq);
 
     vmstate_register(DEVICE(dev), 0, &vmstate_ide_pci, d);
     qemu_register_reset(cmd646_reset, d);
-- 
1.8.3.1



