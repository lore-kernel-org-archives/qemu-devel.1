Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42716C8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 10:26:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BE0720787
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 10:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rdXQpXyl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BE0720787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU6P8-00022T-4x
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 06:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52920)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zltjiangshi@gmail.com>) id 1jU6NF-0000KZ-1B
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:24:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <zltjiangshi@gmail.com>) id 1jU6NE-0003Hi-Ax
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:24:56 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:41956)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jU6ND-00035S-TE
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:24:55 -0400
Received: by mail-pg1-x542.google.com with SMTP id h69so2545576pgc.8
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 03:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=PZw1qikU5QL3z0KwwsBxPolZSBQpYRyX7qlwqGo+OmM=;
 b=rdXQpXylSJGYZC9P9Myp0KqB4TODGm4GSnKJ2H8cCV/lNGtKD8h+XTaI6xC2F8x6JM
 Tyxq5qRpJu3mwBil88gz3xwXbE74h9sWPrTPrxU6zNb9+3XwYvHF5f0EDYavFZZmT3Cj
 KVYaX2ri+Tv3TA8G825zIoHaHG0mwsiWqwoa+Cn6+R43aHMVf9i8cAtKzfU6eiKDAvWA
 Pq8QVv/6QFPOi8UhuWX2TbazJunl1pi22LwnM5FDEgJipMyGfO9I3vK8WcF0pMANo6KD
 QnT1UAe3puJ3qOLpVPJnotR+BaB6rPaZNnoq23pKcKdDYDQKXKYmokPYz9QAnddDOCUT
 KBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=PZw1qikU5QL3z0KwwsBxPolZSBQpYRyX7qlwqGo+OmM=;
 b=QoB+Z7IaGvbNljBLFgCKHPQR9f4MvWTUAwUjroZVGJm9ysa08D8ECQX552L77B1RLj
 /Yjz3hfHxrqprVN3ElonxHt7c9JYLzl+7I7wr7q6kIniugtK4aZFcWGgpvaeMDlTZnMZ
 YdOBUtxZEWQWdEZJT8hECYSEubjCHz1OjuMN21oW7NQ05DkuttoCuFNMpnAzHX580N1k
 LVTbhmhKsbC+Niiz1eCGRJ36uQESyPtsL56clnCBAFLhMt5pTNeY+3MocTwHbvdcWoIu
 Ebh+RYjDGKwuRI3yHE901WW6U4Ng23bJVqxcKz2aj5Xh/KATxE8YsoO6IHholrkQGmr2
 RWYQ==
X-Gm-Message-State: AGi0PuYX+uirE0kJDGrVJBI3AbE2wqcdQsCoIca61GYh45ZE5c0hMf44
 SB0h/cKPj4TiwGC4DAXC+Ys=
X-Google-Smtp-Source: APiQypI2UdctKLdW5JHWhgMg6++CFb83P/PjUY+Oq+rwfUw23PXP9OOwltujFoQK+4P+bkBRRbfjyw==
X-Received: by 2002:aa7:8d06:: with SMTP id j6mr2866255pfe.237.1588242294746; 
 Thu, 30 Apr 2020 03:24:54 -0700 (PDT)
Received: from software.domain.org (28.144.92.34.bc.googleusercontent.com.
 [34.92.144.28])
 by smtp.gmail.com with ESMTPSA id a15sm1397872pju.3.2020.04.30.03.24.52
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 30 Apr 2020 03:24:54 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH for-5.1 V2 3/7] hw/mips: Add CPU IRQ3 delivery for KVM
Date: Thu, 30 Apr 2020 18:22:31 +0800
Message-Id: <1588242155-23924-4-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1588242155-23924-1-git-send-email-chenhc@lemote.com>
References: <1588242155-23924-1-git-send-email-chenhc@lemote.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: Huacai Chen <chenhuacai@gmail.com>, Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>, qemu-devel@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently, KVM/MIPS only deliver I/O interrupt via IP2, this patch add
IP3 delivery as well, because Loongson-3 based machine use both IRQ2
(CPU's IP2) and IRQ3 (CPU's IP3).

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 hw/mips/mips_int.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/mips/mips_int.c b/hw/mips/mips_int.c
index 796730b..5526219 100644
--- a/hw/mips/mips_int.c
+++ b/hw/mips/mips_int.c
@@ -48,16 +48,14 @@ static void cpu_mips_irq_request(void *opaque, int irq, int level)
     if (level) {
         env->CP0_Cause |= 1 << (irq + CP0Ca_IP);
 
-        if (kvm_enabled() && irq == 2) {
+        if (kvm_enabled() && (irq == 2 || irq == 3))
             kvm_mips_set_interrupt(cpu, irq, level);
-        }
 
     } else {
         env->CP0_Cause &= ~(1 << (irq + CP0Ca_IP));
 
-        if (kvm_enabled() && irq == 2) {
+        if (kvm_enabled() && (irq == 2 || irq == 3))
             kvm_mips_set_interrupt(cpu, irq, level);
-        }
     }
 
     if (env->CP0_Cause & CP0Ca_IP_mask) {
-- 
2.7.0


