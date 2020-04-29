Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403E9C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 08:30:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A4F42076B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 08:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+Ip6im6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4F42076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTi7O-0005Bw-3f
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 04:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54630)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTi5s-0003lJ-GC
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:29:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTi5s-0002Ji-4x
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:29:24 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54720)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTi5r-0002JW-Pk
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:29:23 -0400
Received: by mail-wm1-x342.google.com with SMTP id h4so1006396wmb.4
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 01:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sGhpxna5aVKxU3TFJCrqD1PUkNzmXBTRq/95VopA0dc=;
 b=I+Ip6im6J0ttrRnJtAFcFOqGtWrJmdxdXZgKmSciXBFl6ypdgvlauBatSUGWDrMaHf
 NGYFSpq4lJ3ZjTZ2HSuC1SmNZ8eEzdotvxVBxQEq/uYij/QjS1cE1OmhAB3QU1CwOxIu
 1y0Wa7EmSzYb+0JQG1DWtKOogueJkWmUexTOv+W1MM6kX5ycfWqANfNxwIMStLzi2vKL
 ueiru7IIQ5W5QUhsYbRDB5LOKtAXLAKsLrvZg42LpSaBZVnxaYGyEJaj1B1L28goXUxK
 7kQuplwXrbQOTz4in11ro17zBLYr5+lU5bBKcSPuQ+ckdpkkSUcoEFGhV0xpl7zpFu75
 BYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=sGhpxna5aVKxU3TFJCrqD1PUkNzmXBTRq/95VopA0dc=;
 b=lMveElD/N5exS1BdOFJyxW8jEqtNe/7A+Ry/4/05greLpFkpxBhCNQ0D6EpUVrAi0K
 /W/qBt/UDwUXqHFIdNUpdiGiDK3WHykgeo1vFx13+cU/e0JoyhxgmoIncsoH7tE6ZhUu
 mJbvRUYyXQdGPT3CwYFJhtqiqgYu4XLzUc0ndxJecPMPxtEasq/c1tdadwpT3xC2Z0pI
 hhpH3Y/+HA8A4xp28GoYmKq+o3GIWksYTugEqCVhKWWtF6ZdqBIJU+VVjMFzVswENSOb
 ev/9qKlPn6vpQofzf45QBVpPDr/wl4xQorxnnnmS+W7rcbEWlOs5ija7oSTpcRDRspKG
 hKRQ==
X-Gm-Message-State: AGi0PuZ504Y8cPIPtpy7umFk4oVAMa3Klv/KGW6EYgE83rGTo69zBiRY
 /JX78s/gSP/iFPZnjGHezZo7y9AeBvE=
X-Google-Smtp-Source: APiQypIS22DSdUmq9gopVwPMLuKL+vm0XplQsjg7mIEfPiGlqx23HqYx4rk3mMOuo5ywvaHSYca09A==
X-Received: by 2002:a1c:1d92:: with SMTP id d140mr1870366wmd.67.1588148962236; 
 Wed, 29 Apr 2020 01:29:22 -0700 (PDT)
Received: from localhost.localdomain (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id a9sm6373615wmm.38.2020.04.29.01.29.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2020 01:29:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] target/mips/kvm: Assert unreachable code is not used
Date: Wed, 29 Apr 2020 10:29:16 +0200
Message-Id: <20200429082916.10669-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200429082916.10669-1-f4bug@amsat.org>
References: <20200429082916.10669-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::342
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

This code must not be used outside of KVM. Abort if it is.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/kvm.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/target/mips/kvm.c b/target/mips/kvm.c
index de3e26ef1f..050bfbd7fa 100644
--- a/target/mips/kvm.c
+++ b/target/mips/kvm.c
@@ -196,9 +196,7 @@ int kvm_mips_set_interrupt(MIPSCPU *cpu, int irq, int level)
     CPUState *cs = CPU(cpu);
     struct kvm_mips_interrupt intr;
 
-    if (!kvm_enabled()) {
-        return 0;
-    }
+    assert(kvm_enabled());
 
     intr.cpu = -1;
 
@@ -219,9 +217,7 @@ int kvm_mips_set_ipi_interrupt(MIPSCPU *cpu, int irq, int level)
     CPUState *dest_cs = CPU(cpu);
     struct kvm_mips_interrupt intr;
 
-    if (!kvm_enabled()) {
-        return 0;
-    }
+    assert(kvm_enabled());
 
     intr.cpu = dest_cs->cpu_index;
 
-- 
2.21.1


