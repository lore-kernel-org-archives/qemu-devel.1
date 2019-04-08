Received: from eggs.gnu.org ([209.51.188.92]:48932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDPla-00089L-H8
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:36:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDPlZ-0003eS-KS
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:36:34 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  8 Apr 2019 10:36:13 +0200
Message-Id: <20190408083627.7479-2-armbru@redhat.com>
In-Reply-To: <20190408083627.7479-1-armbru@redhat.com>
References: <20190408083627.7479-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 01/15] qemu-img: Use error_vreport() in
 error_exit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

error_exit() uses low-level error_printf() to report errors.
Modernize it to use error_vreport().

Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qemu-img.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index aa6f81f1ea..55201fb913 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -85,13 +85,11 @@ static void QEMU_NORETURN GCC_FMT_ATTR(1, 2) error_exit(const char *fmt, ...)
 {
     va_list ap;
 
-    error_printf("qemu-img: ");
-
     va_start(ap, fmt);
-    error_vprintf(fmt, ap);
+    error_vreport(fmt, ap);
     va_end(ap);
 
-    error_printf("\nTry 'qemu-img --help' for more information\n");
+    error_printf("Try 'qemu-img --help' for more information\n");
     exit(EXIT_FAILURE);
 }
 
-- 
2.17.2
