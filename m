Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7B6C4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 09:55:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2C1621906
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 09:55:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2C1621906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAWfw-0003pg-7r
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 05:55:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59165)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iAWd2-00013D-On
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 05:52:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iAWcy-0005X3-W6
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 05:52:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58676)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iAWcq-0005T2-EC; Wed, 18 Sep 2019 05:51:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1E79D2026F;
 Wed, 18 Sep 2019 09:51:50 +0000 (UTC)
Received: from localhost (ovpn-116-168.ams2.redhat.com [10.36.116.168])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9ADAD5C21E;
 Wed, 18 Sep 2019 09:51:46 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed, 18 Sep 2019 11:51:36 +0200
Message-Id: <20190918095144.955-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Wed, 18 Sep 2019 09:51:50 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/8] block: Add @exact parameter to
 bdrv_co_truncate()
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-devel@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This series is supposed to pull out some of the problems from my
=E2=80=9CGeneric file creation fallback=E2=80=9D series.

The blk_truncate_for_formatting() function added there was buggy, as
Maxim noted, in that it did not check whether blk_truncate() actually
resized the block node to the target offset.  One way to fix this is to
add a parameter to it that forces the block driver to do so, and that is
done by this series.

I think this is generally useful (you can see the diff stat saldo is
only +23 lines), because it allows us to drop a special check in
qemu-img resize, and it fixes a bug in qed (which has relied on this
behavior for over 8 years, but unfortunately bdrv_truncate()=E2=80=99s be=
havior
changed quite exactly 8 years ago).

However, in the process I noticed we actually don=E2=80=99t need
blk_truncate_for_formatting(): The underlying problem is that some
format drivers truncate their underlying file node to 0 before
formatting it to drop all data.  So they should pass exact=3Dtrue, but
they cannot, because this would break creation on block devices.  Hence
blk_truncate_for_formatting().

It turns out, though, that three of the four drivers in question don=E2=80=
=99t
need to truncate their file node at all.  The remaining one is qed which
simply really should pass exact=3Dtrue (it=E2=80=99s a bug fix).

(I do drop those blk_truncate() invocations in this series, because
otherwise I feel like it is impossible to decide whether they should get
exact=3Dfalse or exact=3Dtrue.  Either way is wrong.)


Max Reitz (8):
  block: Handle filter truncation like native impl.
  block/cor: Drop cor_co_truncate()
  block: Do not truncate file node when formatting
  block: Add @exact parameter to bdrv_co_truncate()
  block: Evaluate @exact in protocol drivers
  block: Let format drivers pass @exact
  block: Pass truncate exact=3Dtrue where reasonable
  Revert "qemu-img: Check post-truncation size"

 include/block/block.h          |  6 ++---
 include/block/block_int.h      | 17 ++++++++++++-
 include/sysemu/block-backend.h |  4 +--
 block/block-backend.c          |  6 ++---
 block/commit.c                 |  5 ++--
 block/copy-on-read.c           |  8 ------
 block/crypto.c                 |  8 +++---
 block/file-posix.c             | 11 ++++++--
 block/file-win32.c             |  3 ++-
 block/gluster.c                |  1 +
 block/io.c                     | 29 ++++++++++++---------
 block/iscsi.c                  | 10 ++++++--
 block/mirror.c                 |  4 +--
 block/nfs.c                    |  2 +-
 block/parallels.c              | 18 +++++++------
 block/qcow.c                   |  9 ++-----
 block/qcow2-refcount.c         |  2 +-
 block/qcow2.c                  | 45 +++++++++++++++++++++------------
 block/qed.c                    |  3 ++-
 block/raw-format.c             |  5 ++--
 block/rbd.c                    |  1 +
 block/sheepdog.c               |  5 ++--
 block/ssh.c                    |  3 ++-
 block/vdi.c                    |  2 +-
 block/vhdx-log.c               |  4 +--
 block/vhdx.c                   |  7 +++---
 block/vmdk.c                   |  8 +++---
 block/vpc.c                    |  2 +-
 blockdev.c                     |  2 +-
 qemu-img.c                     | 46 ++++++++--------------------------
 qemu-io-cmds.c                 |  7 +++++-
 tests/test-block-iothread.c    |  8 +++---
 32 files changed, 157 insertions(+), 134 deletions(-)

--=20
2.21.0


