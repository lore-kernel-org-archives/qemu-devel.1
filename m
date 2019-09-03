Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0E1C3A5A5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 06:21:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17211215EA
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 06:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17211215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i52Bk-0000Q9-C7
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 02:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56993)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1i529e-0007BG-5G
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 02:19:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1i529b-0003We-FT
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 02:19:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53980)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1i529b-0003Vr-AN
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 02:18:59 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F05663084295
 for <qemu-devel@nongnu.org>; Tue,  3 Sep 2019 06:18:57 +0000 (UTC)
Received: from thuth.com (ovpn-116-80.ams2.redhat.com [10.36.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F82D60127;
 Tue,  3 Sep 2019 06:18:53 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>,
	qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 08:18:43 +0200
Message-Id: <20190903061849.21493-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Tue, 03 Sep 2019 06:18:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/6] Make the core libqtest library independe
 from global_qtest
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

global_qtest and the related wrapper functions often caused trouble in
the past - if they are used somewhere in the libqtest or libqos library
code, it's hard to write tests that properly track multiple test states
(like migration tests).

This patch series finally gets rid of the remaining global_qtest
dependencies in the core libqtest code. The first patches are used to
clean up some files that should not use global_qtest anymore, then the
wrapper functions and the global_qtest definition get moved to a separate
header file called libqtest-single.h - which then should only be used in
tests that track only a single test state.

Thomas Huth (6):
  tests/migration: Do not use functions anymore that rely on
    global_qtest
  tests/libqos/e1000e: Make e1000e libqos functions independent from
    global_qtest
  tests/libqos: Replace clock_step with qtest_clock_step in virtio code
  tests: Remove unnecessary global_qtest references
  tests/libqtest: Move global_test wrapper function into a separate
    header
  tests/libqtest: Use libqtest-single.h in tests that require
    global_qtest

 MAINTAINERS                   |   2 +-
 tests/ahci-test.c             |   1 -
 tests/bios-tables-test.c      |   1 -
 tests/cpu-plug-test.c         |   2 +-
 tests/display-vga-test.c      |   2 +-
 tests/e1000e-test.c           |   2 +-
 tests/fdc-test.c              |   2 +-
 tests/i440fx-test.c           |   2 +-
 tests/i82801b11-test.c        |   2 +-
 tests/intel-hda-test.c        |   2 +-
 tests/ioh3420-test.c          |   2 +-
 tests/ipmi-kcs-test.c         |   3 +-
 tests/ivshmem-test.c          |   3 -
 tests/libqos/e1000e.c         |  16 +-
 tests/libqos/virtio.c         |  15 +-
 tests/libqos/virtio.h         |   5 +-
 tests/libqtest-single.h       | 315 ++++++++++++++++++++++++++++++++++
 tests/libqtest.c              |  13 --
 tests/libqtest.h              | 289 -------------------------------
 tests/migration-test.c        |   6 +-
 tests/qos-test.c              |   2 +-
 tests/rtas-test.c             |   1 -
 tests/rtc-test.c              |   2 +-
 tests/rtl8139-test.c          |   2 +-
 tests/test-netfilter.c        |   2 +-
 tests/test-x86-cpuid-compat.c |   2 +-
 tests/tmp105-test.c           |   2 +-
 tests/tpm-crb-test.c          |   2 +-
 tests/tpm-tests.c             |   2 +-
 tests/tpm-tis-test.c          |   2 +-
 tests/usb-hcd-ohci-test.c     |   2 +-
 tests/usb-hcd-uhci-test.c     |   2 +-
 tests/usb-hcd-xhci-test.c     |   2 +-
 tests/vhost-user-test.c       |   2 +-
 tests/virtio-blk-test.c       |  10 +-
 tests/virtio-ccw-test.c       |   2 +-
 tests/virtio-net-test.c       |   2 +-
 tests/virtio-scsi-test.c      |   2 +-
 tests/virtio-serial-test.c    |   2 +-
 39 files changed, 373 insertions(+), 357 deletions(-)
 create mode 100644 tests/libqtest-single.h

-- 
2.18.1


