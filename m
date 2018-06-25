Received: from eggs.gnu.org ([2001:4830:134:3::10]:54393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fXU1A-0001y8-Fe
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:07:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fXU17-0000Jx-A2
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:07:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36654 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fXU17-0000Je-4c
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:07:01 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 25 Jun 2018 18:06:58 +0200
Message-Id: <20180625160658.7315-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] osdep: work around Coverity parsing errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>

Coverity does not like the new _Float* types that are used by
recent glibc, and croaks on every single file that includes
stdlib.h.  Add dummy typedefs to please it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
	I've been using this patch for a couple months, and Peter pointed
	out that other projects are doing similar hacks.  So it's probably
	time to send it upstream.

	Note that this is a parse error, so it cannot be fixed in the
	model file.

 include/qemu/osdep.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 9ed62423c0..0084f3fa71 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -33,6 +33,14 @@
 #else
 #include "exec/poison.h"
 #endif
+#ifdef __COVERITY__
+typedef float _Float32;
+typedef double _Float32x;
+typedef double _Float64;
+typedef __float80 _Float64x;
+typedef __float128 _Float128;
+#endif
+
 #include "qemu/compiler.h"
 
 /* Older versions of C++ don't get definitions of various macros from
-- 
2.17.1
