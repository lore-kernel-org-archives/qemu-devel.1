Received: from eggs.gnu.org ([2001:4830:134:3::10]:50084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fMAb0-00078g-Iz
	for qemu-devel@nongnu.org; Fri, 25 May 2018 07:09:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fMAaz-0003Z3-LP
	for qemu-devel@nongnu.org; Fri, 25 May 2018 07:09:18 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42162)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fMAaz-0003Y3-F9
	for qemu-devel@nongnu.org; Fri, 25 May 2018 07:09:17 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 May 2018 12:09:14 +0100
Message-Id: <20180525110914.22348-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] scripts/update-linux-headers: Handle
 __aligned_u64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Alex Williamson <alex.williamson@redhat.com>

We'll currently replace any 'u64' with a 'uint64_t' including when
it's embedded in an '__aligned_u64', creating a '__aligned_uint64_t'
which doesn't exist. We need to instead expand out the kernel's
definition of __aligned_u64:
   #define __aligned_u64 __u64 __attribute__((aligned(8)))
before we convert the __u64 to uint64_t.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Alex's "scripts/update-linux-headers: Update handling of __aligned_u64"
patch also addresses this problem, but I think we need to take this
approach, because the resulting header is supposed to be host-OS-portable.

 scripts/update-linux-headers.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 947dec2852..1fe54f8ab1 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -51,7 +51,8 @@ cp_portable() {
     fi
 
     header=$(basename "$f");
-    sed -e 's/__u\([0-9][0-9]*\)/uint\1_t/g' \
+    sed -e 's/__aligned_u64/__u64 __attribute__((aligned(8)))/g' \
+        -e 's/__u\([0-9][0-9]*\)/uint\1_t/g' \
         -e 's/u\([0-9][0-9]*\)/uint\1_t/g' \
         -e 's/__s\([0-9][0-9]*\)/int\1_t/g' \
         -e 's/__le\([0-9][0-9]*\)/uint\1_t/g' \
-- 
2.17.0
