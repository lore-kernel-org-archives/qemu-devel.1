Received: from eggs.gnu.org ([2001:4830:134:3::10]:52690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1flW9q-0001O1-Sc
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 05:14:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1flW9n-00019O-Mt
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 05:14:02 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:45486)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1flW9n-00016d-Ek
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 05:13:59 -0400
Received: by mail-pf1-x442.google.com with SMTP id i26-v6so2907762pfo.12
	for <qemu-devel@nongnu.org>; Fri, 03 Aug 2018 02:13:59 -0700 (PDT)
From: Lidong Chen <jemmy858585@gmail.com>
Date: Fri,  3 Aug 2018 17:13:38 +0800
Message-Id: <1533287630-4221-1-git-send-email-lidongchen@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 00/12] Enable postcopy RDMA live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhang.zhanghailiang@huawei.com, quintela@redhat.com, dgilbert@redhat.com
Cc: qemu-devel@nongnu.org, Lidong Chen <lidongchen@tencent.com>

The RDMA QIOChannel does not support bi-directional communication, so when RDMA 
live migration with postcopy enabled, the source qemu return path get qemu file 
error.

These patches implement bi-directional communication for RDMA QIOChannel and 
disable the RDMA WRITE during the postcopy phase.

This patch just make postcopy works, and will improve performance later.

[v6]
 - rebase
 - add the check whether release rdma resource has finished(David)
 - remove unnecessary RDMA_CONTROL_ERROR when cleanup(David)
 - poll the cm event for destination qemu

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

Lidong Chen (12):
  migration: disable RDMA WRITE after postcopy started
  migration: create a dedicated connection for rdma return path
  migration: avoid concurrent invoke channel_close by different threads
  migration: implement bi-directional RDMA QIOChannel
  migration: Stop rdma yielding during incoming postcopy
  migration: implement io_set_aio_fd_handler function for RDMA
    QIOChannel
  migration: invoke qio_channel_yield only when qemu_in_coroutine()
  migration: poll the cm event while wait RDMA work request completion
  migration: implement the shutdown for RDMA QIOChannel
  migration: poll the cm event for destination qemu
  migration: remove the unnecessary RDMA_CONTROL_ERROR message
  migration: create a dedicated thread to release rdma resource

 migration/colo.c              |   2 +
 migration/migration.c         |  13 +-
 migration/migration.h         |  10 +
 migration/postcopy-ram.c      |   2 +
 migration/qemu-file-channel.c |  12 +-
 migration/qemu-file.c         |  14 +-
 migration/ram.c               |   4 +
 migration/rdma.c              | 448 ++++++++++++++++++++++++++++++++++++++----
 migration/savevm.c            |   3 +
 9 files changed, 458 insertions(+), 50 deletions(-)

-- 
1.8.3.1
