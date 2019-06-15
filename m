Return-Path: <SRS0=kcoF=UO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D79C31E51
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 15:48:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FD4B21841
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 15:48:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FD4B21841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32892 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcAvB-0006QS-HP
	for qemu-devel@archiver.kernel.org; Sat, 15 Jun 2019 11:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35480)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hcAqb-0003e1-G9
 for qemu-devel@nongnu.org; Sat, 15 Jun 2019 11:44:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hcAqZ-0007q0-Ia
 for qemu-devel@nongnu.org; Sat, 15 Jun 2019 11:44:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50538)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hcAqV-0007YO-VB; Sat, 15 Jun 2019 11:44:00 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F1B1E8762E;
 Sat, 15 Jun 2019 15:43:57 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-41.brq.redhat.com [10.40.204.41])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 75EE31001B05;
 Sat, 15 Jun 2019 15:43:54 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat, 15 Jun 2019 17:43:29 +0200
Message-Id: <20190615154352.26824-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Sat, 15 Jun 2019 15:43:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 00/23] Support disabling TCG on ARM
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo motived me to salvage this (other!) previous series fromi
Samuel Ortiz (NEMU project).

v1 cover from Samuel [1]:

  This patchset allows for building and running ARM targets with TCG
  disabled. It splits the target/arm/helper.c file into logical TCG and
  non TCG dependent files so that one can build and run QEMU binaries wit=
h
  or without TCG enabled.

  The rationale behind this work comes from the NEMU project where we're
  trying to only support x86 and ARM 64-bit architectures, without
  including the TCG code base. We can only do so if we can build and run
  ARM binaries with TCG disabled.

v2:

Most of the patches from v1 got adapted, except the "Move all
interrupt handlers" patch, because Peter disagreed with it.
See threads:
 https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg03908.html
 https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg07304.html
Anyway this is not a blocking issue, and can be done once this series
get merged.

This is a kind of series you don't want to rebase (as in, the quicker
it get merged, the saner). It is also one of my most painful QEMU
series, and really wish it was worthwhile.

The diffstat is pretty decent.

Regards,

Phil.

[1]: https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg02451.html

Philippe Mathieu-Daud=C3=A9 (15):
  target/arm: Makefile cleanup (Aarch64)
  target/arm: Makefile cleanup (ARM)
  target/arm: Makefile cleanup (KVM)
  target/arm: Makefile cleanup (softmmu)
  target/arm: Add copyright boilerplate
  target/arm: Fix multiline comment syntax
  target/arm: Declare some function publicly
  target/arm: Move code around
  target/arm: Move the v7-M Security State helpers to v7m_helper
  target/arm: Declare v7m_cpacr_pass() publicly
  target/arm: Make the v7-M Security State routines static
  target/arm: Make arm_deliver_fault() static
  target/arm: Fix coding style issues
  target/arm: Restrict semi-hosting to TCG
  target/arm: Missing symbols when building with --disable-tcg

Samuel Ortiz (8):
  target/arm: Move all v7m insn helpers into their own file
  target/arm: Move v7m exception handling routines to v7m_helper
  target/arm: Move the DC ZVA helper into op_helper
  target/arm: Make ARM TLB filling routine static
  target/arm: Move CPU state dumping routines to helper.c
  target/arm: Move watchpoints APIs to helper.c
  target/arm: Define TCG dependent functions when TCG is enabled
  target/arm: Do not build TCG objects when TCG is off

 target/arm/Makefile.objs   |   25 +-
 target/arm/cpu.c           |    8 +-
 target/arm/helper.c        | 3416 ++++++------------------------------
 target/arm/internals.h     |   77 +-
 target/arm/kvm-missing.c   |   22 +
 target/arm/op_helper.c     |  358 ++--
 target/arm/translate-a64.c |  127 --
 target/arm/translate.c     |   90 +-
 target/arm/translate.h     |    5 -
 target/arm/v7m_helper.c    | 2603 +++++++++++++++++++++++++++
 10 files changed, 3451 insertions(+), 3280 deletions(-)
 create mode 100644 target/arm/kvm-missing.c
 create mode 100644 target/arm/v7m_helper.c

--=20
2.20.1


