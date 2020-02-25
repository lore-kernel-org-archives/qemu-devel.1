Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D008BC35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:50:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A6D322464
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4vyiXj6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A6D322464
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Zfk-0003JO-Nv
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:50:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52446)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z07-0003NP-4N
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:07:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z02-0003QQ-HT
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:07:47 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:43582)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Z02-0003Pr-Au
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:07:42 -0500
Received: by mail-wr1-x436.google.com with SMTP id r11so14428862wrq.10
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=R+3E//07Zu2jdn1KQND0/s0ZPSqqCrLozXLbsCVH9II=;
 b=Z4vyiXj66obXqVxYnugVtp1AcwMcREMULSZwkF1g7VhsiML81yTu6MqAU8+m1MJNoe
 drqsAAdl6n6qvzHT4JNNRWC/aAvKELOvESL2FHp7do44hE+j4b00S0DHlQm0F3AerSpL
 azshqI47/jzTC8Dtxx0unr37yD679ehDT1OseT20t7lsR14nW3akpAKDRfLjUgFMrC0d
 ov07XqC1fy8Zg+uz+ve16pZz2BNaQyjDIjQBw9JbyyjfyP+JpUFIQdPsLA07hEzICPgj
 IZGfHWLHmm3AF6kN6WiluHRQPuEsuNFIC4WGLmDd70MgOa7PvxcraBcf/4BbuMkhKeeV
 Yihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=R+3E//07Zu2jdn1KQND0/s0ZPSqqCrLozXLbsCVH9II=;
 b=M9AK1I+o/12eq5Bxai2zuGL1LzsVaAbhOwTdwVxVg3uB8Jjky+M+TnWn91Td+AjxzP
 pVmHHmK2f87pWTlWGHueByzyyyArPCg1MixjzUFcKlqv/Q08SzwT7DxnyuLIdboXOJX/
 /f2E/2qJfYOXJ3Lz+tbf24Jmni867nEUXRmxgg5JFqEmXfw6ySkYBD4gARqMsMO/JnmI
 F2GHfBLp+MTLjClpFmwsLZZ9P9+Td6jDJr/MLYuvGwZm3LcfZysS9inGqsplwdOFxg1K
 Fng1wxFsHpNpfCDQKa/fN8DzDL//MNG8DAkqYbYJLRBNWvaT0aDKQ0Uwgqgo4A0oJGFR
 ZAEg==
X-Gm-Message-State: APjAAAW+gMHQsCbJUsQwicE4gphhQoh9bFURW/Qlw6PgQhe329otaD4p
 nQVSadhYliru0WQm0FFt0Qxsi6nK
X-Google-Smtp-Source: APXvYqzAEWh4gV3v1OYHIgDufG1i21QtgeiRzALVq0PCJO7qPd+Awmj6b1aM+mOKsSevEPFt0PFxBw==
X-Received: by 2002:a5d:4bd0:: with SMTP id l16mr76818809wrt.271.1582632461069; 
 Tue, 25 Feb 2020 04:07:41 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id h13sm22709423wrw.54.2020.02.25.04.07.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 04:07:40 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 107/136] hw/net: Use memory_region_init_rom() with read-only
 regions
Date: Tue, 25 Feb 2020 13:07:05 +0100
Message-Id: <1582632454-16491-5-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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

This commit was produced with the Coccinelle script
scripts/coccinelle/memory-region-housekeeping.cocci.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200224205533.23798-10-philmd@redhat.com>
Supersedes: <20200221173049.18134-1-philmd@redhat.com>
---
 hw/net/dp8393x.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index a134d43..6bcdfe1 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -916,13 +916,12 @@ static void dp8393x_realize(DeviceState *dev, Error **errp)
     s->watchdog = timer_new_ns(QEMU_CLOCK_VIRTUAL, dp8393x_watchdog, s);
     s->regs[SONIC_SR] = 0x0004; /* only revision recognized by Linux */
 
-    memory_region_init_ram(&s->prom, OBJECT(dev),
-                           "dp8393x-prom", SONIC_PROM_SIZE, &local_err);
+    memory_region_init_rom(&s->prom, OBJECT(dev), "dp8393x-prom",
+                           SONIC_PROM_SIZE, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
     }
-    memory_region_set_readonly(&s->prom, true);
     prom = memory_region_get_ram_ptr(&s->prom);
     checksum = 0;
     for (i = 0; i < 6; i++) {
-- 
1.8.3.1



