Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A784C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 08:07:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8484206F8
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 08:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HQ0MjnkG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8484206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKHMp-0005xS-Uz
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 04:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42270)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jKHKJ-0000yZ-C0
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:05:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jKHKH-0007jJ-ND
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:05:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34103
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jKHKH-0007hk-Hq
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:05:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585901116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UMB9JjIaLrSst3MocdOc+Svn33XmTr9puid36pPNV4Y=;
 b=HQ0MjnkGkDkzlGKno/ve55wVETs+Z8gojsO082doIo14uqluDmp4bZoTqEeA6yJa21kJ2q
 VJ+3KZXNKqf+kmQ9Dx/zrxhioNFeznZ8jh+kdbaqAvsCKzKGyhj23RvMuIyR4G0D/ak/a7
 AweHShsaWU7RW5fp8/aVV+vDkdJ7vwk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-9IXIftfFPOqM_xhz1QpNiQ-1; Fri, 03 Apr 2020 04:05:13 -0400
X-MC-Unique: 9IXIftfFPOqM_xhz1QpNiQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3EEBCDB63;
 Fri,  3 Apr 2020 08:05:12 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-60.ams2.redhat.com
 [10.36.113.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 14B2A25276;
 Fri,  3 Apr 2020 08:05:04 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id EBA6217506; Fri,  3 Apr 2020 10:05:02 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/12] acpi: add aml builder stubs
Date: Fri,  3 Apr 2020 10:04:52 +0200
Message-Id: <20200403080502.8154-3-kraxel@redhat.com>
In-Reply-To: <20200403080502.8154-1-kraxel@redhat.com>
References: <20200403080502.8154-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Needed when moving aml builder code to devices.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/acpi/aml-build-stub.c | 79 ++++++++++++++++++++++++++++++++++++++++
 hw/acpi/Makefile.objs    |  4 +-
 2 files changed, 81 insertions(+), 2 deletions(-)
 create mode 100644 hw/acpi/aml-build-stub.c

diff --git a/hw/acpi/aml-build-stub.c b/hw/acpi/aml-build-stub.c
new file mode 100644
index 000000000000..58b2e162277f
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
index 777da07f4d70..cab9bcd457dc 100644
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
2.18.2


