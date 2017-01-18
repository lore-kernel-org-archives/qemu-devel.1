Received: from eggs.gnu.org ([2001:4830:134:3::10]:41550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=0AIh=ZA=redhat.com=mst@kernel.org>)
	id 1cTxH0-0003tU-CG
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 15:56:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=0AIh=ZA=redhat.com=mst@kernel.org>)
	id 1cTxGz-00010U-1P
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 15:56:02 -0500
Received: from mail.kernel.org ([198.145.29.136]:56652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=0AIh=ZA=redhat.com=mst@kernel.org>)
	id 1cTxGy-0000zb-RG
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 15:56:00 -0500
Date: Wed, 18 Jan 2017 22:55:55 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484772931-16272-5-git-send-email-mst@redhat.com>
References: <1484772931-16272-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484772931-16272-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/4] ARRAY_SIZE: check that argument is an
 array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Sergey Fedorov <serge.fdrv@gmail.com>

It's a familiar pattern: some code uses ARRAY_SIZE, then refactoring
changes the argument from an array to a pointer to a dynamically
allocated buffer.  Code keeps compiling but any ARRAY_SIZE calls now
return the size of the pointer divided by element size.

Let's add build time checks to ARRAY_SIZE before we allow more
of these in the code-base.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/qemu/osdep.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 689f253..24bfda0 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -199,7 +199,13 @@ extern int daemon(int, int);
 #endif
 
 #ifndef ARRAY_SIZE
-#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+/*
+ * &(x)[0] is always a pointer - if it's same type as x then the argument is a
+ * pointer, not an array as expected.
+ */
+#define ARRAY_SIZE(x) ((sizeof(x) / sizeof((x)[0])) + QEMU_BUILD_BUG_ON_ZERO( \
+                        __builtin_types_compatible_p(typeof(x), \
+                                                     typeof(&(x)[0]))))
 #endif
 
 int qemu_daemon(int nochdir, int noclose);
-- 
MST
