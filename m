Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019A8C2D0C3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:14:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5A0E206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kz7ecRqg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5A0E206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igtwn-00032n-H8
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 12:14:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57281)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFZ-0005mW-BW
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFY-0000Af-B4
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:37 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44899)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtFY-000089-51
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:36 -0500
Received: by mail-wr1-x444.google.com with SMTP id q10so8018201wrm.11
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=U3vOKBgC/i6K4YScuB6kA+GIuvMW8sSGRrxjWYPsniE=;
 b=Kz7ecRqgS8g0kMk/BTGySZ5sAGGmOEu/Uvt0Fbd4bpGxBYeoN3qAGJ5KG4A5KyJ62+
 yB079OSks+yO/6dy8aJT+hkApyeGfJaSLFCTKBNvGJc8wcWnvJDhw0lvoKzgyqAPPsI+
 /MfGMdLsJBtLbwEU1ffzgb9nxGIf9rhBwU5uRXs+int/x6infaBj0abzMVmi6jwW9w7t
 YrVsmF1bvM4//Kof4+Isk2XGlxCDXo4ExaLGSnTtpoILc3zBlceZ/mZmH9xhahEAi15C
 rMgHtmITDCoDGH8CFyYX+UGXNkxkeUGj3o0BcYU2RgGvU4zGc4z1+xdqStHyfwuQ9pnW
 2W9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=U3vOKBgC/i6K4YScuB6kA+GIuvMW8sSGRrxjWYPsniE=;
 b=g00Ow/OZ0PsfpPBVmPDwdwsLisbLGS/jDSMqTWTB4BAiZ3+ka6U13fSS5znuxBYUeX
 /9yN0eyitcEinB1Ywl7Edr9RAkU7RZ1SgLkaGdDYsth9QzCMJ3Lo5N4FrwKPHZWau81y
 b7bWpJJEADv8GlJexAq/CEMtJh0XBnqxA0eZdJKVpM35FbcUy8R5gzJtvFP8B3lH/8SQ
 WCC3nl0mxAR+5Bar8pAVDeUO+mvy/WC5sxzRnltSBxsR4jFEbL+fXW6/nCBCCPywghHt
 1I7OUQJjzG9rZhhawO/2I3KYfgOwPuii6cKNA+sGOV2obh1mQihjNksVQ2YPo0FIlczm
 MaUA==
X-Gm-Message-State: APjAAAUP5+XvOAPbNihUi6LWpKNWypimusI9LryOJXk1X83HY2Qt0HwY
 RshVNIgpyhES/mnsnpsd7SdkJXMw
X-Google-Smtp-Source: APXvYqwJJxsgFJ76cLZbAoF0rKyH6MndSdPU4Kd8cSPKZ1wzaWmRvlUEgTaUD7ajuGdFq5c6OcYuRg==
X-Received: by 2002:adf:c446:: with SMTP id a6mr30088253wrg.218.1576513774759; 
 Mon, 16 Dec 2019 08:29:34 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.29.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:29:33 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 47/62] pci-stub: add more MSI functions
Date: Mon, 16 Dec 2019 17:28:31 +0100
Message-Id: <1576513726-53700-48-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
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



