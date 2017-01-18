Received: from eggs.gnu.org ([2001:4830:134:3::10]:41551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=0AIh=ZA=redhat.com=mst@kernel.org>)
	id 1cTxH0-0003tV-Cf
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 15:56:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=0AIh=ZA=redhat.com=mst@kernel.org>)
	id 1cTxGw-0000yG-0J
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 15:56:02 -0500
Received: from mail.kernel.org ([198.145.29.136]:56610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=0AIh=ZA=redhat.com=mst@kernel.org>)
	id 1cTxGv-0000xc-Qd
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 15:55:57 -0500
Date: Wed, 18 Jan 2017 22:55:52 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484772931-16272-4-git-send-email-mst@redhat.com>
References: <1484772931-16272-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484772931-16272-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/4] compiler: expression version of
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
Cc: pbonzini@redhat.com, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Richard Henderson <rth@twiddle.net>

QEMU_BUILD_BUG_ON uses a typedef in order to be safe
to use outside functions, but sometimes it's useful
to have a version that can be used within an expression.
Following what Linux does, introduce QEMU_BUILD_BUG_ON_ZERO
that return zero after checking condition at build time.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/qemu/compiler.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 2882470..f4cf13b 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -89,6 +89,8 @@
     typedef char glue(qemu_build_bug_on__,__LINE__)[(x) ? -1 : 1] \
         __attribute__((unused))
 
+#define QEMU_BUILD_BUG_ON_ZERO(x) (sizeof(int[(x) ? -1 : 1]) - sizeof(int))
+
 #if defined __GNUC__
 # if !QEMU_GNUC_PREREQ(4, 4)
    /* gcc versions before 4.4.x don't support gnu_printf, so use printf. */
-- 
MST
