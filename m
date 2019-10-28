Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854C3CA9EA0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 07:35:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D4222086D
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 07:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G77liLAT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D4222086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOzZ9-0002L5-Eb
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 03:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46431)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iOzYQ-0000xg-O1
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:35:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iOzYN-0001xB-Rt
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:35:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45185
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iOzYN-0001uy-IX
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 03:35:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572248100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jcov7sAse9PZAwUrhYmpKYGSx5+7+XKzJCTKhDLtVkM=;
 b=G77liLAT9KZ4sVcKov91ky2+7n+0gwZ/we1ctDtyIVmvenmQMozLvy1T/ZN21BvvhpnVV0
 3wa/Uzx5MxZoh5sksJlgYWYwnB9R9o7bM5t2QuqXXgvcy872d9C1OmuI3JQHyHA8JNKFcR
 bgCSYr09E6h8UNmCKSr9WeiVrh1v+0Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-u5ojY5MAOpSBjbJu6T6zmg-1; Mon, 28 Oct 2019 03:34:57 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3122F1800DCA;
 Mon, 28 Oct 2019 07:34:55 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-86.brq.redhat.com [10.40.204.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A572619C69;
 Mon, 28 Oct 2019 07:34:44 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/26] tests/acceptance: Queue for 4.2
Date: Mon, 28 Oct 2019 08:34:15 +0100
Message-Id: <20191028073441.6448-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: u5ojY5MAOpSBjbJu6T6zmg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Fabien Chouteau <chouteau@adacore.com>, Kamil Rytarowski <kamil@netbsd.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

These Avocado-related patches were posted some weeks/months ago
but got lost in the mailing list traffic.

Please review,

Phil.

Cleber Rosa (1):
  Acceptance tests: refactor wait_for_console_pattern

Philippe Mathieu-Daud=C3=A9 (25):
  python/qemu/machine: Allow to use other serial consoles than default
  tests/acceptance: Fixe wait_for_console_pattern() hangs
  tests/acceptance: Send <carriage return> on serial lines
  tests/acceptance: Refactor exec_command_and_wait_for_pattern()
  tests/acceptance: Rename avocado_qemu.Test as MachineTest
  tests/acceptance: Make pick_default_qemu_bin() more generic
  tests/acceptance: Introduce LinuxUserTest base class
  tests/acceptance: Add bFLT loader linux-user test
  tests/acceptance: Add test that boots the HelenOS microkernel on Leon3
  tests/acceptance: Add test that boots Linux up to BusyBox on Leon3
  .travis.yml: Let the avocado job run the Leon3 test
  tests/acceptance: Add test that runs NetBSD 4.0 installer on PRep/40p
  tests/acceptance: Test Open Firmware on the PReP/40p
  tests/acceptance: Test OpenBIOS on the PReP/40p
  tests/acceptance: Test Sandalfoot initrd on the PReP/40p
  .travis.yml: Let the avocado job run the 40p tests
  tests/boot_console: Test booting HP-UX firmware upgrade
  tests/boot_linux_console: Use Avocado archive::gzip_uncompress()
  tests/boot_linux_console: Add a test for the Raspberry Pi 2
  tests/boot_linux_console: Test the raspi2 UART1 (16550 based)
  tests/boot_linux_console: Boot Linux and run few commands on raspi3
  tests/boot_linux_console: Test SDHCI and termal sensor on raspi3
  tests/boot_linux_console: Add initrd test for the Exynos4210
  tests/boot_linux_console: Add sdcard test for the Exynos4210
  tests/boot_linux_console: Run BusyBox on 5KEc 64-bit cpu

 .travis.yml                               |   2 +-
 MAINTAINERS                               |   2 +
 docs/devel/testing.rst                    |   8 +-
 python/qemu/machine.py                    |   9 +-
 tests/acceptance/avocado_qemu/__init__.py |  71 ++++-
 tests/acceptance/boot_linux_console.py    | 348 +++++++++++++++++++---
 tests/acceptance/cpu_queries.py           |   4 +-
 tests/acceptance/empty_cpu_model.py       |   4 +-
 tests/acceptance/linux_initrd.py          |   4 +-
 tests/acceptance/linux_ssh_mips_malta.py  |  22 +-
 tests/acceptance/load_bflt.py             |  52 ++++
 tests/acceptance/machine_sparc_leon3.py   |  65 ++++
 tests/acceptance/migration.py             |   4 +-
 tests/acceptance/ppc_prep_40p.py          | 134 +++++++++
 tests/acceptance/version.py               |   4 +-
 tests/acceptance/virtio_version.py        |   4 +-
 tests/acceptance/vnc.py                   |   4 +-
 17 files changed, 660 insertions(+), 81 deletions(-)
 create mode 100644 tests/acceptance/load_bflt.py
 create mode 100644 tests/acceptance/machine_sparc_leon3.py
 create mode 100644 tests/acceptance/ppc_prep_40p.py

--=20
2.21.0


