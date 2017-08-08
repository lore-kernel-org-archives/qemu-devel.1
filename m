Received: from eggs.gnu.org ([2001:4830:134:3::10]:59994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1df5aU-00010k-Vv
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:34:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1df5aT-0000d3-Vu
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 10:34:26 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue,  8 Aug 2017 09:34:16 -0500
Message-Id: <20170808143416.3581-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10] tests/multiboot: Fix whitespace
 failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

Commit b43671f8 accidentally broke run_test.sh within tests/multiboot;
due to a subtle change in whitespace.

These two commands produce theh same output (at least, for sane $IFS
of space-tab-newline):

echo -e "...$@..."
echo -e "...$*..."

But that's only because echo inserts spaces between multiple arguments
(the $@ case), while the $* form gives a single argument to echo with
the spaces already present.

But when converting to printf %b, there are no automatic spaces between
multiple arguments, so we HAVE to use $*.

It doesn't help that run_test.sh isn't part of 'make check'.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/multiboot/run_test.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/multiboot/run_test.sh b/tests/multiboot/run_test.sh
index c8f3da8f37..0278148b43 100755
--- a/tests/multiboot/run_test.sh
+++ b/tests/multiboot/run_test.sh
@@ -26,7 +26,7 @@ run_qemu() {
     local kernel=$1
     shift

-    printf %b "\n\n=== Running test case: $kernel $@ ===\n\n" >> test.log
+    printf %b "\n\n=== Running test case: $kernel $* ===\n\n" >> test.log

     $QEMU \
         -kernel $kernel \
-- 
2.13.4
