Received: from eggs.gnu.org ([2001:4830:134:3::10]:34330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dLEvf-0000uy-M7
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 16:30:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dLEvc-0005hl-Hu
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 16:30:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dLEvc-0005hA-BE
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 16:30:12 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 132EA33459A
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 20:30:11 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 14 Jun 2017 17:29:55 -0300
Message-Id: <20170614203000.19984-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 0/5] hostmem-file: Add "persistent" option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>

This series adds a new "persistent" option to
memory-backend-file.  The new option it will be useful if
somebody is sharing RAM contents on a file using share=on, but
don't need it to be flushed to disk when QEMU exits.

Internally, it will trigger a madvise(MADV_REMOVE) or
fallocate(FALLOC_FL_PUNCH_HOLE) call when the memory backend is
destroyed.

To make we actually trigger the new code when QEMU exits, the
first patch in the series ensures we destroy all user-created
objects when exiting QEMU.

Eduardo Habkost (5):
  vl: Clean up user-creatable objects when exiting
  memory: Allow RAM up to block->max_length to be discarded
  memory: Add RAM_NONPERSISTENT flag
  memory: Add 'persistent' parameter to
    memory_region_init_ram_from_file()
  hostmem-file: Add "persistent" option

 include/exec/memory.h           |  4 ++++
 include/exec/ram_addr.h         |  4 ++--
 include/qom/object_interfaces.h |  8 ++++++++
 backends/hostmem-file.c         | 35 ++++++++++++++++++++++++++++++++++-
 exec.c                          | 26 ++++++++++++++++++++++----
 memory.c                        |  4 +++-
 numa.c                          |  2 +-
 qom/object_interfaces.c         |  5 +++++
 vl.c                            |  1 +
 qemu-options.hx                 |  9 ++++++++-
 10 files changed, 88 insertions(+), 10 deletions(-)

-- 
2.11.0.259.g40922b1
