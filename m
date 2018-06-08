Received: from eggs.gnu.org ([2001:4830:134:3::10]:41363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fRJFE-0007FT-Ba
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 11:24:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fRJFD-0005P3-DE
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 11:24:04 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  8 Jun 2018 18:23:47 +0300
Message-Id: <20180608152353.98712-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v4 0/6] NBD export
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, eblake@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Hi all.

This is a proposal and realization of new NBD meta context: qemu.

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

v4:
01: add trace for -skipped case
02: new
03: trace -skipped case in nbd_meta_pattern, rebase on 02
04: fix nbd_meta_qemu_query: use meta->exp instead of client->exp, rebase on 02

v3:
01: new
02: rewritten to satisfy changes in 03, drop r-b
03: - fix comments
    - rewrite nbd_meta_bitmap_query() and rename it to
      nbd_meta_qemu_query(): parse 'qemu:dirty-bitmaps:' for LIST
      option to represent list of all dirty-bitmap contexts.
    - trace points
    - s/512/BDRV_SECTOR_SIZE/
      drop TODO comment
04: s/2.13/3.0
05: new

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

Vladimir Sementsov-Ogievskiy (6):
  nbd/server: fix trace
  nbd/server: refactor NBDExportMetaContexts
  nbd/server: add nbd_meta_empty_or_pattern helper
  nbd/server: implement dirty bitmap export
  qapi: new qmp command nbd-server-add-bitmap
  docs/interop: add nbd.txt

 docs/interop/nbd.txt |  37 ++++++
 qapi/block.json      |  23 ++++
 include/block/nbd.h  |   6 +
 blockdev-nbd.c       |  23 ++++
 nbd/server.c         | 347 +++++++++++++++++++++++++++++++++++++++++++++------
 MAINTAINERS          |   1 +
 6 files changed, 396 insertions(+), 41 deletions(-)
 create mode 100644 docs/interop/nbd.txt

-- 
2.11.1
