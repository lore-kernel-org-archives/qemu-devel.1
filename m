Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEAAC54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 19:20:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E87A20656
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 19:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pN2E2m6q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E87A20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQyRr-00014B-1a
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 15:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52078)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1jQyQZ-0007hA-RY
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 15:19:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1jQyQY-0007gc-Ad
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 15:19:27 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:42382)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <palmerdabbelt@google.com>)
 id 1jQyQX-0007dW-Sx
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 15:19:25 -0400
Received: by mail-pl1-x643.google.com with SMTP id v2so5622102plp.9
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 12:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:date:message-id:mime-version:content-transfer-encoding:cc
 :from:to; bh=d2aQTDRAnh1W1uDd73pKIcIBYgis36iQt06EI8YmDrs=;
 b=pN2E2m6qSoaom/4RWEWGJIAiKglZBsnOOAJkYLDW0TFi0GRqtF+NL5qzXlwGjA8g43
 M3ulH0EpM/ibrYAnNsEhiK8fDYXxIqH0lWxbhmRq+CosYiW8seSWR/0hHHPe0AK0//GQ
 PnF+Q/b6MdjHym2cb6K92xGz4EiNquim42F0XMbQOTOU6BgaTqrFi4b8F8GVX/hbRh48
 NFjRJNYr4FX6k/mmmXqjYfBEbigeCbXTvdp3DnOwkCmPtUW50t0BPkWyqFgulMZ7UkjX
 sLWavhJ8/0BacVDd8weZH0RYey2sfjeJOVRiaeP5RnUIy5KJuWxEhNAt3joNM7JBOV24
 nrhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=d2aQTDRAnh1W1uDd73pKIcIBYgis36iQt06EI8YmDrs=;
 b=er7nrCXGXkLODcotofz3vb+nOu2Uq+WR9VEBaHkTyFJM6bU7H925hWf5v/d5eyuOiH
 k+CO3KmxDV2UPKuo+1ETt7rW0yEJp+PLai8/15eY17W/TgHrdsOQsHQlbyC5mbrjpYVe
 knRpM9zk+plZe9kgn04rSIzsVSfr3uUBx2ShdfwXbIFiK2LV91vhZpuTjokRbYxznaO8
 FHMmcEnZm8Ji0o+85/hU/Kapvz71ZUJmFo+3iyMXOf2/4HNsLXB0D9sgbTFH7dG6YhbU
 LH8ZgbC8ZbqodJ7nTq6EtB97FrS89xHop/tjhuJRdF+pyTff+hjSjCBtlpTndShVE4BW
 GDVg==
X-Gm-Message-State: AGi0PubQlG1RNLuY+V839LHgd936yxlWOsPUEdAfIZR/V5KB4N0rAsNx
 KtskHxgSTUMRmpXeFZCXO7iiug==
X-Google-Smtp-Source: APiQypLI5c5Cdk+yBJuabxDSseVYoNfNLx75Kl68Jw+Bwvhm+JFcUoaBmn2gMpXS6O7U2JMQmYBSsw==
X-Received: by 2002:a17:902:7886:: with SMTP id
 q6mr23086848pll.237.1587496761677; 
 Tue, 21 Apr 2020 12:19:21 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net.
 [76.210.143.223])
 by smtp.gmail.com with ESMTPSA id y187sm3193810pfg.16.2020.04.21.12.19.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 12:19:21 -0700 (PDT)
Subject: [PULL] RISC-V Patches for 5.0-rc4
Date: Tue, 21 Apr 2020 12:09:55 -0700
Message-Id: <20200421191001.92644-1-palmerdabbelt@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: qemu-riscv@nongnu.org,          qemu-devel@nongnu.org
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=palmerdabbelt@google.com; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::643
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

The following changes since commit 20038cd7a8412feeb49c01f6ede89e36c8995472:

  Update version for v5.0.0-rc3 release (2020-04-15 20:51:54 +0100)

are available in the Git repository at:

  git@github.com:palmer-dabbelt/qemu.git tags/riscv-for-master-5.0-rc4

for you to fetch changes up to 8a7ce6ac908a8ef30d6a81fe8334c3c942670949:

  riscv/sifive_u: Add a serial property to the sifive_u machine (2020-04-21 10:54:59 -0700)

----------------------------------------------------------------
RISC-V Patches for 5.0-rc4

This contains handful of patches that I'd like to target for 5.0.  I know it's
a bit late, I thought I'd already sent these out but must have managed to miss
doing so.  The patches include:

* A handful of fixes to PTE lookups related to H-mode support.
* The addition of a serial number fo the SiFive U implementetaion, which allows
  bootloaders to generate a sane MAC address.

These pass "make check" and boot Linux for me.

----------------------------------------------------------------
Peter: Sorry I dropped the ball here.  I can understand if it's too late for
5.0, but if there's still going to be an rc4 then I'd love to have these
included.
----------------------------------------------------------------
Alistair Francis (5):
      target/riscv: Don't set write permissions on dirty PTEs
      riscv: Don't use stage-2 PTE lookup protection flags
      riscv: AND stage-1 and stage-2 protection flags
      riscv/sifive_u: Fix up file ordering
      riscv/sifive_u: Add a serial property to the sifive_u SoC

Bin Meng (1):
      riscv/sifive_u: Add a serial property to the sifive_u machine

 hw/riscv/sifive_u.c         | 137 ++++++++++++++++++++++++++------------------
 include/hw/riscv/sifive_u.h |   3 +
 target/riscv/cpu_helper.c   |  17 +++---
 3 files changed, 94 insertions(+), 63 deletions(-)


