Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31E3C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 15:59:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E39320658
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 15:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WNwPFwSg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E39320658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFg1e-0001hU-ET
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 11:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFfyG-0004GZ-Et
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 11:55:48 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50438
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFfyB-0003s6-Ii
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 11:55:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599580540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rd1yDVC2PLm/mbyb4s3J2rHQe4El+Eyr3YAhnhSaUkU=;
 b=WNwPFwSg+7TRyDubz05yZKOlfVyI6ZPL7cBAxXwot3e1VCBUoKf0JzLEMYMtETFyw0C7+E
 skgy4zE52lb2qUpydXVf4p0ucazqHTn9XW16rh34mW3cmDBpxOFVNnJKWyxJe5UNU0f7OM
 LrTp0NLU1uT85pcmm+8aTqDR1l4mDTw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-oAGPhu5PP0exXqk9ji6t9w-1; Tue, 08 Sep 2020 11:55:39 -0400
X-MC-Unique: oAGPhu5PP0exXqk9ji6t9w-1
Received: by mail-wr1-f71.google.com with SMTP id o6so6983125wrp.1
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 08:55:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rd1yDVC2PLm/mbyb4s3J2rHQe4El+Eyr3YAhnhSaUkU=;
 b=qZ53n+zGPbH4FRsjota+EK3L4/LMbFq0ZkqED0H96y+aklVkkc40w03Gre6gZjRFu6
 wNrVWpegctvc6l52F7f7YsFSSxSmRoCGpTW1oti1sL0GvYdRG/3WS/8nj9eYGR9yDe94
 mKqem1RStMGx8VukADKlos5AMHrR6hyggF9YwfF3H+3iC7qbz3t/jfNzUuCvNGf66TzH
 WuU5fuC6j3VoQVqJnLV9TYf/AnTzrmluDtQY/EQ9bBct4QR9HXfvzgC7WszB0gUuPs6v
 FmjRszERbYsUPjRYe6VdYx7ybXsmBunqRgLb2qb62PDuxLiECwAkhYLzOThc/y8j1ybp
 Kw7g==
X-Gm-Message-State: AOAM532OU0322jeZnFbgZiKJ35ZhGgt0DvYV3D0Xdh/E7pXOkfSHHnfu
 mZz9Q2yfqku5yZG0WZnHW2S2a4tl6rchfpRw4wUVMJ1sS27YqluKmPPilInEz6xTxwXDJkxww+L
 SKiIRXFtsKeYL79U=
X-Received: by 2002:a7b:ca56:: with SMTP id m22mr221225wml.12.1599580538035;
 Tue, 08 Sep 2020 08:55:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxYnoWVgP/Ap99zKyQud1Rr5s6XZtll0OYfYZ+la+K5Rnwnnrg8qI1BhbSu4nN0ILR5SpT+xA==
X-Received: by 2002:a7b:ca56:: with SMTP id m22mr221200wml.12.1599580537809;
 Tue, 08 Sep 2020 08:55:37 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id b187sm33175270wmb.8.2020.09.08.08.55.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 08:55:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/6] hw/i386/q35: Remove unreachable Xen code on Q35 machine
Date: Tue,  8 Sep 2020 17:55:25 +0200
Message-Id: <20200908155530.249806-2-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200908155530.249806-1-philmd@redhat.com>
References: <20200908155530.249806-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 03:00:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Xen accelerator requires specific changes to a machine to be able
to use it. See for example the 'Xen PC' machine configure its PCI
bus calling pc_xen_hvm_init_pci(). There is no 'Xen Q35' machine
declared. This code was probably added while introducing the Q35
machine, based on the existing PC machine (see commit df2d8b3ed4
"Introduce q35 pc based chipset emulator"). Remove the unreachable
code to simplify this file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/i386/pc_q35.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 0cb9c18cd44..f3506269fe0 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -34,9 +34,7 @@
 #include "sysemu/arch_init.h"
 #include "hw/i2c/smbus_eeprom.h"
 #include "hw/rtc/mc146818rtc.h"
-#include "hw/xen/xen.h"
 #include "sysemu/kvm.h"
-#include "sysemu/xen.h"
 #include "hw/kvm/clock.h"
 #include "hw/pci-host/q35.h"
 #include "hw/qdev-properties.h"
@@ -179,10 +177,6 @@ static void pc_q35_init(MachineState *machine)
         x86ms->below_4g_mem_size = machine->ram_size;
     }
 
-    if (xen_enabled()) {
-        xen_hvm_init(pcms, &ram_memory);
-    }
-
     x86_cpus_init(x86ms, pcmc->default_cpu_version);
 
     kvmclock_create();
@@ -208,10 +202,7 @@ static void pc_q35_init(MachineState *machine)
     }
 
     /* allocate ram and load rom/bios */
-    if (!xen_enabled()) {
-        pc_memory_init(pcms, get_system_memory(),
-                       rom_memory, &ram_memory);
-    }
+    pc_memory_init(pcms, get_system_memory(), rom_memory, &ram_memory);
 
     /* create pci host bus */
     q35_host = Q35_HOST_DEVICE(qdev_new(TYPE_Q35_HOST_DEVICE));
@@ -271,7 +262,7 @@ static void pc_q35_init(MachineState *machine)
 
     assert(pcms->vmport != ON_OFF_AUTO__MAX);
     if (pcms->vmport == ON_OFF_AUTO_AUTO) {
-        pcms->vmport = xen_enabled() ? ON_OFF_AUTO_OFF : ON_OFF_AUTO_ON;
+        pcms->vmport = ON_OFF_AUTO_ON;
     }
 
     /* init basic PC hardware */
-- 
2.26.2


