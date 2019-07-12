Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADA9C742D1
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 17:36:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8FE920665
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 17:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8FE920665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlzTB-00070d-OB
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 13:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39652)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hlzSp-00069W-PD
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:36:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hlzSo-00048z-MJ
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:36:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48596)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hlzSm-00043i-51; Fri, 12 Jul 2019 13:36:04 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C812330BC591;
 Fri, 12 Jul 2019 17:36:02 +0000 (UTC)
Received: from localhost (unknown [10.40.205.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6160460A9A;
 Fri, 12 Jul 2019 17:36:02 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 12 Jul 2019 19:35:53 +0200
Message-Id: <20190712173600.14554-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 12 Jul 2019 17:36:02 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/7] block: Generic file creation fallback
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Kevin commented on my RFC, so I got what an RFC wants, and he didn=E2=80=99=
t
object to the creation fallback part.  So I suppose I can go down that
route at least.  (Which was actually the more important part of the
series.)

So as in the RFC, this series adds a fallback path for creating files
(on the protocol layer) if the protocol driver does not support file
creation, but the file already exists.


v1 (as compared to the RFC):
- Changed patch 1 to match Kevin=E2=80=99s proposal
- Added patches 2 and 3 to replace the truncation fallback
- Changed patch 4 accordingly
- Added patches 5 and 6
- Truncated patch 7 (haha!), because there no longer is a truncation
  fallback, so we cannot test it.

I would like to note that the diff stat without patches 1 and 7 is
141+, 139-.  So this series is basically a net zero for our code size,
but it prevents future series that might add such pseudo-creation
support to other drivers but file-posix (for host devices) and iscsi
(e.g. I=E2=80=99m looking at you, nvme).


git-backport-diff against the RFC:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/7:[0016] [FC] 'block/nbd: Fix hang in .bdrv_close()'
002/7:[down] 'block: Add blk_truncate_for_formatting()'
003/7:[down] 'block: Use blk_truncate_for_formatting()'
004/7:[0012] [FC] 'block: Generic file creation fallback'
005/7:[down] 'file-posix: Drop hdev_co_create_opts()'
006/7:[down] 'iscsi: Drop iscsi_co_create_opts()'
007/7:[down] 'iotests: Add test for image creation fallback'


Max Reitz (7):
  block/nbd: Fix hang in .bdrv_close()
  block: Add blk_truncate_for_formatting()
  block: Use blk_truncate_for_formatting()
  block: Generic file creation fallback
  file-posix: Drop hdev_co_create_opts()
  iscsi: Drop iscsi_co_create_opts()
  iotests: Add test for image creation fallback

 include/sysemu/block-backend.h | 12 +++++
 block.c                        | 83 +++++++++++++++++++++++++++++-----
 block/block-backend.c          | 54 ++++++++++++++++++++++
 block/file-posix.c             | 67 ---------------------------
 block/iscsi.c                  | 56 -----------------------
 block/nbd.c                    | 14 +++++-
 block/parallels.c              |  2 +-
 block/qcow.c                   |  2 +-
 block/qcow2.c                  |  2 +-
 block/qed.c                    |  2 +-
 tests/qemu-iotests/259         | 61 +++++++++++++++++++++++++
 tests/qemu-iotests/259.out     | 14 ++++++
 tests/qemu-iotests/group       |  1 +
 13 files changed, 230 insertions(+), 140 deletions(-)
 create mode 100755 tests/qemu-iotests/259
 create mode 100644 tests/qemu-iotests/259.out

--=20
2.21.0


