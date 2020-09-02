Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A4DC433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:08:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B983C20767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XTHCLwnB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B983C20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDSUn-000521-Rs
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 09:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDSMU-0006AB-Kh
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 08:59:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41327)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDSMS-00078b-0x
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 08:59:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599051575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DUshaNDmq7H1Av4588PgSRGXK5hC8dXArAHSxrQ/ftE=;
 b=XTHCLwnB57ZlOkhrikSu+y72995K1fLzL5xC92L5MRR7yzPKxhd+2dqTIb3lQhgjKg+7ho
 vZ8BxBIUpq6jz5ZVU0Fwgwod9qQGum8hYo/eTehB7X+D/iZ2w2rzrK7eOb32xeV1UrQ+2P
 wfA4uWozfH6IuB/h8H8bTsRqiS4xPiI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-EZwRIX0hMO6GXjMGmBa9gA-1; Wed, 02 Sep 2020 08:59:24 -0400
X-MC-Unique: EZwRIX0hMO6GXjMGmBa9gA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 988A556C34
 for <qemu-devel@nongnu.org>; Wed,  2 Sep 2020 12:59:18 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C8455D9D3
 for <qemu-devel@nongnu.org>; Wed,  2 Sep 2020 12:59:18 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/39] Next round of Meson fixes and cleanups
Date: Wed,  2 Sep 2020 08:58:38 -0400
Message-Id: <20200902125917.26021-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:42:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is the final set of patches that I would like to have in 5.2
as far as the Meson conversion is concerned.

Patch 1 is a cross-compilation bugfix from Thomas.

Patches 2..5 rework the "make check" generator so that outputs
of successful tests are hidden, and so that if a test appears
in multiple suites it is not run multiple times by "make check".

Patch 6..10 are miscellaneous bugfixes.

Patches 11..25 convert the check-unit testsuite.

Patches 26..39 remove some of the now-dead code from the configure
script and the Makefile, introducing some simplification whenever symbols
are not needed anymore in the Makefile.

Marc-André Lureau (14):
  meson: build qapi tests library
  meson: declare tasn1 dependency
  meson: declare keyutils dependency
  meson: convert qht-bench
  tests: qga has virtio-serial by default when host has it
  meson: convert the unit tests
  meson: move keyutils dependency check
  meson: remove old socket_scm_helper rule
  meson: convert vhost-user-bridge
  meson: convert atomic*-bench
  tests: do not print benchmark output to stdout
  tests/migration/stress: remove unused exit_success
  meson: fix migration/stress compilation with glibc>=2.30
  meson: convert migration/initrd-stress

Paolo Bonzini (24):
  mtest2make: split environment from test command
  mtest2make: split working directory from test command
  mtest2make: hide output of successful tests
  mtest2make: unify tests that appear in multiple suites
  meson: remove b_lundef option
  configure: do not include absolute paths in -I and -L paths
  configure: include cross sdl2-config in meson cross file
  ninjatool: use constant names for stamp files
  meson: fix libqos linking
  meson: convert the speed tests
  configure: remove dead code for in-tree builds
  meson: compute config_all_devices directly
  Makefile: remove dead variables and includes
  Makefile: inline the relevant parts of rules.mak
  configure: move disassembler configuration to meson
  configure: move C++ compiler handling to meson
  meson: keep all compiler flags detection together
  configure: move -ldl test to meson
  configure: remove unnecessary libm test
  configure: do not look for install(1)
  meson: get glib compilation flags from GLIB_CFLAGS
  configure: do not include dependency flags in QEMU_CFLAGS and LIBS
  configure: drop dead variables
  docs: suggest Meson replacements for various configure functions

Thomas Huth (1):
  configure: Add system = 'linux' for meson when cross-compiling

 .gitignore                       |   2 -
 Makefile                         |  63 ++---
 Makefile.objs                    |  34 ---
 accel/tcg/meson.build            |   2 +-
 configure                        | 331 ++-----------------------
 disas/meson.build                |   4 +-
 docs/devel/build-system.rst      |  18 +-
 hw/arm/meson.build               |   2 +-
 hw/riscv/meson.build             |   2 +-
 meson.build                      | 135 ++++++++---
 monitor/meson.build              |   2 +-
 rules.mak                        | 158 ------------
 scripts/empty.c                  |   6 +
 scripts/grepy.sh                 |   3 -
 scripts/mtest2make.py            |  95 ++++----
 scripts/ninjatool.py             |   8 +-
 scripts/test-driver.py           |  35 +++
 tests/Makefile.include           | 405 +------------------------------
 tests/benchmark-crypto-cipher.c  |   8 +-
 tests/benchmark-crypto-hash.c    |   2 +-
 tests/benchmark-crypto-hmac.c    |   8 +-
 tests/include/meson.build        |  16 ++
 tests/meson.build                | 259 ++++++++++++++++++++
 tests/migration/initrd-stress.sh |  10 +
 tests/migration/meson.build      |  14 ++
 tests/migration/stress.c         |  15 +-
 tests/qtest/libqos/meson.build   |   9 +-
 tests/tcg/Makefile.qemu          |   2 -
 tests/test-crypto-secret.c       |  10 +-
 tests/test-qga.c                 |   4 +-
 30 files changed, 588 insertions(+), 1074 deletions(-)
 delete mode 100644 Makefile.objs
 delete mode 100644 rules.mak
 create mode 100644 scripts/empty.c
 delete mode 100755 scripts/grepy.sh
 create mode 100644 scripts/test-driver.py
 create mode 100644 tests/include/meson.build
 create mode 100755 tests/migration/initrd-stress.sh
 create mode 100644 tests/migration/meson.build

-- 
2.26.2


