Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44F6CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 15:03:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E3AF21479
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 15:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X9XvkgZG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E3AF21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54775 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP6YF-0002dX-TV
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 11:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44519)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iP6Ug-0007SZ-R4
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 10:59:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iP6Uf-00041q-CD
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 10:59:42 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:34464)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iP6Uf-000417-4L
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 10:59:41 -0400
Received: by mail-wm1-x32e.google.com with SMTP id v3so9724401wmh.1
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 07:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IH5OeIrZdu9f4WmN8QbJjhNZNi59ppuAcQe49wB5R04=;
 b=X9XvkgZGjWyRJj/CpfVajRGMc5XVj2SAiOPy0/1yem2NrnaxS2O8zAiHsl39kt8/Kw
 8GqSy3vzpYIRIYQ9Ldut/RVwAnvt7C/YrvahJhLFGJzL7lPlrimnT46RZvyzp9px5nVe
 kb29gqd9eTezNB78u3vHjYxJdh44Q1sXO/0Mc7Da4gmBv0i2X/R+45YF24pm3m9CjOH+
 hZpYgYGQ99Z6nLiLomDnlbyvdz4Sfg9FQUDM7u7frPnDe1o13Y93mX73hvKC+dJ05fpD
 4q3JZfFzF0cqhNsc9Jzfaflg14iqXgdUY+/VSe7MvhN/tEy9ycAs2BaVJVe9TAbrj8uu
 MQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IH5OeIrZdu9f4WmN8QbJjhNZNi59ppuAcQe49wB5R04=;
 b=QfQrKFRzqkzIjXuKtpTd1YT2GGoICMXpIx92CiZOuEZJ9vfGSF7m/ppTkFqaYgc7AX
 K95tRfkWRQwUKyfdetVGtcRo35Mjk0ltZO2c0+9B+1puYhe3BHmWKx1HKLGaSUCSvccE
 8DQcOv7GtTV6iJpxIsbM01gF7R79FRMc86pq9mjbHD5xNxCtT/8wFKkHKUyVRxoxMMKv
 xRTTmlRf5iOOuJdtvOE0CDirKvlslx+MABw8+VPIxYMLYDwwFkwPJ5L4+XgzXtANdXUg
 IcEJhjOVvzGMe4M9g3nqSrCWLEOVrDGxiOpt59pJoEUFghBUAn2Vczadm2ktBfYXMF5i
 bidA==
X-Gm-Message-State: APjAAAW9FOhp6ZRRwtHgHPO6L3sjKiYEF3JNpeFyOypSQxTQZ6myJ7qD
 cEHBYEq02Jwli/mXbgzgOcCBFt91GR8c+w==
X-Google-Smtp-Source: APXvYqwxbcFoQBiOnPPcBihbSV+wu01cw9y3rVitsMzFv8pjie0Xq3giTDQLgsp7qlIUT63cwx4TRQ==
X-Received: by 2002:a1c:4606:: with SMTP id t6mr344099wma.73.1572274778749;
 Mon, 28 Oct 2019 07:59:38 -0700 (PDT)
Received: from localhost.localdomain (230.106.138.88.rev.sfr.net.
 [88.138.106.230])
 by smtp.gmail.com with ESMTPSA id 143sm14842876wmb.33.2019.10.28.07.59.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 07:59:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/12] tcg patch queue
Date: Mon, 28 Oct 2019 15:59:25 +0100
Message-Id: <20191028145937.10914-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

V2 fixes a build problem that affected win32.


r~


The following changes since commit 187f35512106501fe9a11057f4d8705431e0026d:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-next-251019-3' into staging (2019-10-26 10:13:48 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-tcg-20191028

for you to fetch changes up to fe9b676fb3160496b4b2bf0c57d33be724bf04c3:

  translate-all: Remove tb_alloc (2019-10-28 10:35:23 +0100)

----------------------------------------------------------------
Improvements for TARGET_PAGE_BITS_VARY
Fix for TCI ld16u_i64.
Fix for segv on icount execute from i/o memory.
Two misc cleanups.

----------------------------------------------------------------
Alex Bennée (1):
      cputlb: ensure _cmmu helper functions follow the naming standard

Clement Deschamps (1):
      translate-all: fix uninitialized tb->orig_tb

Richard Henderson (8):
      exec: Split out variable page size support to exec-vary.c
      configure: Detect compiler support for __attribute__((alias))
      exec: Use const alias for TARGET_PAGE_BITS_VARY
      exec: Restrict TARGET_PAGE_BITS_VARY assert to CONFIG_DEBUG_TCG
      exec: Promote TARGET_PAGE_MASK to target_long
      exec: Cache TARGET_PAGE_MASK for TARGET_PAGE_BITS_VARY
      cputlb: Fix tlb_vaddr_to_host
      translate-all: Remove tb_alloc

Stefan Weil (1):
      tci: Add implementation for INDEX_op_ld16u_i64

Wei Yang (1):
      cpu: use ROUND_UP() to define xxx_PAGE_ALIGN

 Makefile.target                  |   2 +-
 include/exec/cpu-all.h           |  33 ++++++++----
 include/exec/cpu_ldst_template.h |   4 +-
 include/qemu-common.h            |   6 +++
 tcg/tcg.h                        |  20 +++++---
 accel/tcg/cputlb.c               |  26 ++++++++--
 accel/tcg/translate-all.c        |  21 ++------
 exec-vary.c                      | 108 +++++++++++++++++++++++++++++++++++++++
 exec.c                           |  34 ------------
 target/cris/translate_v10.inc.c  |   3 +-
 tcg/tci.c                        |  15 ++++++
 configure                        |  19 +++++++
 12 files changed, 214 insertions(+), 77 deletions(-)
 create mode 100644 exec-vary.c

