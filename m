Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BB6C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 15:49:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F0DF207D4
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 15:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cz3QznPH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F0DF207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrkQC-0002u1-GW
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 11:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrkHv-0003RR-V2
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 11:41:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46950
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrkHu-0008OE-2K
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 11:41:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593877269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EtUEaayxY7dmCSI9Atr+yr9J3sNs3cVN+JMD3iSh+ak=;
 b=Cz3QznPH+UCqtY8etVwDAmgLQz1v668jVw4Fs7BEaTXP5PA3W7+pgMAysVefzl9HGYz9oK
 HzrI47kLHPmaa7ErLJ2DYUsHPNXl3J+PwjxuWT8AIuQTSotDbTVhoIs0vdIQ+DPeEpxO1k
 UM4dNj1fJmitbJe4Wu+ayxzL3MZ2nps=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-R1PGXlkwP3S8JUJaEBuT4w-1; Sat, 04 Jul 2020 11:41:07 -0400
X-MC-Unique: R1PGXlkwP3S8JUJaEBuT4w-1
Received: by mail-wm1-f70.google.com with SMTP id t18so39730956wmj.5
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 08:41:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EtUEaayxY7dmCSI9Atr+yr9J3sNs3cVN+JMD3iSh+ak=;
 b=bf/ZyMrDM2qjSBcGmMOG88YaZtHEkCw5vm+L0S8OAqHr+CUBGURgspc2QgIRCSzoAJ
 spryzWAsICujChVUZnlRO3wqVRAKIBw0i3RK9pMJ0QYeAgHxh6fcmgQATz2Alje2CFLD
 Ew5n3wEL9sjHG0SKN5J2U/gt87/R8CZZtlt4TAuzv8tVdnqPVtOozsY7++y2iB7sqsWT
 9xx541qP52p5Tkn1F81eH/bLfjm1BTWy1GU8//G8HsSy3y+EwfBcxYIxHVtUTDWDI6EK
 w01gXFFFmNHRc36yw2gpHSBWmvFmee/QzA1JkxCDGvoVDrzZRrzxgsr0QDDHuvxuhRCF
 LEqw==
X-Gm-Message-State: AOAM530ZgVz/Y+3A3XiTtyHsRHo6thkyl9AX+5LRHQQl3JTdE9HlXgWx
 U7wm8F8szqcqgyXzjwZkcl84RP/oQsiSWoTkCJIYgDyNUNMXabLyMBgTEhQf94oAJ4ctAhXa13G
 RUkYqFIUC93K3LnM=
X-Received: by 2002:a7b:c84d:: with SMTP id c13mr41373485wml.170.1593877265247; 
 Sat, 04 Jul 2020 08:41:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBQ+oFQ07HIPe/VONHqPVER0qLoAra3sFJaOR728rzbo9eCzhVkGvzuwBIXrIuo+Dcy5zd6g==
X-Received: by 2002:a7b:c84d:: with SMTP id c13mr41373449wml.170.1593877265082; 
 Sat, 04 Jul 2020 08:41:05 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id v6sm4904514wrr.85.2020.07.04.08.41.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 08:41:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 21/23] hw/riscv: Emit warning when old code is used
Date: Sat,  4 Jul 2020 17:39:06 +0200
Message-Id: <20200704153908.12118-22-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200704153908.12118-1-philmd@redhat.com>
References: <20200704153908.12118-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 11:39:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>,
 qemu-riscv@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This code hasn't been QOM'ified yet. Warn the user.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/riscv/riscv_htif.c  | 4 ++++
 hw/riscv/sifive_uart.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/hw/riscv/riscv_htif.c b/hw/riscv/riscv_htif.c
index ca87a5cf9f..bd080dbefb 100644
--- a/hw/riscv/riscv_htif.c
+++ b/hw/riscv/riscv_htif.c
@@ -30,6 +30,7 @@
 #include "hw/riscv/riscv_htif.h"
 #include "qemu/timer.h"
 #include "qemu/error-report.h"
+#include "hw/qdev-deprecated.h"
 
 #define RISCV_DEBUG_HTIF 0
 #define HTIF_DEBUG(fmt, ...)                                                   \
@@ -238,6 +239,9 @@ HTIFState *htif_mm_init(MemoryRegion *address_space, MemoryRegion *main_mem,
     uint64_t fromhost_offset = fromhost_addr - base;
 
     HTIFState *s = g_malloc0(sizeof(HTIFState));
+
+    qdev_warn_deprecated_function_used();
+
     s->address_space = address_space;
     s->main_mem = main_mem;
     s->main_mem_ram_ptr = memory_region_get_ram_ptr(main_mem);
diff --git a/hw/riscv/sifive_uart.c b/hw/riscv/sifive_uart.c
index 9350482662..1a5890d5f7 100644
--- a/hw/riscv/sifive_uart.c
+++ b/hw/riscv/sifive_uart.c
@@ -25,6 +25,7 @@
 #include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/riscv/sifive_uart.h"
+#include "hw/qdev-deprecated.h"
 
 /*
  * Not yet implemented:
@@ -183,6 +184,9 @@ SiFiveUARTState *sifive_uart_create(MemoryRegion *address_space, hwaddr base,
     Chardev *chr, qemu_irq irq)
 {
     SiFiveUARTState *s = g_malloc0(sizeof(SiFiveUARTState));
+
+    qdev_warn_deprecated_function_used();
+
     s->irq = irq;
     qemu_chr_fe_init(&s->chr, chr, &error_abort);
     qemu_chr_fe_set_handlers(&s->chr, uart_can_rx, uart_rx, uart_event,
-- 
2.21.3


