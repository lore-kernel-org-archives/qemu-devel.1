Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE02DC8300B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:56:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9864E20757
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZYXIx+do"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9864E20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7o9-0004Ns-O2
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 07:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33738)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7jT-0002nQ-5n
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:51:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7jR-0000Lx-Dh
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:51:58 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37851)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jU7jQ-0000LP-VD
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:51:57 -0400
Received: by mail-wm1-x341.google.com with SMTP id z6so1552625wml.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 04:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Jt6G/iju8uSaFNeIzNPrG1p2vPHbPGysm95I3wdnMB0=;
 b=ZYXIx+doJ//wjNe0LhPLGhlbk9ZCEQPF4Aid9SHgu3OORkpLidu8TmOvs1yU2d3O63
 nOy9mNnSb83YRMm/EaevTJswCQx5+P1lgIvGxc1DdseSkwkmu7KYIc2ryKPLD3LyH99f
 1utovLxWWVy86R/NLo3aSaofiWtWgOGqLXFPri+zWkdFOhj14R/hnkJdP0psS4paW8FD
 QbxfJ847Zkw1K2WQmSlkJzEa9weF3SwHvrUYC/Y6s1A83cqMxgcQIgTrbepqRY1a51P0
 qzxSGXZ5O3tyGwUK4xk5A6Lm7WBNRh4uirQpdEaSPL1+05D5DYm8eRS7dgaGR+ljhXo4
 8zYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Jt6G/iju8uSaFNeIzNPrG1p2vPHbPGysm95I3wdnMB0=;
 b=p13XSPzT1l3b4CMBAHEtWYS/3IfxV31VEq/nKGQ5mlLjzyuJvtwlC748CWGXa2n0dM
 Ghf2mrM2SeDbmw2gbVUiwOcp7sCfPAQ4naWe8nT19BMgXlDFagUmg7bNtdIFN3Lh6erL
 tYaQkROHIV/R9aJ0oa4STbxmHWMoh946vXUhSuYmt0BCRF476+WLeKMBCa3VKHZ9skZZ
 nLikPQ7yvJYIhLqDIN2a1kIHaBc+AZacyhwbR6on9I/rIFRg3ohHrcw9Hmg2yI455+vk
 LXsYn0Vv1Ws0gy6vo9SvvpqN+vMCIbDKqy9xjM7t5B4HwZfdv/BsJBCWfpnYcT/o07PR
 DEoQ==
X-Gm-Message-State: AGi0PuYbGQcBAx925pgVxijOS1L5kIkMqi/gfGPD2J0sVYWgsY7gZNWK
 AfF5DhjyWsR5xuFSxujFJwk3r8Oesjj15w==
X-Google-Smtp-Source: APiQypKHQ21JansXTdVDtmpHXDcbWPhS3pEkkbz9b2mmwHhexzl31EOSEsxSQ1ybOpfq2qQdHpqN9A==
X-Received: by 2002:a1c:ba56:: with SMTP id k83mr2538868wmf.1.1588247515236;
 Thu, 30 Apr 2020 04:51:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j22sm491518wre.84.2020.04.30.04.51.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 04:51:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/31] hw/core/clock-vmstate: define a vmstate entry for clock
 state
Date: Thu, 30 Apr 2020 12:51:21 +0100
Message-Id: <20200430115142.13430-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430115142.13430-1-peter.maydell@linaro.org>
References: <20200430115142.13430-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::341
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

From: Damien Hedde <damien.hedde@greensocs.com>

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-id: 20200406135251.157596-3-damien.hedde@greensocs.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/core/Makefile.objs   |  1 +
 include/hw/clock.h      |  9 +++++++++
 hw/core/clock-vmstate.c | 25 +++++++++++++++++++++++++
 3 files changed, 35 insertions(+)
 create mode 100644 hw/core/clock-vmstate.c

diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index 1d9b0aa2057..115df550874 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -21,6 +21,7 @@ common-obj-$(CONFIG_SOFTMMU) += null-machine.o
 common-obj-$(CONFIG_SOFTMMU) += loader.o
 common-obj-$(CONFIG_SOFTMMU) += machine-hmp-cmds.o
 common-obj-$(CONFIG_SOFTMMU) += numa.o
+common-obj-$(CONFIG_SOFTMMU) += clock-vmstate.o
 obj-$(CONFIG_SOFTMMU) += machine-qmp-cmds.o
 
 common-obj-$(CONFIG_EMPTY_SLOT) += empty_slot.o
diff --git a/include/hw/clock.h b/include/hw/clock.h
index 82a7f3c6982..f3e44e9460c 100644
--- a/include/hw/clock.h
+++ b/include/hw/clock.h
@@ -74,6 +74,15 @@ struct Clock {
     QLIST_ENTRY(Clock) sibling;
 };
 
+/*
+ * vmstate description entry to be added in device vmsd.
+ */
+extern const VMStateDescription vmstate_clock;
+#define VMSTATE_CLOCK(field, state) \
+    VMSTATE_CLOCK_V(field, state, 0)
+#define VMSTATE_CLOCK_V(field, state, version) \
+    VMSTATE_STRUCT_POINTER_V(field, state, version, vmstate_clock, Clock)
+
 /**
  * clock_setup_canonical_path:
  * @clk: clock
diff --git a/hw/core/clock-vmstate.c b/hw/core/clock-vmstate.c
new file mode 100644
index 00000000000..260b13fc2c8
--- /dev/null
+++ b/hw/core/clock-vmstate.c
@@ -0,0 +1,25 @@
+/*
+ * Clock migration structure
+ *
+ * Copyright GreenSocs 2019-2020
+ *
+ * Authors:
+ *  Damien Hedde
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "migration/vmstate.h"
+#include "hw/clock.h"
+
+const VMStateDescription vmstate_clock = {
+    .name = "clock",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(period, Clock),
+        VMSTATE_END_OF_LIST()
+    }
+};
-- 
2.20.1


