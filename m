Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215FAC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:48:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBA4F206A5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CdNmfnvZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBA4F206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVcOi-0004yo-0L
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc72-0006z0-4L
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:30:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50346
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc71-0006st-1Y
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588602626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NCBO1aLd2aLs6F2iVluN8cNPCS4OZGD2p7feJr3pvrU=;
 b=CdNmfnvZC/UNK2tOpIEgunLFKHgOW4FFHZkoE0hl+qbo5WlsLqkPc52jFuuBNBcWuetnh2
 4gaRNzScYAEl0gezsJdy7RGBJip77YWMgbftc1akeil+jjlR1TMjcEcyjEkEYtpm+pVAIv
 SeScyqGDkV560/d7TRo1XUJbgThCDDQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-_sACLOrHMk-rrsyc7xwwVw-1; Mon, 04 May 2020 10:30:24 -0400
X-MC-Unique: _sACLOrHMk-rrsyc7xwwVw-1
Received: by mail-wr1-f70.google.com with SMTP id z8so3697870wrp.7
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 07:30:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=KDH+uIa1iy/4EI4LPUlxUORLJ/6b+eATnz4vYJlDr4s=;
 b=n15osL4YCnvndoWjqekgw0NQ08hOp8ii5hQOw7v7sTwvGa8rAB2b7mUT3jfM+VmLqe
 wqC0Qv0IIm1VA0scEnSA2ljikctu1/hccsfD2sp58lF0T3h96jbc5gV7pan/nSpB70N6
 c/qbE5kQbDbzrv86MiCAtNeKgOxJL7Vfo+eYNKvItdN/59YHOkMnvjkILVUJhdtetPll
 Z2gZYOLhd87CP8NKQ8LYUaV4brlWwzGRA+I2kSiDT3rKSxLB661Yr3D057VJDhAvHxIz
 yZbYBMQPZgmd6zw/yP8YCBZn1KsUbWLq9W1OugTkABgu1S27v8KvChBGKkPkJwDxqoS3
 F42w==
X-Gm-Message-State: AGi0PuYZRMB5Z0jGp60PVlajVjrinTWUeI9SPyNWMcw1qYrHOdGBksQV
 nI+o9ca4MDh82ScBRv4fTbAv4LG7n6j2iR51dzh/9vMEJs/Uieu9TfgyqroLajqk0islpEa4K/W
 UQZRhgXBOM7ygiqo=
X-Received: by 2002:a1c:6a08:: with SMTP id f8mr14270267wmc.132.1588602623238; 
 Mon, 04 May 2020 07:30:23 -0700 (PDT)
X-Google-Smtp-Source: APiQypK9NsyZYkCQwKRNVucEGY8Aq6HzBCO2IB4uDZLxAbTqwUlrroiq4IOYmuM07Mm5Lc/dJz60xQ==
X-Received: by 2002:a1c:6a08:: with SMTP id f8mr14270248wmc.132.1588602623043; 
 Mon, 04 May 2020 07:30:23 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 h1sm14166869wme.42.2020.05.04.07.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 07:30:22 -0700 (PDT)
Date: Mon, 4 May 2020 10:30:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 28/29] hw/i386: Add 'vmport.h' local header
Message-ID: <20200504142814.157589-29-mst@redhat.com>
References: <20200504142814.157589-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200504142814.157589-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 05:09:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Eduardo Habkost <ehabkost@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Move 'vmport' related declarations in a target-specific header.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20200504083342.24273-4-f4bug@amsat.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/vmport.h     | 34 ++++++++++++++++++++++++++++++++++
 include/hw/i386/pc.h |  3 ---
 hw/i386/pc.c         |  1 +
 hw/i386/vmmouse.c    |  1 +
 hw/i386/vmport.c     |  1 +
 5 files changed, 37 insertions(+), 3 deletions(-)
 create mode 100644 hw/i386/vmport.h

diff --git a/hw/i386/vmport.h b/hw/i386/vmport.h
new file mode 100644
index 0000000000..47eda7a22b
--- /dev/null
+++ b/hw/i386/vmport.h
@@ -0,0 +1,34 @@
+/*
+ * QEMU VMPort emulation
+ *
+ * Copyright (C) 2007 Herv=C3=A9 Poussineau
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a=
 copy
+ * of this software and associated documentation files (the "Software"), t=
o deal
+ * in the Software without restriction, including without limitation the r=
ights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or se=
ll
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included=
 in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OT=
HER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
 FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS =
IN
+ * THE SOFTWARE.
+ */
+
+#ifndef HW_I386_VMPORT_H
+#define HW_I386_VMPORT_H
+
+#define TYPE_VMPORT "vmport"
+
+typedef uint32_t (VMPortReadFunc)(void *opaque, uint32_t address);
+
+void vmport_register(unsigned char command, VMPortReadFunc *func, void *op=
aque);
+
+#endif
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 26e2a3d92b..de49a57506 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -130,9 +130,6 @@ typedef struct PCMachineClass {
 GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled);
=20
 /* vmport.c */
-#define TYPE_VMPORT "vmport"
-typedef uint32_t (VMPortReadFunc)(void *opaque, uint32_t address);
-void vmport_register(unsigned char command, VMPortReadFunc *func, void *op=
aque);
 void vmmouse_get_data(uint32_t *data);
 void vmmouse_set_data(const uint32_t *data);
=20
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 84669ddc84..f6b8431c8b 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -91,6 +91,7 @@
 #include "qapi/qmp/qerror.h"
 #include "config-devices.h"
 #include "e820_memory_layout.h"
+#include "vmport.h"
 #include "fw_cfg.h"
 #include "trace.h"
=20
diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
index e8e62bd96b..78b36f6f5d 100644
--- a/hw/i386/vmmouse.c
+++ b/hw/i386/vmmouse.c
@@ -29,6 +29,7 @@
 #include "hw/input/i8042.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
+#include "vmport.h"
=20
 /* debug only vmmouse */
 //#define DEBUG_VMMOUSE
diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index 114141c6f3..00d47e0c4c 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -26,6 +26,7 @@
 #include "hw/i386/pc.h"
 #include "sysemu/hw_accel.h"
 #include "qemu/log.h"
+#include "vmport.h"
 #include "trace.h"
=20
 #define VMPORT_CMD_GETVERSION 0x0a
--=20
MST


