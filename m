Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBA4C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 17:50:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2C4B214D8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 17:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h112lvmA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2C4B214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixaRI-00031Q-1Y
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 12:50:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41447)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1ixaLe-0002tg-Pb
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:44:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1ixaLd-0004WH-I6
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:44:54 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32497
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ixaLd-0004Vm-EC
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:44:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580492693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OWuBJrCDI7xTRzpXC70WCHo60lyzDCMfSvd7HoDdn5Y=;
 b=h112lvmArx6QHhPvtmzwwpw7JT+ba4PoRmrkskgi8CpeSky0dEt5C34ccWBJq8FkYeiYtD
 ebaT8WAcjAIQXzsOP9l8y5ChN7QkWEaHFCCrmJdoHXv7bxQgRafZLfz6blO+3MVqxq11Fi
 agh9GnE66m8oSYplvxeqrKdKuDVcH0A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-nuISxwZtOB2vcaB8LA3mGQ-1; Fri, 31 Jan 2020 12:44:38 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B7DD800D48;
 Fri, 31 Jan 2020 17:44:37 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9AC347FB60;
 Fri, 31 Jan 2020 17:44:36 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/17] Improve qcow2 all-zero detection
Date: Fri, 31 Jan 2020 11:44:19 -0600
Message-Id: <20200131174436.2961874-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: nuISxwZtOB2vcaB8LA3mGQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: david.edmondson@oracle.com, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Based-on: <20200124103458.1525982-2-david.edmondson@oracle.com>
([PATCH v2 1/2] qemu-img: Add --target-is-zero to convert)

I'm working on adding an NBD extension that reports whether an image
is already all zero when the client first connects.  I initially
thought I could write the NBD code to just call bdrv_has_zero_init(),
but that turned out to be a bad assumption that instead resulted in
this patch series.  The NBD patch will come later (and cross-posted to
the NBD protocol, libnbd, nbdkit, and qemu, as it will affect all four
repositories).

I do have an RFC question on patch 13 - as implemented here, I set a
qcow2 bit if the image has all clusters known zero and no backing
image.  But it may be more useful to instead report whether all
clusters _allocated in this layer_ are zero, at which point the
overall image is all-zero only if the backing file also has that
property (or even make it two bits).  The tweaks to subsequent patches
based on what we think makes the most useful semantics shouldn't be
hard.

[repo.or.cz appears to be down as I type this; I'll post a link to a
repository later when it comes back up]

Eric Blake (17):
  qcow2: Comment typo fixes
  qcow2: List autoclear bit names in header
  qcow2: Avoid feature name extension on small cluster size
  block: Improve documentation of .bdrv_has_zero_init
  block: Don't advertise zero_init_truncate with encryption
  block: Improve bdrv_has_zero_init_truncate with backing file
  gluster: Drop useless has_zero_init callback
  sheepdog: Consistently set bdrv_has_zero_init_truncate
  block: Refactor bdrv_has_zero_init{,_truncate}
  block: Add new BDRV_ZERO_OPEN flag
  file-posix: Support BDRV_ZERO_OPEN
  gluster: Support BDRV_ZERO_OPEN
  qcow2: Add new autoclear feature for all zero image
  qcow2: Expose all zero bit through .bdrv_known_zeroes
  qcow2: Implement all-zero autoclear bit
  iotests: Add new test for qcow2 all-zero bit
  qcow2: Let qemu-img check cover all-zero bit

 block.c                    |  62 +++++----
 block/file-posix.c         |  16 ++-
 block/file-win32.c         |   3 +-
 block/gluster.c            |  34 +++--
 block/nfs.c                |   7 +-
 block/parallels.c          |   4 +-
 block/qcow.c               |   2 +-
 block/qcow2-refcount.c     |  60 +++++++-
 block/qcow2-snapshot.c     |  11 ++
 block/qcow2.c              | 150 +++++++++++++++++---
 block/qcow2.h              |   6 +-
 block/qed.c                |   3 +-
 block/raw-format.c         |  12 +-
 block/rbd.c                |   3 +-
 block/sheepdog.c           |   7 +-
 block/ssh.c                |   7 +-
 block/vdi.c                |   8 +-
 block/vhdx.c               |  16 +--
 block/vmdk.c               |   9 +-
 block/vpc.c                |   8 +-
 blockdev.c                 |   2 +-
 docs/interop/qcow2.txt     |  15 +-
 include/block/block.h      |  38 ++++-
 include/block/block_int.h  |  14 +-
 qapi/block-core.json       |   4 +
 qemu-img.c                 |   9 +-
 tests/qemu-iotests/031.out |  14 +-
 tests/qemu-iotests/036     |   6 +-
 tests/qemu-iotests/036.out |  10 +-
 tests/qemu-iotests/060.out |   6 +-
 tests/qemu-iotests/061     |   6 +-
 tests/qemu-iotests/061.out |  26 ++--
 tests/qemu-iotests/065     |  12 +-
 tests/qemu-iotests/082.out |   7 +
 tests/qemu-iotests/122     |   2 +-
 tests/qemu-iotests/188     |   2 +-
 tests/qemu-iotests/188.out |   2 +-
 tests/qemu-iotests/206.out |   4 +
 tests/qemu-iotests/242.out |   1 +
 tests/qemu-iotests/285     | 124 +++++++++++++++++
 tests/qemu-iotests/285.out | 277 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 42 files changed, 832 insertions(+), 178 deletions(-)
 create mode 100755 tests/qemu-iotests/285
 create mode 100644 tests/qemu-iotests/285.out

--=20
2.24.1


