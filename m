Received: from eggs.gnu.org ([2001:4830:134:3::10]:46545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f73D6-0005Vj-De
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 14:14:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f73D3-0007sI-75
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 14:14:08 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 13 Apr 2018 21:13:58 +0300
Message-Id: <20180413181401.46318-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 0/3] NBD export bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com, jsnow@redhat.com

Hi all.

This is a proposal and realization of new NBD meta context:
qemu. (I hope to send corresponding proposal to NBD protocol soon)

New possible queries will look like:
qemu:dirty-bitmap:<export-bitmap-name>

Mapping from export-bitmap-name to BdrvDirtyBitmap is done through qmp
command nbd-server-add-bitmap. For now, only one bitmap export is
allowed per NBD export, however it may be easily improved if needed 
(we don't have such cases for now)

Client and testing.
I wrote client code for Virtuozzo, but it turned out to be unused,
actually it's used only for tests. We don't have cases, where we need
to import dirty bitmap through qemu nbd-client. All this done for
exporting dirty bitmaps to the third tool. So, I think, it is not worth
refactoring, rebasing and merging client part upstream, if there are no
real usage cases.

v2:
01 from v1 is dropped: actually, we don't need generic namespace
parsing for now (especially, after moving to qemu: namespace, which has
the same length as base:), lets postpone it.

01: Improve comment wording (Eric), add Eric's r-b
02: improve commit message
    move NBD_STATE_DIRTY to header
    add comment on NBD_MAX_BITMAP_EXTENTS
    remove MAX_EXTENT_LENGTH and instead update add_extents() which
      uses it
    use export_bitmap_context instead of export_bitmap_name to reduce
      operations on it
    move from qemu-dirty-bitmap to qemu:dirty-bitmap
    other way to parse namespace name
    handle FLAG_DF
03: Improve specification of new qmp command (Eric)

Vladimir Sementsov-Ogievskiy (3):
  nbd/server: add nbd_meta_single_query helper
  nbd/server: implement dirty bitmap export
  qapi: new qmp command nbd-server-add-bitmap

 qapi/block.json     |  23 +++++
 include/block/nbd.h |   6 ++
 blockdev-nbd.c      |  23 +++++
 nbd/server.c        | 274 ++++++++++++++++++++++++++++++++++++++++++++++------
 4 files changed, 297 insertions(+), 29 deletions(-)

-- 
2.11.1
