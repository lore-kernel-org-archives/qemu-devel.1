Received: from eggs.gnu.org ([2001:4830:134:3::10]:49133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1cz16g-0007QX-U0
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 09:17:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1cz16d-0008DD-OX
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 09:17:46 -0400
Received: from mailout4.w1.samsung.com ([210.118.77.14]:11705)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1cz16d-0008C9-Im
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 09:17:43 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout4.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OOE00BORI9DRT00@mailout4.w1.samsung.com> for
	qemu-devel@nongnu.org; Fri, 14 Apr 2017 14:17:37 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Fri, 14 Apr 2017 16:17:14 +0300
Message-id: <1492175840-5021-1-git-send-email-a.perevalov@samsung.com>
References: <CGME20170414131735eucas1p21f1fcadf426789276f567191372f7794@eucas1p2.samsung.com>
Subject: [Qemu-devel] [PATCH 0/6] calculate downtime for postcopy live
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com, qemu-devel@nongnu.org
Cc: a.perevalov@samsung.com, i.maximets@samsung.com

This patch set includes downtime calculation on destination,
sending it to source machine for statistics (query-migration).

Also additional traceses here for track down who was pagefault
initiator.

This patch set is based on master branch of git://git.qemu-project.org/qemu.git
base commit is commit 372b3fe0b2ecdd39ba850e31c0c6686315c507af.

It contains kernel side pages, just for convinience of applying current patch set,
for testing util kernel headers arn't synced.

Alexey Perevalov (6):
  userfault: add pid into uffd_msg & update UFFD_FEATURE_*
  util: introduce glib-helper.c
  migration: add UFFD_FEATURE_THREAD_ID feature support
  migration: calculate downtime on dst side
  migration: send postcopy downtime back to source
  migration: detailed traces for postcopy

 hw/block/xen_disk.c               |  10 +-
 include/glib-compat.h             | 352 --------------------------------------
 include/glib/glib-compat.h        | 352 ++++++++++++++++++++++++++++++++++++++
 include/glib/glib-helper.h        |  30 ++++
 include/migration/migration.h     |  18 +-
 include/migration/postcopy-ram.h  |   2 +-
 include/qemu/osdep.h              |   2 +-
 linux-headers/linux/userfaultfd.h |   5 +
 linux-user/main.c                 |   2 +-
 migration/migration.c             | 302 +++++++++++++++++++++++++++++++-
 migration/postcopy-ram.c          | 133 +++++++++++++-
 migration/qemu-file.c             |   1 -
 migration/savevm.c                |   2 +-
 migration/trace-events            |  15 +-
 scripts/clean-includes            |   2 +-
 util/Makefile.objs                |   1 +
 util/glib-helper.c                |  29 ++++
 17 files changed, 878 insertions(+), 380 deletions(-)
 delete mode 100644 include/glib-compat.h
 create mode 100644 include/glib/glib-compat.h
 create mode 100644 include/glib/glib-helper.h
 create mode 100644 util/glib-helper.c

-- 
1.8.3.1
