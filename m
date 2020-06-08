Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40498C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:26:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A29C206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ggYah4Bj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A29C206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiKb5-0005qe-6V
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 12:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKFc-0007pz-FR
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:03:52 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34769
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKFb-0008EC-GG
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:03:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591632230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+WkHvAzEi0wEkdKvuBuPydWDbkpdF7QxEn1l5oochA0=;
 b=ggYah4BjkLQsunB9rp+MfwY5gv3DcUQBfajT1gu/2/u/A+9kAT7mi9xeF7Fh1OAHJ3KEO1
 0/g5Po27om5DUMVVidYXdO+hS/Z3JCjif5oHHF4E23dKnIXNpnYUZ8p1QoaexsF9OxfNXu
 x8QtJz4eTRf+ui3jHfwcp8X5e4Tq50I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-iYEr0ercM76rX7aK5RxrOg-1; Mon, 08 Jun 2020 12:03:48 -0400
X-MC-Unique: iYEr0ercM76rX7aK5RxrOg-1
Received: by mail-wr1-f72.google.com with SMTP id o1so7300976wrm.17
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 09:03:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+WkHvAzEi0wEkdKvuBuPydWDbkpdF7QxEn1l5oochA0=;
 b=iKcucyYzA8rqCYpnG6HFWVIseWgAhITBuGvXUupJlWi6IifV0QVMBB/XL+92H3MeZu
 yQ5SxLiTQCPHhhzpg32M1R6j0xPJeKonrjTTO+RcE3kTS4bwcB0OMRi5SM6/cBli/QGj
 qv1EkRfy0OhOUR8GAAC8EmIkZPxdVUsdznSTZodzO4BxLMhzp5/QtYVzkRd1QZ0+mOzE
 2pzVxlVACJa5DgPQuqj9lw0KkBWIicxx+6C43F9l1uuxeaRHgNi0TyLodJoG+TIxT8IH
 mz4MNa44uFGUVToVU6oWw2F+le41BPVPutaRQxmlcJAGtWphcbS/1XNG+HFGalN2P4Ki
 JQ3Q==
X-Gm-Message-State: AOAM530MHp1N9TtEmS7toU/Q7SQYVcAwzpiEMO2O+yb8EZfKsUQVQ8Io
 pZJrmvMLmt8R6oA4TRWr7jd8NEqlzc68Me67RWsBrEq3ioaUH2rvYvf3gl7oikMlSNxIounFkBo
 t13nMKJJVXSuFt+c=
X-Received: by 2002:a5d:49c5:: with SMTP id t5mr24893751wrs.18.1591632227119; 
 Mon, 08 Jun 2020 09:03:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrpgU9KBovh6Bb8PslmNvBRv90nOw1Va1g7BnyPuxlNkUnSsxx5Z+mEp10XtU+59c/IEfXNQ==
X-Received: by 2002:a5d:49c5:: with SMTP id t5mr24893708wrs.18.1591632226912; 
 Mon, 08 Jun 2020 09:03:46 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id s8sm181183wrg.50.2020.06.08.09.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 09:03:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 31/35] hw/sh4: Emit warning when old code is used
Date: Mon,  8 Jun 2020 18:00:40 +0200
Message-Id: <20200608160044.15531-32-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200608160044.15531-1-philmd@redhat.com>
References: <20200608160044.15531-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 11:58:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 hw/char/sh_serial.c | 3 +++
 hw/intc/sh_intc.c   | 3 +++
 hw/sh4/r2d.c        | 3 +++
 hw/sh4/sh7750.c     | 4 ++++
 hw/timer/sh_timer.c | 5 +++++
 5 files changed, 18 insertions(+)

diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
index 167f4d8cb9..9366a23dd2 100644
--- a/hw/char/sh_serial.c
+++ b/hw/char/sh_serial.c
@@ -31,6 +31,7 @@
 #include "chardev/char-fe.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
+#include "hw/qdev-deprecated.h"
 
 //#define DEBUG_SERIAL
 
@@ -382,6 +383,8 @@ void sh_serial_init(MemoryRegion *sysmem,
 {
     sh_serial_state *s;
 
+    qdev_warn_deprecated_function_used();
+
     s = g_malloc0(sizeof(sh_serial_state));
 
     s->feat = feat;
diff --git a/hw/intc/sh_intc.c b/hw/intc/sh_intc.c
index 72a55e32dd..c90fbf47bb 100644
--- a/hw/intc/sh_intc.c
+++ b/hw/intc/sh_intc.c
@@ -13,6 +13,7 @@
 #include "hw/sh4/sh_intc.h"
 #include "hw/irq.h"
 #include "hw/sh4/sh.h"
+#include "hw/qdev-deprecated.h"
 
 //#define DEBUG_INTC
 //#define DEBUG_INTC_SOURCES
@@ -444,6 +445,8 @@ int sh_intc_init(MemoryRegion *sysmem,
 {
     unsigned int i, j;
 
+    qdev_warn_deprecated_function_used();
+
     desc->pending = 0;
     desc->nr_sources = nr_sources;
     desc->mask_regs = mask_regs;
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 72bb5285cc..22bbbe7d3c 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -43,6 +43,7 @@
 #include "hw/usb.h"
 #include "hw/block/flash.h"
 #include "exec/address-spaces.h"
+#include "hw/qdev-deprecated.h"
 
 #define FLASH_BASE 0x00000000
 #define FLASH_SIZE (16 * MiB)
@@ -187,6 +188,8 @@ static qemu_irq *r2d_fpga_init(MemoryRegion *sysmem,
 {
     r2d_fpga_t *s;
 
+    qdev_warn_deprecated_function_used();
+
     s = g_malloc0(sizeof(r2d_fpga_t));
 
     s->irl = irl;
diff --git a/hw/sh4/sh7750.c b/hw/sh4/sh7750.c
index d660714443..379822e0c2 100644
--- a/hw/sh4/sh7750.c
+++ b/hw/sh4/sh7750.c
@@ -32,6 +32,7 @@
 #include "hw/sh4/sh_intc.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
+#include "hw/qdev-deprecated.h"
 
 #define NB_DEVICES 4
 
@@ -756,6 +757,8 @@ SH7750State *sh7750_init(SuperHCPU *cpu, MemoryRegion *sysmem)
 {
     SH7750State *s;
 
+    qdev_warn_deprecated_function_used();
+
     s = g_malloc0(sizeof(SH7750State));
     s->cpu = cpu;
     s->periph_freq = 60000000;	/* 60MHz */
@@ -866,6 +869,7 @@ SH7750State *sh7750_init(SuperHCPU *cpu, MemoryRegion *sysmem)
 
 qemu_irq sh7750_irl(SH7750State *s)
 {
+    qdev_warn_deprecated_function_used();
     sh_intc_toggle_source(sh_intc_source(&s->intc, IRL), 1, 0); /* enable */
     return qemu_allocate_irq(sh_intc_set_irl, sh_intc_source(&s->intc, IRL), 0);
 }
diff --git a/hw/timer/sh_timer.c b/hw/timer/sh_timer.c
index 13c4051808..d5e33507b0 100644
--- a/hw/timer/sh_timer.c
+++ b/hw/timer/sh_timer.c
@@ -14,6 +14,7 @@
 #include "hw/sh4/sh.h"
 #include "qemu/timer.h"
 #include "hw/ptimer.h"
+#include "hw/qdev-deprecated.h"
 
 //#define DEBUG_TIMER
 
@@ -199,6 +200,8 @@ static void *sh_timer_init(uint32_t freq, int feat, qemu_irq irq)
 {
     sh_timer_state *s;
 
+    qdev_warn_deprecated_function_used();
+
     s = (sh_timer_state *)g_malloc0(sizeof(sh_timer_state));
     s->freq = freq;
     s->feat = feat;
@@ -319,6 +322,8 @@ void tmu012_init(MemoryRegion *sysmem, hwaddr base,
     tmu012_state *s;
     int timer_feat = (feat & TMU012_FEAT_EXTCLK) ? TIMER_FEAT_EXTCLK : 0;
 
+    qdev_warn_deprecated_function_used();
+
     s = (tmu012_state *)g_malloc0(sizeof(tmu012_state));
     s->feat = feat;
     s->timer[0] = sh_timer_init(freq, timer_feat, ch0_irq);
-- 
2.21.3


