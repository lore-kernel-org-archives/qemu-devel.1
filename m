Received: from eggs.gnu.org ([2001:4830:134:3::10]:52701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gNIGg-0005YL-6S
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:05:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gNIGc-0004HU-7A
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:05:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gNIGc-0004GY-2N
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:05:10 -0500
From: David Hildenbrand <david@redhat.com>
Date: Thu, 15 Nov 2018 15:04:52 +0100
Message-Id: <20181115140501.7872-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 0/9] qapi: rewrite string-input-visitor
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

RFC - v1:
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
  cutils: add qemu_strtod() and qemu_strtod_finite()
  cutils: use qemu_strtod_finite() in do_strtosz()
  qapi: use qemu_strtod_finite() in string-input-visitor
  qapi: use qemu_strtod_finite() in qobject-input-visitor
  test-string-input-visitor: add more tests
  qapi: rewrite string-input-visitor
  test-string-input-visitor: use virtual walk
  test-string-input-visitor: split off uint64 list tests
  test-string-input-visitor: add range overflow tests

 include/qapi/string-input-visitor.h |   4 +-
 include/qemu/cutils.h               |   8 +-
 monitor.c                           |   2 +-
 qapi/qobject-input-visitor.c        |   9 +-
 qapi/string-input-visitor.c         | 418 ++++++++++++++++------------
 tests/test-cutils.c                 |  14 +-
 tests/test-string-input-visitor.c   | 172 +++++++++---
 util/cutils.c                       |  52 +++-
 8 files changed, 432 insertions(+), 247 deletions(-)

-- 
2.17.2
