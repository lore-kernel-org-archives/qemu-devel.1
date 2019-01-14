Received: from eggs.gnu.org ([209.51.188.92]:53495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gj1Gt-00029O-Dr
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:23:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gj1Gs-0002n3-QS
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:23:15 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 14 Jan 2019 13:23:09 +0100
Message-Id: <1547468589-17579-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] configure: Only build the s390-ccw bios if the
 compiler supports -march=z900
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org

We want to build our s390-ccw bios with -march=z900 so that it also
works with the oldest s390x CPU that we support with TCG. However,
Clang on s390x does not support -march=z900 anymore, so we can not
use this compiler to build the s390-ccw bios. Thus add a proper test
to the configure script to see whether the compiler is usable.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 configure | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 05b7e85..df34974 100755
--- a/configure
+++ b/configure
@@ -5906,7 +5906,10 @@ if test "$cpu" = "ppc64" -a "$targetos" != "Darwin" ; then
 fi
 
 if test "$cpu" = "s390x" ; then
-  roms="$roms s390-ccw"
+  # Only build the s390-ccw bios if the compiler supports -march=z900
+  if "$cc" -dumpspecs 2>/dev/null | grep -q "march=z900"; then
+    roms="$roms s390-ccw"
+  fi
 fi
 
 # Probe for the need for relocating the user-only binary.
-- 
1.8.3.1
