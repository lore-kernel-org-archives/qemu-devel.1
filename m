Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F12C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:20:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F5DB206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fpmhIKFv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F5DB206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiKVM-0005XI-Ed
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 12:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKEl-0007Ad-DB
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:03:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24000
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKEk-0007xp-Hr
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591632177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L3z7/2H5A05Y0veUntj0sB8fSeRKRdeeSYeKdBwF4Hw=;
 b=fpmhIKFvXLBpniJCwiDDDhPv207fXRcRPf8Fyzb5skveGIlLOsn5quV6q8sdbFQl24gin0
 pn8EXow3zBSue5C8vbvUVw2Mp3zYD3fBOtJEipjW+o09za2eUlMYrD7hIhzVutB/3tAQPA
 bz1mHO1dTKHznxeOYtNDRhN1EJmjMr0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-zw1hIS5-O-qUsrcP6P48tg-1; Mon, 08 Jun 2020 12:02:56 -0400
X-MC-Unique: zw1hIS5-O-qUsrcP6P48tg-1
Received: by mail-wr1-f71.google.com with SMTP id t5so7327493wro.20
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 09:02:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=L3z7/2H5A05Y0veUntj0sB8fSeRKRdeeSYeKdBwF4Hw=;
 b=S0Q+TWqf/0eKPvUDZaobNV3IWdkhCY03VcxrOpzOsHTJnmtM8HCsWTGzuPcArALQAQ
 54GxNQHwWxhojrP6wtuNsc8DCBfMOEtEkHiko9g8KhBfELsX6fnk8RHL2SKKCiXeKwVt
 SKWjY1T4GBYIEwMo+/UbXMJXyCvKWIQEit+0ETRMEUOTPb9R1KZ3IwYX574Yd3P2POt5
 x0v8vUk+tsfxb/A3p5gW8jDEcaQXKC2jF8+xOrvBbt9jFU+sCQFc7L99HMslThL6BKTW
 5oAVZvTmQbFJzICQ89r/PPq2dPvKaoAqPcz3jsZk5+2ddoIhtLzyIjICDIM7quWSZ+Z2
 byVw==
X-Gm-Message-State: AOAM53038LSUtuJChcpORNX2pTkmnEqL2uwN5FqMhe3NkTDL5+ASzNo0
 gaIHgXyHqesJEAvZF6JC370ZcFy2DRTTB58BVg92DgkHkoX+GFohbkhPG6dGYAzYshLX6J8bOXB
 HsJbL6oQ4IUCrzAQ=
X-Received: by 2002:a5d:4841:: with SMTP id n1mr25485582wrs.64.1591632174026; 
 Mon, 08 Jun 2020 09:02:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxA5a/fZ3ZxfFd0NOMzf3yCM2KT4oTBQZPfei9kF9bupOnm+jcw1E0PX8MzjNlME16qgafXA==
X-Received: by 2002:a5d:4841:: with SMTP id n1mr25485541wrs.64.1591632173820; 
 Mon, 08 Jun 2020 09:02:53 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id q8sm49134wmq.1.2020.06.08.09.02.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 09:02:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 22/35] hw/m68k/mcf520x: Emit warning when old code is used
Date: Mon,  8 Jun 2020 18:00:31 +0200
Message-Id: <20200608160044.15531-23-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200608160044.15531-1-philmd@redhat.com>
References: <20200608160044.15531-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 05:40:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Magnus Damm <magnus.damm@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org,
 Stafford Horne <shorne@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <rth@twiddle.net>,
 "Daniel P . Berrange" <berrange@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This code hasn't been QOM'ified yet. Warn the user.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
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
index 2ab9701ad6..72627f6833 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -26,6 +26,7 @@
 #include "hw/sysbus.h"
 #include "elf.h"
 #include "exec/address-spaces.h"
+#include "hw/qdev-deprecated.h"
 
 #define SYS_FREQ 166666666
 
@@ -191,6 +192,8 @@ static void mcf5208_sys_init(MemoryRegion *address_space, qemu_irq *pic)
     m5208_timer_state *s;
     int i;
 
+    qdev_warn_deprecated_function_used();
+
     /* SDRAMC.  */
     memory_region_init_io(iomem, NULL, &m5208_sys_ops, NULL, "m5208-sys", 0x00004000);
     memory_region_add_subregion(address_space, 0xfc0a8000, iomem);
-- 
2.21.3


