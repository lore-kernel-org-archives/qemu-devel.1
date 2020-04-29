Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86F0C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 08:30:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7374C20731
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 08:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/vWWwHy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7374C20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTi7H-00056D-JV
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 04:30:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54622)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTi5r-0003jV-05
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:29:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTi5q-0002JP-Kp
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:29:22 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51205)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTi5q-0002JA-8t
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:29:22 -0400
Received: by mail-wm1-x344.google.com with SMTP id x4so1010817wmj.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 01:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=s3vuzfzHqrILA6RfaHqkgzWfKCZQlZmqp6m3sNft2FE=;
 b=k/vWWwHyVmftdgJlHL/K5iRhDGaMTz9Y+ThIHtUE+fWLFZ4IKUcQmhWk2U3quCzr9q
 lDYfybt5tcclFPdqzytKPXy7HAEl8pnQ9rfuInmzzqov45UQsNBJzShYJLWi6BtU2r7y
 KG3Tu8Au1xvE5tfERWMj1qOZKqTS+a385p89hFXjRA9Pg0kdMHxZQUH7vSwc2mDHQ0oY
 ud3hP2+OUVfbXpJb8LSNdycO8T43Th0oRY0V7cdHDlpq8/9tW5mgHnigOiIJfFb8Hzw1
 FSLHcwZkV7MWrCsdwT58GFWYcXWzVIBwBUhdcFTF2w509WYIyCF7zlWs7ScWp195nJnI
 3LkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=s3vuzfzHqrILA6RfaHqkgzWfKCZQlZmqp6m3sNft2FE=;
 b=hcX7Taf8UIBNSPkNhyT8OneP7LDAg2CmYVn2/FmOV/K79h55N1DAa4JCIR0zcEjJAp
 rhH4TK36mP/w5S1986zFollsIaXihvWK36oJ41yy6S5rn9u7PwtCizkmJjvVmq5K8AkJ
 HdtLj0GfshN4nK1aTkFUOuEtx6kEhtbC9+98zLawtYJoNR3bl+chfMvaa9rzNfi/KGcE
 P3ReBBSvO/sTEpDv7ZE1/q1g4KhHkUFmxNYkIVimmNi+2JZCm4GopnRCGcSavWYX+b8f
 ZqNYT9sF0SkWjwQH5fpub8kc2sL2rqb7sstgJhwjbJSGiVbi/ggACMWt9AiPpGXlGkxO
 6yCw==
X-Gm-Message-State: AGi0Pub6iy0dcIhFT+KlnutnFoIJfgyoPGmbrcpifeiIcPn8lNl2dfCC
 xiZkxyn/tO7BIhw0JRX+G9Nmd6vqQco=
X-Google-Smtp-Source: APiQypK/ht8IopfGi2eiVWSwdJdodx7tXbgvXyqm7Sh0h+QxdQYFK3wpm/BHBJ5Uv4g6HRMVfywG0g==
X-Received: by 2002:a7b:c390:: with SMTP id s16mr1857960wmj.14.1588148960788; 
 Wed, 29 Apr 2020 01:29:20 -0700 (PDT)
Received: from localhost.localdomain (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id a9sm6373615wmm.38.2020.04.29.01.29.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2020 01:29:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] hw/mips/mips_int: De-duplicate KVM interrupt delivery
Date: Wed, 29 Apr 2020 10:29:15 +0200
Message-Id: <20200429082916.10669-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200429082916.10669-1-f4bug@amsat.org>
References: <20200429082916.10669-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Refactor duplicated code in a single place.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/mips/mips_int.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/hw/mips/mips_int.c b/hw/mips/mips_int.c
index 796730b11d..4a1bf846da 100644
--- a/hw/mips/mips_int.c
+++ b/hw/mips/mips_int.c
@@ -47,17 +47,12 @@ static void cpu_mips_irq_request(void *opaque, int irq, int level)
 
     if (level) {
         env->CP0_Cause |= 1 << (irq + CP0Ca_IP);
-
-        if (kvm_enabled() && irq == 2) {
-            kvm_mips_set_interrupt(cpu, irq, level);
-        }
-
     } else {
         env->CP0_Cause &= ~(1 << (irq + CP0Ca_IP));
+    }
 
-        if (kvm_enabled() && irq == 2) {
-            kvm_mips_set_interrupt(cpu, irq, level);
-        }
+    if (kvm_enabled() && irq == 2) {
+        kvm_mips_set_interrupt(cpu, irq, level);
     }
 
     if (env->CP0_Cause & CP0Ca_IP_mask) {
-- 
2.21.1


