Received: from eggs.gnu.org ([2001:4830:134:3::10]:50418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d6jZh-0003jy-JT
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:11:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d6jZd-0001gw-H1
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:11:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38278)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d6jZd-0001fK-8W
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:11:33 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  5 May 2017 17:11:25 -0300
Message-Id: <20170505201128.12099-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/3] string-input-visitor: Support enum/bool
 alternate types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

v1 was originally part of the following series:

  [PATCH 0/4] x86: Support "-cpu feature=force"

But as I am not sure yet "feature=force" is the right way to go,
I decided to send only the string-input-visitor alternate
support, in case the QAPI maintainers want to merge it anyway.

Changes v1 -> v2:
* Updated string_input_visitor_new() documentation
  to mention alternate support (Markus Armbruster)
* Detect ambiguous alternates at runtime. Test case included.
* Removed support for integers. We don't need it yet, and
  it would require sorting out the parse_str() mess.
* Change supported_qtypes to uint32_t (Eric Blake)
* Replace assert() on all generated visitor functions with a
  single QEMU_BUILD_BUG_ON() on visit_start_alternate()
  (Eric Blake)
* Extra spaces around "|" on generated visitor code
  (Eric Blake)
* Don't use bitops.h and just use (1U << QTYPE_FOO)
  (Markus Armbruster)
* Update tests/qapi-schema/qapi-schema-test.out to match
  qapi-schema-test.json updates
* New patch: qapi: Add enum_table[] parameter to start_alternate
  (needed to detect ambiguous alternates)
* Code indentation fix (Markus Armbruster)

Eduardo Habkost (3):
  visitor: Add 'supported_qtypes' parameter to visit_start_alternate()
  qapi: Add enum_table[] parameter to start_alternate
  string-input-visitor: Support alternate types

 include/qapi/visitor.h                  | 13 ++++-
 include/qapi/visitor-impl.h             |  4 +-
 scripts/qapi-visit.py                   | 17 ++++--
 include/qapi/string-input-visitor.h     |  6 +-
 qapi/qapi-visit-core.c                  | 12 +++-
 qapi/qapi-clone-visitor.c               |  4 +-
 qapi/qapi-dealloc-visitor.c             |  4 +-
 qapi/qobject-input-visitor.c            |  7 ++-
 qapi/string-input-visitor.c             | 99 +++++++++++++++++++++++++++++----
 tests/test-string-input-visitor.c       | 76 +++++++++++++++++++++++++
 qapi/trace-events                       |  2 +-
 tests/qapi-schema/qapi-schema-test.json |  8 +++
 tests/qapi-schema/qapi-schema-test.out  |  9 +++
 13 files changed, 234 insertions(+), 27 deletions(-)

-- 
2.11.0.259.g40922b1
