Received: from eggs.gnu.org ([2001:4830:134:3::10]:59389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fORBR-0006IZ-Jp
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:16:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fORBQ-0003zi-Dl
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:16:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41808 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fORBQ-0003zT-8N
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:16:16 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E14E4401EF10
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 17:16:15 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-117-47.ams2.redhat.com
	[10.36.117.47])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 71B4F63F50
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 17:16:15 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 31 May 2018 19:15:57 +0200
Message-Id: <20180531171606.21604-6-pbonzini@redhat.com>
In-Reply-To: <20180531171606.21604-1-pbonzini@redhat.com>
References: <20180531171253.21012-1-pbonzini@redhat.com>
	<20180531171606.21604-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 44/53] scripts/update-linux-headers: Handle
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

From: Peter Maydell <peter.maydell@linaro.org>

The kernel has changed its license documentation, so instead of COPYING
being a stand-alone file that defines the license, it refers to various
other files under LICENSES/. This means we need to copy not just COPYING
but also these other files to our copy of the kernel headers.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20180525132755.21839-4-peter.maydell@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
