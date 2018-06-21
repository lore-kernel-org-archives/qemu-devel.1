Received: from eggs.gnu.org ([2001:4830:134:3::10]:50169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fW38z-0004fw-Jq
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:13:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fW38x-00021C-0u
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:13:13 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 21 Jun 2018 14:12:47 -0300
Message-Id: <20180621171257.14897-2-f4bug@amsat.org>
In-Reply-To: <20180621171257.14897-1-f4bug@amsat.org>
References: <20180621171257.14897-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 01/11] trace: Fix format string for the struct
 timeval members casted to size_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

This fixes when using GCC with -Wformat-signedness:

    migration/trace.h: In function ‘_nocheck__trace_dirty_bitmap_load_success’:
    migration/trace.h:6368:24: error: format ‘%zd’ expects argument of type ‘signed size_t’, but argument 3 has type ‘long unsigned int’ [-Werror=format=]
      qemu_log("%d@%zd.%06zd:dirty_bitmap_load_success " "" "\n",
                   ~~^
                   %ld
    migration/trace.h:6370:18:
               (size_t)_now.tv_sec, (size_t)_now.tv_usec
               ~~~~~~~~~~~~~~~~~~~
    migration/trace.h:6368:30: error: format ‘%zd’ expects argument of type ‘signed size_t’, but argument 4 has type ‘long unsigned int’ [-Werror=format=]
      qemu_log("%d@%zd.%06zd:dirty_bitmap_load_success " "" "\n",
                       ~~~~^
                       %06ld
    migration/trace.h:6370:39:
               (size_t)_now.tv_sec, (size_t)_now.tv_usec
                                    ~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 scripts/tracetool/backend/log.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend/log.py
index 78933d03ad..6751f41bc5 100644
--- a/scripts/tracetool/backend/log.py
+++ b/scripts/tracetool/backend/log.py
@@ -38,7 +38,7 @@ def generate_h(event, group):
     out('    if (%(cond)s && qemu_loglevel_mask(LOG_TRACE)) {',
         '        struct timeval _now;',
         '        gettimeofday(&_now, NULL);',
-        '        qemu_log("%%d@%%zd.%%06zd:%(name)s " %(fmt)s "\\n",',
+        '        qemu_log("%%d@%%zu.%%06zu:%(name)s " %(fmt)s "\\n",',
         '                 getpid(),',
         '                 (size_t)_now.tv_sec, (size_t)_now.tv_usec',
         '                 %(argnames)s);',
-- 
2.18.0.rc2
