Received: from eggs.gnu.org ([2001:4830:134:3::10]:56952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dgAZc-00016B-Sf
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:06:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dgAZX-0002NG-Cu
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:06:00 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 11 Aug 2017 16:05:30 +0200
Message-Id: <20170811140536.2792-2-kwolf@redhat.com>
In-Reply-To: <20170811140536.2792-1-kwolf@redhat.com>
References: <20170811140536.2792-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 1/7] tests/multiboot: Fix whitespace failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

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
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
