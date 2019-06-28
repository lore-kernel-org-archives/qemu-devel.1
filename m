Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2E0C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 14:11:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 861A6208E3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 14:11:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 861A6208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgrbX-000754-Qk
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 10:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59625)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hgrCo-0002QP-4T
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 09:46:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hgrCm-0004lQ-KX
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 09:46:22 -0400
Received: from relay.sw.ru ([185.231.240.75]:41274)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1hgrCm-0004i6-B1; Fri, 28 Jun 2019 09:46:20 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1hgrCh-0008NT-Vp; Fri, 28 Jun 2019 16:46:16 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Fri, 28 Jun 2019 16:46:07 +0300
Message-Id: <1561729574-530879-1-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v3 0/7] Allow Valgrind checking all QEMU
 processes
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, mreitz@redhat.com,
 andrey.shinkevich@virtuozzo.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In the current implementation of the QEMU bash iotests, only qemu-io
processes may be run under the Valgrind, which is a useful tool for
finding memory usage issues. Let's allow the common.rc bash script
runing all the QEMU processes, such as qemu-kvm, qemu-img, qemu-ndb
and qemu-vxhs, under the Valgrind tool.

v3:
  01: The new function _casenotrun() was added to the common.rc bash
      script to notify the user of test cases dropped for some reason.
      Suggested by Kevin.
      Particularly, the notification about the nonexistent TMPDIR in
      the test 051 was added (noticed by Vladimir).
  02: The timeout in some test cases was extended for Valgrind because
      it differs when running on the ramdisk.
  03: Due to the common.nbd script has been changed with the commit
      b28f582c, the patch "iotests: amend QEMU NBD process synchronization"
      is actual no more. Note that QEMU_NBD is launched in the bash nested
      shell in the _qemu_nbd_wrapper() as it was before in common.rc.
  04: The patch "iotests: new file to suppress Valgrind errors" was dropped
      due to my superficial understanding of the work of the function
      blk_pread_unthrottled(). Special thanks to Kevin who shed the light
      on the null block driver involved. Now, the parameter 'read-zeroes=on'
      is passed to the null block driver to initialize the buffer in the
      function guess_disk_lchs() that the Valgrind was complaining to.

v2:
  01: The patch 2/7 of v1 was merged into the patch 1/7, suggested by Daniel.
  02: Another patch 7/7 was added to introduce the Valgrind error suppression
      file into the QEMU project.
  Discussed in the email thread with the message ID:
  <1560276131-683243-1-git-send-email-andrey.shinkevich@virtuozzo.com>

Andrey Shinkevich (7):
  iotests: allow Valgrind checking all QEMU processes
  iotests: exclude killed processes from running under Valgrind
  iotests: Add casenotrun report to bash tests
  iotests: Valgrind fails with nonexistent directory
  iotests: extended timeout under Valgrind
  iotests: extend sleeping time under Valgrind
  iotests: Set read-zeroes on in null block driver for Valgrind

 tests/qemu-iotests/028        |   6 +-
 tests/qemu-iotests/039        |   5 ++
 tests/qemu-iotests/039.out    |  30 ++-------
 tests/qemu-iotests/051        |  14 ++--
 tests/qemu-iotests/051.pc.out |  10 +--
 tests/qemu-iotests/061        |   2 +
 tests/qemu-iotests/061.out    |  12 +---
 tests/qemu-iotests/137        |   1 +
 tests/qemu-iotests/137.out    |   6 +-
 tests/qemu-iotests/183        |   9 ++-
 tests/qemu-iotests/186        |  20 +++---
 tests/qemu-iotests/186.out    | 152 +++++++++++++++++++++---------------------
 tests/qemu-iotests/192        |   6 +-
 tests/qemu-iotests/227        |   4 +-
 tests/qemu-iotests/227.out    |   4 +-
 tests/qemu-iotests/240        |   8 +--
 tests/qemu-iotests/247        |   6 +-
 tests/qemu-iotests/common.rc  |  76 ++++++++++++++++-----
 18 files changed, 205 insertions(+), 166 deletions(-)

-- 
1.8.3.1


