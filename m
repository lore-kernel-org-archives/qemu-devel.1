Received: from eggs.gnu.org ([2001:4830:134:3::10]:35504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fNCRr-00014y-CC
	for qemu-devel@nongnu.org; Mon, 28 May 2018 03:20:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fNCRo-0003Vo-4u
	for qemu-devel@nongnu.org; Mon, 28 May 2018 03:20:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40644 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fNCRn-0003VR-Vx
	for qemu-devel@nongnu.org; Mon, 28 May 2018 03:20:04 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 91255400E9BA
	for <qemu-devel@nongnu.org>; Mon, 28 May 2018 07:20:03 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 28 May 2018 15:19:53 +0800
Message-Id: <20180528071958.17053-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v8 0/5] monitor: let Monitor be thread safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

v8:
- some wording changes according to previous comments [Markus]
- return -ENOENT too in stubs/fdset.c:monitor_fdset_get_fd() [Stefan]
- refactor the fdset functions a bit, drop "ret" where proper [Markus]
- one more patch to fix monitor_lock comment [Markus]
- regular rebase and torturing

v7:
- let monitor_fdset_get_fd() return -errno, touch up qemu_open() to
  translate that into errno.  [Markus]
- touch up comment for Monitor.rs
- rebase, and torture the code a bit with qtest.

v6:
- add/drop some r-bs
- address all the comments from Markus
- rebase, and run some simple qtests to make sure nothing breaks

v5:
- collect r-bs and rebase
- move two close()s outside critical section [Dave]
- move comment to end of line [Stefan]

v4:
- fix a s/cur_mon/mon/ typo

v3:
- add comment for fields that are protected by monitor lock [Stefan]
- drop most of patch 2, only keep the protections for mon->fds [Stefan]
- add one trivial patch to add some more comments for either readline
  and cpu_get/cpu_set [Stefan]
- add protection for monitor_fdset_get_fd() [Stefan]

v2:
- cc correct people... sorry.

Stefan reported this problem that in the future we might start to have
more threads operating on the same Monitor object.  This seris try to
add fundamental support for it.

Please review.  Thanks,

Peter Xu (5):
  monitor: rename out_lock to mon_lock
  monitor: protect mon->fds with mon_lock
  monitor: more comments on lock-free elements
  monitor: fix comment for monitor_lock
  monitor: add lock to protect mon_fdsets

 monitor.c     | 152 ++++++++++++++++++++++++++++++++++++--------------
 stubs/fdset.c |   2 +-
 util/osdep.c  |   3 +-
 3 files changed, 113 insertions(+), 44 deletions(-)

-- 
2.17.0
