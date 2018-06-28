Received: from eggs.gnu.org ([2001:4830:134:3::10]:38168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAn-0007Oy-NI
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAm-0000kP-Jh
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:45 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:38237)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYdAm-0000jp-CK
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:44 -0400
Received: by mail-wr0-x22d.google.com with SMTP id e18-v6so6691406wrs.5
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:05:44 -0700 (PDT)
Received: from 640k.lan ([82.84.124.111]) by smtp.gmail.com with ESMTPSA id
	127-v6sm6211110wmd.18.2018.06.28.13.05.42 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 28 Jun 2018 13:05:42 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Jun 2018 22:04:40 +0200
Message-Id: <1530216310-52873-31-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
References: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 30/60] osdep: work around Coverity parsing errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Coverity does not like the new _Float* types that are used by
recent glibc, and croaks on every single file that includes
stdlib.h.  Add dummy typedefs to please it.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/osdep.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 9ed6242..a91068d 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -33,6 +33,21 @@
 #else
 #include "exec/poison.h"
 #endif
+#ifdef __COVERITY__
+/* Coverity does not like the new _Float* types that are used by
+ * recent glibc, and croaks on every single file that includes
+ * stdlib.h.  These typedefs are enough to please it.
+ *
+ * Note that these fix parse errors so they cannot be placed in
+ * scripts/coverity-model.c.
+ */
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
1.8.3.1
