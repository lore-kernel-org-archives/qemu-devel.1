Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0CAC54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 14:55:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45FD920656
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 14:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="wHKj/viN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45FD920656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT5Ae-0000Kl-EE
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 10:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59998)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrew@daynix.com>) id 1jT59G-0007Dk-RU
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 10:54:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <andrew@daynix.com>) id 1jT59F-0003aa-MG
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 10:54:18 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:38922)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1jT59F-0003ZN-5N
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 10:54:17 -0400
Received: by mail-lf1-x144.google.com with SMTP id m2so14060049lfo.6
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 07:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Ju5oSkgNe0d4rH2rLCOydGzpRFUJq7Gmr1xQg3XTncc=;
 b=wHKj/viNCHxtS7KBtjbui0syCpDaZOh4gFhrCD5op+W1x8B46SQ8AKjJiByisXnwQt
 kmpBxggbef+IPOgk/fXqGZvRQNZsHvJJOonOjX/7RJsthh9lvlVTB7OXW+VehhvgNaZl
 aK0td6ODaZVyWiheaMil+vN8GJdDI2HUAa6OBWRZSXBX6kygmLzQTonBOll1Z2dRcFQu
 AiDWWZQVgGpXxkzZklspkL/HmYErU29CQlOFKhUMau8ybfrqLAM+v+LKN3G0CalEZSeu
 nU7ieA0o/s5YBx1Pd4niV6X6DJfoUeQdpLRJ5oYUjBNUWI9vn45Nk8wIOg/IhWN26DB3
 j+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Ju5oSkgNe0d4rH2rLCOydGzpRFUJq7Gmr1xQg3XTncc=;
 b=VniunUxZy7JXHOobB1mqPaZ/KZ3CX53RD2xtKJHeAKmyOv5TW0ZyJkmIdUBxnUj3Yr
 921ZthxTjt+1IfA3yo7NT/cobeSFAyPaZfQ2YsBzxNhriz8n7LmuDZIRqGQMYM1y3lXw
 4y2hkJDoSuzeygfEpR8Eu4dxiHW4xfB7BL1DAJIjgFfrFHuNvJMSwgdM3pOW6whpVq2c
 ByYBu7pcVcMrk22Z9asWeI4kyJhpQgQMTRsnwnidkPaoG2x6/j25KoRbf4MoHPGFESt4
 i2PZyQRps1rOEmlJpUGUbSZ2smk+IAViLrWwS2wYp4VRiMW7LTWGKoyWDxCqdbXurrXQ
 YnVQ==
X-Gm-Message-State: AGi0Pua2Zyg5HzNu6RMvOgF6Awrn/ZY5yMLKCvqYvErzJdB0pob/6BS/
 a0ZDgriFKqCVljs18Yso+j7epVZVaBPYJg==
X-Google-Smtp-Source: APiQypLq6Y1NfKj+sqH0VhesCI88YSYJ6yFebL4T6vvjtBFEtcDg9sPe/49oRMNdTQuq6TGEhGWubQ==
X-Received: by 2002:a05:6512:10c5:: with SMTP id
 k5mr15928359lfg.0.1587999254288; 
 Mon, 27 Apr 2020 07:54:14 -0700 (PDT)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id i14sm904527lfl.21.2020.04.27.07.54.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2020 07:54:13 -0700 (PDT)
From: andrew@daynix.com
To: qemu-devel@nongnu.org
Subject: [PATCH] e1000e: Added ICR clearing by corresponding IMS bit.
Date: Mon, 27 Apr 2020 18:21:48 +0300
Message-Id: <20200427152148.283771-1-andrew@daynix.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::144;
 envelope-from=andrew@daynix.com; helo=mail-lf1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::144
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
Cc: jasowang@redhat.com, dmitry.fleytman@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrew Melnychenko <andrew@daynix.com>

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1707441
Added ICR clearing if there is IMS bit - according to the note by
section 13.3.27 of the 8257X developers manual.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 hw/net/e1000e_core.c | 9 +++++++++
 hw/net/trace-events  | 1 +
 2 files changed, 10 insertions(+)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index d5676871fa..8878b7ef00 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -2624,6 +2624,15 @@ e1000e_mac_icr_read(E1000ECore *core, int index)
         e1000e_clear_ims_bits(core, core->mac[IAM]);
     }
 
+    /*
+     * PCIe* GbE Controllers Open Source Software Developer’s Manual
+     * 13.3.27 Interrupt Cause Read Register
+     */
+    if (core->mac[ICR] & core->mac[IMS]) {
+        trace_e1000e_irq_icr_clear_icr_bit_ims(core->mac[ICR], core->mac[IMS]);
+        core->mac[ICR] = 0;
+    }
+
     trace_e1000e_irq_icr_read_exit(core->mac[ICR]);
     e1000e_update_interrupt_state(core);
     return ret;
diff --git a/hw/net/trace-events b/hw/net/trace-events
index e18f883cfd..46e40fcfa9 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -237,6 +237,7 @@ e1000e_irq_icr_read_entry(uint32_t icr) "Starting ICR read. Current ICR: 0x%x"
 e1000e_irq_icr_read_exit(uint32_t icr) "Ending ICR read. Current ICR: 0x%x"
 e1000e_irq_icr_clear_zero_ims(void) "Clearing ICR on read due to zero IMS"
 e1000e_irq_icr_clear_iame(void) "Clearing ICR on read due to IAME"
+e1000e_irq_icr_clear_icr_bit_ims(uint32_t icr, uint32_t ims) "Clearing ICR on read due corresponding IMS bit: 0x%x & 0x%x"
 e1000e_irq_iam_clear_eiame(uint32_t iam, uint32_t cause) "Clearing IMS due to EIAME, IAM: 0x%X, cause: 0x%X"
 e1000e_irq_icr_clear_eiac(uint32_t icr, uint32_t eiac) "Clearing ICR bits due to EIAC, ICR: 0x%X, EIAC: 0x%X"
 e1000e_irq_ims_clear_set_imc(uint32_t val) "Clearing IMS bits due to IMC write 0x%x"
-- 
2.24.1


