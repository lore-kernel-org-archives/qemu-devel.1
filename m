Received: from eggs.gnu.org ([2001:4830:134:3::10]:52348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fDocy-0002A0-Uo
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:04:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fDocv-0008Ga-Oy
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:04:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60984 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fDocv-0008GB-KY
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:04:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 41B5781A88C4
	for <qemu-devel@nongnu.org>; Wed,  2 May 2018 10:04:41 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed,  2 May 2018 18:04:18 +0800
Message-Id: <20180502100422.8688-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v4 0/4] monitor: let Monitor be thread safe
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

 monitor.c | 132 ++++++++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 95 insertions(+), 37 deletions(-)

-- 
2.14.3
