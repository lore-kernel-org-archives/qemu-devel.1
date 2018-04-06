Received: from eggs.gnu.org ([2001:4830:134:3::10]:36406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f4Uts-0007xm-KI
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f4Utr-0007ne-LB
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:44 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:35301)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1f4Utr-0007lr-CV
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:43 -0400
Received: by mail-wr0-x235.google.com with SMTP id 80so2413856wrb.2
	for <qemu-devel@nongnu.org>; Fri, 06 Apr 2018 10:11:43 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  6 Apr 2018 19:11:14 +0200
Message-Id: <1523034681-33787-14-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1523034681-33787-1-git-send-email-pbonzini@redhat.com>
References: <1523034681-33787-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 13/20] kvmclock: fix clock_is_reliable on
 migration from QEMU < 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Chapman <mike@very.puzzling.org>

From: Michael Chapman <mike@very.puzzling.org>

When migrating from a pre-2.9 QEMU, no clock_is_reliable flag is
transferred. We should assume that the source host has an unreliable
KVM_GET_CLOCK, rather than using whatever was determined locally, to
ensure that any drift from the TSC-based value calculated by the guest
is corrected.

Signed-off-by: Michael Chapman <mike@very.puzzling.org>
Message-Id: <20180406053406.774-1-mike@very.puzzling.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/kvm/clock.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index 1707434..7dac319 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -242,6 +242,19 @@ static const VMStateDescription kvmclock_reliable_get_clock = {
 };
 
 /*
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
+/*
  * When migrating, read the clock just before migration,
  * so that the guest clock counts during the events
  * between:
@@ -268,6 +281,7 @@ static const VMStateDescription kvmclock_vmsd = {
     .name = "kvmclock",
     .version_id = 1,
     .minimum_version_id = 1,
+    .pre_load = kvmclock_pre_load,
     .pre_save = kvmclock_pre_save,
     .fields = (VMStateField[]) {
         VMSTATE_UINT64(clock, KVMClockState),
-- 
1.8.3.1
