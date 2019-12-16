Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA00C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 20:49:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 233352176D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 20:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SAZq1dLa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 233352176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igxJE-00009z-OU
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 15:49:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36234)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1igxHr-0006tR-UE
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 15:48:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1igxHo-0006Hm-CN
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 15:48:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31516
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1igxHn-0006GL-Vu
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 15:48:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576529291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+Fxv/08Xa0VbcqCSvsm0VgrWIKaPNFsllFhCVnw+YLI=;
 b=SAZq1dLaiyjjq8I1hzXpiBv+2GUA7ikRYoltPQLwXLcaaw1h7gxM7FG20YIqUE1i080/An
 bRF2tGA0lfWaZxWhBnmdqwkLaPh78osqDtjt4K/rB6jKaCsj+j0vbxNbgDw2XxImgmzMTw
 rOqHomWrPBKqWCjzMtsgwYbV++J+/Ro=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-_3L8DJ-vNPWrTcGnvlpMrw-1; Mon, 16 Dec 2019 15:48:09 -0500
X-MC-Unique: _3L8DJ-vNPWrTcGnvlpMrw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B4708D811D;
 Mon, 16 Dec 2019 20:48:07 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6C11B5D9C9;
 Mon, 16 Dec 2019 20:48:01 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: [kvm-unit-tests PATCH 00/10] KVM: arm64: PMUv3 Event Counter Tests
Date: Mon, 16 Dec 2019 21:47:47 +0100
Message-Id: <20191216204757.4020-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: peter.maydell@linaro.org, andrew.murray@arm.com, drjones@redhat.com,
 alexandru.elisei@arm.com, andre.przywara@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series implements tests exercising the PMUv3 event counters.
It tests both the 32-bit and 64-bit versions. Overflow interrupts
also are checked. Those tests only are written for arm64.

It allowed to reveal some issues related to SW_INCR implementation
(esp. related to 64-bit implementation), some problems related to
32-bit <-> 64-bit transitions and consistency of enabled states
of odd and event counters.

Overflow interrupt testing relies of one patch from Andre
("arm: gic: Provide per-IRQ helper functions") to enable the
PPI 23, coming from "arm: gic: Test SPIs and interrupt groups"
(https://patchwork.kernel.org/cover/11234975/). Drew kindly
provided "arm64: Provide read/write_sysreg_s".

All PMU tests can be launched with:
./run_tests.sh -g pmu
Tests also can be launched individually. For example:
./arm-run arm/pmu.flat -append 'chained-sw-incr'

With KVM:
- chain-promotion and chained-sw-incr are known to be failing.
- Problems were reported upstream.
With TCG:
- pmu-event-introspection is failing due to missing required events
  (we may remove this from TCG actually)
- chained-sw-incr also fails. I haven't investigated yet.

The series can be found at:
https://github.com/eauger/kut/tree/pmu_event_counters_v1

History:
v1 -> v2:
- Use new report() proto
- Style cleanup
- do not warn about ARM spec recommendations
- add a comment about PMCEID0/1 splits

Andre Przywara (1):
  arm: gic: Provide per-IRQ helper functions

Andrew Jones (1):
  arm64: Provide read/write_sysreg_s

Eric Auger (8):
  arm: pmu: Let pmu tests take a sub-test parameter
  arm: pmu: Add a pmu struct
  arm: pmu: Check Required Event Support
  arm: pmu: Basic event counter Tests
  arm: pmu: Test chained counter
  arm: pmu: test 32-bit <-> 64-bit transitions
  arm/arm64: gic: Introduce setup_irq() helper
  arm: pmu: Test overflow interrupts

 arm/gic.c              |  24 +-
 arm/pmu.c              | 783 ++++++++++++++++++++++++++++++++++++++++-
 arm/unittests.cfg      |  55 ++-
 lib/arm/asm/gic-v3.h   |   2 +
 lib/arm/asm/gic.h      |  12 +
 lib/arm/gic.c          | 101 ++++++
 lib/arm64/asm/sysreg.h |  11 +
 7 files changed, 950 insertions(+), 38 deletions(-)

--=20
2.20.1


