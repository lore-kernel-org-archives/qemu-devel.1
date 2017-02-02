Received: from eggs.gnu.org ([2001:4830:134:3::10]:41606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cZGzb-00013r-BY
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 08:00:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cZGzY-0008Ta-9m
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 08:00:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cZGzY-0008Sh-44
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 08:00:00 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D8A4780F99
	for <qemu-devel@nongnu.org>; Thu,  2 Feb 2017 12:59:59 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu,  2 Feb 2017 12:59:53 +0000
Message-Id: <20170202125956.21942-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/3] Protect against long IDs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, amit.shah@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

QEMU currently asserts if you try and create a PCI device
on the end of a very long chain, because the ID string
exceeds the maximum length, and ends up aliasing.

Fail with a clean error in this common case;  there's
lots of other places that call the various registration
functions that now check for this error; I've only made
sure the common qdev path fails cleanly.

With these patches it fails with the slightly cleaner:

qemu-system-x86_64: -device x3130-upstream,id=pci.52,bus=pci.51,addr=0x0: Path too long for VMState (0000:00:0f.0:00.0:00.0:00.0:00.0:00.0:00.0:00.0:00.0:00.0:00.0:00.0:00.0:00.0:00.0:00.0:00.0:00.0:00.0:00.0:00.0:00.0:00.0:00.0:00.0:00.0:00.0:00.0:00.0:00.0:00.0:00.0:00.0:00.0:00.0:00.0:00.0:00.0:00.0:00.0:00.0:00.0:00.0:00.0:00.0:00.0:00.0:00.0:00.0:00.0)

I don't think in real uses we'll end up with paths this long,
so I'm not intending to fix the paths to be dynamic lengths
unless we find a really good case where it happens.

This corresponds to:
  https://bugzilla.redhat.com/show_bug.cgi?id=1342434

Dave

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

v2
  Fix some indents on the last patch

Dr. David Alan Gilbert (3):
  vmstate_register_with_alias_id: Take an Error **
  migration: Check for ID length
  vmstate registration: check return values

 hw/core/qdev.c              |  9 ++++++---
 hw/intc/apic_common.c       |  2 +-
 include/migration/vmstate.h |  7 +++++--
 migration/savevm.c          | 24 ++++++++++++++++++------
 stubs/vmstate.c             |  3 ++-
 5 files changed, 32 insertions(+), 13 deletions(-)

-- 
2.9.3
