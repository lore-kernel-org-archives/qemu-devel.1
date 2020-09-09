Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803D0C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 18:42:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D645F2080C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 18:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AV0xDeBQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D645F2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG52x-00076j-1K
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 14:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kG51m-0005pb-FJ
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 14:41:06 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26891
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kG51k-0007PK-1y
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 14:41:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599676863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9cAT//7j2Y8jfX8iNL9T3RYOCu0eNGOXi5z5qtt0GxE=;
 b=AV0xDeBQhKVq9XCFRnfksoaYh4feWay8fHZelXZ4KwQjqSNwAeYILHu7DP2LGkpYd/bMlq
 2aqoMLtxc4UupyxCTG6xo1lT9aSgo0Y8k9x7vzJdY/4wLP6TtU6EWbSCUl4XfLom5zQKIe
 2ZSid8Xdb3XsZG3EPmg4FyCzNiSF2cU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-WKHTp7v_Plu76ovZjasXUA-1; Wed, 09 Sep 2020 14:40:36 -0400
X-MC-Unique: WKHTp7v_Plu76ovZjasXUA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0C3A8015AA
 for <qemu-devel@nongnu.org>; Wed,  9 Sep 2020 18:40:35 +0000 (UTC)
Received: from localhost (ovpn-113-94.ams2.redhat.com [10.36.113.94])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EC0BE5D9E8;
 Wed,  9 Sep 2020 18:40:29 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/8] virtiofsd: Announce submounts to the guest
Date: Wed,  9 Sep 2020 20:40:20 +0200
Message-Id: <20200909184028.262297-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 14:15:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: virtio-fs@redhat.com, Miklos Szeredi <mszeredi@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RFC: https://www.redhat.com/archives/virtio-fs/2020-May/msg00024.html

Branch: https://github.com/XanClic/qemu.git virtiofs-submounts-v2
Branch: https://git.xanclic.moe/XanClic/qemu.git virtiofs-submounts-v2


(Note that there is an accompanying Linux (kernel) series
“fuse: Mirror virtio-fs submounts”.)


Hi,

We want to (be able to) announce the host mount structure of the shared
directory to the guest so it can replicate that structure.  This ensures
that whenever the combination of st_dev and st_ino is unique on the
host, it will be unique in the guest as well.

This feature is optional and needs to be enabled explicitly, so that the
mount structure isn’t leaked to the guest if the user doesn’t want it to
be.

The last patch in this series adds a test script.  For it to pass, you
need to compile a kernel with the accompanying “fuse: Mirror virtio-fs
submounts” patch series, and provide it to the test (as described in the
test patch).


Known caveats:
- stat(2) doesn’t trigger auto-mounting.  Therefore, issuing a stat() on
  a sub-mountpoint before it’s been auto-mounted will show its parent’s
  st_dev together with the st_ino it has in the sub-mounted filesystem.

  For example, imagine you want to share a whole filesystem with the
  guest, which on the host first looks like this:

    root/           (st_dev=64, st_ino=128)
      sub_fs/       (st_dev=64, st_ino=234)

  And then you mount another filesystem under sub_fs, so it looks like
  this:

    root/           (st_dev=64, st_ino=128)
      sub_fs/       (st_dev=96, st_ino=128)
        ...

  As you can see, sub_fs becomes a mount point, so its st_dev and st_ino
  change from what they were on root’s filesystem to what they are in
  the sub-filesystem.  In fact, root and sub_fs now have the same
  st_ino, which is not unlikely given that both are root nodes in their
  respective filesystems.

  Now, this filesystem is shared with the guest through virtiofsd.
  There is no way for virtiofsd to uncover sub_fs’s original st_ino
  value of 234, so it will always provide st_ino=128 to the guest.
  However, virtiofsd does notice that sub_fs is a mount point and
  announces this fact to the guest.

  We want this to result in something like the following tree in the
  guest:

    root/           (st_dev=32, st_ino=128)
      sub_fs/       (st_dev=33, st_ino=128)
        ...

  That is, sub_fs should be a different filesystem that’s auto-mounted.
  However, as stated above, stat(2) doesn’t trigger auto-mounting, so
  before it happens, the following structure will be visible:

    root/           (st_dev=32, st_ino=128)
      sub_fs/       (st_dev=32, st_ino=128)

  That is, sub_fs and root will have the same st_dev/st_ino combination.

  This can easily be seen by executing find(1) on root in the guest,
  which will subsequently complain about an alleged filesystem loop.

  To properly fix this problem, we probably would have to be able to
  uncover sub_fs’s original st_ino value (i.e. 234) and let the guest
  use that until the auto-mount happens.  However, there is no way to
  get that value (from userspace at least).

  Note that NFS with crossmnt has the exact same issue.


- You can unmount auto-mounted submounts in the guest, but then you
  still cannot unmount them on the host.  The guest still holds a
  reference to the submount’s root directory, because that’s just a
  normal entry in its parent directory (on the submount’s parent
  filesystem).

  This is kind of related to the issue noted above: When the submount is
  unmounted, the guest shouldn’t have a reference to sub_fs as the
  submount’s root directory (host’s st_dev=96, st_ino=128), but to it as
  a normal entry in its parent filesystem (st_dev=64, st_ino=234).

  (When you have multiple nesting levels, you can unmount inner mounts
  when the outer ones have been unmounted in the guest.  For example,
  say you have a structure A/B/C/D, where each is a mount point, then
  unmounting D, C, and B in the guest will allow the host to unmount D
  and C.)


Max Reitz (8):
  linux/fuse.h: Pull in from Linux
  virtiofsd: Announce FUSE_ATTR_FLAGS
  virtiofsd: Add attr_flags to fuse_entry_param
  virtiofsd: Add fuse_reply_attr_with_flags()
  virtiofsd: Store every lo_inode's parent_dev
  virtiofsd: Announce sub-mount points
  tests/acceptance/boot_linux: Accept SSH pubkey
  tests/acceptance: Add virtiofs_submounts.py

 include/standard-headers/linux/fuse.h         |  11 +-
 tools/virtiofsd/fuse_common.h                 |   8 +
 tools/virtiofsd/fuse_lowlevel.h               |  20 ++
 tools/virtiofsd/fuse_lowlevel.c               |  34 ++-
 tools/virtiofsd/helper.c                      |   1 +
 tools/virtiofsd/passthrough_ll.c              |  84 ++++-
 tests/acceptance/boot_linux.py                |  13 +-
 tests/acceptance/virtiofs_submounts.py        | 289 ++++++++++++++++++
 .../virtiofs_submounts.py.data/cleanup.sh     |  46 +++
 .../guest-cleanup.sh                          |  30 ++
 .../virtiofs_submounts.py.data/guest.sh       | 138 +++++++++
 .../virtiofs_submounts.py.data/host.sh        | 127 ++++++++
 12 files changed, 780 insertions(+), 21 deletions(-)
 create mode 100644 tests/acceptance/virtiofs_submounts.py
 create mode 100644 tests/acceptance/virtiofs_submounts.py.data/cleanup.sh
 create mode 100644 tests/acceptance/virtiofs_submounts.py.data/guest-cleanup.sh
 create mode 100644 tests/acceptance/virtiofs_submounts.py.data/guest.sh
 create mode 100644 tests/acceptance/virtiofs_submounts.py.data/host.sh

-- 
2.26.2


