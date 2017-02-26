Received: from eggs.gnu.org ([2001:4830:134:3::10]:50195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ci7Vo-0004JF-4x
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 17:41:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ci7Vl-0002dS-0U
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 17:41:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42375)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ci7Vk-0002cg-OH
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 17:41:48 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1QMcfqN070106
	for <qemu-devel@nongnu.org>; Sun, 26 Feb 2017 17:41:40 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28u6xmuyvh-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 26 Feb 2017 17:41:40 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Sun, 26 Feb 2017 17:41:38 -0500
From: Greg Kurz <groug@kaod.org>
Date: Sun, 26 Feb 2017 23:41:32 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148814889214.28146.16915712763478774662.stgit@bahia>
Subject: [Qemu-devel] [PATCH v2 00/28] Series short description
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jann Horn <jannh@google.com>, Prasad J Pandit <prasad@redhat.com>, Greg Kurz <groug@kaod.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>

This series tries to fix CVE-2016-9602 reported by Jann Horn of Google
Project Zero:

https://bugzilla.redhat.com/show_bug.cgi?id=1413929

This vulnerability affects all accesses to the underlying filesystem in
the "local" backend code.

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

The right way to address this is to use "at" variants of all syscalls in
the "local" backend code. This requires to open directories without
traversing any symlink in the intermediate path elements. There was a
tentative to introduce an O_BENEATH flag for openat() that would address
this:

https://patchwork.kernel.org/patch/7007181/

Unfortunately this never got merged.  An alternative is to walk through all
path elements manually with openat(O_NOFOLLOW).

v2:
	- /proc based implementation for xattr code (fixes metadata perf drop
          observed with v1)
        - some code refactoring

Stefan.

I had to rework some patches you had already reviewed, please consider
giving your Reviewed-by again if the changes are ok.

Thanks.

--
Greg

---

Greg Kurz (28):
      9pfs: local: move xattr security ops to 9p-xattr.c
      9pfs: remove side-effects in local_init()
      9pfs: remove side-effects in local_open() and local_opendir()
      9pfs: introduce openat_nofollow() helper
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
 hw/9pfs/9p-posix-acl.c  |   44 --
 hw/9pfs/9p-util.c       |   65 +++
 hw/9pfs/9p-util.h       |   52 ++
 hw/9pfs/9p-xattr-user.c |   24 -
 hw/9pfs/9p-xattr.c      |  166 +++++++-
 hw/9pfs/9p-xattr.h      |   87 +---
 hw/9pfs/Makefile.objs   |    2 
 9 files changed, 887 insertions(+), 596 deletions(-)
 create mode 100644 hw/9pfs/9p-local.h
 create mode 100644 hw/9pfs/9p-util.c
 create mode 100644 hw/9pfs/9p-util.h
