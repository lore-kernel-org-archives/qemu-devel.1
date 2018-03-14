Received: from eggs.gnu.org ([2001:4830:134:3::10]:41604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ew51O-0002oq-TN
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 07:56:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ew51K-0004Vp-0x
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 07:56:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40889 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ew51J-0004VV-RQ
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 07:56:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A32938182D16
	for <qemu-devel@nongnu.org>; Wed, 14 Mar 2018 11:56:33 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 14 Mar 2018 11:55:49 +0000
Message-Id: <20180314115618.28831-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 00/29] postcopy+vhost-user/shared ram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, maxime.coquelin@redhat.com, marcandre.lureau@redhat.com, peterx@redhat.com, quintela@redhat.com
Cc: aarcange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

  This set enables postcopy migration with shared memory to a vhost user =
process.
It's based off current head.

  Testing is mostly performed with dpdk, with corresponding modifications=
 by
Maxime.

  v6 is a rebase on top of Michael's PCI world; this took some merging
because of Jay Zhou's 'vhost: used_memslots refactoring', which needed
a bit of a change to 'vhost+postcopy: Stash RAMBlock and offset' (which
I dropped the Review-by off)=20
and 'postcopy+vhost-user: Split set_mem_table for postcopy' (which I
kept it, since the change is mostly contextual).

And I removed a blank line at the end of a patch.

Dave


Dr. David Alan Gilbert (29):
  migrate: Update ram_block_discard_range for shared
  qemu_ram_block_host_offset
  postcopy: use UFFDIO_ZEROPAGE only when available
  postcopy: Add notifier chain
  postcopy: Add vhost-user flag for postcopy and check it
  vhost-user: Add 'VHOST_USER_POSTCOPY_ADVISE' message
  libvhost-user: Support sending fds back to qemu
  libvhost-user: Open userfaultfd
  postcopy: Allow registering of fd handler
  vhost+postcopy: Register shared ufd with postcopy
  vhost+postcopy: Transmit 'listen' to slave
  postcopy+vhost-user: Split set_mem_table for postcopy
  migration/ram: ramblock_recv_bitmap_test_byte_offset
  libvhost-user+postcopy: Register new regions with the ufd
  vhost+postcopy: Send address back to qemu
  vhost+postcopy: Stash RAMBlock and offset
  vhost+postcopy: Helper to send requests to source for shared pages
  vhost+postcopy: Resolve client address
  postcopy: helper for waking shared
  postcopy: postcopy_notify_shared_wake
  vhost+postcopy: Add vhost waker
  vhost+postcopy: Call wakeups
  libvhost-user: mprotect & madvises for postcopy
  vhost-user: Add VHOST_USER_POSTCOPY_END message
  vhost+postcopy: Wire up POSTCOPY_END notify
  vhost: Huge page align and merge
  postcopy: Allow shared memory
  libvhost-user: Claim support for postcopy
  postcopy shared docs

 contrib/libvhost-user/libvhost-user.c | 302 ++++++++++++++++++++++++-
 contrib/libvhost-user/libvhost-user.h |  11 +
 docs/devel/migration.rst              |  41 ++++
 docs/interop/vhost-user.txt           |  52 +++++
 exec.c                                |  86 ++++++--
 hw/virtio/trace-events                |  16 +-
 hw/virtio/vhost-user.c                | 403 ++++++++++++++++++++++++++++=
+++++-
 hw/virtio/vhost.c                     |  66 +++++-
 include/exec/cpu-common.h             |   4 +
 migration/migration.c                 |   6 +
 migration/migration.h                 |   4 +
 migration/postcopy-ram.c              | 353 +++++++++++++++++++++++-----=
-
 migration/postcopy-ram.h              |  73 ++++++
 migration/ram.c                       |   5 +
 migration/ram.h                       |   1 +
 migration/savevm.c                    |  13 ++
 migration/trace-events                |   6 +
 trace-events                          |   3 +-
 vl.c                                  |   2 +
 19 files changed, 1351 insertions(+), 96 deletions(-)

--=20
2.14.3
