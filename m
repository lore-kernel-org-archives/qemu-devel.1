Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3ACC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:29:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DF70221E5
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C0bS9mW4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DF70221E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFece-0002IQ-In
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 10:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFeaP-0005Sz-57
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 10:27:05 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53301
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFeZo-0006ra-Uf
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 10:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599575184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PKU6z94K7UIxWkqADbhCdk+fTBY5NmZMu8z2vQrSItw=;
 b=C0bS9mW49YnvLU89SLxzYcFjhDaRI6t6NxspnPDek8R/H4vaTlsgMIG9oIgxF1e7/yQCDf
 TXj+oZNjxosQHwvlwP5XbDFqDI37/vjuLg9Pg6sbut8K+HjfgfYhbY9/GODIqcUc+hMX1G
 IYEZjyP0TQqCsa0PHPMj8PHWvv1CQ3A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-UPM2H5oIO9CF3hrdllYomQ-1; Tue, 08 Sep 2020 10:26:22 -0400
X-MC-Unique: UPM2H5oIO9CF3hrdllYomQ-1
Received: by mail-wr1-f72.google.com with SMTP id 33so7009223wrk.12
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 07:26:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PKU6z94K7UIxWkqADbhCdk+fTBY5NmZMu8z2vQrSItw=;
 b=HjpmkwgjFQti5IOzDCD7K67z6O14MsFyFI2Ozp8S1aUuFzTq1sGsxYXt6vxWjssGge
 SiTbYfR+As2tVPYYiAMBg8m/CV3F0BojImI/iZExXcyNaFJPDLSNiSzV/tY3CZtElqiY
 BjXIOlFst6e8e/sdPhJhJXyTPmyyyjIVJl+Ljux7wfp3sDIAxmkaz8g54ypNA7y6onxb
 w4VD4caMbMZhA/h0pOr+fKaJWnrx2f9j3iZKQuls4X+M+JntuSZIHWkxXQ53Lzu+R/D1
 ybUgmdw4cdXy5+b05MNorTvSQ5jhaj9VHDM12ou1HoeeZVQyducKk7bBk4Gmb7MtvrAI
 9FSQ==
X-Gm-Message-State: AOAM5310SMjzFalAnSfVUtUEUK06j/6fM1tcv6HKSYzFo5fzhMZ32m/o
 HQ95/2UX32AebrerEkOTwqKisNqZeRcYKo1mFLb/zgBmjvwWD3GCCoPSUIhI+MLEUiScHmrVwXh
 lKzZ1hmlPXy4Ut4A=
X-Received: by 2002:adf:e690:: with SMTP id r16mr22862684wrm.15.1599575181396; 
 Tue, 08 Sep 2020 07:26:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxi9E+6zi0GSsRROj52mze2J8TZAWamqoyYBE/YoqC5pV7oZ//ef2PGOt34D9MOXVPg3sxNYQ==
X-Received: by 2002:adf:e690:: with SMTP id r16mr22862661wrm.15.1599575181175; 
 Tue, 08 Sep 2020 07:26:21 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id h8sm34388736wrw.68.2020.09.08.07.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 07:26:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/5] hw/xen: Split x86-specific declaration from generic
 hardware ones
Date: Tue,  8 Sep 2020 16:25:58 +0200
Message-Id: <20200908142559.192945-5-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200908142559.192945-1-philmd@redhat.com>
References: <20200908142559.192945-1-philmd@redhat.com>
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
 Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, xen-devel@lists.xenproject.org,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

xen_hvm_init() is restricted to the X86 architecture.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/hw/xen/xen-x86.h | 15 +++++++++++++++
 include/hw/xen/xen.h     |  2 --
 hw/i386/pc_piix.c        |  2 +-
 hw/i386/xen/xen-hvm.c    |  1 +
 4 files changed, 17 insertions(+), 3 deletions(-)
 create mode 100644 include/hw/xen/xen-x86.h

diff --git a/include/hw/xen/xen-x86.h b/include/hw/xen/xen-x86.h
new file mode 100644
index 00000000000..85e3db1b8de
--- /dev/null
+++ b/include/hw/xen/xen-x86.h
@@ -0,0 +1,15 @@
+/*
+ * Xen X86-specific
+ *
+ * Copyright 2020 Red Hat, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef QEMU_HW_XEN_X86_H
+#define QEMU_HW_XEN_X86_H
+
+#include "hw/i386/pc.h"
+
+void xen_hvm_init_pc(PCMachineState *pcms, MemoryRegion **ram_memory);
+
+#endif /* QEMU_HW_XEN_X86_H */
diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
index b2b459964cb..1406648ca58 100644
--- a/include/hw/xen/xen.h
+++ b/include/hw/xen/xen.h
@@ -30,8 +30,6 @@ qemu_irq *xen_interrupt_controller_init(void);
 
 void xenstore_store_pv_console_info(int i, struct Chardev *chr);
 
-void xen_hvm_init_pc(PCMachineState *pcms, MemoryRegion **ram_memory);
-
 void xen_register_framebuffer(struct MemoryRegion *mr);
 
 #endif /* QEMU_HW_XEN_H */
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 3e008bb0b1a..43205f48188 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -46,7 +46,7 @@
 #include "hw/sysbus.h"
 #include "sysemu/arch_init.h"
 #include "hw/i2c/smbus_eeprom.h"
-#include "hw/xen/xen.h"
+#include "hw/xen/xen-x86.h"
 #include "exec/memory.h"
 #include "exec/address-spaces.h"
 #include "hw/acpi/acpi.h"
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 49748cda3fb..e03c59e53da 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -22,6 +22,7 @@
 #include "hw/xen/xen_common.h"
 #include "hw/xen/xen-legacy-backend.h"
 #include "hw/xen/xen-bus.h"
+#include "hw/xen/xen-x86.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qemu/error-report.h"
-- 
2.26.2


