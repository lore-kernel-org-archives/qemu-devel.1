Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480CBC3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:19:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1458420644
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yENjP4f3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1458420644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyc93-00054j-LY
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 09:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35093)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc6h-0003Jm-89
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc6f-0005K9-L8
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:26 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:33032)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hyc6e-0005He-Jq
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:24 -0400
Received: by mail-wm1-x32c.google.com with SMTP id p77so3177703wme.0
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 06:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SD5ZT/I/fGGNqGuhj28nPoIF8fnOhWt0fYax6076UXY=;
 b=yENjP4f3yrT9/NAooiizQ1KbvOYNNqdMDA4oyAceZ9VU49eqvRtnDnZGKvf2k6z+yr
 pQ0k83l/o8u0RzMrO7ITWwVXdehQiAnlQqpaaUrWa8g4oh7F02XIqsbSkRXALG39dSAX
 kaLKX55wJ9sPLBsXTpRQafN9B2nKw+eaFQcvMo9vyiLJVUDqq8UUL4Nz+iBX+AttIWuc
 tnAE7jeuhg/DZgDs7nmZrzDq8DU5AO1/xJ2jCnCPVF9wYXbWQrfcmSPzXrqj4KeE8i9/
 Eg70+mk0N4kGVez/7G5AcPcwOVUjSUBYK6Nc9GU5cdB0W1j01HWYweQJer6G7TFIH+zV
 bKKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SD5ZT/I/fGGNqGuhj28nPoIF8fnOhWt0fYax6076UXY=;
 b=tjqJTb5Ngi56d/sut8uJFqarOquWV7ZADKkVajri6uHGxgqM54RwRiOIbts1ha1+FF
 eUDLzGYRuPU0/BdtEAonzt6BzM4tLNl+DNtvN837VBuvHG4FjI/SiEOe7RhZKbp43hNr
 5yL6aq/DlqtvldDp+FrXg1EKV0I6yOhv2TefqJYKuv+haX++hz5f61bpgtbjtx7bRQXk
 TFGyl+92YJQygqeFHSYeMKZqPinBtTX8ozmeNQ50Fii9fley41LKd1KJOJVwUCgJdZvq
 8rNHyi42TW77j3CZym8uxxi+QbfMTtHqu0WJhGzHXPl8rpXMzh+5M4WcVrBLKN0xbSl9
 M1ng==
X-Gm-Message-State: APjAAAU317KbY2K03u+JYkCeaUAIS2kNupWJjhPH8m0giv4cPLMYLFQM
 Syjnjwl8NkNaNw0HLvRA74mXR0B9j9uVCQ==
X-Google-Smtp-Source: APXvYqx3Wpy42SiZ+gKaodGale8NvErZLW4Z83QhIANwCUmmKKez/JZCG1ewMzf57Auz0E+bCmkQHg==
X-Received: by 2002:a1c:107:: with SMTP id 7mr7514812wmb.84.1565961441005;
 Fri, 16 Aug 2019 06:17:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 4sm8705796wro.78.2019.08.16.06.17.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2019 06:17:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 14:16:50 +0100
Message-Id: <20190816131719.28244-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
Subject: [Qemu-devel] [PULL 00/29] target-arm queue
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

First arm pullreq of 4.2...

thanks
-- PMM

The following changes since commit 27608c7c66bd923eb5e5faab80e795408cbe2b51:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20190814a' into staging (2019-08-16 12:00:18 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20190816

for you to fetch changes up to 664b7e3b97d6376f3329986c465b3782458b0f8b:

  target/arm: Use tcg_gen_extrh_i64_i32 to extract the high word (2019-08-16 14:02:53 +0100)

----------------------------------------------------------------
target-arm queue:
 * target/arm: generate a custom MIDR for -cpu max
 * hw/misc/zynq_slcr: refactor to use standard register definition
 * Set ENET_BD_BDU in I.MX FEC controller
 * target/arm: Fix routing of singlestep exceptions
 * refactor a32/t32 decoder handling of PC
 * minor optimisations/cleanups of some a32/t32 codegen
 * target/arm/cpu64: Ensure kvm really supports aarch64=off
 * target/arm/cpu: Ensure we can use the pmu with kvm
 * target/arm: Minor cleanups preparatory to KVM SVE support

----------------------------------------------------------------
Aaron Hill (1):
      Set ENET_BD_BDU in I.MX FEC controller

Alex Bennée (1):
      target/arm: generate a custom MIDR for -cpu max

Andrew Jones (6):
      target/arm/cpu64: Ensure kvm really supports aarch64=off
      target/arm/cpu: Ensure we can use the pmu with kvm
      target/arm/helper: zcr: Add build bug next to value range assumption
      target/arm/cpu: Use div-round-up to determine predicate register array size
      target/arm/kvm64: Fix error returns
      target/arm/kvm64: Move the get/put of fpsimd registers out

Damien Hedde (1):
      hw/misc/zynq_slcr: use standard register definition

Peter Maydell (2):
      target/arm: Factor out 'generate singlestep exception' function
      target/arm: Fix routing of singlestep exceptions

Richard Henderson (18):
      target/arm: Pass in pc to thumb_insn_is_16bit
      target/arm: Introduce pc_curr
      target/arm: Introduce read_pc
      target/arm: Introduce add_reg_for_lit
      target/arm: Remove redundant s->pc & ~1
      target/arm: Replace s->pc with s->base.pc_next
      target/arm: Replace offset with pc in gen_exception_insn
      target/arm: Replace offset with pc in gen_exception_internal_insn
      target/arm: Remove offset argument to gen_exception_bkpt_insn
      target/arm: Use unallocated_encoding for aarch32
      target/arm: Remove helper_double_saturate
      target/arm: Use tcg_gen_extract_i32 for shifter_out_im
      target/arm: Use tcg_gen_deposit_i32 for PKHBT, PKHTB
      target/arm: Remove redundant shift tests
      target/arm: Use ror32 instead of open-coding the operation
      target/arm: Use tcg_gen_rotri_i32 for gen_swap_half
      target/arm: Simplify SMMLA, SMMLAR, SMMLS, SMMLSR
      target/arm: Use tcg_gen_extrh_i64_i32 to extract the high word

 target/arm/cpu.h               |  13 +-
 target/arm/helper.h            |   1 -
 target/arm/kvm_arm.h           |  28 ++
 target/arm/translate-a64.h     |   4 +-
 target/arm/translate.h         |  39 ++-
 hw/misc/zynq_slcr.c            | 450 ++++++++++++++++----------------
 hw/net/imx_fec.c               |   4 +
 target/arm/cpu.c               |  30 ++-
 target/arm/cpu64.c             |  31 ++-
 target/arm/helper.c            |   7 +
 target/arm/kvm.c               |   7 +
 target/arm/kvm64.c             | 161 +++++++-----
 target/arm/op_helper.c         |  15 --
 target/arm/translate-a64.c     | 130 ++++------
 target/arm/translate-vfp.inc.c |  45 +---
 target/arm/translate.c         | 572 +++++++++++++++++------------------------
 16 files changed, 771 insertions(+), 766 deletions(-)

