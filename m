Received: from eggs.gnu.org ([2001:4830:134:3::10]:38373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fmej0-00032G-IX
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 08:35:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fmeiz-0006da-J8
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 08:35:02 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  6 Aug 2018 13:34:40 +0100
Message-Id: <20180806123445.1459-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-3.0 v2 0/5] Arm migration fixes for 3.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Shannon Zhao <shannon.zhaosl@gmail.com>

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

Patches 1..3 are the same as for v1 and have been reviewed.
Patches 4 and 5 fix a further bug which I discovered during
testing of 1..3: the GICv3 migration structs had several
uses of the pre_load and post_load hooks which assumed that the
hooks were run whether the subsection was present or not. In
fact the migration code only runs the hooks when the subsection
is present in the incoming migration stream, and so for correct
behaviour we need to move the code we were running in the hooks
up to the parent VMSDs.

I've now tested this by doing a save/load of:
 2.12.0 QEMU -> new QEMU
 new QEMU -> new QEMU

An on-trunk QEMU prior to these bugfixes won't migrate
to a QEMU with the bugfixes, but we never released any
final QEMU version with the bugs in.

thanks
-- PMM

Peter Maydell (5):
  hw/intc/arm_gicv3_common: Give no-migration-shift-bug subsection a
    needed function
  hw/intc/arm_gicv3_common: Combine duplicate .subsections in
    vmstate_gicv3_cpu
  target/arm: Add dummy needed functions to M profile vmstate
    subsections
  hw/intc/arm_gicv3_common: Move post_load hooks to top-level VMSD
  hw/intc/arm_gicv3_common: Move gicd shift bug handling to
    gicv3_post_load

 hw/intc/arm_gicv3_common.c | 284 ++++++++++++++++++-------------------
 target/arm/machine.c       |   3 +
 2 files changed, 145 insertions(+), 142 deletions(-)

-- 
2.17.1
