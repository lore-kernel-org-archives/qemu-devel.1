Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241D4C2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:58:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3DCE20658
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CBmDUPlc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3DCE20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCpVW-0003xG-5e
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 14:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35721)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jCpKd-0001Va-CR
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:46:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jCpKc-00071z-B0
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:46:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27385
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jCpKc-00071I-6k
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584125209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qp7vKpOv2W7tIk36eqDbxgbGQUwh1AA9h75Fp+jTf+g=;
 b=CBmDUPlc2LUnVPpAK5T2de+A+2CV0kPmNc6yNf/FoCdqTEoTjamAlLhH0bJ5CHNutsg/4l
 3AC6N6e3nPh0IY2HCi6AXmFZSq5DZq4xek2Mr2seFfPLEuM7fqS0wY785xHOHPk3D1ldx+
 xicfATmHl1S7ON6wcNBCgU/fcipUM3o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-tXbpwCjMM6iwdjjSyoMMow-1; Fri, 13 Mar 2020 14:46:48 -0400
X-MC-Unique: tXbpwCjMM6iwdjjSyoMMow-1
Received: by mail-wr1-f72.google.com with SMTP id u12so2283269wrw.10
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 11:46:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3a+Tnm1TZFFOSQQDhmf8V5bigxeVUKZlbcJluEprtLU=;
 b=gYwQElMx1vMo6ceeJ6jpNnyIumFHq7iBybGjQuoxOpcZ5TxJK6of9mFI37AF/w3Rg4
 ficp2ymD9CtH6ZjFYXL3/qq2dZxQpN3AA1YtPmnix2f7h+XEf9qqgeVWFp2iNZ0GGRSb
 vTPV1BNeobOw//x3YCJTd9jZNS+yWOeg8gIOzKT9qNDxrglm//4P/eTL7MAh8FQxg0vf
 lSQnib7bIt9RUF2lLtpj6R7ZCsGRwzlhxmywXItY5jnrOTwKyt1Uiy6GVevZ5sdS6gNO
 Gz41q3rLPzJt0QdDssMDvO20J74YAnMmEew/XFZ8p/9wt5G0qgeWNBeAMO14kWqVeWE3
 PD9w==
X-Gm-Message-State: ANhLgQ3bYGl7w7WDccyWr5UyGS2lmswjuqSX56YhMLbMD4JVO0x4pZAR
 ThIGMNMkYO2UMY2G1glcbfCsZjLwYtRwqdZV+4i5aeTYmFu2Ot7rkUsaoQ23sJGd78ua6fd+Uuw
 54Nvqu2pCWbaV92o=
X-Received: by 2002:a1c:418b:: with SMTP id
 o133mr12554787wma.165.1584125206768; 
 Fri, 13 Mar 2020 11:46:46 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsTWLso2AUAV0UjexAIg/0GX7zlm2N8Xuan3B9/zbfe9muByFs7C6b/pWpzDwJ/vc1St8TMwg==
X-Received: by 2002:a1c:418b:: with SMTP id
 o133mr12554767wma.165.1584125206561; 
 Fri, 13 Mar 2020 11:46:46 -0700 (PDT)
Received: from x1w.redhat.com (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id d21sm901937wrb.51.2020.03.13.11.46.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2020 11:46:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 8/9] hw/core: Add qdev stub for user-mode
Date: Fri, 13 Mar 2020 19:46:06 +0100
Message-Id: <20200313184607.11792-9-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200313184607.11792-1-philmd@redhat.com>
References: <20200313184607.11792-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While user-mode does not use peripherals (devices), it uses a
CPU which is a device.
In the next commit we will reduce the QAPI generated code for
user-mode. Since qdev.c calls qapi_event_send_device_deleted(),
let's add a stub for it.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/core/qdev-stubs.c  | 20 ++++++++++++++++++++
 hw/core/Makefile.objs |  1 +
 2 files changed, 21 insertions(+)
 create mode 100644 hw/core/qdev-stubs.c

diff --git a/hw/core/qdev-stubs.c b/hw/core/qdev-stubs.c
new file mode 100644
index 0000000000..0819dcba12
--- /dev/null
+++ b/hw/core/qdev-stubs.c
@@ -0,0 +1,20 @@
+/*
+ * QAPI qdev stubs
+ *
+ * Copyright (c) 2020 Red Hat, Inc.
+ *
+ * Author:
+ *   Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.
+ * See the COPYING file in the top-level directory.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/qapi-events-qdev.h"
+
+void qapi_event_send_device_deleted(bool has_device,
+                                    const char *device, const char *path)
+{
+}
diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index 6215e7c208..89bf247173 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -8,6 +8,7 @@ common-obj-y +=3D vmstate-if.o
 # irq.o needed for qdev GPIO handling:
 common-obj-y +=3D irq.o
=20
+common-obj-$(call lnot,$(CONFIG_SOFTMMU)) +=3D qdev-stubs.o
 common-obj-$(CONFIG_SOFTMMU) +=3D reset.o
 common-obj-$(CONFIG_SOFTMMU) +=3D qdev-fw.o
 common-obj-$(CONFIG_SOFTMMU) +=3D fw-path-provider.o
--=20
2.21.1


