Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68080C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 01:47:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EE4920853
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 01:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MsADinCo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EE4920853
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjYn6-0002Gp-6R
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 21:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Yd7iXgMKCqYPQfMUUMRK.IUSWKSa-JKbKRTUTMTa.UXM@flex--jkz.bounces.google.com>)
 id 1jjYlv-0000uM-IE
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 21:46:19 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49]:48198)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Yd7iXgMKCqYPQfMUUMRK.IUSWKSa-JKbKRTUTMTa.UXM@flex--jkz.bounces.google.com>)
 id 1jjYlt-0001UY-Rd
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 21:46:19 -0400
Received: by mail-yb1-xb49.google.com with SMTP id n11so8813474ybg.15
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 18:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=QhZG+MpGikP6aQB6hTKAfWvCLB9Uct4lEoyUeHJvUFs=;
 b=MsADinCov1SVUD4h9FxITAW+5Gy+lolEWooH4pck1rySgoVucK6Q3UqSKxZGoz/9OU
 uDAQijbyh86b+13psJ/vJMTVc6tEOE0yccSqJPzxmJjMWOfmmtGcTPT1VxwcblFuooCD
 idZPRUEDDvoALuOaZMW8ZGkZDnchiMHUvf6QZ/IU7Ix+zbM4/zEIqZ5JoYi0QFiaEEh9
 SHzR1am2TAkXhqD8dpuIyECHENlepoAFQ6jtB2WlYfuKbiDf+9bGUjRCWVU/zVwLSgiX
 GVXxSAlFjiF7mdn3djSuFIyMkvs/gQaLF/racwh+f0+2p2/iAYiye9w0gnq5z3RbMGhx
 AAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=QhZG+MpGikP6aQB6hTKAfWvCLB9Uct4lEoyUeHJvUFs=;
 b=KzZSjYm2XJOBpPQjvz7tUcFENc+RfnBJgiOvRYy95UgKWNmlDlcGoKNCYICOHZtWaB
 bCWFBd/BzyznTuWE/2GhQb2WwWDYJY8VLgaHo9uT97WA1gt/choq7J1UwyZudkcZPfJa
 WXVQkhRKBe5TsNmsPXqsSbkmaaS8VUuzhh/asRnJ0NvcCWttcLvE78hgAVBZKZhTdtzT
 +nyYNcMsDYj+oHyBB/iAVrzYM4XswGsrH9hR6UuyEqVzwDf1z4tCPA7NsxQDPd041kFj
 CzOItF6ScC4mB55xMoO0p90+wkYKJFNTAvsESOisdEZEOkxk4pdcgPuswDiBKWjgUEg1
 kNAA==
X-Gm-Message-State: AOAM530oTRiPDtCWV/a3aGhtUTtaQybOGVr9JnclHiorFvWtbWwt5g80
 KVUvLMJZYYgh0cVdF0aox3k6wzDVgrmKRLbl8gmCw9WXx6RAlFGHF7DH+c2ayy8+uXH1pfzPJ+X
 wbBRoJKwgcQOxPb/AJ3s/fnz762EeXK3S6NRLC8xMJgbibg3wQGGs
X-Google-Smtp-Source: ABdhPJzwO/A/YEtvS70ak/u+y4ZpPh8mncSw6xBf0VC6N/i0U8v/lcKYw60Iczf2wquRWpTFjGUKzfU=
X-Received: by 2002:a25:3ac6:: with SMTP id
 h189mr17533884yba.281.1591926369554; 
 Thu, 11 Jun 2020 18:46:09 -0700 (PDT)
Date: Thu, 11 Jun 2020 18:46:01 -0700
Message-Id: <20200612014606.147691-1-jkz@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [PATCH 0/5] linux-user: Support extended clone(CLONE_VM)
From: Josh Kunz <jkz@google.com>
To: qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, laurent@vivier.eu, alex.bennee@linaro.org, 
 Josh Kunz <jkz@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3Yd7iXgMKCqYPQfMUUMRK.IUSWKSa-JKbKRTUTMTa.UXM@flex--jkz.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -105
X-Spam_score: -10.6
X-Spam_bar: ----------
X-Spam_report: (-10.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=_AUTOLEARN
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

This patch series implements extended support for the `clone` system
call. As best I can tell, any option combination including `CLONE_VM`
should be supported with the addition of this patch series. The
implementation is described in greater detail in the patches themselves.

Testing:

  * All targets built on x86_64.
  * `make check` and `make check-tcg` are passing. Additional tests have
    been added to `linux-test.c` to validate clone behavior.

Caveats:

  * This series touches, but does not fix, several bits of code that are
    racey (namely the sigact table and the fd trans table).
  * `exit_group` does not perform the appropriate cleanup for non-thread
    children created with `CLONE_VM`. CPUs for such children are never
    cleaned up. The correct implementation of exit-group is non-trivial
    (since it also needs to track/handle cleanup for threads in the
    clone'd child process). Also, I don't fully understand the
    interaction between QOM<->linux-user. My naive implementation based
    on the current implementation `exit(2)` was regularly crashing. If
    maintainers have suggestions for better ways to handle exit_group,
    they would be greatly appreciated. 
  * execve does not clean up the CPUs of clone'd children, for the same
    reasons as `exit_group`.

Josh Kunz (5):
  linux-user: Refactor do_fork to use new `qemu_clone`
  linux-user: Make fd_trans task-specific.
  linux-user: Make sigact_table part of the task state.
  linux-user: Support CLONE_VM and extended clone options
  linux-user: Add PDEATHSIG test for clone process hierarchy.

 linux-user/Makefile.objs            |   2 +-
 linux-user/clone.c                  | 565 ++++++++++++++++++++++++++++
 linux-user/clone.h                  |  27 ++
 linux-user/fd-trans-tbl.c           |  13 +
 linux-user/fd-trans-type.h          |  17 +
 linux-user/fd-trans.c               |   3 -
 linux-user/fd-trans.h               |  75 ++--
 linux-user/main.c                   |   1 +
 linux-user/qemu.h                   |  49 +++
 linux-user/signal.c                 |  84 ++++-
 linux-user/syscall.c                | 452 ++++++++++++----------
 tests/tcg/multiarch/Makefile.target |   3 +
 tests/tcg/multiarch/linux-test.c    | 227 ++++++++++-
 13 files changed, 1264 insertions(+), 254 deletions(-)
 create mode 100644 linux-user/clone.c
 create mode 100644 linux-user/clone.h
 create mode 100644 linux-user/fd-trans-tbl.c
 create mode 100644 linux-user/fd-trans-type.h

-- 
2.27.0.290.gba653c62da-goog


