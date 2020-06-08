Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3221C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:15:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7D692063A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QmitIeyF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7D692063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiKQQ-0007Ku-SK
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 12:15:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKDl-0006Vp-HO
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:01:57 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25430
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKDk-0007mM-NZ
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591632116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=faJPKsgnKj1MSj1B3bxzpLa01+W3HhU/7Hynie77jqI=;
 b=QmitIeyFWMWWxO86DkQDWwTOAm8GBG5Fo0QpYuh26bGeU4JBObO7kUevkNtkXRYbn9GsPa
 gDnk+1FDe5w/V0dQW3d+BBgQb5Yu/bY8BCb6CP0a75XsVK6VXd8fY2JyUPiAu9siUIPN4R
 13tsu2dFN2/EaPvbwbUkVPd1uq5qFjg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-ejMzWpmyO8GgO0-UmpfQ-Q-1; Mon, 08 Jun 2020 12:01:51 -0400
X-MC-Unique: ejMzWpmyO8GgO0-UmpfQ-Q-1
Received: by mail-wm1-f71.google.com with SMTP id l2so9560wmi.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 09:01:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=faJPKsgnKj1MSj1B3bxzpLa01+W3HhU/7Hynie77jqI=;
 b=iMxLvvSFAaPRIMh3wzhBFfleUgI/UFIU4YxWORJFzAh8byjpA0mVf+o57jaCMaz2Q7
 ENDsJKcAUDM/lknG+k+Mh2BgF+NInSTvGri8aVIn3Yb2o7g8U/0mM1fWysng/uA+qCqp
 ybd6W0eKijWVnyU2qYtMk1/V8hw66t1OA2k+Hk/a9jnKbq+XTeWEZc6E7jCH3USC+T0+
 /u57psG8oJhwLBuoaniZMYY+dkCyIt5dwow5szsTzrYJBCIqBhOscq2/4yP0uZlZPHgm
 WKPRDOpDh+XARD3bi2vbqX0rYFABqLlsucIQtQon8TLI3YA3LQqBRyHFDHzWWIgz3WZx
 jNvg==
X-Gm-Message-State: AOAM531LlGDMr6bsgOl0o9/6igvsmSGlhzfM99hLrLAr+h8dNf13PvuL
 Vfdmxh+gtTdYSPfXFDL6ni1KiqY516hQoZdeN7a4qhm4md/d9uIntptNeuO78SnGwojjPKIHupd
 qz6ANA8SMH6ZlGsc=
X-Received: by 2002:adf:9304:: with SMTP id 4mr25264204wro.280.1591632109663; 
 Mon, 08 Jun 2020 09:01:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9mBFO0YH5teWKyWXjB3IP6YUG1XRf7/NfjmoGjY1J2DcXSECmfNz6g9nRc2AB3mdjKgV/Zg==
X-Received: by 2002:adf:9304:: with SMTP id 4mr25264164wro.280.1591632109513; 
 Mon, 08 Jun 2020 09:01:49 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id l1sm220993wrb.31.2020.06.08.09.01.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 09:01:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 11/35] hw/display/vga-isa-mm: Emit warning when old code
 is used
Date: Mon,  8 Jun 2020 18:00:20 +0200
Message-Id: <20200608160044.15531-12-philmd@redhat.com>
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
 hw/display/vga-isa-mm.c | 5 +++++
 hw/display/vga.c        | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/hw/display/vga-isa-mm.c b/hw/display/vga-isa-mm.c
index 7321b7a06d..3e62389b63 100644
--- a/hw/display/vga-isa-mm.c
+++ b/hw/display/vga-isa-mm.c
@@ -29,6 +29,7 @@
 #include "hw/display/vga.h"
 #include "vga_int.h"
 #include "ui/pixel_ops.h"
+#include "hw/qdev-deprecated.h"
 
 #define VGA_RAM_SIZE (8 * MiB)
 
@@ -71,6 +72,8 @@ static void vga_mm_init(ISAVGAMMState *s, hwaddr vram_base,
 {
     MemoryRegion *s_ioport_ctrl, *vga_io_memory;
 
+    qdev_warn_deprecated_function_used();
+
     s->it_shift = it_shift;
     s_ioport_ctrl = g_malloc(sizeof(*s_ioport_ctrl));
     memory_region_init_io(s_ioport_ctrl, NULL, &vga_mm_ctrl_ops, s,
@@ -99,6 +102,8 @@ int isa_vga_mm_init(hwaddr vram_base,
 
     s = g_malloc0(sizeof(*s));
 
+    qdev_warn_deprecated_function_used();
+
     s->vga.vram_size_mb = VGA_RAM_SIZE / MiB;
     s->vga.global_vmstate = true;
     vga_common_init(&s->vga, NULL);
diff --git a/hw/display/vga.c b/hw/display/vga.c
index 061fd9ab8f..d59a9c896b 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -35,6 +35,7 @@
 #include "hw/xen/xen.h"
 #include "migration/vmstate.h"
 #include "trace.h"
+#include "hw/qdev-deprecated.h"
 
 //#define DEBUG_VGA_MEM
 //#define DEBUG_VGA_REG
@@ -2262,6 +2263,8 @@ MemoryRegion *vga_init_io(VGACommonState *s, Object *obj,
 {
     MemoryRegion *vga_mem;
 
+    qdev_warn_deprecated_function_used();
+
     *vga_ports = vga_portio_list;
     *vbe_ports = vbe_portio_list;
 
-- 
2.21.3


