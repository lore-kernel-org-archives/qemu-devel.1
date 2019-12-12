Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD19C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:22:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C86B22527
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUIbLF3s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C86B22527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifT6v-0008WS-Qf
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 13:22:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58105)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifSHE-0005Jt-1L
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 12:29:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ifSHC-00043P-VG
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 12:29:23 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42490)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ifSHC-00042H-NJ
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 12:29:22 -0500
Received: by mail-wr1-x444.google.com with SMTP id q6so3602936wro.9
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 09:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=U3vOKBgC/i6K4YScuB6kA+GIuvMW8sSGRrxjWYPsniE=;
 b=JUIbLF3sasHweeFUwYx+n6HAXX/gtL+eF5oXBA4MFHSuUfx/omfDZ0P6yADcrDkdNh
 VTJr6b++ukm7AJ76O+zdniasm3U4A9Scetms2oUEdMB3S9Pr4C3cX0WGQZDIzpLBLGfV
 VcE0b7DC6zbF3G6rijnHFS4MRL86jbpE3FXtEKBXlN0Gg8+ZyY6rim8oAunCstYAtCO9
 oEo7wIKwRj8OHrcWCH7Aj3FQ19/yCSjLwJmMSJRCZMJt8gtztIMhukIVJSIe/7gT9swo
 pQMLCLfHgJ5Tcv4J0TilcV04VWLYRxurqBud6It+1sjpHqMVf6wWFAB8Qh+HTr8h/M0q
 yVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=U3vOKBgC/i6K4YScuB6kA+GIuvMW8sSGRrxjWYPsniE=;
 b=ez0iQSJxJDMox+J0gkIZOgDVOFqlhLrJVgsamd1HjwF4v8EAMjmDl/oas+aR7EnM+8
 K1a/+ykveKw/1v12tR2t/UzpOODxEw8+uhVMmqpaBTMNx1xxIhWN30r5FRjf+J4UDFPe
 WEAL4dTtGvvSnw0kfzUGczg5R6wVKwfwoMpaZe2ibwlsPwrcjgW2rg3XiXGlC4i1tHzz
 yuUZWDq8gPCcyN/B+MiMSyAfvfOafAg7TwIUxWeQunE+zr2v6/XWfh0jBHkYz34BbrYF
 OwWnWCBKXizAz7cDvjPHQm3aYM8F7e0hLrpj/MCy4JetY4d9kdhoiBXHtqGupAPtBDRS
 p5Ww==
X-Gm-Message-State: APjAAAVx5vGIEFQicqkft1Xuwx3VGcfI5x/sqEsCjeLVdeZi8SfhDF+n
 LBnqbL7Cq4lv1F4oYdf83H3XEUll
X-Google-Smtp-Source: APXvYqzvWRVXpPKifLV+b+mzlZ2uJLjX/njBYsU+a+7ZS+05I2jyqHG6dVo9OQLOEkPXSq1GOa34Kg==
X-Received: by 2002:adf:9427:: with SMTP id 36mr7572003wrq.166.1576171761522; 
 Thu, 12 Dec 2019 09:29:21 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id 2sm6810130wrq.31.2019.12.12.09.29.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 09:29:20 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/8] pci-stub: add more MSI functions
Date: Thu, 12 Dec 2019 18:29:10 +0100
Message-Id: <1576171754-45138-5-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576171754-45138-1-git-send-email-pbonzini@redhat.com>
References: <1576171754-45138-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: philmd@redhat.com, slp@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On x86, KVM needs some function from the PCI subsystem in order to set
up interrupt routes.  Provide some stubs to support x86 machines that
lack PCI.

Reviewed-by: Sergio Lopez <slp@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/pci/pci-stub.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/hw/pci/pci-stub.c b/hw/pci/pci-stub.c
index c04a5df..cc2a2e1 100644
--- a/hw/pci/pci-stub.c
+++ b/hw/pci/pci-stub.c
@@ -26,6 +26,7 @@
 #include "qapi/qmp/qerror.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/msi.h"
+#include "hw/pci/msix.h"
 
 bool msi_nonbroken;
 bool pci_available;
@@ -64,3 +65,29 @@ void msi_notify(PCIDevice *dev, unsigned int vector)
 {
     g_assert_not_reached();
 }
+
+/* Required by target/i386/kvm.c */
+bool msi_is_masked(const PCIDevice *dev, unsigned vector)
+{
+    g_assert_not_reached();
+}
+
+MSIMessage msi_get_message(PCIDevice *dev, unsigned int vector)
+{
+    g_assert_not_reached();
+}
+
+int msix_enabled(PCIDevice *dev)
+{
+    return false;
+}
+
+bool msix_is_masked(PCIDevice *dev, unsigned vector)
+{
+    g_assert_not_reached();
+}
+
+MSIMessage msix_get_message(PCIDevice *dev, unsigned int vector)
+{
+    g_assert_not_reached();
+}
-- 
1.8.3.1



