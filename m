Received: from eggs.gnu.org ([2001:4830:134:3::10]:34213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gL4Yn-0003uD-0p
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 06:02:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gL4Yk-0004Ow-Ri
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 06:02:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gL4Yk-0004BU-Hk
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 06:02:42 -0500
From: David Hildenbrand <david@redhat.com>
Date: Fri,  9 Nov 2018 12:02:15 +0100
Message-Id: <20181109110221.10553-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 0/6] qapi: rewrite string-input-visitor
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

Guess once this part here is done, the output visitor is the next thing
to rework.

David Hildenbrand (6):
  cutils: add qemu_strtod()
  qapi: use qemu_strtod() in string-input-visitor
  qapi: rewrite string-input-visitor
  test-string-input-visitor: use virtual walk
  test-string-input-visitor: split off uint64 list tests
  test-string-input-visitor: add range overflow tests

 include/qapi/string-input-visitor.h |   3 +-
 include/qemu/cutils.h               |   1 +
 qapi/string-input-visitor.c         | 444 ++++++++++++++++------------
 tests/test-string-input-visitor.c   | 131 +++++---
 util/cutils.c                       |  22 ++
 5 files changed, 377 insertions(+), 224 deletions(-)

-- 
2.17.2
