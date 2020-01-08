Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E54C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 03:47:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 410592070A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 03:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uht4wAQb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 410592070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip2Je-00059B-Fx
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 22:47:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48325)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2Hn-0002uc-Ft
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:45:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2Hi-0002Jt-1S
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:45:35 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:34956)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ip2Hh-0002Im-Pd
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:45:29 -0500
Received: by mail-pg1-x52b.google.com with SMTP id l24so881317pgk.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 19:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vJhNLYnagWq/YKJ23nUu05Jes+KeJKmUek4xneeisU4=;
 b=uht4wAQbNJDL3xwfTSCUPX/ce5hSz0XByHW6iUP3ewYLWotOrFWQT7EM8Sn4qiVab/
 7PZ6CIZblnoc7Rq/LNrfC2gC5ETpXM1ibtxWAmYHPQG7nHdOWRzWWExdDmOSOWikHsWH
 PqVW0ZBBsveUwfvmPo0EUr3okoIiMJGOovC1peb6PJzN8Yccd4GfK7TUOcFOny+GgJvv
 0QFUh7As724NHR/9OonEQxa3eaJU41bjQidXkz1o/kdME0ZM5cEyKXJNjku/h3AAgTfi
 XP00dGUGARBe3ow06r4gNjLK4pk+1uvgawxH6bevsIwycJHkfduJ83LXAerP4gjrkZ4h
 mS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vJhNLYnagWq/YKJ23nUu05Jes+KeJKmUek4xneeisU4=;
 b=XzjGMrrHoSWmvWWe1Xnd4PmL7qe8K+sS9Rg+AiReQOuPUBuQK1iAVoXZP4yTtUI7+Y
 4+yD1HHPDpIEI72UNOpMnqz8MelzUWowhpjCnq4ddL5kNU1/AqRsPasE6DkA7kKfas57
 T8s2qAxWi1PuGBpa+CvxTbkZyVAS19mfnBwNZnMH+Hpnh2mPSDANTm68rWA5P2C8uKqW
 pxYRcUfxA0RfOORH8XmENvNgsyfQ8DbcSwTZ0C5SE08jbc6i3XZyPahTxGyzLoo1HWpb
 Cmt8CEKHFrIxFohZl6IavYn0e6CQnYQZzBQN1yh8ropAofyBDDVtF8UsOUCKzuQQERVX
 /zeQ==
X-Gm-Message-State: APjAAAXuZbNR09s88r/DxaRSAYLeO/poDfnN47Ni86+O4fFNoRlJQaJu
 VTw9AHd7NAmqCy5ek+cFEHolLPuJA/YlFA==
X-Google-Smtp-Source: APXvYqyQ6a9/l6KBf7RCyjn+F5fddIuh4zjJgliyHEyWxn1lriAU/xfCbBJ/PYntNCs/KdvkaxAThw==
X-Received: by 2002:a65:4d0b:: with SMTP id i11mr3258879pgt.340.1578455128264; 
 Tue, 07 Jan 2020 19:45:28 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id f23sm1198433pgj.76.2020.01.07.19.45.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 19:45:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/41] tcg patch queue
Date: Wed,  8 Jan 2020 14:44:42 +1100
Message-Id: <20200108034523.17349-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52b
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

The following changes since commit 035eed4c0d257c905a556fa0f4865a0c077b4e7f:

  Merge remote-tracking branch 'remotes/vivier/tags/q800-for-5.0-pull-request' into staging (2020-01-07 17:08:21 +0000)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-tcg-20200108

for you to fetch changes up to 5e7ef51cbe47e726f76bfbc208e167085cf398c4:

  MAINTAINERS: Replace Claudio Fontana for tcg/aarch64 (2020-01-08 11:54:12 +1100)

----------------------------------------------------------------
Improve -static and -pie linking
Add cpu_{ld,st}*_mmuidx_ra
Remove MMU_MODE*_SUFFIX
Move tcg headers under include/

----------------------------------------------------------------
Philippe Mathieu-Daudé (4):
      tcg: Search includes from the project root source directory
      tcg: Search includes in the parent source directory
      tcg: Move TCG headers to include/tcg/
      configure: Remove tcg/ from the preprocessor include search list

Richard Henderson (37):
      configure: Drop adjustment of textseg
      tcg: Remove softmmu code_gen_buffer fixed address
      configure: Do not force pie=no for non-x86
      configure: Always detect -no-pie toolchain support
      configure: Unnest detection of -z,relro and -z,now
      configure: Override the os default with --disable-pie
      configure: Support -static-pie if requested
      target/xtensa: Use probe_access for itlb_hit_test
      cputlb: Use trace_mem_get_info instead of trace_mem_build_info
      trace: Remove trace_mem_build_info_no_se_[bl]e
      target/s390x: Include tcg.h in mem_helper.c
      target/arm: Include tcg.h in sve_helper.c
      accel/tcg: Include tcg.h in tcg-runtime.c
      linux-user: Include tcg.h in syscall.c
      linux-user: Include trace-root.h in syscall-trace.h
      plugins: Include trace/mem.h in api.c
      cputlb: Move body of cpu_ldst_template.h out of line
      translator: Use cpu_ld*_code instead of open-coding
      cputlb: Rename helper_ret_ld*_cmmu to cpu_ld*_code
      cputlb: Provide cpu_(ld,st}*_mmuidx_ra for user-only
      target/i386: Use cpu_*_mmuidx_ra instead of templates
      cputlb: Expand cpu_ldst_useronly_template.h in user-exec.c
      target/nios2: Remove MMU_MODE{0,1}_SUFFIX
      target/alpha: Remove MMU_MODE{0,1}_SUFFIX
      target/cris: Remove MMU_MODE{0,1}_SUFFIX
      target/i386: Remove MMU_MODE{0,1,2}_SUFFIX
      target/microblaze: Remove MMU_MODE{0,1,2}_SUFFIX
      target/sh4: Remove MMU_MODE{0,1}_SUFFIX
      target/unicore32: Remove MMU_MODE{0,1}_SUFFIX
      target/xtensa: Remove MMU_MODE{0,1,2,3}_SUFFIX
      target/m68k: Use cpu_*_mmuidx_ra instead of MMU_MODE{0,1}_SUFFIX
      target/mips: Use cpu_*_mmuidx_ra instead of MMU_MODE*_SUFFIX
      target/s390x: Use cpu_*_mmuidx_ra instead of MMU_MODE*_SUFFIX
      target/ppc: Use cpu_*_mmuidx_ra instead of MMU_MODE*_SUFFIX
      cputlb: Remove support for MMU_MODE*_SUFFIX
      cputlb: Expand cpu_ldst_template.h in cputlb.c
      MAINTAINERS: Replace Claudio Fontana for tcg/aarch64

 Makefile                                  |   2 +-
 accel/tcg/atomic_template.h               |  67 ++---
 include/exec/cpu_ldst.h                   | 446 +++++++++---------------------
 include/exec/cpu_ldst_template.h          | 211 --------------
 include/exec/cpu_ldst_useronly_template.h | 159 -----------
 include/exec/translator.h                 |  48 +---
 {tcg => include/tcg}/tcg-gvec-desc.h      |   0
 {tcg => include/tcg}/tcg-mo.h             |   0
 {tcg => include/tcg}/tcg-op-gvec.h        |   0
 {tcg => include/tcg}/tcg-op.h             |   2 +-
 {tcg => include/tcg}/tcg-opc.h            |   0
 {tcg => include/tcg}/tcg.h                |  33 +--
 include/user/syscall-trace.h              |   2 +
 target/alpha/cpu.h                        |   2 -
 target/cris/cpu.h                         |   2 -
 target/i386/cpu.h                         |   3 -
 target/m68k/cpu.h                         |   2 -
 target/microblaze/cpu.h                   |   3 -
 target/mips/cpu.h                         |   4 -
 target/nios2/cpu.h                        |   2 -
 target/ppc/cpu.h                          |   2 -
 target/s390x/cpu.h                        |   5 -
 target/sh4/cpu.h                          |   2 -
 target/unicore32/cpu.h                    |   2 -
 target/xtensa/cpu.h                       |   4 -
 tcg/i386/tcg-target.h                     |   2 +-
 trace/mem-internal.h                      |  17 --
 accel/tcg/cpu-exec.c                      |   2 +-
 accel/tcg/cputlb.c                        | 315 ++++++++++++++++-----
 accel/tcg/tcg-runtime-gvec.c              |   2 +-
 accel/tcg/tcg-runtime.c                   |   1 +
 accel/tcg/translate-all.c                 |  39 +--
 accel/tcg/user-exec.c                     | 238 +++++++++++++++-
 bsd-user/main.c                           |   2 +-
 cpus.c                                    |   2 +-
 exec.c                                    |   2 +-
 linux-user/main.c                         |   2 +-
 linux-user/syscall.c                      |   1 +
 plugins/api.c                             |   1 +
 target/alpha/translate.c                  |   2 +-
 target/arm/helper-a64.c                   |   2 +-
 target/arm/sve_helper.c                   |   1 +
 target/arm/translate-a64.c                |   4 +-
 target/arm/translate-sve.c                |   6 +-
 target/arm/translate.c                    |   4 +-
 target/cris/translate.c                   |   2 +-
 target/hppa/translate.c                   |   2 +-
 target/i386/mem_helper.c                  |   2 +-
 target/i386/seg_helper.c                  |  56 ++--
 target/i386/translate.c                   |   2 +-
 target/lm32/translate.c                   |   2 +-
 target/m68k/op_helper.c                   |  77 ++++--
 target/m68k/translate.c                   |   2 +-
 target/microblaze/translate.c             |   2 +-
 target/mips/op_helper.c                   | 182 ++++--------
 target/mips/translate.c                   |   2 +-
 target/moxie/translate.c                  |   2 +-
 target/nios2/translate.c                  |   2 +-
 target/openrisc/translate.c               |   2 +-
 target/ppc/mem_helper.c                   |  13 +-
 target/ppc/translate.c                    |   4 +-
 target/riscv/cpu_helper.c                 |   2 +-
 target/riscv/translate.c                  |   2 +-
 target/s390x/mem_helper.c                 |  11 +-
 target/s390x/translate.c                  |   4 +-
 target/sh4/translate.c                    |   2 +-
 target/sparc/ldst_helper.c                |   2 +-
 target/sparc/translate.c                  |   2 +-
 target/tilegx/translate.c                 |   2 +-
 target/tricore/translate.c                |   2 +-
 target/unicore32/translate.c              |   2 +-
 target/xtensa/mmu_helper.c                |   5 +-
 target/xtensa/translate.c                 |   2 +-
 tcg/aarch64/tcg-target.inc.c              |   4 +-
 tcg/arm/tcg-target.inc.c                  |   4 +-
 tcg/i386/tcg-target.inc.c                 |   4 +-
 tcg/mips/tcg-target.inc.c                 |   2 +-
 tcg/optimize.c                            |   2 +-
 tcg/ppc/tcg-target.inc.c                  |   4 +-
 tcg/riscv/tcg-target.inc.c                |   4 +-
 tcg/s390/tcg-target.inc.c                 |   4 +-
 tcg/sparc/tcg-target.inc.c                |   2 +-
 tcg/tcg-common.c                          |   2 +-
 tcg/tcg-op-gvec.c                         |   8 +-
 tcg/tcg-op-vec.c                          |   6 +-
 tcg/tcg-op.c                              |   6 +-
 tcg/tcg.c                                 |   2 +-
 tcg/tci.c                                 |   2 +-
 MAINTAINERS                               |   4 +-
 configure                                 | 117 +++-----
 docs/devel/loads-stores.rst               | 215 ++++++++++----
 91 files changed, 1075 insertions(+), 1357 deletions(-)
 delete mode 100644 include/exec/cpu_ldst_template.h
 delete mode 100644 include/exec/cpu_ldst_useronly_template.h
 rename {tcg => include/tcg}/tcg-gvec-desc.h (100%)
 rename {tcg => include/tcg}/tcg-mo.h (100%)
 rename {tcg => include/tcg}/tcg-op-gvec.h (100%)
 rename {tcg => include/tcg}/tcg-op.h (99%)
 rename {tcg => include/tcg}/tcg-opc.h (100%)
 rename {tcg => include/tcg}/tcg.h (96%)

