Received: from eggs.gnu.org ([2001:4830:134:3::10]:55746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.vnet.ibm.com>) id 1evVc5-00067h-U6
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:08:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.vnet.ibm.com>) id 1evVc3-0000zs-2I
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:08:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56474)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.vnet.ibm.com>)
	id 1evVc2-0000yJ-Q6
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:08:10 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2CM4kiI117933
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 18:08:07 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gnxck07xb-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 18:08:06 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.vnet.ibm.com>;
	Mon, 12 Mar 2018 18:08:05 -0400
From: Fabiano Rosas <farosas@linux.vnet.ibm.com>
Date: Mon, 12 Mar 2018 19:07:48 -0300
Message-Id: <20180312220753.20096-1-farosas@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 0/5] block: Ensure non-protocol drivers can
 only be selected explicitly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com

Block drivers can be selected by either protocol syntax:

  <protocol>:<filename>[:options]

or explicitly:

  driver=<driver>[,option=<opt1>...]

For the protocol syntax to work, drivers should set the protocol_name
field of the BlockDriver structure and provide bdrv_file_open and
bdrv_parse_filename implementations.

Conversely, block drivers that do not support the protocol syntax
should instead implement bdrv_open and not have a protocol_name field.

Some drivers do not currently adhere to this and errors arise when
trying to select them using the protocol syntax. For instance:

  $ qemu-img info replication:foo
  qemu-img: block.c:2401: bdrv_open_inherit: \
  Assertion `!!(flags & BDRV_O_PROTOCOL) == !!drv->bdrv_file_open' failed.
  Aborted (core dumped)

This patch-set ensures that the following drivers are meeting the
above criteria:
- blkreplay
- quorum
- replication
- throttle

Aside from that, documentation was added to make the above more
explicit.

v1 -> v2:
 - patch 1: updated commit message
 - patch 5: improved protocol_name documentation

 https://lists.nongnu.org/archive/html/qemu-devel/2018-03/msg02998.html

Fabiano Rosas (5):
  block/replication: Remove protocol_name field
  block/quorum: Remove protocol-related fields
  block/throttle: Remove protocol-related fields
  block/blkreplay: Remove protocol-related fields
  include/block/block_int: Document protocol related functions

 block/blkreplay.c         | 3 +--
 block/quorum.c            | 3 +--
 block/replication.c       | 1 -
 block/throttle.c          | 3 +--
 include/block/block_int.h | 8 ++++++++
 replication.h             | 1 -
 6 files changed, 11 insertions(+), 8 deletions(-)

--
2.13.6
