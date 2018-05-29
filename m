Received: from eggs.gnu.org ([2001:4830:134:3::10]:58726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fNXe6-0004E8-Ih
	for qemu-devel@nongnu.org; Tue, 29 May 2018 01:58:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fNXe2-0001AI-KN
	for qemu-devel@nongnu.org; Tue, 29 May 2018 01:58:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45778 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fNXe2-0001A1-Fj
	for qemu-devel@nongnu.org; Tue, 29 May 2018 01:58:06 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C37FE4002248
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 05:58:05 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Tue, 29 May 2018 13:57:48 +0800
Message-Id: <20180529055755.12404-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v9 0/7] monitor: let Monitor be thread safe
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

v9:
- two more patches to implement Markus's idea to init monitor earlier
  (which are patch 5 & 6)
- touch up patch 7 to init the fdset lock in monitor_init_globals()

v8:
- some wording changes according to previous comments [Markus]
- return -ENOENT too in stubs/fdset.c:monitor_fdset_get_fd() [Stefan]
- refactor the fdset functions a bit, drop "ret" where proper [Markus]
- one more patch to fix monitor_lock comment [Markus]
- regular rebase and torturing

Stefan reported this problem that in the future we might start to have
more threads operating on the same Monitor object.  This seris try to
add fundamental support for it.

Please review.  Thanks,

Peter Xu (7):
  monitor: rename out_lock to mon_lock
  monitor: protect mon->fds with mon_lock
  monitor: more comments on lock-free elements
  monitor: fix comment for monitor_lock
  monitor: remove event_clock_type
  monitor: move init global earlier
  monitor: add lock to protect mon_fdsets

 monitor.c     | 164 ++++++++++++++++++++++++++++++++++----------------
 stubs/fdset.c |   2 +-
 util/osdep.c  |   3 +-
 vl.c          |   7 +--
 4 files changed, 117 insertions(+), 59 deletions(-)

-- 
2.17.0
