Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B4FC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:05:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C42E2073C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="In7ULMKF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C42E2073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2G3A-0008FI-Cv
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 10:05:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60635)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2FhR-0004sb-3S
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2FhO-0002Sp-PL
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:41 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:43812)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2FhO-0002QL-HT
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:38 -0500
Received: by mail-wr1-x42c.google.com with SMTP id r11so6957757wrq.10
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 06:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=AvLTlb1mlCxI535cEDG/qFrA3d9eb3oYnfPvbffg3nY=;
 b=In7ULMKFYM6W+fAZDWHUXhFFQX3fUqIE+x4JD0LBBlz/c5hfklc8fZoW/RMYAz7pRw
 7LQx4XkxWU2mdhmY7IWMA7+GVtc/aC9zssffheEjPSYVLe8wLQ20mG2g/zPNncjoqCFV
 yXomRN8W75nMzH3jeVppuHOaTMeGXtjtDx8Xdp+Xnwr/rw6/xmXrkHKXXkAsqtI/2SDQ
 LwB+Xc+GDlLUBqfY8q9yHo3iWoC81TK1ASxrdgqm+NuS7YTN/UHsSLohAVbtOVQs+u3X
 OIZAb8hx+71gO6pFDOTMUKljRhtc3tQeu/zreT3juDIHdMg7WhQEu0LT5K5ykOp+wn7N
 BOIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AvLTlb1mlCxI535cEDG/qFrA3d9eb3oYnfPvbffg3nY=;
 b=hvRc9xIDWfRohDoGLwq6XCOunALZBUhAm+Y4daLtEz8z5zNrc05JjuGsLXLie9+xV4
 nA2iQYaYbRx/urNSBw8DmX2D3i21bsnlDWBlyxbJfty3YQ2JUENsinVTkQnZAbba4XHv
 Ozf7DqnLwfbNzp+pFIhmfDmdE8/81UNazQUqHDbmRVGW7pVLYQ8YBq3wba3nL4d26kK1
 bdRZMyYRi/OLMiLYiDI7keqtbRd0vnKlmj65vRKu0rmZ1Y69Muaj6i4bFfbp7/uSmmAm
 DztXbHw7rZcjd2z0KEuKZHtCVsn+G4Lhvzn7kiQ9Xa8SbuZ6+uv/a4P/yTJSe+37DUjh
 RaJQ==
X-Gm-Message-State: APjAAAWFLAHX1wHVSjiObz3VXovy6H67suJfiS5BDBT8ev/iysx8ZEQk
 2fcWzBDmb72wNiTgV1TzgrLrIT8VcN0=
X-Google-Smtp-Source: APXvYqxvTIpM+SD++B9S7nCoILsrtyEuOvO0j4+g76vOwx1AEPQ+qDgUowun+rXhvM++1fY7Eh+3AQ==
X-Received: by 2002:a5d:4984:: with SMTP id r4mr21288856wrq.137.1581604957251; 
 Thu, 13 Feb 2020 06:42:37 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e22sm3362454wme.45.2020.02.13.06.42.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 06:42:36 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 45/46] hw/arm/raspi: Extract the cores count from the board
 revision
Date: Thu, 13 Feb 2020 14:41:44 +0000
Message-Id: <20200213144145.818-46-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213144145.818-1-peter.maydell@linaro.org>
References: <20200213144145.818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

The count of ARM cores is encoded in the board revision.  Add a
helper to extract the number of cores, and use it.  This will be
helpful when we add the Raspi0/1 that have a single core.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200208165645.15657-14-f4bug@amsat.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: tweaked commit message as suggested by Igor]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/raspi.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index bee6ca0a086..90ad9b81158 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -101,6 +101,21 @@ static const char *board_soc_type(uint32_t board_rev)
     return soc_types[proc_id];
 }
 
+static int cores_count(uint32_t board_rev)
+{
+    static const int soc_cores_count[] = {
+        0, BCM283X_NCPUS, BCM283X_NCPUS,
+    };
+    int proc_id = board_processor_id(board_rev);
+
+    if (proc_id >= ARRAY_SIZE(soc_cores_count) || !soc_cores_count[proc_id]) {
+        error_report("Unsupported processor id '%d' (board revision: 0x%x)",
+                     proc_id, board_rev);
+        exit(1);
+    }
+    return soc_cores_count[proc_id];
+}
+
 static const char *board_type(uint32_t board_rev)
 {
     static const char *types[] = {
@@ -307,9 +322,7 @@ static void raspi_machine_class_init(ObjectClass *oc, void *data)
     mc->no_parallel = 1;
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
-    mc->max_cpus = BCM283X_NCPUS;
-    mc->min_cpus = BCM283X_NCPUS;
-    mc->default_cpus = BCM283X_NCPUS;
+    mc->default_cpus = mc->min_cpus = mc->max_cpus = cores_count(board_rev);
     mc->default_ram_size = board_ram_size(board_rev);
     if (board_version(board_rev) == 2) {
         mc->ignore_memory_transaction_failures = true;
-- 
2.20.1


