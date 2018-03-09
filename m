Received: from eggs.gnu.org ([2001:4830:134:3::10]:47579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.vnet.ibm.com>) id 1euMf3-0005LD-Ca
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 13:22:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.vnet.ibm.com>) id 1euMez-0001gb-Au
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 13:22:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36124
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.vnet.ibm.com>)
	id 1euMez-0001fy-5K
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 13:22:29 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w29IKK6v003602
	for <qemu-devel@nongnu.org>; Fri, 9 Mar 2018 13:22:27 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gkxkfj3he-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 13:22:26 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.vnet.ibm.com>;
	Fri, 9 Mar 2018 13:22:26 -0500
From: Fabiano Rosas <farosas@linux.vnet.ibm.com>
Date: Fri,  9 Mar 2018 15:21:56 -0300
Message-Id: <20180309182202.31206-1-farosas@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 0/5] block: Ensure non-protocol drivers can
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
 include/block/block_int.h | 6 ++++++
 replication.h             | 1 -
 6 files changed, 9 insertions(+), 8 deletions(-)

--
2.13.6
