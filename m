Received: from eggs.gnu.org ([2001:4830:134:3::10]:35508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1d5Ze0-0004z1-M4
	for qemu-devel@nongnu.org; Tue, 02 May 2017 11:23:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1d5Zdy-0000P8-1C
	for qemu-devel@nongnu.org; Tue, 02 May 2017 11:23:16 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Tue,  2 May 2017 17:23:05 +0200
Message-Id: <20170502152306.3101-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/1] numa: equally distribute memory on nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>

When there are more nodes than available memory to put the minimum
allowed memory by node, all the memory is put on the last node.

This series introduces a new MachineState function to
distribute equally the memory across the nodes
without breaking compatibility with previous
machine types.

The new function uses an error diffusion algorithm to
distribute the memory across the nodes.

v3:
- by default, use the new algorithm (moved to machine.c),
- use the legacy algorithm with pseries-2.9, pc-q35-2.9 and
  pc-i440fx-2.9 (and previous)

v2:
- introduce the MachineState function
- if the machine state function pointer is NULL (default),
  use the legacy algorithm
- use the new algorithm for pseries-2.10 only

Laurent Vivier (1):
  numa: equally distribute memory on nodes

 hw/core/machine.c       |  2 ++
 hw/i386/pc_piix.c       |  1 +
 hw/i386/pc_q35.c        |  1 +
 hw/ppc/spapr.c          |  1 +
 include/hw/boards.h     |  2 ++
 include/qemu/typedefs.h |  1 +
 include/sysemu/numa.h   |  9 +++++++--
 numa.c                  | 49 ++++++++++++++++++++++++++++++++++++++-----------
 8 files changed, 53 insertions(+), 13 deletions(-)

-- 
2.9.3
