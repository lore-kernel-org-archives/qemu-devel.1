Received: from eggs.gnu.org ([2001:4830:134:3::10]:60030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fMClG-0006JJ-0g
	for qemu-devel@nongnu.org; Fri, 25 May 2018 09:28:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fMClF-0000qx-6P
	for qemu-devel@nongnu.org; Fri, 25 May 2018 09:28:02 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42170)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fMClE-0000p1-Vh
	for qemu-devel@nongnu.org; Fri, 25 May 2018 09:28:01 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 May 2018 14:27:52 +0100
Message-Id: <20180525132755.21839-4-peter.maydell@linaro.org>
In-Reply-To: <20180525132755.21839-1-peter.maydell@linaro.org>
References: <20180525132755.21839-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 3/6] scripts/update-linux-headers: Handle
 kernel license no longer being one file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, "Michael S . Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

The kernel has changed its license documentation, so instead of COPYING
being a stand-alone file that defines the license, it refers to various
other files under LICENSES/. This means we need to copy not just COPYING
but also these other files to our copy of the kernel headers.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
We could copy the whole of LICENSES/ but that seems like overkill.
---
 scripts/update-linux-headers.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 1fe54f8ab1..feb75390aa 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -142,6 +142,20 @@ else
     cp "$linux/COPYING" "$output/linux-headers"
 fi
 
+# Recent kernel sources split the copyright/license info into multiple
+# files, which we need to copy. This set of licenses is the set that
+# are referred to by SPDX lines in the headers we currently copy.
+# We don't copy the Documentation/process/license-rules.rst which
+# is also referred to by COPYING, since it's explanatory rather than license.
+if [ -d "$linux/LICENSES" ]; then
+    mkdir -p "$output/linux-headers/LICENSES/preferred" \
+             "$output/linux-headers/LICENSES/exceptions"
+    for l in preferred/GPL-2.0 preferred/BSD-2-Clause preferred/BSD-3-Clause \
+             exceptions/Linux-syscall-note; do
+        cp "$linux/LICENSES/$l" "$output/linux-headers/LICENSES/$l"
+    done
+fi
+
 cat <<EOF >$output/linux-headers/linux/virtio_config.h
 #include "standard-headers/linux/virtio_config.h"
 EOF
-- 
2.17.0
