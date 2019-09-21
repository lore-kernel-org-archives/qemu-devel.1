Return-Path: <SRS0=nDBX=XQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9C0C4360D
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 15:06:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A334C2054F
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 15:06:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A334C2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBgxa-0005oc-GZ
	for qemu-devel@archiver.kernel.org; Sat, 21 Sep 2019 11:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39773)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iBgw5-0004KV-M1
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 11:04:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iBgw4-0003Dg-NG
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 11:04:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51844)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>)
 id 1iBgw1-0003CV-9R; Sat, 21 Sep 2019 11:04:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A54088535D;
 Sat, 21 Sep 2019 15:04:27 +0000 (UTC)
Received: from thuth.com (ovpn-116-27.ams2.redhat.com [10.36.116.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2025E608A5;
 Sat, 21 Sep 2019 15:04:23 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 0/4] Make it possible to compile with CONFIG_ARM_V7M=n
Date: Sat, 21 Sep 2019 17:04:16 +0200
Message-Id: <20190921150420.30743-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Sat, 21 Sep 2019 15:04:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We've got CONFIG_ARM_V7M, but it currently can't be disabled.
Here are some patches that should allow to disable the switch
(if the corresponding boards are disabled, too).

RFC -> v1:
 - Move the definitions into internals.h instead of cpu.h in the 1st patch
 - Instead of creating an ugly stubs file, simply make armv7m_nvic.c
   mandatory for linking.

Thomas Huth (4):
  target/arm: Make cpu_register() and set_feature() available for other
    files
  target/arm: Move cortex-m related functions to new file v7m.c
  hw/arm: Move armv7m_nvic.c to hw/arm/ and always enable it for arm
    builds
  default-configs: Do not enforce CONFIG_ARM_V7M anymore

 default-configs/arm-softmmu.mak |   3 -
 hw/arm/Makefile.objs            |   2 +
 hw/{intc => arm}/armv7m_nvic.c  |   0
 hw/arm/trace-events             |  17 +++
 hw/intc/Makefile.objs           |   1 -
 hw/intc/trace-events            |  17 ---
 target/arm/Makefile.objs        |   1 +
 target/arm/cpu.c                | 166 +--------------------------
 target/arm/cpu64.c              |  17 +--
 target/arm/internals.h          |  18 +++
 target/arm/v7m.c                | 193 ++++++++++++++++++++++++++++++++
 11 files changed, 234 insertions(+), 201 deletions(-)
 rename hw/{intc => arm}/armv7m_nvic.c (100%)
 create mode 100644 target/arm/v7m.c

-- 
2.18.1


