Received: from eggs.gnu.org ([2001:4830:134:3::10]:37157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fIc0S-0003I6-1t
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:36:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fIc0R-0004e4-71
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:36:52 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 15 May 2018 23:36:30 +0800
Message-Id: <20180515153634.5868-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/4] vmdk: Implement x-blockdev-create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

v2: Respin after comments by Markus:
    - QAPI: drop qapi_enum_parse_full patch.
    - Drop vmdk_subformat_str.
    - Fix an uninitialized variable error.
    - Authentic casing for subformat enum.

This adds vmdk support to x-blockdev-create command.

Unlike other formats, several VMDK subformats consists of multiple files
(extents). In the QAPI interface we use an array of BlockdevRef to pass in. The
management tool need to figure out how many extent files are needed but that is
simple enough. There is a convention how VMware (as well as qemu-img) builds
the extents' file names, but that isn't standardized, therefore it is not
documented as part of this API.  Extraneous extents in the end of the provided
array are ignored.

A big part of the patch is refactoring so that BlockdevRef parsing can be
hooked in.

Please review! Thanks.

Fam Zheng (4):
  vmdk: Refactor vmdk_create_extent
  vmdk: Implement .bdrv_co_create callback
  iotests: Filter cid numbers in VMDK extent info
  iotests: Add VMDK tests for blockdev-create

 block/vmdk.c                     | 530 +++++++++++++++++++++++++++------------
 qapi/block-core.json             |  67 ++++-
 qapi/qapi-schema.json            |   1 +
 tests/qemu-iotests/214           | 268 ++++++++++++++++++++
 tests/qemu-iotests/214.out       | 304 ++++++++++++++++++++++
 tests/qemu-iotests/common.filter |   1 +
 tests/qemu-iotests/group         |   1 +
 7 files changed, 1016 insertions(+), 156 deletions(-)
 create mode 100755 tests/qemu-iotests/214
 create mode 100644 tests/qemu-iotests/214.out

-- 
2.14.3
