Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9453EC10F14
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:10:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 608D62086A
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LackDA61"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 608D62086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFi8s-0000Us-45
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 13:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35379)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhrH-0005Ku-NR
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhrG-0003Jr-PF
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:11 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37566)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iFhrG-0003Iw-Jb
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:10 -0400
Received: by mail-wm1-x344.google.com with SMTP id f22so7708260wmc.2
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 09:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=iz9uDsoXfYTqHHYiw4kw2GlIgMTkxYJyyAIl7JwKIzw=;
 b=LackDA61KpmL+54zZOQ7LkQXbAfDSmZpp+jD1getURoorxoN/S0kBF8Io3m2w6RZTh
 pJ8XRW5BKHa5KltRmhq1ZquZr14SubZDwqufJ1E1O8U5rvq8vN8pzcKpWdovz3NCSUlT
 hX0pQzcXhWp596iPvAI0f8B/VAkPtfvkslrNd83RNhWNH2S+YjG+oeRy+jIIzviVMs7y
 6xlr3zHEQiXagqroUkT6h0nPQZ50DD/5gRe3YzgTSRYqtsE2OvdjE/YLZThOb39t1GJU
 HyQs97uuisztsek8885nN1e8cWPsmWqUXz8um7PgkZXkN2O4kw9v419ryskFYtKgXFnS
 ylEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=iz9uDsoXfYTqHHYiw4kw2GlIgMTkxYJyyAIl7JwKIzw=;
 b=aoQQ/yo7ldWAoucORdRobxcULUh9HeXnpH7In2XkG0xvecgiQdAbulxPYV0AmzekMU
 iDD+h76eifXHyV6TU9siUTHwgA5n/cfE0PX1LJ6m18+lDom5EZ+VGRlBB0QtHaTA1j5G
 eUPToVOqx84Nj4Yd4fbHzLKyGGTk5kq8Of7EXwmwTSCvto+2t5upRAplZ1x2M0b2Ky1P
 DA41l/BcAotIG+L65bUkxyfwY4eWYi5gVQxJllH4OWZ4dSehOyrTv7vxEw8RSd/ebVZK
 DvHz3pJybUPWDA5Ly7tUGFDFHNJLCcOu9KAInMMhiRta4yvj43BZcZUrGXsZUMv5eTUp
 7QYQ==
X-Gm-Message-State: APjAAAVnLIj3xaM39TapaRtR8PmJIEEqFRGLd8vjhyJqjcoCjPnclAXJ
 p1breLYjiTx7nVFbXcRDIrR4kF2/
X-Google-Smtp-Source: APXvYqx+q6+3TBj3Krcfkijv+tsu7dv4hY+T1FvDAfKZxcZF/f9atIq90mmSj5qq/T4GWhX8V/vmRg==
X-Received: by 2002:a1c:dd0a:: with SMTP id u10mr3598853wmg.100.1570035129276; 
 Wed, 02 Oct 2019 09:52:09 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g4sm27303990wrw.9.2019.10.02.09.52.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 02 Oct 2019 09:52:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/30] ide: fix leak from qemu_allocate_irqs
Date: Wed,  2 Oct 2019 18:51:37 +0200
Message-Id: <1570035113-56848-15-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
References: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
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
Reviewed-by: Thomas Huth <thuth@redhat.com>
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



