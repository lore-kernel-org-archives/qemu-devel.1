Received: from eggs.gnu.org ([2001:4830:134:3::10]:56363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dufmG-0003OA-O9
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:15:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dufmD-000574-5k
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:15:00 -0400
Received: from ozlabs.ru ([107.173.13.209]:59740)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dufmC-00056x-Vq
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:14:57 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Wed, 20 Sep 2017 21:46:19 +1000
Message-Id: <20170920114637.42004-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu v4 00/18] memory: Reduce memory use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>


This was inspired by https://bugzilla.redhat.com/show_bug.cgi?id=1481593
Previous versions:
v1: https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg01559.html
v2: https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg04069.html
v3: https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg04523.html

This patchset tries to reduce amount of memory used by FlatViews
and tries share as many FVs between address spaces as possible.

Changelog:
v4:
* total rework again to provide grounds for new 15/18, 17/18, 18/18

v3:
* addressed comments from v2, mainly simplified the code

v2:
* total rework


This is based on sha1
c51700273a Peter Maydell "Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20170919-v2' into staging".

Please comment. Thanks.



Alexey Kardashevskiy (18):
  exec: Explicitly export target AS from
    address_space_translate_internal
  memory: Open code FlatView rendering
  memory: Move FlatView allocation to a helper
  memory: Move AddressSpaceDispatch from AddressSpace to FlatView
  memory: Remove AddressSpace pointer from AddressSpaceDispatch
  memory: Switch memory from using AddressSpace to FlatView
  memory: Cleanup after switching to FlatView
  memory: Rename mem_begin/mem_commit/mem_add helpers
  memory: Store physical root MR in FlatView
  memory: Alloc dispatch tree where topology is generared
  memory: Move address_space_update_ioeventfds
  memory: Share FlatView's and dispatch trees between address spaces
  memory: Do not allocate FlatView in address_space_init
  memory: Add flat views to HMP "info mtree"
  memory: Share special empty FlatView
  memory: Get rid of address_space_init_shareable
  memory: Create FlatView directly
  memory: Give memory_region_transaction_commit a hint

 include/exec/memory-internal.h |  16 +-
 include/exec/memory.h          |  76 ++++----
 include/hw/arm/armv7m.h        |   2 +-
 cpus.c                         |   5 +-
 exec.c                         | 330 +++++++++++++++++++++--------------
 hw/arm/armv7m.c                |   9 +-
 hw/intc/openpic_kvm.c          |   2 +-
 memory.c                       | 383 +++++++++++++++++++++++++++++++----------
 monitor.c                      |   3 +-
 target/arm/cpu.c               |  16 +-
 target/i386/cpu.c              |   5 +-
 hmp-commands-info.hx           |   7 +-
 12 files changed, 570 insertions(+), 284 deletions(-)

-- 
2.11.0
