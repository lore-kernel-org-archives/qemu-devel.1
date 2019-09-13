Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7FDC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:31:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71F9A20693
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71F9A20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8nY7-0004Qr-Gb
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 11:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53445)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i8nUp-0001D0-PP
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:28:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i8nUo-0004fb-Lc
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:28:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33394)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i8nUm-0004eq-1q; Fri, 13 Sep 2019 11:28:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 23A3F18C8932;
 Fri, 13 Sep 2019 15:28:23 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ADBB85D772;
 Fri, 13 Sep 2019 15:28:20 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 13 Sep 2019 18:28:15 +0300
Message-Id: <20190913152818.17843-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Fri, 13 Sep 2019 15:28:23 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v5 0/3] Fix qcow2+luks corruption introduced by
 commit 8ac0f15f335
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-stable <qemu-stable@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 8ac0f15f335 accidently broke the COW of non changed areas
of newly allocated clusters, when the write spans multiple clusters,
and needs COW both prior and after the write.
This results in 'after' COW area being encrypted with wrong
sector address, which render it corrupted.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1745922

CC: qemu-stable <qemu-stable@nongnu.org>

V2: grammar, spelling and code style fixes.
V3: more fixes after the review.
V4: addressed review comments from Max Reitz,
    and futher refactored the qcow2_co_encrypt to just take full host and guest offset
    which simplifies everything.

V5: reworked the patches so one of them fixes the bug
    only and other one is just refactoring

Best regards,
	Maxim Levitsky

Maxim Levitsky (3):
  Fix qcow2+luks corruption introduced by commit 8ac0f15f335
  block/qcow2: refactor threaded encryption code
  qemu-iotests: Add test for bz #1745922

 block/qcow2-cluster.c      | 29 +++++++-----
 block/qcow2-threads.c      | 62 ++++++++++++++++++++------
 block/qcow2.c              |  5 ++-
 block/qcow2.h              |  8 ++--
 tests/qemu-iotests/263     | 91 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/263.out | 40 +++++++++++++++++
 tests/qemu-iotests/group   |  2 +
 7 files changed, 206 insertions(+), 31 deletions(-)
 create mode 100755 tests/qemu-iotests/263
 create mode 100644 tests/qemu-iotests/263.out

-- 
2.17.2


