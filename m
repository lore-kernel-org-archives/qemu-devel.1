Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2608AC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 19:22:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8FF9222C3
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 19:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mFbldVZu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8FF9222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDZL3-00017E-K3
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 15:22:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45479)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iDYmB-0002K6-Kl
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:46:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iDYmA-00055h-7R
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:46:03 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:40012)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iDYm8-0004zY-Je
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:46:01 -0400
Received: by mail-wr1-x435.google.com with SMTP id l3so3907584wru.7
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 11:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5fLMKoxAcnX8/4qyqjfQR0D8xnH/RRawEKHgUpx30II=;
 b=mFbldVZuWlLD2GhEZUegG2+QpAlQSTFI3gTYfJ6AN/D+s2wKarl7ABAXqPagx9vK51
 VAZTqBpOw9uqqtZksfwUKs6Tc5spRBmo9V6JXwfEWGK6cNkULePFYI7RJ2/NmvH2zXLG
 F9XsFrWHcz0JQRa4NdzFhpIwY412Oblkafuz9kMBSs+lyNJ4InX7a2x7763IC3O62Qzs
 31B4c8vAym5l61RdXAnSl+nZN/O9E3SlS5hXEbuoFMyZn03AEE+G8sPxWGzd6ZB7AEyt
 xvoQD/hD/3ciIEcj+TxXJ1aYYoz8DwzhCvJYckAtDLvEufBPHBThUapb6FPsV5iiLz2C
 aIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5fLMKoxAcnX8/4qyqjfQR0D8xnH/RRawEKHgUpx30II=;
 b=BHF7GKADQ8TnFbqwYsyzPCPcNBTobr+801MGSvLj5cjNV0DXT6dI2YWuBazHmoNa8a
 OGInPH/8zQGMR0Iyx+UJQ1uwAMQsL1zwxVGQRunaIyqcd2dSy05uMQJqYgIrY48CJnS3
 +WUC1g1QLUxegMHkL/sUonISG/hoxUBuGhAYbOoi/BpcnA9HlcgpoqUIJDqaBh8xxiAy
 cDvAwV5M21ThjGUy+UV11V7PtMWbrd5CzZvjsP7SSrS1TFWPKw2h1mNw1EwnPiaI6kgP
 hHwKPlx/sK9/Wfgr7k4oz8h3TX6J7RnZgvN2AS5NZrHfbHyBFxben166iUzGJexsPt3J
 2dkg==
X-Gm-Message-State: APjAAAVx8QZ1xyEt96LXvt1fESng/d8EUv8UnCeGqs6mC35sWPXaqA8W
 mFqpo+u5FnzFw2xpS7GEX5zdNg==
X-Google-Smtp-Source: APXvYqxaFE0PR+uncVL23TJnaZMutVhYw2oLRH8g9RTMpItkS5MebF5f+j1V61PiTwoPXtyYqKuU3A==
X-Received: by 2002:adf:ebd0:: with SMTP id v16mr3954377wrn.352.1569523557012; 
 Thu, 26 Sep 2019 11:45:57 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i8sm113014wrw.36.2019.09.26.11.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 11:45:52 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2B9461FFAA;
 Thu, 26 Sep 2019 19:35:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 21/28] target/i386: Fix broken build with WHPX enabled
Date: Thu, 26 Sep 2019 19:35:46 +0100
Message-Id: <20190926183553.13895-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926183553.13895-1-alex.bennee@linaro.org>
References: <20190926183553.13895-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilias Maratos <i.maratos@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The WHPX build is broken since commit 12e9493df92 which removed the
"hw/boards.h" where MachineState is declared:

  $ ./configure \
     --enable-hax --enable-whpx

  $ make x86_64-softmmu/all
  [...]
    CC      x86_64-softmmu/target/i386/whpx-all.o
  target/i386/whpx-all.c: In function 'whpx_accel_init':
  target/i386/whpx-all.c:1378:25: error: dereferencing pointer to
  incomplete type 'MachineState' {aka 'struct MachineState'}
       whpx->mem_quota = ms->ram_size;
                           ^~
  make[1]: *** [rules.mak:69: target/i386/whpx-all.o] Error 1
    CC      x86_64-softmmu/trace/generated-helpers.o
  make[1]: Target 'all' not remade because of errors.
  make: *** [Makefile:471: x86_64-softmmu/all] Error 2

Restore this header, partially reverting commit 12e9493df92.

Fixes: 12e9493df92
Reported-by: Ilias Maratos <i.maratos@gmail.com>
Reviewed-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20190920113329.16787-2-philmd@redhat.com>

diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index 0c15241ae4..def0c28480 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -18,6 +18,7 @@
 #include "sysemu/cpus.h"
 #include "sysemu/runstate.h"
 #include "qemu/main-loop.h"
+#include "hw/boards.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "migration/blocker.h"
-- 
2.20.1


