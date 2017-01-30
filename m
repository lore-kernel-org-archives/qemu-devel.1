Received: from eggs.gnu.org ([2001:4830:134:3::10]:45247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYAmI-0004EM-Oz
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:09:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYAmF-0008M6-Kx
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:09:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36661
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cYAmF-0008Lx-FH
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:09:43 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0UC8fos010535
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:09:42 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0b-001b2d01.pphosted.com with ESMTP id 289y2t5u24-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:09:41 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 30 Jan 2017 07:09:41 -0500
From: Greg Kurz <groug@kaod.org>
Date: Mon, 30 Jan 2017 13:09:36 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH RFC 00/36] 9pfs: local: fix vulnerability to
 symlink attacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ppandit@redhat.com, jannh@google.com, Eric Blake <eblake@redhat.com>, Greg Kurz <groug@kaod.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

This series tries to fix CVE-2016-9602. This vulnerability affects all
accesses to the underlying filesystem in the "local" backend code.

If QEMU is started with:

-fsdev local,security_model=<passthrough|none>,path=/foo/bar

then the guest can cause QEMU to create symlinks in /foo/bar.

This causes accesses to any path /foo/bar/some/path to be unsafe, since
untrusted code within the guest (or in another guest sharing the same
virtfs folder) could change some/path to point to a random path of the
host filesystem.

The core problem is that the "local" backend relies on path-based syscalls
to access the underlying filesystem. All path-based syscalls are vulnerable
to this issue, even open(O_NOFOLLOW) or syscalls that explicitly don't
dereference symlinks, since the kernel only checks the rightmost element of
the path. Depending on the privilege level of the QEMU process, a guest can
end up opening, renaming, changing ACLs, unlinking... files on the host
filesystem.

A possible fix is to always walk paths manually with openat(O_NOFOLLOW), and
use "*at()" variants of all syscalls in the "local" backend code. This will
likely not improve performances for path-based syscalls in the guest, but I
don't see how to fix the issue without kernel support (like an O_PATHSTATIC
flag to tell the full path should not traverse any symlink for example).

A fair amount of code is shared by all security models: this series hence
starts with preparatory patches to split the code. This allows to have
patches of reasonable size, that don't affect too many code paths.

TODO:
- the accesses to metadata files of the "mapped-file" security mode also need
  to be converted

---

Greg Kurz (36):
      9pfs: local: move xattr security ops to 9p-xattr.c
      9pfs: local: split chmod operation per security model
      9pfs: local: split mknod operation per security model
      9pfs: local: split mkdir operation per security model
      9pfs: local: split open2 operation per security model
      9pfs: local: split symlink operation per security model
      9pfs: local: split mkdir operation per security model
      9pfs: local: improve error handling in link op
      9pfs: local: post link operation for mapped-file security
      v9fs: local: improve error handling in rename op
      9pfs: local: post rename operation for mapped-file security
      9pfs: local: pre remove operation for mapped-file security
      9pfs: local: pre unlikat operation for mapped-file security
      9pfs: remove side-effects in local_init()
      9pfs: remove side-effects in local_open() and local_opendir()
      9pfs: introduce openat_nofollow() helper
      9pfs: local: keep a file descriptor on the shared folder
      9pfs: local: open/opendir: don't follow symlinks
      9pfs: local: utimensat: don't follow symlinks
      9pfs: local: readlink: don't follow symlinks
      9pfs: local: truncate: don't follow symlinks
      9pfs: local: statfs: don't follow symlinks
      9pfs: local: mknod/mkdir/open2: don't follow symlinks
      9pfs: local: chmod: don't follow symlinks
      9pfs: local: symlink: don't follow symlinks
      9pfs: local: chown: don't follow symlinks
      9pfs: local: link: don't follow symlinks
      9pfs: local: rename: don't follow symlinks
      9pfs: local: remove: don't follow symlinks
      9pfs: local: unlinkat: don't follow symlinks
      9pfs: local: introduce symlink-attack safe xattr helpers
      9pfs: local: lstat: don't follow symlinks
      9pfs: local: lgetxattr: don't follow symlinks
      9pfs: local: llistxattr: don't follow symlinks
      9pfs: local: lsetxattr: don't follow symlinks
      9pfs: local: lremovexattr: don't follow symlinks


 hw/9pfs/9p-local.c      | 1319 +++++++++++++++++++++++++++++++++--------------
 hw/9pfs/9p-local.h      |   22 +
 hw/9pfs/9p-posix-acl.c  |   48 --
 hw/9pfs/9p-util.c       |   69 ++
 hw/9pfs/9p-util.h       |   25 +
 hw/9pfs/9p-xattr-user.c |   28 -
 hw/9pfs/9p-xattr.c      |  229 ++++++++
 hw/9pfs/9p-xattr.h      |   91 +--
 hw/9pfs/Makefile.objs   |    2 
 9 files changed, 1306 insertions(+), 527 deletions(-)
 create mode 100644 hw/9pfs/9p-local.h
 create mode 100644 hw/9pfs/9p-util.c
 create mode 100644 hw/9pfs/9p-util.h

--
Greg
