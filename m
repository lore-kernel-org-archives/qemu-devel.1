Received: from eggs.gnu.org ([2001:4830:134:3::10]:40000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fQDsl-00083v-PN
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 11:28:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fQDsg-0003lB-RU
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 11:28:23 -0400
Received: from mail-pl0-x229.google.com ([2607:f8b0:400e:c01::229]:38517)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1fQDsg-0003ka-Kx
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 11:28:18 -0400
Received: by mail-pl0-x229.google.com with SMTP id b14-v6so1733251pls.5
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 08:28:18 -0700 (PDT)
From: Lidong Chen <jemmy858585@gmail.com>
Date: Tue,  5 Jun 2018 23:27:59 +0800
Message-Id: <1528212489-19137-1-git-send-email-lidongchen@tencent.com>
Subject: [Qemu-devel] [PATCH v5 00/10] Enable postcopy RDMA live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhang.zhanghailiang@huawei.com, quintela@redhat.com, dgilbert@redhat.com, berrange@redhat.com, aviadye@mellanox.com, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, adido@mellanox.com, galsha@mellanox.com, Lidong Chen <lidongchen@tencent.com>

The RDMA QIOChannel does not support bi-directional communication, so when RDMA 
live migration with postcopy enabled, the source qemu return path get qemu file 
error.

These patches implement bi-directional communication for RDMA QIOChannel and 
disable the RDMA WRITE during the postcopy phase.

This patch just make postcopy works, and will improve performance later.

[v5]
 - rebase
 - fix bug for create a dedicated thread to release rdma resource(David)
 - fix bug for poll the cm event while wait RDMA work request completion(David,Gal)

[v4]
 - not wait RDMA_CM_EVENT_DISCONNECTED event after rdma_disconnect
 - implement io_set_aio_fd_handler function for RDMA QIOChannel (Juan Quintela)
 - invoke qio_channel_yield only when qemu_in_coroutine() (Juan Quintela)
 - create a dedicated thread to release rdma resource
 - poll the cm event while wait RDMA work request completion
 - implement the shutdown function for RDMA QIOChannel

[v3]
 - add a mutex in QEMUFile struct to avoid concurrent channel close (Daniel)
 - destroy the mutex before free QEMUFile (David)
 - use rdmain and rmdaout instead of rdma->return_path (Daniel)

[v2]
 - does not update bytes_xfer when disable RDMA WRITE (David)
 - implement bi-directional communication for RDMA QIOChannel (Daniel)

Lidong Chen (10):
  migration: disable RDMA WRITE after postcopy started
  migration: create a dedicated connection for rdma return path
  migration: avoid concurrent invoke channel_close by different threads
  migration: implement bi-directional RDMA QIOChannel
  migration: Stop rdma yielding during incoming postcopy
  migration: implement io_set_aio_fd_handler function for RDMA
    QIOChannel
  migration: invoke qio_channel_yield only when qemu_in_coroutine()
  migration: create a dedicated thread to release rdma resource
  migration: poll the cm event while wait RDMA work request completion
  migration: implement the shutdown for RDMA QIOChannel

 migration/colo.c              |   2 +
 migration/migration.c         |   4 +
 migration/migration.h         |   7 +
 migration/postcopy-ram.c      |   2 +
 migration/qemu-file-channel.c |  12 +-
 migration/qemu-file.c         |  14 +-
 migration/ram.c               |   4 +
 migration/rdma.c              | 404 ++++++++++++++++++++++++++++++++++++++----
 migration/savevm.c            |   3 +
 9 files changed, 414 insertions(+), 38 deletions(-)

-- 
1.8.3.1
