Received: from eggs.gnu.org ([2001:4830:134:3::10]:32862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fBLWd-0008E5-2t
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:36:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fBLWZ-0007bU-UV
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:36:03 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:35913)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1fBLWZ-0007bH-Nr
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:35:59 -0400
Received: by mail-pg0-x243.google.com with SMTP id i6so13487170pgv.3
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 07:35:59 -0700 (PDT)
From: Lidong Chen <jemmy858585@gmail.com>
Date: Wed, 25 Apr 2018 22:35:29 +0800
Message-Id: <1524666934-8064-1-git-send-email-lidongchen@tencent.com>
Subject: [Qemu-devel] [PATCH v2 0/5] Enable postcopy RDMA live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com, dgilbert@redhat.com
Cc: qemu-devel@nongnu.org, galsha@mellanox.com, aviadye@mellanox.com, licq@mellanox.com, adido@mellanox.com, Lidong Chen <lidongchen@tencent.com>

The RDMA QIOChannel does not support bi-directional communication, so when RDMA 
live migration with postcopy enabled, the source qemu return path get qemu file 
error.

These patches implement bi-directional communication for RDMA QIOChannel and 
disable the RDMA WRITE during the postcopy phase.

This patch just make postcopy works, and will improve performance later.

[v2]
 - does not update bytes_xfer when disable RDMA WRITE (David)
 - implement bi-directional communication for RDMA QIOChannel (Daniel)

Please, review.

Lidong Chen (5):
  migration: disable RDMA WRITE after postcopy started
  migration: create a dedicated connection for rdma return path
  migration: remove unnecessary variables len in QIOChannelRDMA
  migration: implement bi-directional RDMA QIOChannel
  migration: Stop rdma yielding during incoming postcopy

 migration/qemu-file.c |   8 +-
 migration/rdma.c      | 287 +++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 265 insertions(+), 30 deletions(-)

-- 
1.8.3.1
