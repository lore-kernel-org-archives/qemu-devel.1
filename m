Received: from eggs.gnu.org ([2001:4830:134:3::10]:37487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cif3a-00018B-TK
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:31:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cif3X-0007uI-Pd
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:30:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33738)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cif3X-0007t1-Fz
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:30:55 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1SAShA6138667
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 05:30:53 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28w1xnxh18-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 05:30:53 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 28 Feb 2017 10:30:50 -0000
From: Greg Kurz <groug@kaod.org>
Date: Tue, 28 Feb 2017 11:30:12 +0100
Message-Id: <1488277840-18608-1-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 00/28] 9p CVE-2016-9602 fixes 2017-02-28 for 2.9
 soft freeze
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

The following changes since commit 9b9fbe8a4e9eec9072ee2697a6af59144442785f:

  Merge remote-tracking branch 'remotes/kraxel/tags/pull-ui-20170227-1' into staging (2017-02-27 19:19:46 +0000)

are available in the git repository at:

  https://github.com/gkurz/qemu.git tags/cve-2016-9602-for-upstream

for you to fetch changes up to c23d5f1d5bc0e23aeb845b1af8f996f16783ce98:

  9pfs: local: drop unused code (2017-02-28 11:21:15 +0100)

----------------------------------------------------------------
This pull request have all the fixes for CVE-2016-9602, so that it can
be easily picked up by downstreams, as suggested by Michel Tokarev.

----------------------------------------------------------------
Greg Kurz (28):
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

 hw/9pfs/9p-local.c      | 1023 ++++++++++++++++++++++++++---------------------
 hw/9pfs/9p-local.h      |   20 +
 hw/9pfs/9p-posix-acl.c  |   44 +-
 hw/9pfs/9p-util.c       |   69 ++++
 hw/9pfs/9p-util.h       |   54 +++
 hw/9pfs/9p-xattr-user.c |   24 +-
 hw/9pfs/9p-xattr.c      |  166 +++++++-
 hw/9pfs/9p-xattr.h      |   87 +---
 hw/9pfs/Makefile.objs   |    2 +-
 9 files changed, 893 insertions(+), 596 deletions(-)
 create mode 100644 hw/9pfs/9p-local.h
 create mode 100644 hw/9pfs/9p-util.c
 create mode 100644 hw/9pfs/9p-util.h
-- 
2.7.4
