Received: from eggs.gnu.org ([209.51.188.92]:47743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gu498-0005by-L0
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 18:40:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gu45E-0005e1-Cp
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 18:36:54 -0500
From: John Snow <jsnow@redhat.com>
Date: Wed, 13 Feb 2019 18:36:16 -0500
Message-Id: <20190213233618.22484-1-jsnow@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 0/2] bitmaps: add inconsistent bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, eblake@redhat.com, John Snow <jsnow@redhat.com>, vsementsov@virtuozzo.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>

Allow QEMU to read in bitmaps that have the in-use bit set, for the
purposes of allowing users to clear or reset these bitmaps.

This is chosen in preference to a hard error on load to minimize
impact for a non-critical error, but to force the user or management
utility to acknowledge that the bitmap is no longer viable.

Requires: [PATCH v2 0/6] dirty-bitmaps: deprecate @status field
          (Which in turn requires my bitmaps staging branch.)

RFC: This is just for general approach, naming, and API.
     I chose NOT to overload the busy predicate so that it would be distinct,
     which unfortunately means many more manual checks across blockdev.

     - I chose "inconsistent" over "corrupt" to be more literal to the
     meaning of the "in-use" bit, but maybe this is overcautious.

     - I chose to make the field optional so that it disappears in
     normative cases, as the information is only really relevant when
     inconsistent=true.

     I also have NOT tested this and I didn't verify the saving logic
     for what happens if you don't delete or clear the bitmap,
     but I'm on PTO the next two days and I wanted this to see daylight.

John Snow (2):
  block/dirty-bitmaps: add inconsistent bit
  block/dirty-bitmap: implement inconsistent bit

 block/dirty-bitmap.c         | 34 ++++++++++++++++++++++++++++
 block/qcow2-bitmap.c         | 42 ++++++++++++++++++-----------------
 blockdev.c                   | 43 ++++++++++++++++++++++++++++++++++++
 include/block/dirty-bitmap.h |  3 +++
 qapi/block-core.json         |  9 ++++++--
 5 files changed, 109 insertions(+), 22 deletions(-)

-- 
2.17.2
