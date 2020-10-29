Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D10C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 17:21:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57E6C20759
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 17:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IDgtBHe/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57E6C20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYBca-0005zf-8p
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 13:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kYBZX-0000wm-87
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 13:18:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60467)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kYBZR-0003YU-EU
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 13:18:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603991920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=htnl3YCE9sRQfNTO8XIW8l1T9YrH9mIUBJqaFgB8tDI=;
 b=IDgtBHe/41cu3BpYCoW+4wcv4H/FiZzSFcV7dRA34Tstw17+edly45WFql0qPafSjxrlWc
 HB3oah7TuBk3/KToiJIr8J912CJspgFozUFHwoaHlJgMSiMXHgKqHXbSQVrsMEzD8tKP1h
 vVwzfo4C7JuhSrZfNr7axGm9jFMj7u0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-SWwFO5FZPyGg7kN16Fg6ZA-1; Thu, 29 Oct 2020 13:18:22 -0400
X-MC-Unique: SWwFO5FZPyGg7kN16Fg6ZA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2594804757
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 17:17:53 +0000 (UTC)
Received: from localhost (unknown [10.40.194.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 10A841002C03;
 Thu, 29 Oct 2020 17:17:46 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/7] virtiofsd: Announce submounts to the guest
Date: Thu, 29 Oct 2020 18:17:37 +0100
Message-Id: <20201029171744.150726-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
v1: https://lists.nongnu.org/archive/html/qemu-devel/2020-09/msg03598.html

Branch: https://github.com/XanClic/qemu.git virtiofs-submounts-v3
Branch: https://git.xanclic.moe/XanClic/qemu.git virtiofs-submounts-v3

Based-on: <160390309510.12234.8858324597971641979.stgit@gimli.home>
          (Alex’s pull request
          “VFIO updates 2020-10-28 (for QEMU 5.2 soft-freeze)”,
          notably the “linux-headers: update against 5.10-rc1” patch)


Hi,

We want to (be able to) announce the host mount structure of the shared
directory to the guest so it can replicate that structure.  This ensures
that whenever the combination of st_dev and st_ino is unique on the
host, it will be unique in the guest as well.

This feature is optional and needs to be enabled explicitly, so that the
mount structure isn’t leaked to the guest if the user doesn’t want it to
be.

The last patch in this series adds a test script.  For it to pass, you
need to compile a kernel that includes the “fuse: Mirror virtio-fs
submounts” patch series (e.g. 5.10-rc1), and provide it to the test (as
described in the test patch).


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


- You can mount a filesystem twice on the host, and then it will show
  the same st_dev for all files within both mounts.  However, the mounts
  are still distinct, so that if you e.g. mount another filesystem in
  one of the trees, it will not show up in the other.

  With this version of the series, both mounts will show up as different
  filesystems in the guest (i.e., both will have their own st_dev).
  That is because the guest receives no information to correlate
  different mounts; it just sees that some directory is a mount point,
  so it allocates a dedicated anonymous block device and uses it for
  that mounted filesystem, independently of what other submounts there
  may be.

  That means if a combination of st_dev+st_ino is unique in the guest,
  it may not be unique on the host.


v2:
- Switch from the FUSE_ATTR_FLAGS to the FUSE_SUBMOUNTS capability

- Include Miklos’s patch for using statx() to include the mount ID as an
  additional key for lo_inodes (besides st_dev and st_ino).

  On one hand, this fixes a bug where if you mount the same filesystem
  twice in the shared directory, virtiofsd used to see it as the exact
  same tree (so you couldn’t mount another filesystem in one of both
  trees, but not in the other -- in the guest, it would either appear in
  both or neither).  Now it sees both trees and all nodes within as
  separate.

  On the other, Miklos's patch allows us to simplify the submount
  detection a bit, because we don’t actually have to store every node
  parent’s st_dev.  It turns out that in all code that actually needs to
  check for submounts, we already have the parent lo_inode around and
  can just query its mount ID and st_dev.

  (While the code was pretty much taken from Miklos as he posted it
  (with minor adjustments), I didn’t add his S-o-b, because he didn’t
  give it.  I hope using Suggested-by, linking to his original mail, and
  CC-ing him on this series will suffice.)


git-backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/7:[down] 'virtiofsd: Check FUSE_SUBMOUNTS'
002/7:[0013] [FC] 'virtiofsd: Add attr_flags to fuse_entry_param'
003/7:[down] 'meson.build: Check for statx()'
004/7:[down] 'virtiofsd: Add mount ID to the lo_inode key'
005/7:[0077] [FC] 'virtiofsd: Announce sub-mount points'
006/7:[----] [--] 'tests/acceptance/boot_linux: Accept SSH pubkey'
007/7:[----] [--] 'tests/acceptance: Add virtiofs_submounts.py'


Max Reitz (7):
  virtiofsd: Check FUSE_SUBMOUNTS
  virtiofsd: Add attr_flags to fuse_entry_param
  meson.build: Check for statx()
  virtiofsd: Add mount ID to the lo_inode key
  virtiofsd: Announce sub-mount points
  tests/acceptance/boot_linux: Accept SSH pubkey
  tests/acceptance: Add virtiofs_submounts.py

 meson.build                                   |  16 +
 tools/virtiofsd/fuse_common.h                 |   7 +
 tools/virtiofsd/fuse_lowlevel.h               |   5 +
 tools/virtiofsd/fuse_lowlevel.c               |   5 +
 tools/virtiofsd/helper.c                      |   1 +
 tools/virtiofsd/passthrough_ll.c              | 117 ++++++-
 tools/virtiofsd/passthrough_seccomp.c         |   1 +
 tests/acceptance/boot_linux.py                |  13 +-
 tests/acceptance/virtiofs_submounts.py        | 289 ++++++++++++++++++
 .../virtiofs_submounts.py.data/cleanup.sh     |  46 +++
 .../guest-cleanup.sh                          |  30 ++
 .../virtiofs_submounts.py.data/guest.sh       | 138 +++++++++
 .../virtiofs_submounts.py.data/host.sh        | 127 ++++++++
 13 files changed, 779 insertions(+), 16 deletions(-)
 create mode 100644 tests/acceptance/virtiofs_submounts.py
 create mode 100644 tests/acceptance/virtiofs_submounts.py.data/cleanup.sh
 create mode 100644 tests/acceptance/virtiofs_submounts.py.data/guest-cleanup.sh
 create mode 100644 tests/acceptance/virtiofs_submounts.py.data/guest.sh
 create mode 100644 tests/acceptance/virtiofs_submounts.py.data/host.sh

-- 
2.26.2


