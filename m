Received: from eggs.gnu.org ([2001:4830:134:3::10]:41765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mike@very.puzzling.org>) id 1f4KCI-0002pG-Iy
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 01:46:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mike@very.puzzling.org>) id 1f4KCE-0000Sr-M9
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 01:46:02 -0400
Received: from [101.0.100.17] (port=7271
	helo=bulkhead.engineroom.anchor.net.au)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mike@very.puzzling.org>)
	id 1f4KCE-0000R2-Bd
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 01:45:58 -0400
Received: from ogopogo.bridge.anchor.net.au (ogopogo.bridge.anchor.net.au
	[10.108.254.11])
	by bulkhead.engineroom.anchor.net.au (Postfix) with ESMTP id
	569C21572944
	for <qemu-devel@nongnu.org>; Fri,  6 Apr 2018 15:13:25 +1000 (AEST)
From: Michael Chapman <mike@very.puzzling.org>
Date: Fri,  6 Apr 2018 15:13:24 +1000
Message-Id: <20180406051324.31470-1-mike@very.puzzling.org>
Subject: [Qemu-devel] [PATCH] kvmclock: fix clock_is_reliable on migration
 from QEMU < 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

When migrating from a pre-2.9 QEMU, no clock_is_reliable flag is
transferred. We should assume that the source host has an unreliable
KVM_GET_CLOCK, rather than using whatever was determined locally, to
ensure that any drift from the TSC-based value calculated by the guest
is corrected.

Signed-off-by: Michael Chapman <mike@very.puzzling.org>
---
 hw/i386/kvm/clock.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index 1707434db3..7dac319403 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -241,6 +241,19 @@ static const VMStateDescription kvmclock_reliable_get_clock = {
     }
 };
 
+/*
+ * When migrating, assume the source has an unreliable
+ * KVM_GET_CLOCK unless told otherwise.
+ */
+static int kvmclock_pre_load(void *opaque)
+{
+    KVMClockState *s = opaque;
+
+    s->clock_is_reliable = false;
+
+    return 0;
+}
+
 /*
  * When migrating, read the clock just before migration,
  * so that the guest clock counts during the events
@@ -268,6 +281,7 @@ static const VMStateDescription kvmclock_vmsd = {
     .name = "kvmclock",
     .version_id = 1,
     .minimum_version_id = 1,
+    .pre_load = kvmclock_pre_load,
     .pre_save = kvmclock_pre_save,
     .fields = (VMStateField[]) {
         VMSTATE_UINT64(clock, KVMClockState),
-- 
2.14.3
