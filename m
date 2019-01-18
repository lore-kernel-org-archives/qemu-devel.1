Received: from eggs.gnu.org ([209.51.188.92]:52236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gkT7b-0004wS-6X
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:19:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gkT7a-0001HL-E0
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:19:39 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 18 Jan 2019 13:19:18 +0100
Message-Id: <20190118121925.24468-5-cohuck@redhat.com>
In-Reply-To: <20190118121925.24468-1-cohuck@redhat.com>
References: <20190118121925.24468-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 04/11] configure: Only build the s390-ccw bios
 if the compiler supports -march=z900
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>

From: Thomas Huth <thuth@redhat.com>

We want to build our s390-ccw bios with -march=z900 so that it also
works with the oldest s390x CPU that we support with TCG. However,
Clang on s390x does not support -march=z900 anymore, so we can not
use this compiler to build the s390-ccw bios. Thus add a proper test
to the configure script to see whether the compiler is usable.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1547470346-18416-1-git-send-email-thuth@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 configure | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 3eee3fcf70..87273d1c12 100755
--- a/configure
+++ b/configure
@@ -5889,8 +5889,12 @@ if test "$cpu" = "ppc64" -a "$targetos" != "Darwin" ; then
   roms="$roms spapr-rtas"
 fi
 
+# Only build s390-ccw bios if we're on s390x and the compiler has -march=z900
 if test "$cpu" = "s390x" ; then
-  roms="$roms s390-ccw"
+  write_c_skeleton
+  if compile_prog "-march=z900" ""; then
+    roms="$roms s390-ccw"
+  fi
 fi
 
 # Probe for the need for relocating the user-only binary.
-- 
2.17.2
