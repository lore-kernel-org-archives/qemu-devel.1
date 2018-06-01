Received: from eggs.gnu.org ([2001:4830:134:3::10]:33150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fOYpy-0002YS-9l
	for qemu-devel@nongnu.org; Thu, 31 May 2018 21:26:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fOYpt-0001rT-8g
	for qemu-devel@nongnu.org; Thu, 31 May 2018 21:26:38 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:45410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fOYpt-0001qU-0m
	for qemu-devel@nongnu.org; Thu, 31 May 2018 21:26:33 -0400
Received: by mail-qk0-x241.google.com with SMTP id c198-v6so18723790qkg.12
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 18:26:32 -0700 (PDT)
From: Keno Fischer <keno@juliacomputing.com>
Date: Thu, 31 May 2018 21:25:55 -0400
Message-Id: <cover.1527814874.git.keno@juliacomputing.com>
Subject: [Qemu-devel] [PATCH v2 00/20] 9p: Add support for Darwin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Keno Fischer <keno@juliacomputing.com>, groug@kaod.org

This is v2 of my patch series to provide 9p server
support for Darwin.

The patches in this series address review from v1,
now support building the virtfs proxy, as well
as fix bugs found since v1.

Keno Fischer (20):
  cutils: Provide strchrnul
  9p: proxy: Fix size passed to `connect`
  9p: xattr: Fix crash due to free of uninitialized value
  9p: linux: Fix a couple Linux assumptions
  9p: Properly set errp in fstatfs error path
  9p: Avoid warning if FS_IOC_GETVERSION is not defined
  9p: Move a couple xattr functions to 9p-util
  9p: Rename 9p-util -> 9p-util-linux
  9p: Properly error check and translate flags in unlinkat
  9p: darwin: Handle struct stat(fs) differences
  9p: darwin: Handle struct dirent differences
  9p: darwin: Explicitly cast comparisons of mode_t with -1
  9p: darwin: Ignore O_{NOATIME, DIRECT}
  9p: darwin: Provide a compatibility definition for XATTR_SIZE_MAX
  9p: darwin: *xattr_nofollow implementations
  9p: darwin: Compatibility for f/l*xattr
  9p: darwin: Provide a fallback implementation for utimensat
  9p: darwin: Implement compatibility for mknodat
  9p: darwin: virtfs-proxy: Implement setuid code for darwin
  9p: darwin: configure: Allow VirtFS on Darwin

 Makefile                    |   6 ++
 Makefile.objs               |   1 +
 configure                   |  22 +++--
 fsdev/file-op-9p.h          |   2 +-
 fsdev/virtfs-proxy-helper.c | 230 ++++++++++++++++++++++++++++----------------
 hw/9pfs/9p-local.c          |  68 ++++++++-----
 hw/9pfs/9p-proxy.c          |  22 +++--
 hw/9pfs/9p-synth.c          |   4 +
 hw/9pfs/9p-util-darwin.c    | 185 +++++++++++++++++++++++++++++++++++
 hw/9pfs/9p-util-linux.c     |  70 ++++++++++++++
 hw/9pfs/9p-util.c           |  26 -----
 hw/9pfs/9p-util.h           |  31 ++++++
 hw/9pfs/9p-xattr.c          |  33 -------
 hw/9pfs/9p.c                |  86 +++++++++++++++--
 hw/9pfs/Makefile.objs       |   4 +-
 include/qemu/cutils.h       |   1 +
 include/qemu/statfs.h       |  19 ++++
 include/qemu/xattr.h        |   4 +-
 monitor.c                   |   8 +-
 util/cutils.c               |  13 +++
 util/qemu-option.c          |   6 +-
 util/uri.c                  |   6 +-
 22 files changed, 636 insertions(+), 211 deletions(-)
 create mode 100644 hw/9pfs/9p-util-darwin.c
 create mode 100644 hw/9pfs/9p-util-linux.c
 delete mode 100644 hw/9pfs/9p-util.c
 create mode 100644 include/qemu/statfs.h

-- 
2.8.1
