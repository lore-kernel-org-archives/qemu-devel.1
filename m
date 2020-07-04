Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B055C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 15:46:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C93EE207D4
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 15:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EklGo+n/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C93EE207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrkN7-0003y1-WB
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 11:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrkGv-0001rs-FN
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 11:40:09 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31964
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrkGs-0007gO-Dx
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 11:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593877203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wevOFGWECaRJOmLpbzON6N0ynWLO2tBiVdtI/WyaADw=;
 b=EklGo+n/WnsSnP4RjPQNewp1EUQG6IfrToSDa9IY0SGXbCeFYXuSELk8OdGuaxxFIGDv9n
 pEJkO/sjLXdR7vmI06WWc0C8kKlTZsbM1TZ3+c80iaUIahNWhjWrTm/fl9uU6o/eyb/mA+
 UV53MJ+eA4qkJwZmrqZ/7yuve5EALe8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-tPuFxYhQMo2tsWT4m7kYyQ-1; Sat, 04 Jul 2020 11:40:02 -0400
X-MC-Unique: tPuFxYhQMo2tsWT4m7kYyQ-1
Received: by mail-wm1-f71.google.com with SMTP id y204so28646509wmd.2
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 08:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wevOFGWECaRJOmLpbzON6N0ynWLO2tBiVdtI/WyaADw=;
 b=WrugTm95GO8fjgjqi8VX12zRXAplHpkZ8F2fDULHpYYztXduBCK6IM0cMdnQFXlZi8
 JYa2uS89vj4oVW/UQ2C5pWcqA0lABGXpLiNyN7FOqv0TTt/fwyeuVJxkFBXlnXJFethG
 qFefWT1M9py83535kpWUbxXeB1rVdVF+4FLPwVKw9QJJFnHL/spdQJNojwBevcAwiuKo
 iWKZPouwvCJBWAkx2T3EGCe29lkAFxkmbP5XURrDwrw5g7N3n79uI/3wVj0an1mghOFR
 rl2dV+LvYQlyJFJVxxpcoqBZvUbfKMPR0cFBBbf8ockVep0zOyp5cZ1JDHVUiON5mfHB
 s7XA==
X-Gm-Message-State: AOAM531kwIUHhqXtTACiyj5nfAxrIt5cB4LS+NZUD5a7CzVP1ZrVxF3F
 yqR7nI2eZRRW7HJifUqhDMZmpY0gU04/p1jGOKLPUcckLijBWh1S0XdElz5l7e8yIpqteH9HndI
 Qfe4lzNn9S/BS/jQ=
X-Received: by 2002:adf:e701:: with SMTP id c1mr42222368wrm.350.1593877200718; 
 Sat, 04 Jul 2020 08:40:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7bRq3+QaGDlbCyiTBMme4FfYVY7TosEB0YYMwsTU9tY8KuV4ltQNPb9RIjotuQTPhhrgyYQ==
X-Received: by 2002:adf:e701:: with SMTP id c1mr42222337wrm.350.1593877200575; 
 Sat, 04 Jul 2020 08:40:00 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id n14sm17970909wro.81.2020.07.04.08.39.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 08:40:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 09/23] hw/display/tc6393xb: Emit warning when old code
 is used
Date: Sat,  4 Jul 2020 17:38:54 +0200
Message-Id: <20200704153908.12118-10-philmd@redhat.com>
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
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 11:39:20
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/display/tc6393xb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/display/tc6393xb.c b/hw/display/tc6393xb.c
index 49a676d1b0..e4900e9502 100644
--- a/hw/display/tc6393xb.c
+++ b/hw/display/tc6393xb.c
@@ -21,6 +21,7 @@
 #include "ui/console.h"
 #include "ui/pixel_ops.h"
 #include "sysemu/blockdev.h"
+#include "hw/qdev-deprecated.h"
 
 #define IRQ_TC6393_NAND		0
 #define IRQ_TC6393_MMC		1
@@ -556,6 +557,8 @@ TC6393xbState *tc6393xb_init(MemoryRegion *sysmem, uint32_t base, qemu_irq irq)
         },
     };
 
+    qdev_warn_deprecated_function_used();
+
     s = (TC6393xbState *) g_malloc0(sizeof(TC6393xbState));
     s->irq = irq;
     s->gpio_in = qemu_allocate_irqs(tc6393xb_gpio_set, s, TC6393XB_GPIOS);
-- 
2.21.3


