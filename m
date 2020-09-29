Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347DEC4727D
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 22:45:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C90B20757
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 22:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ED7QQA2r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C90B20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNONL-0006le-Dk
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 18:45:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNOLx-0004yX-6B
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 18:44:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53416)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNOLv-0004Yf-70
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 18:44:08 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601419444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Sm3Gm34Jjn5EWoNbFg1uRbBUxTP1yXhpa0ydpRV9pWQ=;
 b=ED7QQA2rWIU0fTxWhINiZA5zsDQCCThTQJvCS0++m87/ixd8uuRkg05jGTv6mIwrKW9zfp
 eadt2E0fZQaMH3rrcZtKzW10M0hWrARXnbLbEF1Mqm8E/hdP39veNYJAmDBsy8hLqK6/b6
 YCQ/UTS6Lg7bKosaOXITI2pbGyaBTAc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-EV1Ge4SsMXm9yEeA4xvxOA-1; Tue, 29 Sep 2020 18:43:59 -0400
X-MC-Unique: EV1Ge4SsMXm9yEeA4xvxOA-1
Received: by mail-wm1-f70.google.com with SMTP id m25so2428694wmi.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 15:43:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Sm3Gm34Jjn5EWoNbFg1uRbBUxTP1yXhpa0ydpRV9pWQ=;
 b=fraObKfU7UzJkB4WJ2ZFzeq6ehgwslvXJHFh9VZ9zl1G2TBG/vPy+h8MBJgY6S/v9w
 WaFtlmvmuxJF5bZ5rsuuSDnrodMwYMLLUVcrkoTsn5JynFGpK7/IEE9uxxK+a7dYCKhw
 43mklbgTZZ+OAZKJQg34jN/37imJ8846FAbOHYedG0xFF1J8lKZdxLv6et6D7vpnCvaj
 hSumU6tZq+B2pJGvctEWWxst8CD8PZ+/emCqYBmExQW7ZsgDKMIpDPJqfm8V9J03SgSO
 tFfyhuvIgNyZvhx15TrZMuK5l3qY/gG+RxID+yg7HrWCofSyNKBSh4pqqBZ3+2IBaMVi
 mzjA==
X-Gm-Message-State: AOAM530BNwOMgH/9QdHBV0Q7nyXyb7sc6YJ4OpnED6HKp5+8QRY2JA+L
 X7fe42YsjdCYoYia/BXya+2N90iykWL034D9OftLal92xaAKf9J3T5nXsm3QEuXq1WRMwh3t1hL
 lKDUkXwzxWr5fTVU=
X-Received: by 2002:a05:600c:2053:: with SMTP id
 p19mr6799105wmg.50.1601419438012; 
 Tue, 29 Sep 2020 15:43:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzytBklMSd+mcQkWT4fWwubovRHL78gH/20a8RlxC2MfpeBb4ay504uDGUwZsnPRbVg7dNQwQ==
X-Received: by 2002:a05:600c:2053:: with SMTP id
 p19mr6799082wmg.50.1601419437666; 
 Tue, 29 Sep 2020 15:43:57 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id t17sm8129443wrx.82.2020.09.29.15.43.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 15:43:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 00/12] Support disabling TCG on ARM (part 2)
Date: Wed, 30 Sep 2020 00:43:43 +0200
Message-Id: <20200929224355.1224017-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cover from Samuel Ortiz from (part 1) [1]:

  This patchset allows for building and running ARM targets with TCG
  disabled. [...]

  The rationale behind this work comes from the NEMU project where we're
  trying to only support x86 and ARM 64-bit architectures, without
  including the TCG code base. We can only do so if we can build and run
  ARM binaries with TCG disabled.

v4 almost 2 years later... [2]:
- Rebased on Meson
- Addressed Richard review comments
- Addressed Claudio review comments

v3 almost 18 months later [3]:
- Rebased
- Addressed Thomas review comments
- Added Travis-CI job to keep building --disable-tcg on ARM

v2 [4]:
- Addressed review comments from Richard and Thomas from v1 [1]

Regards,

Phil.

[1]: https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg02451.html
[2]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg689168.html
[3]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg641796.html
[4]: https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg05003.html

Green CI:
- https://cirrus-ci.com/build/4572961761918976
- https://gitlab.com/philmd/qemu/-/pipelines/196047779
- https://travis-ci.org/github/philmd/qemu/builds/731370972

Based-on: <20200929125609.1088330-1-philmd@redhat.com>
"hw/arm: Restrict APEI tables generation to the 'virt' machine"
https://www.mail-archive.com/qemu-devel@nongnu.org/msg745792.html

Philippe Mathieu-Daudé (10):
  accel/tcg: Add stub for cpu_loop_exit()
  meson: Allow optional target/${ARCH}/Kconfig
  target/arm: Select SEMIHOSTING if TCG is available
  target/arm: Restrict ARMv4 cpus to TCG accel
  target/arm: Restrict ARMv5 cpus to TCG accel
  target/arm: Restrict ARMv6 cpus to TCG accel
  target/arm: Restrict ARMv7 R-profile cpus to TCG accel
  target/arm: Restrict ARMv7 M-profile cpus to TCG accel
  target/arm: Reorder meson.build rules
  .travis.yml: Add a KVM-only Aarch64 job

Samuel Ortiz (1):
  target/arm: Do not build TCG objects when TCG is off

Thomas Huth (1):
  target/arm: Make m_helper.c optional via CONFIG_ARM_V7M

 default-configs/arm-softmmu.mak |  3 --
 meson.build                     |  8 +++-
 target/arm/cpu.h                | 12 ------
 accel/stubs/tcg-stub.c          |  5 +++
 target/arm/cpu_tcg.c            |  4 +-
 target/arm/helper.c             |  7 ----
 target/arm/m_helper-stub.c      | 73 +++++++++++++++++++++++++++++++++
 .travis.yml                     | 35 ++++++++++++++++
 hw/arm/Kconfig                  | 32 +++++++++++++++
 target/arm/Kconfig              |  4 ++
 target/arm/meson.build          | 40 +++++++++++-------
 11 files changed, 184 insertions(+), 39 deletions(-)
 create mode 100644 target/arm/m_helper-stub.c
 create mode 100644 target/arm/Kconfig

-- 
2.26.2


