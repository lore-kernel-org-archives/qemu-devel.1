Received: from eggs.gnu.org ([209.51.188.92]:42557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gou1Z-0006Of-0S
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 12:51:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gou1V-0000AA-9s
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 12:51:43 -0500
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Wed, 30 Jan 2019 20:51:27 +0300
Message-Id: <1548870690-647481-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v10 0/3] qemu-img info lists bitmap directory
 entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, fam@euphon.net, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, andrey.shinkevich@virtuozzo.com

v10:
The 'struct Error' parameter was added to the function prototype
bdrv_query_image_info().
The code refactoring of the function get_bitmap_info_flags().
The comments to the structures ImageInfoSpecificQCow2 and
Qcow2BitmapInfo in the file qapi/block-core.json were corrected.
The changes in the *.out files of the tests 060, 065 082, 198
and 206 were discarded. The new test 239 was enriched by adding human
readable format output and by checking the output with bitmap extra
parameters, such as  non-persistent and disabled.

v9:
The new test 239 of the qemu-iotests set was amended to show the bitmaps
being added and to demonstrate the bitmap flag "in-use".
The version #9 was discussed with the message ID:
<1548705688-1027522-1-git-send-email-andrey.shinkevich@virtuozzo.com>

v8:
The output benchmark files for the qemu-iotests, namely 060, 065 082, 198
and 206, were modified to show the bitmap extension for the qemu specific
information. A new test file 239 was added to the test set that checks the
output for the fields of the bitmap section.
The backward compatibility of the output for images of the version 2
of qcow2 was added.

v7:
A description was added to the function qcow2_get_bitmap_info_list().
In the function qcow2_get_specific_info(), the comment was modified
so that we ignore any error in obtaining the list of bitmaps to
pass the rest of QCOW2 specific information to a caller.

v6:
'[PATCH v6] qemu-img info lists bitmap directory entries'.
The error handling logic for the bitmaps empty list was reversed.

v5:
'[PATCH v5] qemu-img info lists bitmap directory entries'.
The error handling logic for the bitmaps empty list was fixed and documented.

v4:
'[PATCH v4] qemu-img info lists bitmap directory entries'.
Unknown flags are checked with the mask BME_RESERVED_FLAGS.
The code minor refactoring was made.

v3:
'[PATCH v3] qemu-img info lists bitmap directory entries'.
Now, qcow2_get_bitmap_info_list() is invoked under the condition of QCOW
version #3 to avoid memory leaks in case of QCOW version #2.
Furthermore, qcow2_get_bitmap_info_list() checks the number of existing bitmaps.
So, if no bitmap exists, no bitmap error message is printed in the output.
The data type of the bitmap 'granularity' parameter was left as 'uint32'
because bitmap_list_load() returns error if granularity_bits is grater than 31.

v2:
'[PATCH v2] qemu-img info lists bitmap directory entries'.
The targeted version of the release at 'Since' word of the comments to the new
structures changed to 4.0 in the file qapi/block-core.json.
A comment to the 'bitmaps' new member was supplied.
The 'unknown flags' parameter was introduced to indicate presence of QCOW2
bitmap unknown flags, if any.
The word 'dirty' was removed from the code and from the comments as we list all
the bitmaps.
The 'bitmaps' printed parameter was removed for the release versions earlier
than 3.x.
The example of the output was moved above the 'Signed-off-by' line.

The first version was '[PATCH] qemu-img info lists bitmap directory entries'.

Andrey Shinkevich (3):
  bdrv_query_image_info Error parameter added
  qemu-img info lists bitmap directory entries
  qemu-img info: bitmaps extension new test 239

 block.c                    |   5 +-
 block/crypto.c             |   4 +-
 block/qapi.c               |   7 ++-
 block/qcow2-bitmap.c       |  77 +++++++++++++++++++++++++++
 block/qcow2.c              |  20 ++++++-
 block/qcow2.h              |   2 +
 block/vmdk.c               |   3 +-
 include/block/block.h      |   3 +-
 include/block/block_int.h  |   3 +-
 qapi/block-core.json       |  40 +++++++++++++-
 qemu-io-cmds.c             |   7 ++-
 tests/qemu-iotests/239     |  74 ++++++++++++++++++++++++++
 tests/qemu-iotests/239.out | 130 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 14 files changed, 364 insertions(+), 12 deletions(-)
 create mode 100755 tests/qemu-iotests/239
 create mode 100644 tests/qemu-iotests/239.out

-- 
1.8.3.1
