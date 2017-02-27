Received: from eggs.gnu.org ([2001:4830:134:3::10]:46763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ciUHi-0000Ur-An
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:00:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ciUHf-0003s5-6D
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:00:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44676)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ciUHe-0003mB-Tj
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 18:00:47 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1RMtfeY142288
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 18:00:38 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28vjd4py93-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 18:00:38 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 27 Feb 2017 23:00:36 -0000
From: Greg Kurz <groug@kaod.org>
Date: Mon, 27 Feb 2017 23:59:50 +0100
Message-Id: <1488236421-30983-1-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 00/31] 9p patches 2017-02-27 for 2.9 soft freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>

The following changes since commit 8f2d7c341184a95d05476ea3c45dbae2b9ddbe51:

  Merge remote-tracking branch 'remotes/berrange/tags/pull-qcrypto-2017-02-27-1' into staging (2017-02-27 15:33:21 +0000)

are available in the git repository at:

  https://github.com/gkurz/qemu.git tags/for-upstream

for you to fetch changes up to a07ef65e3aeac852188331708716792930d819ef:

  9pfs: local: drop unused code (2017-02-27 22:45:17 +0100)

----------------------------------------------------------------
This pull request brings:
- a fix to a minor bug reported by Coverity
- throttling support in the local backend (command line only)
- a huge fix for CVE-2016-9602 (symlink attack vulnerability)

----------------------------------------------------------------
Greg Kurz (29):
      fsdev: add IO throttle support to fsdev devices
      9pfs: local: move xattr security ops to 9p-xattr.c
      9pfs: remove side-effects in local_init()
      9pfs: remove side-effects in local_open() and local_opendir()
      9pfs: introduce relative_openat_nofollow() helper
      9pfs: local: keep a file descriptor on the shared folder
      9pfs: local: open/opendir: don't follow symlinks
      9pfs: local: lgetxattr: don't follow symlinks
      9pfs: local: llistxattr: don't follow symlinks
      9pfs: local: lsetxattr: don't follow symlinks
      9pfs: local: lremovexattr: don't follow symlinks
      9pfs: local: unlinkat: don't follow symlinks
      9pfs: local: remove: don't follow symlinks
      9pfs: local: utimensat: don't follow symlinks
      9pfs: local: statfs: don't follow symlinks
      9pfs: local: truncate: don't follow symlinks
      9pfs: local: readlink: don't follow symlinks
      9pfs: local: lstat: don't follow symlinks
      9pfs: local: renameat: don't follow symlinks
      9pfs: local: rename: use renameat
      9pfs: local: improve error handling in link op
      9pfs: local: link: don't follow symlinks
      9pfs: local: chmod: don't follow symlinks
      9pfs: local: chown: don't follow symlinks
      9pfs: local: symlink: don't follow symlinks
      9pfs: local: mknod: don't follow symlinks
      9pfs: local: mkdir: don't follow symlinks
      9pfs: local: open2: don't follow symlinks
      9pfs: local: drop unused code

Paolo Bonzini (1):
      9pfs: fix v9fs_lock error case

Pradeep (1):
      throttle: factor out duplicate code

 blockdev.c                      |   83 +---
 fsdev/Makefile.objs             |    2 +-
 fsdev/file-op-9p.h              |    3 +
 fsdev/qemu-fsdev-opts.c         |    3 +
 fsdev/qemu-fsdev-throttle.c     |  118 +++++
 fsdev/qemu-fsdev-throttle.h     |   39 ++
 hw/9pfs/9p-local.c              | 1031 +++++++++++++++++++++------------------
 hw/9pfs/9p-local.h              |   20 +
 hw/9pfs/9p-posix-acl.c          |   44 +-
 hw/9pfs/9p-util.c               |   68 +++
 hw/9pfs/9p-util.h               |   53 ++
 hw/9pfs/9p-xattr-user.c         |   24 +-
 hw/9pfs/9p-xattr.c              |  166 ++++++-
 hw/9pfs/9p-xattr.h              |   87 +---
 hw/9pfs/9p.c                    |   19 +-
 hw/9pfs/Makefile.objs           |    2 +-
 hw/9pfs/cofile.c                |    2 +
 include/qemu/throttle-options.h |   92 ++++
 qemu-options.hx                 |    7 +-
 19 files changed, 1180 insertions(+), 683 deletions(-)
 create mode 100644 fsdev/qemu-fsdev-throttle.c
 create mode 100644 fsdev/qemu-fsdev-throttle.h
 create mode 100644 hw/9pfs/9p-local.h
 create mode 100644 hw/9pfs/9p-util.c
 create mode 100644 hw/9pfs/9p-util.h
 create mode 100644 include/qemu/throttle-options.h
-- 
2.7.4
