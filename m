Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF38C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 15:52:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFBF12084C
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 15:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="as7CJOD2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFBF12084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrkSo-0000Vw-Qn
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 11:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrkHP-0002dV-9O
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 11:40:39 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44589
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrkHM-00082l-Pl
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 11:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593877235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ApDhe32brtQ+Y5RdcPhQgtj2PJElzW6fZw0WZlKaDdE=;
 b=as7CJOD20YxTc+nDPRBn/YnLnAfzGa/ErN08t4H7js1TqfDwrJW9dnh9HPtWX+MTf9QMvG
 krP2k0eNVyLn4wJIedVVnIZUEZy38x+2QOovieZUfcuHWbI5ICzQtwqroVE4gf2NfFUiIB
 K4c+DXpsgl0jseYEMOxBtz5HPu32k18=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-DxR0g9FaM-KbeyOTAb98KA-1; Sat, 04 Jul 2020 11:40:33 -0400
X-MC-Unique: DxR0g9FaM-KbeyOTAb98KA-1
Received: by mail-wr1-f69.google.com with SMTP id e11so36043883wrs.2
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 08:40:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ApDhe32brtQ+Y5RdcPhQgtj2PJElzW6fZw0WZlKaDdE=;
 b=iz+AwaM3VG4VKuiYW+/Ikv3V9CZDf94cmDGFjs7xCsGfKwzo8d7LqZeCAXy+QdY7NF
 ApNZS14Zy2vZDbfEMYKNZHDWAoG6h0A+tOdcQ4iqi2K7dpCwNfCXuQ5j5XNl4JTv5f/3
 TVhz+DR7k9j2i33s1Xtz3d2ll8V0qOPj/8gPmL7vU42XgX51ZKfsfQoeBZZdJJ7lA68F
 JxZVTmTltWOQ9JZSl+UKfpnrZkfhlX3Zgo3Upj7ZHBxKgHf7MvjDQm1fU2mI6iIB+ro4
 zF1+XsZrw2R/ViV6qUgAN/Nge6qq2aStuN/GwjJMLQ7GnHp8yItmLciTW8UUPkX/5SIQ
 L2zQ==
X-Gm-Message-State: AOAM531lzyAodADY7qp+7sL8S+L9NRYa5bUKEUB2EpThDzWopCauvY05
 FbuAT61VQx5FrPoJEn55LEaDY9h++PWL3DlGHNkFJqFdi1rSqn3Bp6jvKpd6d9aVNj1v7dDLK3H
 hGCjrDAYgOPOA1k4=
X-Received: by 2002:a5d:65cd:: with SMTP id e13mr45174011wrw.213.1593877232724; 
 Sat, 04 Jul 2020 08:40:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwc1L/DE70twI/1xOz2kmJOPcOy9N+cy+lOq57wiKPckMzozaMZqMcAsAVBd12z6yKwinCnag==
X-Received: by 2002:a5d:65cd:: with SMTP id e13mr45173991wrw.213.1593877232580; 
 Sat, 04 Jul 2020 08:40:32 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id m16sm12754853wro.0.2020.07.04.08.40.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 08:40:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 15/23] hw/m68k/mcf520x: Emit warning when old code is
 used
Date: Sat,  4 Jul 2020 17:39:00 +0200
Message-Id: <20200704153908.12118-16-philmd@redhat.com>
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
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 08:57:02
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
v2: Add comment (thuth)
---
 hw/m68k/mcf5206.c | 5 +++++
 hw/m68k/mcf5208.c | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
index a2fef04f8e..ec0d176674 100644
--- a/hw/m68k/mcf5206.c
+++ b/hw/m68k/mcf5206.c
@@ -16,6 +16,7 @@
 #include "qemu/timer.h"
 #include "hw/ptimer.h"
 #include "sysemu/sysemu.h"
+#include "hw/qdev-deprecated.h"
 
 /* General purpose timer module.  */
 typedef struct {
@@ -144,6 +145,8 @@ static m5206_timer_state *m5206_timer_init(qemu_irq irq)
 {
     m5206_timer_state *s;
 
+    qdev_warn_deprecated_function_used();
+
     s = g_new0(m5206_timer_state, 1);
     s->timer = ptimer_init(m5206_timer_trigger, s, PTIMER_POLICY_DEFAULT);
     s->irq = irq;
@@ -566,6 +569,8 @@ qemu_irq *mcf5206_init(MemoryRegion *sysmem, uint32_t base, M68kCPU *cpu)
     m5206_mbar_state *s;
     qemu_irq *pic;
 
+    qdev_warn_deprecated_function_used();
+
     s = g_new0(m5206_mbar_state, 1);
 
     memory_region_init_io(&s->iomem, NULL, &m5206_mbar_ops, s,
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index d310a98e7b..0bfcbb6332 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -26,6 +26,7 @@
 #include "hw/sysbus.h"
 #include "elf.h"
 #include "exec/address-spaces.h"
+#include "hw/qdev-deprecated.h"
 
 #define SYS_FREQ 166666666
 
@@ -194,7 +195,9 @@ static void mcf5208_sys_init(MemoryRegion *address_space, qemu_irq *pic)
     /* SDRAMC.  */
     memory_region_init_io(iomem, NULL, &m5208_sys_ops, NULL, "m5208-sys", 0x00004000);
     memory_region_add_subregion(address_space, 0xfc0a8000, iomem);
+
     /* Timers.  */
+    qdev_warn_deprecated_function_used(); /* m5208_timer_state is not QOM */
     for (i = 0; i < 2; i++) {
         s = g_new0(m5208_timer_state, 1);
         s->timer = ptimer_init(m5208_timer_trigger, s, PTIMER_POLICY_DEFAULT);
-- 
2.21.3


