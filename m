Received: from eggs.gnu.org ([209.51.188.92]:45316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1goD6J-0000xD-Uf
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 15:01:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1goD6I-0003HV-To
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 15:01:47 -0500
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Mon, 28 Jan 2019 23:01:26 +0300
Message-Id: <1548705688-1027522-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v9 0/2] qemu-img info lists bitmap directory
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
Cc: armbru@redhat.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, andrey.shinkevich@virtuozzo.com

Currently, I am tackling the implementation of the Eric Blake's ideas,
who proposed the following:
"Should the test also create a disabled bitmap ("enabled":false), to show
the change in flags, and/or a non-persistent bitmap (to show that it
does not affect the qcow2 information, but only the query-blocks output,
because it is transient)?" which were with the the message ID:
<c5c4a099-d89c-6991-6644-98fc760b9106@redhat.com>
The version #7 was discussed with the message ID:
<1544698788-52893-1-git-send-email-andrey.shinkevich@virtuozzo.com>

v9: The new test 239 of the qemu-iotests set was amended to show the bitmaps
being added and to demonstrate the bitmap flag "in-use".

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

Andrey Shinkevich (2):
  qemu-img info lists bitmap directory entries
  qemu-img info: bitmaps extension new test 239

 block/qapi.c               |  6 ++++
 block/qcow2-bitmap.c       | 64 +++++++++++++++++++++++++++++++++
 block/qcow2.c              | 13 +++++++
 block/qcow2.h              |  2 ++
 qapi/block-core.json       | 42 +++++++++++++++++++++-
 tests/qemu-iotests/060.out |  1 +
 tests/qemu-iotests/065     | 16 ++++-----
 tests/qemu-iotests/082.out |  7 ++++
 tests/qemu-iotests/198.out |  2 ++
 tests/qemu-iotests/206.out |  5 +++
 tests/qemu-iotests/239     | 60 +++++++++++++++++++++++++++++++
 tests/qemu-iotests/239.out | 88 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group   |  1 +
 13 files changed, 298 insertions(+), 9 deletions(-)
 create mode 100755 tests/qemu-iotests/239
 create mode 100644 tests/qemu-iotests/239.out

-- 
1.8.3.1
