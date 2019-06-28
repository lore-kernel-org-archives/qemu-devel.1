Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24895C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 16:16:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F061620645
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 16:16:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F061620645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgtY3-0002EJ-5R
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 12:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49731)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <wainersm@redhat.com>) id 1hgsOR-00023p-IH
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:02:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1hgsOQ-0004eD-AO
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:02:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34815)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1hgsOQ-0004dj-4m
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:02:26 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 79EC7356F6
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 15:02:25 +0000 (UTC)
Received: from virtlab501.virt.lab.eng.bos.redhat.com
 (virtlab501.virt.lab.eng.bos.redhat.com [10.19.152.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 333DD5D704;
 Fri, 28 Jun 2019 15:02:18 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 28 Jun 2019 11:02:14 -0400
Message-Id: <20190628150217.32659-1-wainersm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Fri, 28 Jun 2019 15:02:25 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/3] Acceptance tests: boot Linux with KVM test
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
Cc: philmd@redhat.com, jsnow@redhat.com, ehabkost@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

This series introduce a simple test case which boots Linux with
KVM enabled aiming to exercise qemu-kvm integration. No other
acceptance test does that as far as I know.

The patch 02 allows the test writter to mark (by means of Avocado tag)
the test require a given accelerator that if not present will end up
on skipping its run. It uses `qemu -accel help` to determine if accel
is enabled in binary and in some cases (e.g. kvm) it can check the host
support too. Because `qemu -accel help` needs to execute without the
qmp machinery, the patch 01 is needed. The patch 01 allows to boot qemu
with no qmp which can also be used on LinuxInitrd test for instance.

Depends on '[PATCH 1/2] Acceptance tests: exclude "flaky" tests'
which bumps Avocado version to 69.1.

Conflicts with '[RFC PATCH v2 1/3] python/qemu: split QEMUMachine out
from underneath __init__.py'. Upon merge of John's patch I can then
rebase this.

Git: https://github.com/wainersm/qemu
Branch: acceptance_kvm_test=20
Travis: https://travis-ci.org/wainersm/qemu/jobs/551455876

Wainer dos Santos Moschetta (3):
  python/qemu: Allow to launch the VM without qmp
  tests/acceptance: Introduce the "accel" tag
  tests/acceptance: Add boot linux with kvm test

 python/qemu/__init__.py                   | 72 +++++++++++++++--------
 tests/acceptance/avocado_qemu/__init__.py |  5 ++
 tests/acceptance/avocado_qemu/accel.py    | 60 +++++++++++++++++++
 tests/acceptance/kvm.py                   | 58 ++++++++++++++++++
 4 files changed, 171 insertions(+), 24 deletions(-)
 create mode 100644 tests/acceptance/avocado_qemu/accel.py
 create mode 100644 tests/acceptance/kvm.py

--=20
2.21.0


