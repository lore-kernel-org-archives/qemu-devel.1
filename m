Received: from eggs.gnu.org ([2001:4830:134:3::10]:46355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fUvRy-0006oo-Dl
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:48:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fUvRs-0004ju-6A
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:48:10 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 18 Jun 2018 16:47:56 +0200
Message-Id: <20180618144800.555-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 0/4] pc-dimm: pre_plug "slot" and "addr"
 assignment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

As requested by Igor, assign and verify "slot" and "addr" in the
pre_plug handler. Factor out the compatibility handling/configuration
for detecting the alignment to be used when searching for an address
in guest physical memory for a memory device.

This is another part of the original series
    [PATCH v4 00/14] MemoryDevice: use multi stage hotplug handlers
And is based on
    [PATCH v1 0/2] memory: fix alignment checks/asserts
    [PATCH v4 00/12] pc-dimm: next bunch of cleanups

This refactoring is the last step before factoring out pre_plug, plug and
unplug logic of memory devices completely into memory-device.c

David Hildenbrand (4):
  pc-dimm: assign and verify the "slot" property during pre_plug
  machine: factor out enforce_aligned_dimm into memory_device_align
  pc-dimm/memory-device: detect alignment internally
  pc-dimm: assign and verify the "addr" property during pre_plug

 hw/core/machine.c              |  3 ++
 hw/i386/pc.c                   | 20 ++++-------
 hw/i386/pc_piix.c              |  2 +-
 hw/mem/Makefile.objs           |  2 +-
 hw/mem/memory-device.c         | 25 ++++++++++++++
 hw/mem/pc-dimm.c               | 62 ++++++++++++++++++----------------
 hw/ppc/spapr.c                 |  6 ++--
 include/hw/boards.h            | 13 +++++++
 include/hw/i386/pc.h           |  3 --
 include/hw/mem/memory-device.h |  1 +
 include/hw/mem/pc-dimm.h       |  4 +--
 11 files changed, 87 insertions(+), 54 deletions(-)

-- 
2.17.1
