Received: from eggs.gnu.org ([2001:4830:134:3::10]:35764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJvm-00076w-Bo
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:07:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJvl-00053M-Fr
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:07:38 -0500
Received: from mail.kernel.org ([198.145.29.136]:56240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=Ovvj=ZB=redhat.com=mst@kernel.org>)
	id 1cUJvl-00051l-9I
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:07:37 -0500
Date: Thu, 19 Jan 2017 23:07:32 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484859998-25074-4-git-send-email-mst@redhat.com>
References: <1484859998-25074-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484859998-25074-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH v3 3/4] compiler: expression version of
 QEMU_BUILD_BUG_ON
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Richard Henderson <rth@twiddle.net>

QEMU_BUILD_BUG_ON uses a typedef in order to be safe
to use outside functions, but sometimes it's useful
to have a version that can be used within an expression.
Following what Linux does, introduce QEMU_BUILD_BUG_ON_ZERO
that return zero after checking condition at build time.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/qemu/compiler.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index c6f673e..8271eab 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -92,6 +92,9 @@
 #define QEMU_BUILD_BUG_ON(x) typedef QEMU_BUILD_BUG_ON_STRUCT(x) \
     glue(qemu_build_bug_on__, __LINE__) __attribute__((unused))
 
+#define QEMU_BUILD_BUG_ON_ZERO(x) (sizeof(QEMU_BUILD_BUG_ON_STRUCT(x)) - \
+                                   sizeof(QEMU_BUILD_BUG_ON_STRUCT(x)))
+
 #if defined __GNUC__
 # if !QEMU_GNUC_PREREQ(4, 4)
    /* gcc versions before 4.4.x don't support gnu_printf, so use printf. */
-- 
MST
