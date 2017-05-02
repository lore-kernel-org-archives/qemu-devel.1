Received: from eggs.gnu.org ([2001:4830:134:3::10]:49964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d5eSA-0004iE-TB
	for qemu-devel@nongnu.org; Tue, 02 May 2017 16:31:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d5eS7-0004x3-0b
	for qemu-devel@nongnu.org; Tue, 02 May 2017 16:31:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d5eS6-0004va-RA
	for qemu-devel@nongnu.org; Tue, 02 May 2017 16:31:18 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue,  2 May 2017 17:31:11 -0300
Message-Id: <20170502203115.22233-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] x86: Support "-cpu feature=force"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

This series implements "-cpu feature=force", to allow a feature
to be forcefully enabled even if the underlying accelerator
report it as unsupported. This feature should be used only for
testing and debugging.

We use a new QAPI alternate type to keep command-line
compatibility, and to keep compatibility with code that reads the
existing feature QOM properties and expects boolean values.

Eduardo Habkost (4):
  visitor: Add 'supported_qtypes' parameter to visit_start_alternate()
  string-input-visitor: Support alternate types
  tests: Add [+-]feature and feature=on|off test cases
  x86: Support feature=force on the command-line

 qapi-schema.json                        |  32 +++++++++
 include/qapi/visitor.h                  |   5 +-
 include/qapi/visitor-impl.h             |   2 +-
 scripts/qapi-visit.py                   |  14 ++--
 target/i386/cpu.h                       |   2 +
 qapi/qapi-visit-core.c                  |   7 +-
 qapi/qapi-clone-visitor.c               |   3 +-
 qapi/qapi-dealloc-visitor.c             |   3 +-
 qapi/qobject-input-visitor.c            |   6 +-
 qapi/string-input-visitor.c             |  71 ++++++++++++++++---
 target/i386/cpu.c                       |  55 +++++++++++----
 tests/test-string-input-visitor.c       |  89 ++++++++++++++++++++++++
 tests/test-x86-cpuid-compat.c           | 119 ++++++++++++++++++++++++++++++++
 qapi/trace-events                       |   2 +-
 tests/qapi-schema/qapi-schema-test.json |   8 +++
 15 files changed, 379 insertions(+), 39 deletions(-)

-- 
2.11.0.259.g40922b1
