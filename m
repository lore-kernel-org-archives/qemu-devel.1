Received: from eggs.gnu.org ([2001:4830:134:3::10]:60069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=CMim=ZN=redhat.com=mst@kernel.org>)
	id 1cYdOT-0006i7-Eu
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:43:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=CMim=ZN=redhat.com=mst@kernel.org>)
	id 1cYdOS-0000Fi-FF
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:43:05 -0500
Received: from mail.kernel.org ([198.145.29.136]:37766)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=CMim=ZN=redhat.com=mst@kernel.org>)
	id 1cYdOS-0000Em-8B
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:43:04 -0500
Date: Tue, 31 Jan 2017 20:43:00 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1485888144-16531-7-git-send-email-mst@redhat.com>
References: <1485888144-16531-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1485888144-16531-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL v4 06/23] QEMU_BUILD_BUG_ON: use __COUNTER__
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

Some headers use QEMU_BUILD_BUG_ON. This causes a problem
if the C file including that header happens to have
QEMU_BUILD_BUG_ON at the same line number.

Fix using a widely available extension: __COUNTER__.
If unavailable, provide a stub.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/qemu/compiler.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 057639a..e0ce9ff 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -97,6 +97,9 @@
 #define QEMU_BUILD_BUG_ON(x)
 #endif
 
+#define QEMU_BUILD_BUG_ON_ZERO(x) (sizeof(QEMU_BUILD_BUG_ON_STRUCT(x)) - \
+                                   sizeof(QEMU_BUILD_BUG_ON_STRUCT(x)))
+
 #if defined __GNUC__
 # if !QEMU_GNUC_PREREQ(4, 4)
    /* gcc versions before 4.4.x don't support gnu_printf, so use printf. */
-- 
MST
