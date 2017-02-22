Received: from eggs.gnu.org ([2001:4830:134:3::10]:36594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cgc9W-0004KA-Nz
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 14:00:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cgc9T-0004aV-MZ
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 14:00:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cgc9T-0004aD-GD
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 14:00:35 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 22 Feb 2017 16:00:26 -0300
Message-Id: <20170222190029.17243-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/3] target-i386: Implement
 query-cpu-model-expansion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, libvir-list@redhat.com, Jiri Denemark <jdenemar@redhat.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Markus Armbruster <armbru@redhat.com>, Richard Henderson <rth@twiddle.net>, Igor Mammedov <imammedo@redhat.com>, Eric Blake <eblake@redhat.com>

This series implements query-cpu-model-expansion on target-i386.

Changes v2 -> v3:
-----------------

* Rebased on top of my x86-next branch:
  https://github.com/ehabkost/qemu x86-next
* Added new patch that will extend type=full expansion to
  return every (writeable) QOM property from the CPU object

Git branch for testing:
  https://github.com/ehabkost/qemu-hacks work/x86-query-cpu-expansion

libvirt code to use the new feature already exist, and were
submitted to libvir-list, at:
  https://www.mail-archive.com/libvir-list@redhat.com/msg142168.html

Changes v1 -> v2:
-----------------

This version is highly simplified compared to v1. It contains
only an implementation that will return a limited set of
properties. I have a follow-up series that will expend type=full
expansion to return every single QOM property [note: this is now
implemented in v3], but this version will return the same data
for type=static and type=full expansion for simplicity (except
that type=static expansion will use the "base" CPU model as
base).

This means this version also won't include "pmu" and
"host-cache-info" in full expansion, and won't require special
code for those properties.

The unit test code was also removed in this version, to keep the
series simple and easier to review. Most of the patches on the
previous series were changes just to make the test case work. I
will send the test-case-related changes as a follow-up series.

---
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: libvir-list@redhat.com
Cc: Jiri Denemark <jdenemar@redhat.com>
Cc: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Eric Blake <eblake@redhat.com>

Eduardo Habkost (3):
  target-i386: Define static "base" CPU model
  target-i386: Implement query-cpu-model-expansion QMP command
  i386: Improve query-cpu-model-expansion full mode

 target/i386/cpu-qom.h |   2 +
 monitor.c             |   4 +-
 target/i386/cpu.c     | 239 +++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 243 insertions(+), 2 deletions(-)

-- 
2.11.0.259.g40922b1
