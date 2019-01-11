Received: from eggs.gnu.org ([209.51.188.92]:60544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gi2Fr-0004wk-Q7
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 14:14:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gi2Fq-0006DZ-P0
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 14:14:07 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 11 Jan 2019 20:14:00 +0100
Message-Id: <20190111191401.18317-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 0/1] block: Eliminate the S_1KiB, S_2KiB,
 ... macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, lbloch@janustech.com, qemu-block@nongnu.org

Back in September, Leonid Block added a whole bunch of macros (commit
540b8492618) to improve readability of qcow2.h a bit (commit
b6a95c6d100).  He later used them to fix the "vdi" driver's parameter
cluster_size's default value (commit 3dd5b8f4718).  He has now
proposed a further patch[1] to auto-generate these macros.  That patch
feels overengineered to me.

On closer examination, I found I dislike the macros before his new
patch.  So did Eric Blake.

The macros exist because the common KiB, MiB, ... macros aren't usable
when you need a literal rather than a constant expression.
stringify() does, and we use it to define the QemuOpts default value.

Eric proposed to improve QemuOpts to accept integer default values,
too[2].  Before I review that patch series, I want to establish a
"stupidest solution that can possibly work" baseline.  And that's what
this patch is.

[1] [PATCH v2 0/1] include: Auto-generate the sizes lookup table
Message-ID: <20190103213320.2653-1-lbloch@janustech.com>

[2] [PATCH v3 0/6] include: Auto-generate the sizes lookup table
Message-Id: <20190110191901.5082-1-eblake@redhat.com>

Markus Armbruster (1):
  block: Eliminate the S_1KiB, S_2KiB, ... macros

 block/qcow2.h        | 10 +++---
 block/vdi.c          |  3 +-
 include/qemu/units.h | 73 --------------------------------------------
 3 files changed, 7 insertions(+), 79 deletions(-)

-- 
2.17.2
