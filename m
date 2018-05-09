Received: from eggs.gnu.org ([2001:4830:134:3::10]:34809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fGGY3-0006wf-JR
	for qemu-devel@nongnu.org; Wed, 09 May 2018 00:17:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fGGXz-0002dT-Ki
	for qemu-devel@nongnu.org; Wed, 09 May 2018 00:17:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43622 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fGGXz-0002ca-H1
	for qemu-devel@nongnu.org; Wed, 09 May 2018 00:17:47 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 15630406C74A
	for <qemu-devel@nongnu.org>; Wed,  9 May 2018 04:17:47 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed,  9 May 2018 12:17:30 +0800
Message-Id: <20180509041734.14135-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v5 0/4] monitor: let Monitor be thread safe
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

Peter Xu (4):
  monitor: rename out_lock to mon_lock
  monitor: protect mon->fds with mon_lock
  monitor: more comments on lock-free fleids/funcs
  monitor: add lock to protect mon_fdsets

 monitor.c | 144 ++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 103 insertions(+), 41 deletions(-)

-- 
2.17.0
