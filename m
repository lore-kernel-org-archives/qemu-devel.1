Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC61C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 21:52:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34DB6208C0
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 21:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3c5iV/Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34DB6208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB4MD-0006PZ-No
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 17:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56261)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tcminyard@gmail.com>) id 1iB49Z-0001W2-UH
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:40:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tcminyard@gmail.com>) id 1iB49L-00067W-5f
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:39:51 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:43686)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1iB49K-00066k-V8
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:39:39 -0400
Received: by mail-oi1-x241.google.com with SMTP id t84so5521oih.10
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 14:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Vieta1X04i/SCs0pvbOIwKwN90/dIHs868zzWk/WUvk=;
 b=Q3c5iV/QLclzXeadOegbKBTIjw779E4O3K+NB25XGRPtbzqQ6YgqDIHCOC4ynrB85M
 bSTmBPY4qEdXKwF3tGAHeVBgL4jXgIfwdM4NF+Zp3C/Ea6GwkN9Ny/FG9dRrT1lv4ZuQ
 J65NnZhbvmW5j9OQblW/vxThez5kAvftWJCfp5vMqfPEB86W7xH1+hMWYUA9bHPUx5vd
 azGhKkOuZthRv4dhlADsL2eDMjITui3QcclpHEfpUZCQlzwihsoAkRocL5X7xksAzpcj
 0fiSNba09x0JYzzG1jNeX79WF5PAYnp9PoGuB7j1UvD09mJQx1MuWz0IeF1m/rLh5iew
 pfvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=Vieta1X04i/SCs0pvbOIwKwN90/dIHs868zzWk/WUvk=;
 b=kB1HS+tILejjPqjJ3qK1pe9Ydq14RMwEeoi6fxmfKEMIPNFyjEMGjqSpBCYpcD7je2
 d9vkqwyT+5+1GcjZ7NwjdDwSLLZDGwkFvUS+6fN8BtfhVLkEcJjJpl3pSg9c2CzB4nHD
 9h8Lf/Ua8wPx4b+DNPODEkKMYRFQqcNXe01G0flqccnBiv1MBAT2t2Yn7iIsjV8uBPwJ
 AFQwc4vgF+AQs/fH+L7jH5dpbLSBGP22UXswj8b1SbLs0Ef1wHk/xkVxOlTSjC+INv9L
 55jNnXCzDvXZ1XCox20YtsR4SWumUJswk5PdhRbmth8em9ldhav7RBuehksqALOIgA7j
 txlg==
X-Gm-Message-State: APjAAAWJl12ug3I1jnqTRTcVA1nXrRzq8lsNBzZf4Qcop3832o0VI3VD
 /g12MAF98CaVZ1NTqnTVsA==
X-Google-Smtp-Source: APXvYqwVtJCdOSLwXHpleUZ7VSyo3ZBD1QvwcfjawDG9QNvZgeUHVHINaoyRm6UULxUvLYfPvIVr6A==
X-Received: by 2002:aca:4b85:: with SMTP id y127mr66837oia.70.1568929177082;
 Thu, 19 Sep 2019 14:39:37 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
 by smtp.gmail.com with ESMTPSA id e5sm27780otr.81.2019.09.19.14.39.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 14:39:36 -0700 (PDT)
Received: from t560.minyard.net (unknown [192.168.27.180])
 by serve.minyard.net (Postfix) with ESMTPA id 9B7F11800D2;
 Thu, 19 Sep 2019 21:39:35 +0000 (UTC)
From: minyard@acm.org
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 01/15] ipmi: Fix watchdog NMI handling
Date: Thu, 19 Sep 2019 16:39:10 -0500
Message-Id: <20190919213924.31852-2-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190919213924.31852-1-minyard@acm.org>
References: <20190919213924.31852-1-minyard@acm.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: Corey Minyard <cminyard@mvista.com>, Fam Zheng <famz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Corey Minyard <cminyard@mvista.com>

The wrong logic was used for detection (so it wouldn't work at all)
and the wrong interface was used to inject the NMI if the detection
logic was correct.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/ipmi/ipmi.c         | 6 +++---
 hw/ipmi/ipmi_bmc_sim.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/ipmi/ipmi.c b/hw/ipmi/ipmi.c
index 136c86b7a7..cbe158f815 100644
--- a/hw/ipmi/ipmi.c
+++ b/hw/ipmi/ipmi.c
@@ -28,9 +28,8 @@
 #include "qom/object_interfaces.h"
 #include "sysemu/runstate.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
-#include "qapi/visitor.h"
 #include "qemu/module.h"
+#include "hw/nmi.h"
 
 static uint32_t ipmi_current_uuid = 1;
 
@@ -60,7 +59,8 @@ static int ipmi_do_hw_op(IPMIInterface *s, enum ipmi_op op, int checkonly)
         if (checkonly) {
             return 0;
         }
-        qmp_inject_nmi(NULL);
+        /* We don't care what CPU we use. */
+        nmi_monitor_handle(0, NULL);
         return 0;
 
     case IPMI_SHUTDOWN_VIA_ACPI_OVERTEMP:
diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 246a6d390c..8f63bb7181 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -1194,7 +1194,7 @@ static void set_watchdog_timer(IPMIBmcSim *ibs,
         break;
 
     case IPMI_BMC_WATCHDOG_PRE_NMI:
-        if (!k->do_hw_op(s, IPMI_SEND_NMI, 1)) {
+        if (k->do_hw_op(s, IPMI_SEND_NMI, 1)) {
             /* NMI not supported. */
             rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);
             return;
-- 
2.17.1


