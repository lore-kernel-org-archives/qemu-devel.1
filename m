Received: from eggs.gnu.org ([2001:4830:134:3::10]:40616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzVjn-0003am-1H
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 19:37:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzVbR-0005Id-Vg
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 19:28:25 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38029)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fzVbR-0005HV-Mb
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 19:28:21 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 10 Sep 2018 19:27:41 -0400
Message-Id: <20180910232752.31565-2-cota@braap.org>
In-Reply-To: <20180910232752.31565-1-cota@braap.org>
References: <20180910232752.31565-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 01/12] cacheinfo: add i/d cache_linesize_log
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qemu/osdep.h | 2 ++
 util/cacheinfo.c     | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index a91068df0e..a746a5e531 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -570,6 +570,8 @@ extern uintptr_t qemu_real_host_page_size;
 extern intptr_t qemu_real_host_page_mask;
 
 extern int qemu_icache_linesize;
+extern int qemu_icache_linesize_log;
 extern int qemu_dcache_linesize;
+extern int qemu_dcache_linesize_log;
 
 #endif
diff --git a/util/cacheinfo.c b/util/cacheinfo.c
index db5172d07c..57c7d58159 100644
--- a/util/cacheinfo.c
+++ b/util/cacheinfo.c
@@ -7,9 +7,12 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/host-utils.h"
 
 int qemu_icache_linesize = 0;
+int qemu_icache_linesize_log;
 int qemu_dcache_linesize = 0;
+int qemu_dcache_linesize_log;
 
 /*
  * Operating system specific detection mechanisms.
@@ -173,5 +176,7 @@ static void __attribute__((constructor)) init_cache_info(void)
     fallback_cache_info(&isize, &dsize);
 
     qemu_icache_linesize = isize;
+    qemu_icache_linesize_log = 31 - clz32(isize);
     qemu_dcache_linesize = dsize;
+    qemu_dcache_linesize_log = 31 - clz32(dsize);
 }
-- 
2.17.1
