Received: from eggs.gnu.org ([2001:4830:134:3::10]:49066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cQVkG-0003Cl-V9
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 03:56:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cQVkD-0001ip-TJ
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 03:56:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cQVkD-0001h9-O0
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 03:55:57 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9029483F47
	for <qemu-devel@nongnu.org>; Mon,  9 Jan 2017 08:55:57 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon,  9 Jan 2017 16:55:50 +0800
Message-Id: <1483952153-7221-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] x86: ioapic: fix fail migrate when
 irqchip=split
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com

Split irqchip works based on the fact that we kept the first 24 gsi
routing entries inside KVM for userspace ioapic's use. When system
boot, we'll reserve these MSI routing entries before hand. However,
after migration, we forgot to re-configure it up in the destination
side. The result is, we'll get invalid gsi routing entries after
migration (all empty), and we get interrupts with vector=0, then
strange things happen, like keyboard hang.

The solution is simple - we update them after migration, which is a
one line fix in patch 3.

The first two patches are things I used for debugging this issue.
Though it might not be directly related, I still think it's something
good to have in case we encounter similar interrupt issues in the
future.

Please review, thanks,

Peter Xu (3):
  x86: ioapic: add traces for ioapic
  x86: ioapic: dump version for "info ioapic"
  x86: ioapic: fix fail migration when irqchip=split

 hw/intc/ioapic.c        | 22 ++++++++++++++++++++--
 hw/intc/ioapic_common.c |  3 ++-
 hw/intc/trace-events    |  7 +++++++
 3 files changed, 29 insertions(+), 3 deletions(-)

-- 
2.7.4
