Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D1DC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 12:53:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7263920716
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 12:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xXp1CYVu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7263920716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jItuz-0000gC-Kd
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 08:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41572)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jItu7-0008Ng-IH
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 08:52:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jItu6-0007ll-5z
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 08:52:35 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37487)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jItu5-0007jr-Ts
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 08:52:34 -0400
Received: by mail-wr1-x442.google.com with SMTP id w10so21529946wrm.4
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 05:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ALfi4lR0Lc+6XLpLaDFdkaksDiC94nJZHheu4aK1Grg=;
 b=xXp1CYVu02IZNbasReIyYkb8nPg4FbluXCa1DGpywJas0VU9cRm4ySwS2ccDw8rzHJ
 6a/1V2Ee6aWk4zrMFnVf+lUJ5OBLV8p/kcTNgZsZQLXGRGQTygFmeo7Xvs2yqw0kMf9X
 LAiEoF3HRuZXYi6Gp7Sj0WV8CyDYyJJWDoSvjMgmzTE1YpI9fxkXiprrYfG0r53V5srY
 Kq0gaQSQgsJX5rUYEKw6rRqAbUkjHL8XMCczGvA2849Zoc3USyxjN2RwpROWuMNAUvS7
 M9v0TRaX8CVctecJ57zTWsYBJmxvRWUNpZR9a/fkcdqfCPRHd8yyysPFhealsUiPpWr1
 2WKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ALfi4lR0Lc+6XLpLaDFdkaksDiC94nJZHheu4aK1Grg=;
 b=q4nVLdiND9LUa7Tq89oVBmjAxuweDWWn7J1armR4INF2Ia+HASpTGwxtFn15CyaJMj
 iLcR1DsjLPnW/6q3aj3wMKySJKikJN4xxnp9baYYkCbqq07QfxVYtrS1Dm2UvgBnBqnv
 Lu5Kn5AmyOQsD/7r+oeEihmJGbYQljUtpZ8QP6bNWaTVfu16QyDKTZ3AZFD7kVRy1Kxo
 LljRKtCTybjVZTeglausewqTyGK25BFp5EO6ZOET6APNyioBG5T157E2qBU+40bCDEHr
 Zl0bQBV6HqYR9xeVMSPJPtCG47Ne5iDcfanPH9kvKQGdTlqiQtE3wFjqW/lsY/HkF7wn
 oY+A==
X-Gm-Message-State: ANhLgQ1lAMVnXB4pYe5rYA/1ZsWrsRO5dUOutK2p4FQU66z607nsehEl
 QwpxhNnqUrrSRDBKs+VEQVKdfxC6EjEreg==
X-Google-Smtp-Source: ADFU+vus+3Y4d1RQ3ntwwtCtsjRwiKF6bd6nNZVBB+/CAZUQzdaWug1FvHlIx3OmPXDXzE9v1715hQ==
X-Received: by 2002:adf:a348:: with SMTP id d8mr14831676wrb.83.1585572751023; 
 Mon, 30 Mar 2020 05:52:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a10sm13775028wrm.87.2020.03.30.05.52.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2020 05:52:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0] hw/ppc/ppc440_uc.c: Remove incorrect iothread locking
 from dcr_write_pcie()
Date: Mon, 30 Mar 2020 13:52:28 +0100
Message-Id: <20200330125228.24994-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In dcr_write_pcie() we take the iothread lock around a call to
pcie_host_mmcfg_udpate().  This is an incorrect attempt to deal with
the bug fixed in commit 235352ee6e73d7716, where we were not taking
the iothread lock before calling device dcr read/write functions.
(It's not sufficient locking, because although the other cases in the
switch statement won't assert, there is no locking which prevents
multiple guest CPUs from trying to access the PPC460EXPCIEState
struct at the same time and corrupting data.)

Unfortunately with commit 235352ee6e73d7716 we are now trying
to recursively take the iothread lock, which will assert:

  $ qemu-system-ppc -M sam460ex --display none
  **
  ERROR:/home/petmay01/linaro/qemu-from-laptop/qemu/cpus.c:1830:qemu_mutex_lock_iothread_impl: assertion failed: (!qemu_mutex_iothread_locked())
  Aborted (core dumped)

Remove the locking within dcr_write_pcie().

Fixes: 235352ee6e73d7716
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I did a grep of hw/ppc and didn't see anything else that was doing
its own locking inside a dcr read/write fn.
---
 hw/ppc/ppc440_uc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index d5ea962249f..b30e093cbb0 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -13,7 +13,6 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
-#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "cpu.h"
 #include "hw/irq.h"
@@ -1183,9 +1182,7 @@ static void dcr_write_pcie(void *opaque, int dcrn, uint32_t val)
     case PEGPL_CFGMSK:
         s->cfg_mask = val;
         size = ~(val & 0xfffffffe) + 1;
-        qemu_mutex_lock_iothread();
         pcie_host_mmcfg_update(PCIE_HOST_BRIDGE(s), val & 1, s->cfg_base, size);
-        qemu_mutex_unlock_iothread();
         break;
     case PEGPL_MSGBAH:
         s->msg_base = ((uint64_t)val << 32) | (s->msg_base & 0xffffffff);
-- 
2.20.1


