Received: from eggs.gnu.org ([2001:4830:134:3::10]:56338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f8izQ-0000Qg-Fr
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 05:02:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f8izM-0005uK-4W
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 05:02:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35336 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f8izM-0005u5-0d
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 05:02:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 170E9406E8C3
	for <qemu-devel@nongnu.org>; Wed, 18 Apr 2018 09:02:44 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed, 18 Apr 2018 17:02:36 +0800
Message-Id: <20180418090239.13090-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/3] monitor: let Monitor be thread safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

v2:
- cc correct people... sorry.

Stefan reported this problem that in the future we might start to have
more threads operating on the same Monitor object.  This seris try to
add fundamental support for it.

Patch 1 renames the old out_lock to mon_lock, so that it can cover
more things.

Patch 2 uses the mon_lock to protect Monitor object, at least all the
APIs exported in monitor.h

Patch 3 introduces mon_fdsets_lock to protect mon_fdsets global.

Tests: x86 only, make check, raw iotests, windows build.

Please review.  Thanks,

Peter Xu (3):
  monitor: rename out_lock to mon_lock
  monitor: take mon_lock where proper
  monitor: add lock to protect mon_fdsets

 monitor.c | 120 +++++++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 87 insertions(+), 33 deletions(-)

-- 
2.14.3
