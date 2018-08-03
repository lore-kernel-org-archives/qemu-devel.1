Received: from eggs.gnu.org ([2001:4830:134:3::10]:48957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fld4X-0004OE-AK
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 12:37:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fld4W-0006XB-CZ
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 12:37:01 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  3 Aug 2018 17:36:43 +0100
Message-Id: <20180803163646.31068-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/3] Arm migration fixes for 3.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

This patchset primarily fixes problems with Arm migration
induced by a bug in the core vmstate handling of subsections:
currently the migration code incorrectly treats a subsection with
no .needed function pointer as if it was the subsection list
terminator -- it is ignored and so is everything after it.

I did an audit of all uses of subsections in QEMU, and found
that we had four which didn't define a .needed function (assuming
that this meant "always needed", same as the semantics for
not providing a .needed function for a toplevel vmsd).
This patchset fixes them all up by providing a dummy needed
function.

It also fixes an error in vmstate_gicv3_cpu which was accidentally
initializing .subsections twice and so ignoring one of the subsections.

Strictly speaking only the first patch is a true regression from 2.12.

Disclaimer: compile tested only as I have to rush out the door in a
moment, but I wanted to get these on-list for review given that
rc4 isn't too far away... I'll test them properly on Monday.

thanks
-- PMM

Peter Maydell (3):
  hw/intc/arm_gicv3_common: Give no-migration-shift-bug subsection a
    needed function
  hw/intc/arm_gicv3_common: Combine duplicate .subsections in
    vmstate_gicv3_cpu
  target/arm: Add dummy needed functions to M profile vmstate
    subsections

 hw/intc/arm_gicv3_common.c | 9 ++++++---
 target/arm/machine.c       | 3 +++
 2 files changed, 9 insertions(+), 3 deletions(-)

-- 
2.17.1
