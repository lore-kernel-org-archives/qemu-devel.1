Received: from eggs.gnu.org ([2001:4830:134:3::10]:40236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fHJI9-0006MF-Fa
	for qemu-devel@nongnu.org; Fri, 11 May 2018 21:25:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fHJI7-0006TG-Hk
	for qemu-devel@nongnu.org; Fri, 11 May 2018 21:25:45 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri, 11 May 2018 21:25:25 -0400
Message-Id: <20180512012537.22478-1-jsnow@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 00/12] qemu-img: add bitmap queries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, John Snow <jsnow@redhat.com>

Allow qemu-img to show information about bitmaps stored in qcow2 images.
Add a 'bitmap' meta-command with 'dump' sub-command to retrieve a list of
dirty regions in bitmaps stored in a qcow2 image.

RFC:
- I am not 1000% convinced the bm_list caching is perfectly safe,
  especially with respect to migration and inactivation. There are
  more efficiencies and tweaks I can make, but I think this is the
  minimal set.

- I decided not to gate bitmap info in the "info" command behind
  extra flags.

- Bitmap data-gathering in "bitmap dump" could be made more
  space-efficient by just reporting one segment at a time,
  probably.

- `bitmap rm` and `bitmap mk` need extra work, so I am not submitting
  them just yet: rm needs more work around the remove persistence API,
  and make needs more work around the "can add" API.

- None of these commands will work with "in use" bitmaps; we need
  qemu-img check -r bitmaps support for this. I'm not sure what the
  right behavior to "fix" in-use bitmaps should be:
        - Cleared: This might be dangerous.
        - Fully Set: This is safer, but stupid.
        - Deleted: This might be the best option.
        - Un-set in-use: VERY dangerous; would rather not.

John Snow (12):
  qcow2-bitmap: cache bm_list
  qcow2/dirty-bitmap: cache loaded bitmaps
  block/qcow2-bitmap: avoid adjusting bm->flags for RO bitmaps
  qcow2/dirty-bitmaps: load IN_USE bitmaps if disk is RO
  qcow2-bitmap: track bitmap type
  qapi: add bitmap info
  qcow2-bitmap: add basic bitmaps info
  qjson: allow caller to ask for arbitrary indent
  qapi/block-core: add BitmapMapping and BitmapEntry structs
  qemu-img: split off common chunk of map command
  qemu-img: add bitmap dump
  qemu-img: add bitmap clear

 block/qcow2-bitmap.c     | 220 +++++++++++++++++--------
 block/qcow2.c            |   9 +
 block/qcow2.h            |   3 +
 include/qapi/qmp/qjson.h |   1 +
 qapi/block-core.json     |  92 ++++++++++-
 qemu-img-cmds.hx         |   6 +
 qemu-img.c               | 419 +++++++++++++++++++++++++++++++++++++----------
 qobject/qjson.c          |  21 +--
 8 files changed, 612 insertions(+), 159 deletions(-)

-- 
2.14.3
