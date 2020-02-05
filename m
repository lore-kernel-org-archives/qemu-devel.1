Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31008C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 20:39:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEB782072B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 20:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y6ClJ887"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEB782072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izRSL-00073n-6x
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 15:39:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34905)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1izRMG-0006qq-V4
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 15:33:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1izRMF-0004st-Hq
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 15:33:12 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20237
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1izRMF-0004sO-EB
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 15:33:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580934791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qlS46Kt1eYVBUSmaE1NX3v1Vbc0oMSKhdSfGnMvQNP8=;
 b=Y6ClJ887MbOgl+fD8j7c++E8WmNU4VjhAzlDOvDHB7lulxINwqsE6CwrsOw+qzjMV4ds6i
 eDaQoZu+zuc+1bcjloVG4o2909d32wH4GqXCs8pySvNWYSLatpOEBDCvvBeZQ+N+wVqU1Z
 3tHLWW59b5e3vS/5oZcVn8X/5d0HF1s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-NbeQTdDaPWGGmd64PJoehA-1; Wed, 05 Feb 2020 15:32:54 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1380107B7D4;
 Wed,  5 Feb 2020 20:32:53 +0000 (UTC)
Received: from virtlab501.virt.lab.eng.bos.redhat.com
 (virtlab501.virt.lab.eng.bos.redhat.com [10.19.152.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8E2A1100164D;
 Wed,  5 Feb 2020 20:32:50 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/8] Acceptance tests: boot Linux with KVM test
Date: Wed,  5 Feb 2020 15:32:42 -0500
Message-Id: <20200205203250.30526-1-wainersm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: NbeQTdDaPWGGmd64PJoehA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: drjones@redhat.com, ehabkost@redhat.com, philmd@redhat.com,
 thuth@redhat.com, crosa@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds boot Linux tests for x86_64, aarch64, ppc64, and s390x
targets which, unlike others, enable the KVM acceleration. Likewise
it was added test cases for tcg.

It is introduced an infraestructure on avocado_qemu framework
so that:
a) simply tagging the test with `accel:kvm` (or `accel:tcg`) will
automatically set the corresponding '-accel' on the launched
QEMU;
b) test is canceled if the accelerator is not enabled on the QEMU
binary or not available in the host. In special, it checks if SMT
is disabled on POWER8.

The acceptance builder on Travis was changed too in order to make
the test run.

Changes v3 -> v4:
- Broke changes per-arch to ease the reviews. Resulting on
  patches 02, 03, 05, 06.
- The test for aarch64 now passes '-cpu max' and
  -M 'virt,gic-version=3Dmax'. (patch 03) [drjones]
- Added a fix to accel.kvm_available() so that it detects
  correctly the availability of kvm on ppc64le. (patch 05)
- The test for ppc64le now checks if SMT is enabled on
  POWER8 then skip.=20

v3: [PATCH v3 0/4] Acceptance tests: boot Linux with KVM test
- https://www.mail-archive.com/qemu-devel@nongnu.org/msg672635.html
v2: [PATCH v2 0/3] Acceptance tests: boot Linux with KVM test
- https://www.mail-archive.com/qemu-devel@nongnu.org/msg666238.html
v1: [PATCH 0/3] Acceptance tests: boot Linux with KVM test
- https://www.mail-archive.com/qemu-devel@nongnu.org/msg627498.html

Tree:
- Git: https://github.com/wainersm/qemu
- Branch: acceptance_kvm_test-v4

CI:
- Travis (FAIL): https://travis-ci.org/wainersm/qemu/builds/646154220
  Failed jobs are not related with this series changes.

Wainer dos Santos Moschetta (8):
  tests/acceptance: avocado_qemu: Introduce the 'accel' test parameter
  tests/acceptance: boot_linux_console: Add boot Linux/x86 with KVM
  tests/acceptance: boot_linux_console: Add boot Linux/aarch64 with KVM
  python/qemu: accel: Fix kvm_available() on ppc64le
  test/acceptance: boot_linux_console: Add boot Linux/ppc64le with KVM
  tests/acceptance: boot_linux_console: Add boot Linux/s390x with KVM
  tests/acceptance: avocado_qemu: Refactor the handler of 'machine'
    parameter
  travis.yml: Enable acceptance KVM tests

 .travis.yml                               |   7 +-
 docs/devel/testing.rst                    |  16 ++++
 python/qemu/accel.py                      |   3 +-
 tests/acceptance/avocado_qemu/__init__.py |  27 +++++-
 tests/acceptance/boot_linux_console.py    | 108 +++++++++++++++++-----
 5 files changed, 136 insertions(+), 25 deletions(-)

--=20
2.24.1


