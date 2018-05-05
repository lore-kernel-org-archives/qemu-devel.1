Received: from eggs.gnu.org ([2001:4830:134:3::10]:58366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fEyI6-0008ML-6h
	for qemu-devel@nongnu.org; Sat, 05 May 2018 10:36:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fEyI3-00081t-3u
	for qemu-devel@nongnu.org; Sat, 05 May 2018 10:36:02 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:33180)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1fEyI2-00081I-T6
	for qemu-devel@nongnu.org; Sat, 05 May 2018 10:35:59 -0400
Received: by mail-pg0-x243.google.com with SMTP id i194-v6so17321977pgd.0
	for <qemu-devel@nongnu.org>; Sat, 05 May 2018 07:35:58 -0700 (PDT)
From: Lidong Chen <jemmy858585@gmail.com>
Date: Sat,  5 May 2018 22:35:30 +0800
Message-Id: <1525530936-21835-1-git-send-email-lidongchen@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 0/6] Enable postcopy RDMA live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com, dgilbert@redhat.com, berrange@redhat.com
Cc: qemu-devel@nongnu.org, galsha@mellanox.com, aviadye@mellanox.com, adido@mellanox.com, Lidong Chen <lidongchen@tencent.com>

The RDMA QIOChannel does not support bi-directional communication, so when RDMA 
live migration with postcopy enabled, the source qemu return path get qemu file 
error.

These patches implement bi-directional communication for RDMA QIOChannel and 
disable the RDMA WRITE during the postcopy phase.

This patch just make postcopy works, and will improve performance later.

[v3]
 - add a mutex in QEMUFile struct to avoid concurrent channel close (Daniel)
 - destroy the mutex before free QEMUFile (David)
 - use rdmain and rmdaout instead of rdma->return_path (Daniel)

[v2]
 - does not update bytes_xfer when disable RDMA WRITE (David)
 - implement bi-directional communication for RDMA QIOChannel (Daniel)


Lidong Chen (6):
  migration: disable RDMA WRITE after postcopy started
  migration: create a dedicated connection for rdma return path
  migration: remove unnecessary variables len in QIOChannelRDMA
  migration: avoid concurrent invoke channel_close by different threads
  migration: implement bi-directional RDMA QIOChannel
  migration: Stop rdma yielding during incoming postcopy

 migration/colo.c         |   2 +
 migration/migration.c    |   2 +
 migration/postcopy-ram.c |   2 +
 migration/qemu-file.c    |  13 +-
 migration/ram.c          |   4 +
 migration/rdma.c         | 321 +++++++++++++++++++++++++++++++++++++++++------
 migration/savevm.c       |   3 +
 7 files changed, 307 insertions(+), 40 deletions(-)

-- 
1.8.3.1
