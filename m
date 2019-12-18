Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C82EC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 17:06:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 593432176D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 17:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZrkH8Lgq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 593432176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihcm3-0000Mm-Hg
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 12:06:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46772)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1ihcgM-0001mR-Rz
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 12:00:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1ihcgL-0006IB-5w
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 12:00:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20893
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1ihcgK-0006Dq-Vm
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 12:00:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576688416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UypVec3fvC++Brbm0L65MZ5PEBYGI6n1NS4zqNaIBKo=;
 b=ZrkH8Lgq3xgycqW6hk3qgCoi6xLfvbJpMuBOmxfn9BeZrE15STdylteZJta9q0yNsQ/q62
 C/HRKyKd0kFoqjc/26hQK7IjT5qokZ4fPzJ6Hz/I5GYJ6G52zlAhJHYeRKoLhgdCbZsWXG
 6oJ2UovyvUdalVKL++26eZRK02JShVE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-R-wnel9yO9OxcsFIjFaccA-1; Wed, 18 Dec 2019 12:00:14 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC030801E66
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 17:00:13 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-50.gru2.redhat.com
 [10.97.116.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CA46F5C1D4;
 Wed, 18 Dec 2019 17:00:05 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] Acceptance tests: boot Linux with KVM test
Date: Wed, 18 Dec 2019 14:00:00 -0300
Message-Id: <20191218170003.31356-1-wainersm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: R-wnel9yO9OxcsFIjFaccA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: philmd@redhat.com, ehabkost@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds boot Linux tests for x86_64, aarch64, ppc64, s390x
targets which, unlike others, tell QEMU to use KVM. Likewise
it was added cases for tcg.

The patch 01 introduce an infraestructure on avocado_qemu framework
so that:
a) simply tagging the test with `accel:kvm` (or `accel:tcg`) will
   automatically set the corresponding '--accel' on the launched
   QEMU;
a) test is canceled if the accelerator is not enabled in QEMU
   binary and not present in the host.

Changes v1 -> v2:
- old patch 01 was removed becase the same feature is merged on
  commit 74b56bb55395.
- old patch 02 became 01 on v2, and with a major re-implementation. The
  bits that added the accel module is merged on commit 8b272e00186.
- old patch 03 was removed. Based on comments of ehabkost and crosa,
  instead the boot_linux_console test suite got new cases which uses
  the 'accel' tag to specify the use of kvm or tcg.
- Added patch 03 which refactor the handler of 'machine' tag that
  was introduced on commit ba21bde930f.

v1: [PATCH 0/3] Acceptance tests: boot Linux with KVM test
- https://www.mail-archive.com/qemu-devel@nongnu.org/msg627498.html

Tree:
- Git: https://github.com/wainersm/qemu
- Branch: acceptance_kvm_test-v2

CI:
- Travis (FAIL): https://travis-ci.org/wainersm/qemu/builds/626703965
  Not related with those change. Acceptance tests on Travis ran just
fine.

Wainer dos Santos Moschetta (3):
  tests/acceptance: avocado_qemu: Introduce the 'accel' test parameter
  tests/acceptance: boot_linux_console: Add boot Linux with kvm tests
  tests/acceptance: avocado_qemu: Refactor the handler of 'machine'
    parameter

 docs/devel/testing.rst                    | 16 +++++
 tests/acceptance/avocado_qemu/__init__.py | 27 ++++++-
 tests/acceptance/boot_linux_console.py    | 88 +++++++++++++++++------
 3 files changed, 109 insertions(+), 22 deletions(-)

--=20
2.23.0


