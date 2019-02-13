Received: from eggs.gnu.org ([209.51.188.92]:45506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gu3t2-0001ln-KM
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 18:24:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gu3t1-0004tZ-Mh
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 18:24:16 -0500
From: John Snow <jsnow@redhat.com>
Date: Wed, 13 Feb 2019 18:23:50 -0500
Message-Id: <20190213232356.21034-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/6] dirty-bitmaps: deprecate @status field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>, vsementsov@virtuozzo.com, Fam Zheng <fam@euphon.net>, libvir-list@redhat.com, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

The current internal meanings of "locked", "user_locked",
"qmp_locked", "frozen", "enabled", and "disabled" are all
a little muddled.

Deprecate the @status field in favor of two new booleans
that carry very specific meanings. Then, rename and rework
some of the internal semantics to help make the API a bit
more clear and easier to read.

Well, in my opinion.

Based on my current bitmaps branch (includes Eric's patch
and my documentation update patch.)

V2: - All of Eric's suggestions, I hope.
    - Vladimir's phrasing suggestion on patch 1
    - Added a sixth patch that's mostly just motion.

I'm on PTO the next two days, so I didn't get to writing
a test for the busy bit. I think test 223 is a good candidate,
because it uses the NBD functionality. To test with push mode,
I need to come up with a blockdebug configuration that will
let me pause an incremental backup so I can test race-free.
Maybe for V3, sorry.

John Snow (6):
  block/dirty-bitmap: add recording and busy properties
  block/dirty-bitmaps: rename frozen predicate helper
  block/dirty-bitmap: change semantics of enabled predicate
  block/dirty-bitmap: explicitly lock bitmaps with successors
  block/dirty-bitmaps: unify qmp_locked and user_locked calls
  block/dirty-bitmaps: move comment block

 block/dirty-bitmap.c           | 110 ++++++++++++++++++---------------
 blockdev.c                     |  18 +++---
 include/block/dirty-bitmap.h   |   7 +--
 migration/block-dirty-bitmap.c |   8 +--
 nbd/server.c                   |   6 +-
 qapi/block-core.json           |  10 ++-
 qemu-deprecated.texi           |   6 ++
 tests/qemu-iotests/236.out     |  28 +++++++++
 8 files changed, 122 insertions(+), 71 deletions(-)

-- 
2.17.2
