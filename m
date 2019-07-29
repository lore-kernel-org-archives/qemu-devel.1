Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB78C7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:23:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78155206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7PpORk/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78155206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs7Ux-0001wC-Pr
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43668)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hs7Pb-00072L-OW
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:18:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hs7Pa-0007lu-Nk
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:18:07 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:43327)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1hs7Pa-0007j2-A3; Mon, 29 Jul 2019 11:18:06 -0400
Received: by mail-pg1-x543.google.com with SMTP id r22so824214pgk.10;
 Mon, 29 Jul 2019 08:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=A+f1nTAYThN43NLD0uFt8nEj4oW9MitsnNvRn4dZPNs=;
 b=K7PpORk/rkBITy6c5hwX86ZB0qiMr/7hBFH/+0Cw9ysqCuTDipAbdQEmwvq0bKiqGo
 D5WOKXVUZbSWPIJkmBLRCmHMmH6M9ILn3MaE9NBRY+hQf69s3Qig5xHvz6ZQXeqR9Axh
 HMCRYZAxMKxSbZzOmSreoOS1EmxScMS1TI+xomFEq3QgHNpHQPpsquzV46FRT/zI/TGT
 xnUAJQj+4/MfiN0eXixv2HniijFT4euiI78Mhjl8s/t4cA3PTPWaP+0UkeYLC3d/CXba
 A+KqdtzvNZeBW0VtrtuS6UDSDmtaX4w2ePR2qRbCc0sbe6p4rkx3iEWPbMRfoGakVymh
 dgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=A+f1nTAYThN43NLD0uFt8nEj4oW9MitsnNvRn4dZPNs=;
 b=ppLnHkFbRLbMMfbvYIx5EWaMPJEmL6H0zMaXBWqO79AxRvdNMsbvmV2x5mwZJNAvEw
 DpUT/KS/IwKjUso4fz8+kWKug2L6NF2uCh++ggQWhIWVPWYGo7ThEtzOf+Ud2w+iuwKe
 0J5GfdIDezTTVlZnZIAh80YN8okZGpiA9dLp0JKA5OGeCp+XdrIGpBTYSdrXwEZjRlm+
 FgnfAAKod7CWdJzWmHjzWBVZjUzrBFnTWafH409o/FJznNxZHmRnpf1RqvyLdGLlHqEK
 hht1lAPXsW41BTCRaD2ylR1xPvEB6GLQNpX5COR9GGjA3OLUFNz3jCrgaNSo5F1N4Psd
 Utlw==
X-Gm-Message-State: APjAAAXD/7jLZIHdcizIuHlopXRI41TxWYCH8Cl62pOkgsF2KTSg2gGV
 fdw7XBtJV+iXWrhe63Lixde1kEI2KW+gbA==
X-Google-Smtp-Source: APXvYqzcd0ft2mrCl9S/c6Ybp7Wy/Bk3GK63r9Fe+dqaCEX4W6asNo4QRpesFgrdZd40veJwroQcBA==
X-Received: by 2002:aa7:8752:: with SMTP id g18mr35866732pfo.201.1564413484624; 
 Mon, 29 Jul 2019 08:18:04 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.97])
 by smtp.gmail.com with ESMTPSA id h129sm58693941pfb.110.2019.07.29.08.17.57
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 29 Jul 2019 08:18:04 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 29 Jul 2019 20:46:41 +0530
Message-Id: <20190729151651.21306-6-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190729151651.21306-1-mehta.aaru20@gmail.com>
References: <20190729151651.21306-1-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH v7 05/15] stubs: add stubs for io_uring
 interface
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Sergio Lopez <slp@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 saket.sinha89@gmail.com, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefan@redhat.com>, Julia Suvorova <jusual@mail.ru>,
 Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 MAINTAINERS         |  1 +
 stubs/Makefile.objs |  1 +
 stubs/io_uring.c    | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 34 insertions(+)
 create mode 100644 stubs/io_uring.c

diff --git a/MAINTAINERS b/MAINTAINERS
index be688fcd5e..bca5de7d6c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2536,6 +2536,7 @@ R: Stefan Hajnoczi <stefan@redhat.com>
 L: qemu-block@nongnu.org
 S: Maintained
 F: block/io_uring.c
+F: stubs/io_uring.c
 
 qcow2
 M: Kevin Wolf <kwolf@redhat.com>
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 9c7393b08c..5cf160a9c8 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -13,6 +13,7 @@ stub-obj-y += iothread.o
 stub-obj-y += iothread-lock.o
 stub-obj-y += is-daemonized.o
 stub-obj-$(CONFIG_LINUX_AIO) += linux-aio.o
+stub-obj-$(CONFIG_LINUX_IO_URING) += io_uring.o
 stub-obj-y += machine-init-done.o
 stub-obj-y += migr-blocker.o
 stub-obj-y += change-state-handler.o
diff --git a/stubs/io_uring.c b/stubs/io_uring.c
new file mode 100644
index 0000000000..622d1e4648
--- /dev/null
+++ b/stubs/io_uring.c
@@ -0,0 +1,32 @@
+/*
+ * Linux io_uring support.
+ *
+ * Copyright (C) 2009 IBM, Corp.
+ * Copyright (C) 2009 Red Hat, Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+#include "qemu/osdep.h"
+#include "block/aio.h"
+#include "block/raw-aio.h"
+
+void luring_detach_aio_context(LuringState *s, AioContext *old_context)
+{
+    abort();
+}
+
+void luring_attach_aio_context(LuringState *s, AioContext *new_context)
+{
+    abort();
+}
+
+LuringState *luring_init(Error **errp)
+{
+    abort();
+}
+
+void luring_cleanup(LuringState *s)
+{
+    abort();
+}
-- 
2.21.0


