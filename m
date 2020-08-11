Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24D5C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 07:11:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 669F620774
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 07:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O6hVlZtv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 669F620774
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5ORn-00068e-Jh
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 03:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3QUQyXwMKCpIEyI2AA270.yA8C08G-z0H079A929G.AD2@flex--scw.bounces.google.com>)
 id 1k5OQ2-0004t0-3K
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 03:09:58 -0400
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449]:42474)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3QUQyXwMKCpIEyI2AA270.yA8C08G-z0H079A929G.AD2@flex--scw.bounces.google.com>)
 id 1k5OQ0-0000kU-2l
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 03:09:57 -0400
Received: by mail-pf1-x449.google.com with SMTP id b142so9802616pfb.9
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 00:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=YlydLVrlvFblK0TD+YtiVGIDjzrVf7sjzFdGecIMIpo=;
 b=O6hVlZtveM1/xpWIeGlSXem4AkewZ5ecxb7OipY1IPkrM56Xe+uRWg9iZ1UB9xdwx0
 4Mu5kK1NduXp8GMyEHVYTVAewu0cFpIl3f+35LgTYoGIljLJSIxHVimJGMCOXXHe2wTv
 HqMiUplNci1y7qtUOR1NSxIIuxJ071LYfsc/2ZIuKF3NZg6cFWVqEAFN77S3CteLb6hF
 VEjkAchWK4nkKQG31uX8KDUNqRKTDdx00d3MmHeRuVh20MuHieXb7Lig7BPg7O5APbiL
 iuZUJ3X8afpBRD1CxR2NNmD/grVvMUv8CHYVgM4w8Xygrn+NQ8JVkqkgCW4z1WD9R7ss
 xt6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=YlydLVrlvFblK0TD+YtiVGIDjzrVf7sjzFdGecIMIpo=;
 b=CHZIZIS12tmKDr+v8N9Pk+0uG75KIbneTuwRMXpGLQ0aoHS28vpqphowKW/pyZlSsW
 0fHeXhTvhz16jSzjS48gf5FakJqQ0iMSBqclyC6anxFNorxvPyyqe6CfqvEnYhxX6Zx9
 2NwFPI6/QdVxff3SXAUqUY3Z3FEvoUdzGKtAtnE6RC79BZWZf4lR7gh6PMfnMPFTsfog
 Pnv588mQ4UJzGwZhgBQLTuJMrPHZc/ucSuvTouEbjM7NSxknHmarfmukLP7tic7UDHq3
 69P0fLqr39vf166SBvoPMyq1/us5StecuK5VgaEC9hQnM0W1SAfprJGTWqbx1vFJ4CFn
 SpJg==
X-Gm-Message-State: AOAM532meYKNk2f0UT89ElcfM4FN2wZcK+yRyJ6N/stmhnGTL4PJLJI4
 g+BOc6iu57A5S0jQYYDbaIb4IZafUSy9XVT7guMSHT/HNrLHjDjuvB3IP8egNiWegIFNYeycH4S
 0XQzEvLdll/CrYuFvjugB2fJjZ3ZjvDHbjppnTrDehawtyyQ4w9Ww
X-Google-Smtp-Source: ABdhPJyuVgfOsbj9sx8QIJVRGbbeuEEgIoOReOCMiktYU8Iy4oVMZ0usw/eoiSxW+Mmu8m4LwMXJhQ4=
X-Received: by 2002:a63:c902:: with SMTP id o2mr25371615pgg.264.1597129793318; 
 Tue, 11 Aug 2020 00:09:53 -0700 (PDT)
Date: Tue, 11 Aug 2020 00:09:40 -0700
Message-Id: <cover.1597129029.git.scw@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH v2 0/8] fcntl, sockopt, and ioctl options
From: Shu-Chun Weng <scw@google.com>
To: qemu-devel@nongnu.org
Cc: Shu-Chun Weng <scw@google.com>, laurent@vivier.eu
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::449;
 envelope-from=3QUQyXwMKCpIEyI2AA270.yA8C08G-z0H079A929G.AD2@flex--scw.bounces.google.com;
 helo=mail-pf1-x449.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -105
X-Spam_score: -10.6
X-Spam_bar: ----------
X-Spam_report: (-10.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

Hi Laurent,

This is a series of 8 patches in 4 groups, putting into a single thread for
easier tracking.

[PATCH v2 1/8] linux-user: Support F_ADD_SEALS and F_GET_SEALS fcntls
  An incidental follow up on
  https://lists.nongnu.org/archive/html/qemu-devel/2019-09/msg01925.html

[PATCH v2 2/8] linux-user: add missing UDP get/setsockopt option
[PATCH v2 3/8] linux-user: add missing IPv6 get/setsockopt option
[PATCH v2 4/8] linux-user: Add IPv6 options to do_print_sockopt()
  Updated https://lists.nongnu.org/archive/html/qemu-devel/2019-09/msg01317.html
  to consistently add them in get/setsockopt

[PATCH v2 5/8] linux-user: Update SO_TIMESTAMP to SO_TIMESTAMP_OLD/NEW
[PATCH v2 6/8] linux-user: setsockopt() SO_TIMESTAMPNS and SO_TIMESTAMPING
  Updated https://lists.nongnu.org/archive/html/qemu-devel/2019-09/msg01319.html
  to only use TARGET_SO_*_OLD/NEW

[PATCH v2 7/8] thunk: supports flexible arrays
[PATCH v2 8/8] linux-user: Add support for SIOCETHTOOL ioctl
  Updated https://lists.nongnu.org/archive/html/qemu-devel/2019-08/msg05090.html

v1 -> v2:
  Address comments on the first 5 (was 3) patches.
  Fix style problems.

Shu-Chun Weng (8):
  linux-user: Support F_ADD_SEALS and F_GET_SEALS fcntls
  linux-user: add missing UDP get/setsockopt option
  linux-user: add missing IPv6 get/setsockopt option
  linux-user: Add IPv6 options to do_print_sockopt()
  linux-user: Update SO_TIMESTAMP to SO_TIMESTAMP_OLD/NEW
  linux-user: setsockopt() SO_TIMESTAMPNS and SO_TIMESTAMPING
  thunk: supports flexible arrays
  linux-user: Add support for SIOCETHTOOL ioctl

 include/exec/user/thunk.h              |  24 +
 linux-user/Makefile.objs               |   3 +-
 linux-user/alpha/sockbits.h            |  21 +-
 linux-user/ethtool.c                   | 840 +++++++++++++++++++++++++
 linux-user/ethtool.h                   |  20 +
 linux-user/ethtool_entries.h           | 107 ++++
 linux-user/generic/sockbits.h          |  17 +-
 linux-user/hppa/sockbits.h             |  20 +-
 linux-user/ioctls.h                    |   2 +
 linux-user/mips/sockbits.h             |  16 +-
 linux-user/qemu.h                      |   1 +
 linux-user/sparc/sockbits.h            |  21 +-
 linux-user/strace.c                    | 188 +++++-
 linux-user/syscall.c                   | 286 ++++++++-
 linux-user/syscall_defs.h              |  26 +-
 linux-user/syscall_types.h             | 280 +++++++++
 tests/tcg/multiarch/ethtool.c          | 423 +++++++++++++
 tests/tcg/multiarch/socket_timestamp.c | 540 ++++++++++++++++
 thunk.c                                | 152 ++++-
 19 files changed, 2916 insertions(+), 71 deletions(-)
 create mode 100644 linux-user/ethtool.c
 create mode 100644 linux-user/ethtool.h
 create mode 100644 linux-user/ethtool_entries.h
 create mode 100644 tests/tcg/multiarch/ethtool.c
 create mode 100644 tests/tcg/multiarch/socket_timestamp.c

-- 
2.28.0.220.ged08abb693-goog


