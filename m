Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4401DC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 08:26:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BDEF20714
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 08:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ELpFr0TS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BDEF20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyA4u-0006By-BO
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 04:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyA4H-0005m9-0B
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 04:25:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40713
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyA44-0006cF-G9
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 04:25:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595406323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iMxQatL9RPRr52uoa/cQsIi+/qvfqC+NGO6O/Z/trAk=;
 b=ELpFr0TSwHtbJhlGuvPPyiR4Rv6JBARFNyjN/7mtmxphARaHrlMw2YePFITgKznRGzEn4j
 qx75Hf+Nx67Cx1TU9p/A60YcDjw+/+RvOC7pTTqIQZzbMmqVZyZNBb6+3KLl5Lodygv7T4
 lOmBPCwCh/8l7qm7RFF7c2O1dWJTnaU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-GmPvZSdhMVS17cYCP5APfQ-1; Wed, 22 Jul 2020 04:25:21 -0400
X-MC-Unique: GmPvZSdhMVS17cYCP5APfQ-1
Received: by mail-ej1-f72.google.com with SMTP id f11so722651ejb.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 01:25:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iMxQatL9RPRr52uoa/cQsIi+/qvfqC+NGO6O/Z/trAk=;
 b=e/Tj65xHlSTWFM3yPrkE6VQPPVcNBa5vzGc33AgSowJ/GSffciUE9Df5DeIVsiMNF0
 JE51u/1EfT6WCYvHjvhaFIBVEwo8XkhWFCbq/A0/IXImF2bF1CLsF/dP/Sdqfb/HgVGN
 diDtEteCR4BReJGfZoePM3KPVNxNRd4mTDbV7W5cWoRQi5hLQ5YxXE8wpyYREc5PwO3j
 xQ5yJv7jW/oTcmQiVKwGVACY+LTw2eSDTyMAbIQ6rpq8iFKLMYi+JZUaUoEfut1dFy8Y
 B8ClMUeRSCfuFyXMIzA8+W7jf77sozQUm9JNn9xMsYLrLoAhCiZnmi/7ULcuy4FzKFQB
 qibQ==
X-Gm-Message-State: AOAM533TbdMEeCRy5eOqgPnbzXt7AdBE1HZo53MjVXFmFf0n8PuliiqR
 Qg05iwY64MllUK8oKIkBuhp3dIYc48F64B2q/mHywgckE6GDy624Gw4KHk1sRaN6bbbmZYkIccL
 LJBmwRztu0iqDqkw=
X-Received: by 2002:a05:6402:cb9:: with SMTP id
 cn25mr30469512edb.247.1595406320006; 
 Wed, 22 Jul 2020 01:25:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyjYRzzJTOzYTRVfwqd/zbj7wdZv8GzJF0hCcZfQHNO6k/Ak91x0TPiYTcKtYKYbO1SqY50dg==
X-Received: by 2002:a05:6402:cb9:: with SMTP id
 cn25mr30469485edb.247.1595406319749; 
 Wed, 22 Jul 2020 01:25:19 -0700 (PDT)
Received: from x1w.redhat.com (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id m6sm18125273eja.87.2020.07.22.01.25.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 01:25:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2] hw/i386/q35: Remove unreachable Xen code on Q35
 machine
Date: Wed, 22 Jul 2020 10:25:17 +0200
Message-Id: <20200722082517.18708-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 00:40:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
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
---
 hw/i386/pc_q35.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index a3e607a544..12f5934241 100644
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
2.21.3


