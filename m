Received: from eggs.gnu.org ([2001:4830:134:3::10]:38573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fOmtF-00026Q-0g
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:26:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fOmtE-0007AF-2M
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:26:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52706 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fOmtD-00079e-SB
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:26:56 -0400
Date: Fri, 1 Jun 2018 19:26:54 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180601162620.32362-8-mst@redhat.com>
References: <20180601162620.32362-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601162620.32362-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 07/31] osdep: add wait.h compat macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, "Emilio G. Cota" <cota@braap.org>, Eric Blake <eblake@redhat.com>

Man page for WCOREDUMP says:

  WCOREDUMP(wstatus) returns true if the child produced a core dump.
  This macro should be employed only if WIFSIGNALED returned true.

  This  macro  is  not  specified  in POSIX.1-2001 and is not
  available on some UNIX implementations (e.g., AIX, SunOS).  Therefore,
  enclose its use inside #ifdef WCOREDUMP ... #endif.

Let's do exactly this.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/qemu/osdep.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 41658060a7..afc28e5903 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -107,6 +107,16 @@ extern int daemon(int, int);
 #include "glib-compat.h"
 #include "qemu/typedefs.h"
 
+/*
+ * According to waitpid man page:
+ * WCOREDUMP
+ *  This  macro  is  not  specified  in POSIX.1-2001 and is not
+ *  available on some UNIX implementations (e.g., AIX, SunOS).
+ *  Therefore, enclose its use inside #ifdef WCOREDUMP ... #endif.
+ */
+#ifndef WCOREDUMP
+#define WCOREDUMP(status) 0
+#endif
 /*
  * We have a lot of unaudited code that may fail in strange ways, or
  * even be a security risk during migration, if you disable assertions
-- 
MST
