Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03936C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 15:10:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C907C2067D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 15:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmZMo7Fz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C907C2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6Fst-0001R5-0w
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 11:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35064)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i6Fs1-0000wm-Oc
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 11:09:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i6Fs0-0007Np-Q3
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 11:09:53 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e]:37463)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>) id 1i6Fs0-0007NV-Ku
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 11:09:52 -0400
Received: by mail-pf1-x42e.google.com with SMTP id y5so1940387pfo.4
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2019 08:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=OU7PaxyDHg7orZAVl+1ijHx3uo3vuQJ2JQDWvcJ9sP0=;
 b=RmZMo7Fz/6luuwqnV6XgkfrtRdHy05JsSucY4/a1z9ID3rG6RvYZXPEHzZM3BlHYAu
 z4OaLEwXqKDeSYw/0qqphIyfGpAIih+iBJS1c+FELJ7axlN9m5+i7pm9gWAOzCE4hyrP
 VFIuFEtYi4iehstd2YUlH0tqbZB/wTQ5PAVJ8RfQ1g1OWkaJZos7/F9IBrTq9G1KBEQQ
 P+AiHJTStU2Cqtr0aWRz+fR1apavlDoe0eBygq5bGaDuCTkuCuaknwbHPNpp/2gLw0F8
 03shz0DzAaPRuLagLqbs2h1Kkq/oro1UJQtbrbbwMSTu8fLvUqmohW5Wi1p0MhiURqdH
 y98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=OU7PaxyDHg7orZAVl+1ijHx3uo3vuQJ2JQDWvcJ9sP0=;
 b=HztsXKgTlhk6OebUa2WDXA5VhF0s1gmgnD1pSZhNCYxx+eeNzKM3vazDHrTTQn9Dvh
 9xgexrBMBjIuf3iSFzcHQ9IB6CGQ0sDp8cWF24MucJnnMof9njEVIZKxWt7YntbDwnoW
 CEL7DFEt73+aSnUrSLQhqQ38ze46XVZI3tByz8bBJwQWTyM023YH7/1BEbQl7V7rVw0D
 fdgbv7A7Wcx62JgbHrgPqX6p1q5Nj+mqCYxCICcIDs6XGMMJasdpRDYYV+SGjOo9IANV
 ZHuhJxGzhPG2zT+gVK7o9D3qbvPnkiaZUL6LG5btrzy67YEfNJOx5w2N7WQ6cpItntWV
 2Arg==
X-Gm-Message-State: APjAAAXEEAsnULsYlwy1QfuUtjDyOfMv6L+ztBme8G/kzxKriuErUT4x
 AiPr3QW1A7JhzngaZVmIs4cjyeiW
X-Google-Smtp-Source: APXvYqy7VSUPQsVSrwV7FMyarm+sbFnG6Zxb37Lc2NLGRRgNOQtrlESRuqQOLUbH2RfC746EaPAzHA==
X-Received: by 2002:a17:90a:d793:: with SMTP id
 z19mr10024535pju.36.1567782591291; 
 Fri, 06 Sep 2019 08:09:51 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id w134sm7528802pfd.4.2019.09.06.08.09.50
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Fri, 06 Sep 2019 08:09:50 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Date: Fri,  6 Sep 2019 08:09:45 -0700
Message-Id: <1567782585-19854-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42e
Subject: [Qemu-devel] [PATCH] riscv: hw: Remove duplicated "hw/hw.h"
 inclusion
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit a27bd6c779ba ("Include hw/qdev-properties.h less") wrongly
added "hw/hw.h" to sifive_prci.c and sifive_test.c.

Another inclusion of "hw/hw.h" was later added via
commit 650d103d3ea9 ("Include hw/hw.h exactly where needed"), that
resulted in duplicated inclusion of "hw/hw.h".

Fixes: a27bd6c779ba ("Include hw/qdev-properties.h less")
Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
---

 hw/riscv/sifive_prci.c | 1 -
 hw/riscv/sifive_test.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/hw/riscv/sifive_prci.c b/hw/riscv/sifive_prci.c
index 9837b61..562bc3d 100644
--- a/hw/riscv/sifive_prci.c
+++ b/hw/riscv/sifive_prci.c
@@ -19,7 +19,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
 #include "target/riscv/cpu.h"
diff --git a/hw/riscv/sifive_test.c b/hw/riscv/sifive_test.c
index 3557e16..7117409 100644
--- a/hw/riscv/sifive_test.c
+++ b/hw/riscv/sifive_test.c
@@ -19,7 +19,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
 #include "sysemu/runstate.h"
-- 
2.7.4


