Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030AFC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:55:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C21AD206B9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NTKtNCLb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C21AD206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVcUw-0000OY-Sn
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc9p-0003TM-Eh
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:33:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22020
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc9o-0008VJ-Cc
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:33:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588602799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7CFiYdy5xKBq+FqRALV9f5jvve8p3XfD9KaQL2vD9EY=;
 b=NTKtNCLbq6zAKkd1YkK4oUWZmSV3pxYAEKEVqgeHuf/h8zFZlO95H2JC/C71UyFxZD8uIo
 TNulGD/miBhDDAA+SI4jNluvM+7ot6mWbVLTjZ/YzCnnESdhlbvavzfS5XC56mlwdiyUFb
 WDLt+VcYVENR+iCT8IIDxl5zlxD+ju8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-7WejOYbsMgemnJPzwr9OKg-1; Mon, 04 May 2020 10:29:25 -0400
X-MC-Unique: 7WejOYbsMgemnJPzwr9OKg-1
Received: by mail-wm1-f70.google.com with SMTP id f81so3591318wmf.2
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 07:29:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=JRBmE8DpKczmzdQy5ljVjs1IfdrTue9vhDooFsQOZLw=;
 b=YVGSxf7ghfZTBwHPVgGMwdElFQJaUd3rJ1djpmchc1L5DX8amZpyZBN2hfuW3B/pCD
 CnKjkSYdFJR1wkqYuEBFT+vQWoEtvqS+Nanb5R1vu/Gw6KeVayC/s5c9+V4EkE3Yz+Cf
 OZKWZK4C8kw4/PL3BzBfepPhgdeToSQVrKe0/vHikN/jSrPmk20wM2uYsXLCuKOR1btF
 FMAtcOMHahJQc+/PNJm6zhYd/ujHLv7uGadZjPWBxPkR+maWD+etTRdGYFG6EcIiZHmS
 I7Z8GkJrv1UVI/4E1tdWHYbsWBK04d4guSQEZTAK0I4K7pWXs9KoUkfjW8Lyq+5KI1vs
 rOzw==
X-Gm-Message-State: AGi0Pub2yI5ax3/LNHRsDnnJ5BuhEH/155ZvqenvHeMSOJFhVYgnYR7V
 ZaZQYufc6zHE4ejUXGk/kchzG2aWXOIQy77udQpUoDFWe7NzsxRSxpAim3cuYGuP38gTyOHsU4R
 aRcHy017hpRrGQE4=
X-Received: by 2002:a7b:cdfa:: with SMTP id p26mr14860026wmj.186.1588602564523; 
 Mon, 04 May 2020 07:29:24 -0700 (PDT)
X-Google-Smtp-Source: APiQypI32bfvp4kNFdMrvwcifITD+rmyGEDlRc6OBeyQkLYtRxGRFs/3PE0GpW9FzxOiLW23xpSCMw==
X-Received: by 2002:a7b:cdfa:: with SMTP id p26mr14860015wmj.186.1588602564328; 
 Mon, 04 May 2020 07:29:24 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 s24sm14080673wmj.28.2020.05.04.07.29.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 07:29:23 -0700 (PDT)
Date: Mon, 4 May 2020 10:29:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/29] acpi: add aml builder stubs
Message-ID: <20200504142814.157589-5-mst@redhat.com>
References: <20200504142814.157589-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200504142814.157589-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 04:24:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Needed when moving aml builder code to devices.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20200429140003.7336-3-kraxel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/aml-build-stub.c | 79 ++++++++++++++++++++++++++++++++++++++++
 hw/acpi/Makefile.objs    |  4 +-
 2 files changed, 81 insertions(+), 2 deletions(-)
 create mode 100644 hw/acpi/aml-build-stub.c

diff --git a/hw/acpi/aml-build-stub.c b/hw/acpi/aml-build-stub.c
new file mode 100644
index 0000000000..58b2e16227
--- /dev/null
+++ b/hw/acpi/aml-build-stub.c
@@ -0,0 +1,79 @@
+/*
+ * ACPI aml builder stubs for platforms that don't support ACPI.
+ *
+ * Copyright (c) 2006 Fabrice Bellard
+ * Copyright (c) 2016 Red Hat, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/acpi/acpi.h"
+#include "hw/acpi/aml-build.h"
+
+void aml_append(Aml *parent_ctx, Aml *child)
+{
+}
+
+Aml *aml_resource_template(void)
+{
+    return NULL;
+}
+
+Aml *aml_device(const char *name_format, ...)
+{
+    return NULL;
+}
+
+Aml *aml_eisaid(const char *str)
+{
+    return NULL;
+}
+
+Aml *aml_name_decl(const char *name, Aml *val)
+{
+    return NULL;
+}
+
+Aml *aml_io(AmlIODecode dec, uint16_t min_base, uint16_t max_base,
+            uint8_t aln, uint8_t len)
+{
+    return NULL;
+}
+
+Aml *aml_irq_no_flags(uint8_t irq)
+{
+    return NULL;
+}
+
+Aml *aml_int(const uint64_t val)
+{
+    return NULL;
+}
+
+Aml *aml_package(uint8_t num_elements)
+{
+    return NULL;
+}
+
+Aml *aml_dma(AmlDmaType typ, AmlDmaBusMaster bm, AmlTransferSize sz,
+             uint8_t channel)
+{
+    return NULL;
+}
+
+Aml *aml_buffer(int buffer_size, uint8_t *byte_list)
+{
+    return NULL;
+}
diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
index 777da07f4d..cab9bcd457 100644
--- a/hw/acpi/Makefile.objs
+++ b/hw/acpi/Makefile.objs
@@ -20,6 +20,6 @@ common-obj-$(CONFIG_TPM) +=3D tpm.o
 common-obj-$(CONFIG_IPMI) +=3D ipmi.o
 common-obj-$(call lnot,$(CONFIG_IPMI)) +=3D ipmi-stub.o
 else
-common-obj-y +=3D acpi-stub.o
+common-obj-y +=3D acpi-stub.o aml-build-stub.o
 endif
-common-obj-$(CONFIG_ALL) +=3D acpi-stub.o acpi-x86-stub.o ipmi-stub.o
+common-obj-$(CONFIG_ALL) +=3D acpi-stub.o aml-build-stub.o acpi-x86-stub.o=
 ipmi-stub.o
--=20
MST


