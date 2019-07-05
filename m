Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65180C46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 19:52:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A3CC2133F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 19:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxLeZO+7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A3CC2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55611 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjUGO-0007af-Gr
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 15:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55638)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hjUEN-0005Sd-Pc
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 15:50:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hjUEM-0004BJ-Kq
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 15:50:51 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:38356)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hjUEM-00049F-EZ
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 15:50:50 -0400
Received: by mail-wr1-x430.google.com with SMTP id g17so823217wrr.5
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 12:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=yDJUvL9nWhLhts5GRxzh+3OuJBbBUiS1ssTSFuvIqR4=;
 b=fxLeZO+7AFx4RLsW1Py7PqJ9GRusLAGI09wVD/k7KO9DRnwKEMl40K1xzy9VefrDl4
 66O1sLDFLMFacqTaMAoFeSD0okyRXROEXmkr9wvd81i6P9hJPSQHwSdipKO+Il5XwYV8
 k1321fQRfWhQHnDDDqmv5uDmcgGsIwMpft08hgxcdGULWfhgeD4LIiP6DdCKPZPO8Dye
 Se6ngm1ekbCdvhRelA762EMJs3pI5bGW3NfGl0wSifqOghqTHlDzEeMCAoBVSKuxJknn
 oN8Rm5Yd2bTQWkni3butBWHPV7Zv982kJ5wlo5m+dmM1sVOpr6pG+mGTOj1rB60nbjAx
 efrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=yDJUvL9nWhLhts5GRxzh+3OuJBbBUiS1ssTSFuvIqR4=;
 b=iN59Vvqqtewcp7SvnzntG7z6UEh3UWxCAXDuLYXYVhlb8bPi/xbdBgBXvv/Jbh3JJD
 Fo+j8AgPW5twOpx4Fs7WmHmpvPv+9KseOUTF8AKvC/47pNXC79x+I8ljM0B9Lqep5K+d
 DWKt7EzxwWkZyRbBItW48C6udUUbuHpynVD8VktZ2bKmbYTAb2Mqbem4K6PQEIO+6Otg
 hQ60veaXljysMfyczB7dB/aV+kO6+X9++HDG3piLtS+8Aeq37X6UznFjvL4JY7LoWX8G
 /QyAT2FuwBf1PxKnkfVSK6PsvUpLICkbKe9B83nkEYh2eVMnIcqCVVc4rt6cZ7nHQlhN
 +vdg==
X-Gm-Message-State: APjAAAVNcqKejSgPy/XBgPa6HaZmWHkJPN84I1jI6YVuD+1aTDPYoCv6
 mki2XAXdJYXBU0zTgSWI6f7qpMnGC4U=
X-Google-Smtp-Source: APXvYqwgbBF2ys4oZAz2MtCSLDPambQZM5LdOHxfNyK+PPz+dNjnNGhe0wmuxnLVtxytT4/1pJ0izw==
X-Received: by 2002:a5d:438f:: with SMTP id i15mr5207861wrq.37.1562356249171; 
 Fri, 05 Jul 2019 12:50:49 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id d10sm11478625wro.18.2019.07.05.12.50.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2019 12:50:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  5 Jul 2019 21:50:33 +0200
Message-Id: <1562356239-19391-7-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562356239-19391-1-git-send-email-pbonzini@redhat.com>
References: <1562356239-19391-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
Subject: [Qemu-devel] [PULL 06/12] ioapic: clear irq_eoi when updating the
 ioapic redirect table entry
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
Cc: Li Qiang <liq3ea@163.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Li Qiang <liq3ea@163.com>

irq_eoi is used to count the number of irq injected during eoi
broadcast. It should be set to 0 when updating the ioapic's redirect
table entry.

Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Li Qiang <liq3ea@163.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-Id: <20190624151635.22494-1-liq3ea@163.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/intc/ioapic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index 7074489..db9e518 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -380,6 +380,7 @@ ioapic_mem_write(void *opaque, hwaddr addr, uint64_t val,
                 /* restore RO bits */
                 s->ioredtbl[index] &= IOAPIC_RW_BITS;
                 s->ioredtbl[index] |= ro_bits;
+                s->irq_eoi[index] = 0;
                 ioapic_fix_edge_remote_irr(&s->ioredtbl[index]);
                 ioapic_service(s);
             }
-- 
1.8.3.1



