Received: from eggs.gnu.org ([2001:4830:134:3::10]:54659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gWJiL-0007KX-SY
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 06:27:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gWJiL-000662-47
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 06:27:05 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Dec 2018 11:26:46 +0000
Message-Id: <20181210112649.11581-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/3] block: fix last address-of-packed-member
 warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ben Warren <ben@skyportsystems.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Weil <sw@weilnetz.de>

This patchset fixes the remaining clang warnings in the block/ code
about taking the address of a packed struct member, which are all
in block/vpc and block/vdi code handling UUIDs. Mostly I fix
these by copying the unaligned field to/from a local variable.
In the case of qemu_uuid_bswap() I opted to change the API to
take and return the QemuUUID rather than taking a pointer to it,
which makes almost all the callsites simpler. This does mean
a struct copy but the struct is only 16 bytes and I didn't
judge any of the callsites performance-sensitive enough to care
about a struct copy of that size.

As usual, tested with "make check" only.

thanks
-- PMM


Peter Maydell (3):
  block/vpc: Don't take address of fields in packed structs
  block/vdi: Don't take address of fields in packed structs
  uuid: Make qemu_uuid_bswap() take and return a QemuUUID

 include/qemu/uuid.h  |  2 +-
 block/vdi.c          | 54 +++++++++++++++++++++++++++-----------------
 block/vpc.c          |  4 +++-
 hw/acpi/vmgenid.c    |  6 ++---
 tests/vmgenid-test.c |  2 +-
 util/uuid.c          | 10 ++++----
 6 files changed, 45 insertions(+), 33 deletions(-)

-- 
2.19.2
