Received: from eggs.gnu.org ([2001:4830:134:3::10]:51618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gPVc6-0007Q7-2O
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 11:44:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gPVc2-0006VZ-Tg
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 11:44:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39498)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gPVc2-0006U5-LV
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 11:44:26 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed, 21 Nov 2018 17:44:12 +0100
Message-Id: <20181121164421.20780-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 for-4.0 0/9] qapi: Rewrite
 string-input-visitor's integer and list parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>

Rewrite string-input-visitor to be (hopefully) less ugly. Support
int and uint lists (including ranges, but not implemented via type
"Range").

Virtual walks are now supported and more errors are cought (and some bugs
fixed). Fix and extend the tests. Parsing of uint64_t is now properly
supported.

Importantly, when parsing a list we now return the list and not an
ordered set (we are not an ordered set parser after all). Whoever needs
that can add it on top. As far as I can see, current code can deal with
it but I'll have to look at the details.

While at it, introduce and use qemu_strtod() and qemu_strtod_finite().
However don't convert monitor.c as that seems to be too broken for me
(it ignores both conversion errors and range errors, and there is an
actual unit test in which conversion is expected to fail).

v2 -> v3:
- "cutils: Add qemu_strtod() and qemu_strtod_finite()"
-- Avoid UTF-8 characters
-- Proper -ERANGE handling
- Minor comment/subject/description changes
- Added RBs

v1 -> v2:
- "cutils: Add qemu_strtod() and qemu_strtod_finite()"
-- Add a proper documentation
-- Make -EINVAL perform "no conversion" in qemu_strtod_finite().
- "cutils: Fix qemu_strtosz() & friends to reject non-finite sizes"
-- New subject/description
-- Added test case
-- Forward -ERANGE
- "qapi: Fix string-input-visitor to reject NaN and infinities"
-- New subject/description
-- Added test case
- "test-string-input-visitor: Add more tests"
-- Add even more tests (descending range, overflow, range limit)
- "qapi: Rewrite string-input-visitor"
-- Accept ranges with one element (e.g. 1-1)
-- Bail out on big ranges (just like before)
-- Minor style fixed + description updates
- "test-string-input-visitor: split off uint64 list tests"
-- ALso copy + adapt newly added tests for int64 lists

RFC -> v1:
- Too much to name it all, just some highlights
- Pull some tests before the rework
- Introduce qemu_strtod_finite() and use it in more places
- More tests
- "qapi: rewrite string-input-visitor"
-- programming error -> assert
-- g_assert() -> assert(), g_assert_not_reached() -> abort()
-- Accept single-element ranges "1-1"
-- Split parsing and returning the next range element
-- Minor style fixes

David Hildenbrand (9):
  cutils: Add qemu_strtod() and qemu_strtod_finite()
  cutils: Fix qemu_strtosz() & friends to reject non-finite sizes
  qapi: Fix string-input-visitor to reject NaN and infinities
  qapi: Use qemu_strtod_finite() in qobject-input-visitor
  test-string-input-visitor: Add more tests
  qapi: Rewrite string-input-visitor's integer and list parsing
  test-string-input-visitor: Use virtual walk
  test-string-input-visitor: Split off uint64 list tests
  test-string-input-visitor: Add range overflow tests

 include/qapi/string-input-visitor.h |   4 +-
 include/qemu/cutils.h               |   8 +-
 monitor.c                           |   2 +-
 qapi/qobject-input-visitor.c        |   9 +-
 qapi/string-input-visitor.c         | 413 ++++++++++++++++------------
 tests/test-cutils.c                 |  24 +-
 tests/test-string-input-visitor.c   | 223 ++++++++++++---
 util/cutils.c                       |  83 +++++-
 8 files changed, 517 insertions(+), 249 deletions(-)

-- 
2.17.2
