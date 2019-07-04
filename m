Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B07C0651F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 16:12:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B46C52083B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 16:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eKsgB1Ia"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B46C52083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj4Lu-0004Nv-22
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 12:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44110)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hj4HI-0007oS-BX
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 12:08:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hj4HH-0001yf-8Z
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 12:08:08 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51635)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hj4HH-0001x2-04
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 12:08:07 -0400
Received: by mail-wm1-x341.google.com with SMTP id 207so6254745wma.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 09:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zBVYAiG6J50jyh6l/OEdqGwdCdY22/qgM39X5626rSE=;
 b=eKsgB1IaArU/OtJJYKsHYB3LjhtViqctk6WV64FikoiGuYIXwkUir90Iz+PJULF0GY
 WIbcH19C/J1NgJJpld+L/u5sLEIqBMK8sYibG9bcAS6yCcBbbeysi4bLALpyPZ7aV9Er
 JC5S1SV7KY0mloYxwdDOzF01vfeyyOm0uOpIxGQCG/WnrVK1Xf8Ni59kSCSbPC9PYpUZ
 C1OR6xHXqQUb6rHktkQZEVsg0x1pGdGwcV2SniWq2ScJEKB3ejFqDfQG8ZxY4DXvDvpk
 Z+7lvkChuQB1YR7q9/lbYVpaJ0Z7GbhkYsm8j5ZuPfkBLLXdZ7Cd3YijSDSP0I+6WgAN
 00JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zBVYAiG6J50jyh6l/OEdqGwdCdY22/qgM39X5626rSE=;
 b=pF/0xxMouIMuYdQwVw3m9V0k8eaeXo6r7L5QgxjakwV3IzvFD20HyaEr8RdlDpscko
 9sLw6b6PQZ+eSGJaYTfcEqgZMNPHpyfAF5ppkPFqbqL++aHPS+HvqJNzPF+BWFlwDNCQ
 x01rJhfQbGOqxjnBmwEqEvwKg6eEZOSahDmpUmsocgC87ITeHf637QD9xS2+5nRWcbyM
 eXqLtlvfz4jbJMzJKyCxzNW1MsxSjo0WO3UsE9t/rT8gjd65IUPlHp1jKpNMSo7GxsqD
 8h+7Y/+GOP50R3jEHsFvn7gTuNf8MNXxQ6H1jL0s9FImOziuZ23xz5TL3d2EQ6EXy2C0
 ai1Q==
X-Gm-Message-State: APjAAAXwA0lvfD5spXM2SmvuqwaeZzzj0ISvpyypJ2W9p47iT060jodE
 KacAbW048A4KuAGN4zv9GeuJAm6U6BS4Ow==
X-Google-Smtp-Source: APXvYqzRj+U7Bbj5zptd5ywZ6ZT1OsHodocQq25oSNfHkn23Y9/Q4B0U4q8ezE2kR1/pXPjDUi0RnA==
X-Received: by 2002:a7b:c081:: with SMTP id r1mr231688wmh.76.1562256484812;
 Thu, 04 Jul 2019 09:08:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s2sm3849690wmj.33.2019.07.04.09.08.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 04 Jul 2019 09:08:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  4 Jul 2019 17:07:53 +0100
Message-Id: <20190704160802.12419-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PULL 0/9] target-arm queue
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

A last collection of patches to squeeze in before rc0.
The patches from me are all bugfixes. Philippe's are just
code-movement, but I wanted to get these into 4.1 because
that kind of patch is so painful to have to rebase.
(The diffstat is huge but it's just code moving from file to file.)

thanks
-- PMM

The following changes since commit 234e256511e588680300600ce087c5185d68cf2a:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-build-2019-07-02-v2' into staging (2019-07-04 15:58:46 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20190704

for you to fetch changes up to b75f3735802b5b33f10e4bfe374d4b17bb86d29a:

  target/arm: Correct VMOV_imm_dp handling of short vectors (2019-07-04 16:52:05 +0100)

----------------------------------------------------------------
target-arm queue:
 * more code-movement to separate TCG-only functions into their own files
 * Correct VMOV_imm_dp handling of short vectors
 * Execute Thumb instructions when their condbits are 0xf
 * armv7m_systick: Forbid non-privileged accesses
 * Use _ra versions of cpu_stl_data() in v7M helpers
 * v8M: Check state of exception being returned from
 * v8M: Forcibly clear negative-priority exceptions on deactivate

----------------------------------------------------------------
Peter Maydell (6):
      arm v8M: Forcibly clear negative-priority exceptions on deactivate
      target/arm: v8M: Check state of exception being returned from
      target/arm: Use _ra versions of cpu_stl_data() in v7M helpers
      hw/timer/armv7m_systick: Forbid non-privileged accesses
      target/arm: Execute Thumb instructions when their condbits are 0xf
      target/arm: Correct VMOV_imm_dp handling of short vectors

Philippe Mathieu-Daudé (3):
      target/arm: Move debug routines to debug_helper.c
      target/arm: Restrict semi-hosting to TCG
      target/arm/helper: Move M profile routines to m_helper.c

 target/arm/Makefile.objs       |    5 +-
 target/arm/cpu.h               |    7 +
 hw/intc/armv7m_nvic.c          |   54 +-
 hw/timer/armv7m_systick.c      |   26 +-
 target/arm/cpu.c               |    9 +-
 target/arm/debug_helper.c      |  311 +++++
 target/arm/helper.c            | 2646 +--------------------------------------
 target/arm/m_helper.c          | 2679 ++++++++++++++++++++++++++++++++++++++++
 target/arm/op_helper.c         |  295 -----
 target/arm/translate-vfp.inc.c |    2 +-
 target/arm/translate.c         |   15 +-
 11 files changed, 3096 insertions(+), 2953 deletions(-)
 create mode 100644 target/arm/debug_helper.c
 create mode 100644 target/arm/m_helper.c

