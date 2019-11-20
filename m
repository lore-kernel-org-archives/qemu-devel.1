Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F8DC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 14:05:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1452222445
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 14:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RxEoKVPz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1452222445
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXQbS-0007r8-Ue
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 09:05:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47266)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iXQaD-0006MV-71
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:03:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iXQaB-0000rO-8S
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:03:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54075
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iXQaB-0000rF-5D
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:03:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574258626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kmSz5I3iQu8nBCc4Tx2gBHa6XFQ3euGJ0RJ0tEksSC0=;
 b=RxEoKVPzn2rUvcfBoOKw7SGBgm34I6XuglbkUnltobK5hLtlcPWrwRbKs3ouT1ZsjGD/SM
 lp3Q6K6dnzOQqrBrk6C919bHatANhxhsy0J0s2H+3n+G4uMNbezNZsVsqevYgSGE++/PRM
 pxJAu9Ia97zP5PErqJt+zxO5BFwq26c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-5vpkOQnAO9KhpHPSM8_4KQ-1; Wed, 20 Nov 2019 09:03:43 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8445F8024E1;
 Wed, 20 Nov 2019 14:03:42 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 43A9E60499;
 Wed, 20 Nov 2019 14:03:36 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-4.2? 0/6] block: Fix resize (extending) of short overlays
Date: Wed, 20 Nov 2019 15:03:13 +0100
Message-Id: <20191120140319.1505-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 5vpkOQnAO9KhpHPSM8_4KQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Consider the following scenario where the overlay is shorter than its
backing file:

    base.qcow2:     AAAAAAAA
    overlay.qcow2:  BBBB

When resizing (extending) overlay.qcow2, the new blocks should not stay
unallocated and make the additional As from base.qcow2 visible like
before this series, but zeros should be read.

A similar case happens with the various variants of a commit job when an
intermediate file is short (- for unallocated):

    base.qcow2:     A-A-AAAA
    mid.qcow2:      BB-B
    top.qcow2:      C--C--C-

After commit top.qcow2 to mid.qcow2, the following happens:

    mid.qcow2:      CB-C00C0 (correct result)
    mid.qcow2:      CB-C--C- (before this fix)

Without the fix, blocks that previously read as zeros on top.qcow2
suddenly turn into A.

Kevin Wolf (6):
  block: bdrv_co_do_pwrite_zeroes: 64 bit 'bytes' parameter
  block: truncate: Don't make backing file data visible
  iotests: Add qemu_io_log()
  iotests: Fix timeout in run_job()
  iotests: Support job-complete in run_job()
  iotests: Test committing to short backing file

 block/io.c                    |  31 ++++++-
 tests/qemu-iotests/274        | 131 +++++++++++++++++++++++++++++
 tests/qemu-iotests/274.out    | 150 ++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group      |   1 +
 tests/qemu-iotests/iotests.py |  11 ++-
 5 files changed, 319 insertions(+), 5 deletions(-)
 create mode 100755 tests/qemu-iotests/274
 create mode 100644 tests/qemu-iotests/274.out

--=20
2.20.1


