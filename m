Received: from eggs.gnu.org ([2001:4830:134:3::10]:52961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1ffoal-0003Hg-FZ
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:42:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1ffoag-0000Hq-LG
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:42:15 -0400
Received: from relay.sw.ru ([185.231.240.75]:36372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
	id 1ffoag-0000F5-2V
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:42:10 -0400
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Date: Wed, 18 Jul 2018 18:41:43 +0300
Message-Id: <20180718154200.26777-1-dplotnikov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v1 00/17] Background snapshots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com, quintela@redhat.com, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org

The workflow to make a snapshot is the following:
1. Pause the vm
2. Make a snapshot of block devices using the scheme of your choice
3. Turn on background-snapshot migration capability
4. Start the migration using the destination (migration stream) of your choice.
   The migration will resume the vm execution by itself
   when it has the devices' states saved  and is ready to start ram writing
   to the migration stream.
5. Listen to the migration finish event

The bakground snapshot works with support of KVM patch:
"x86: mmu: report failed memory access to the userspace"
(not applied to the mainstream, it's in the kvm mailing list)

--
Change log:

v0 => v1:
============
the patch series has been split in smaller chunks

Denis Plotnikov (17):
  migration: add background snapshot capability
  bitops: add some atomic versions of bitmap operations
  threads: add infrastructure to process sigsegv
  background snapshot: make a dedicated type for ram block list
  ram: extend the data structures for background snapshotting
  background snapshot: add helpers to manage a copy of ram block list
  background snapshot: introduce page buffer
  migration: add helpers to change VM memory protection rights
  background snapshot: extend RAM request for holding a page copy
    pointer
  background snapshots: adapt the page queueing code for using page
    copies
  background snapshot: add a memory page copying function
  ram: add background snapshot support in ram page saving part of
    migration
  background snapshot: add write-protected page access handler function
  kvm: add failed memeory access exit reason
  kvm: add vCPU failed memeory access processing
  migration: move the device state saving logic to a separate function
  background snapshot: enable background snapshot

 include/exec/ram_addr.h   |   7 +
 include/exec/ramlist.h    |   4 +-
 include/qemu/bitops.h     |  25 +++
 include/qemu/thread.h     |   5 +
 linux-headers/linux/kvm.h |   5 +
 migration/migration.c     | 140 +++++++++++++-
 migration/migration.h     |   1 +
 migration/ram.c           | 374 ++++++++++++++++++++++++++++++++++++--
 migration/ram.h           |  17 +-
 migration/savevm.c        |  91 +++++-----
 migration/savevm.h        |   2 +
 qapi/migration.json       |   6 +-
 target/i386/kvm.c         |  17 ++
 util/qemu-thread-posix.c  |  52 ++++++
 14 files changed, 684 insertions(+), 62 deletions(-)

-- 
2.17.0
