Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8640EC10DCE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 01:43:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E46E20663
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 01:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KTz6AibK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E46E20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDenF-0000oY-7I
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 21:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDdMT-0008UI-2M
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:12:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDdMP-0006hc-0h
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:12:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37189
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDdMO-0006gN-SW
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 20:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584317520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kuMVG+NTWOPLSO3v2C9jYeHA3g0NL+S99GiL6fEWeBk=;
 b=KTz6AibK6Legq/VRSxRU7azF91knNj80ZwwAq89xIG0Uj9HpeXYKS4waFpl6az8roPGHKV
 GI0UUz4QMOf2C0uM59Tcan6weXT+Mzqcl7aZK8IvaAtJjTTJEuwxn60VWXOGRvONgRms7y
 1SiCZi6kZsSMueiA0Yc2GUdpjrhuFP8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-s8HI0huWMBup93VmwWnTVQ-1; Sun, 15 Mar 2020 20:11:58 -0400
X-MC-Unique: s8HI0huWMBup93VmwWnTVQ-1
Received: by mail-wr1-f72.google.com with SMTP id t10so1853148wrp.15
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 17:11:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=I6U+Qw9elflVP4hqM5y7jEbjXrYe0uOEYqqfQofz9BY=;
 b=t3fA79S3E1JdIfXxABKGGVaV+UJZ02F1LPrFAUKPeE1DB9R+iyC9RDow5qaAT2ZBe+
 pGOicsSrk09FC824ly6QDd/bocfywMO2R9wP85RcPsxuOg83E+OUGlmFNPlJ7BgMDKJN
 M1N7J31kEoJLQihsv8NRBNNqDnQmV1FHvHZ7hJAwJLc/57hg70IFzD5m4CaG3zFJc4qg
 L/nPu/gUh82lsJWLjL6l834PuwA2uPfZrcHe07Uc1TVwE3HbiautC8nFn6X97UFO9cgr
 UHmJ0EOAFS7vQA3rPXxuKyrYA/5W4jqcTy+QWhhoXSdALlgiT11GF4UPmhTzZ3JCELuT
 3IRw==
X-Gm-Message-State: ANhLgQ3MWLBtEoh3ZIc1sPYzY2aMyFtZpYtEqtJw8PJUVgtri0w1Xa5d
 5t08qu5S8Soakv1UJlRwo69I50VOZp9XX81aG8EV/vFDobZmSVK6VlRy3ebUuZ6Eac1QfmLj5IQ
 /fxld3x3qyy1sBQk=
X-Received: by 2002:adf:8341:: with SMTP id 59mr17006249wrd.314.1584317517487; 
 Sun, 15 Mar 2020 17:11:57 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtEuqJgk3lgm+Ek5BkmkSJzmRlOWJ0lZCx8ohYK/tEC4FIjh9NwBPdYntgEPLEtT/O9nF3+LA==
X-Received: by 2002:adf:8341:: with SMTP id 59mr17006228wrd.314.1584317517263; 
 Sun, 15 Mar 2020 17:11:57 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id x17sm27123353wmi.28.2020.03.15.17.11.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2020 17:11:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 8/9] hw/core: Add qdev stub for user-mode
Date: Mon, 16 Mar 2020 01:11:10 +0100
Message-Id: <20200316001111.31004-9-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316001111.31004-1-philmd@redhat.com>
References: <20200316001111.31004-1-philmd@redhat.com>
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
 Eduardo Habkost <ehabkost@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While user-mode does not use peripherals (devices), it uses a
CPU which is a device.
In the next commit we will reduce the QAPI generated code for
user-mode. Since qdev.c calls qapi_event_send_device_deleted(),
let's add a stub for it.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2: use common-obj-$(CONFIG_ALL) (Paolo)
---
 hw/core/qdev-stubs.c  | 20 ++++++++++++++++++++
 hw/core/Makefile.objs |  3 +++
 2 files changed, 23 insertions(+)
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
index 6215e7c208..9f874a8840 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -31,3 +31,6 @@ common-obj-$(CONFIG_OR_IRQ) +=3D or-irq.o
 common-obj-$(CONFIG_SPLIT_IRQ) +=3D split-irq.o
 common-obj-$(CONFIG_PLATFORM_BUS) +=3D platform-bus.o
 common-obj-$(CONFIG_GENERIC_LOADER) +=3D generic-loader.o
+
+common-obj-$(call lnot,$(CONFIG_SOFTMMU)) +=3D qdev-stubs.o
+common-obj-$(CONFIG_ALL) +=3D qdev-stubs.o
--=20
2.21.1


