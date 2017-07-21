Received: from eggs.gnu.org ([2001:4830:134:3::10]:34357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dYYyF-00066M-8u
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:32:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dYYyC-0001Zm-Tu
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:31:59 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:34750 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dYYyC-0001W1-Gg
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:31:56 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 21 Jul 2017 17:31:48 +0300
Message-Id: <20170721143149.43721-2-vsementsov@virtuozzo.com>
In-Reply-To: <20170721143149.43721-1-vsementsov@virtuozzo.com>
References: <20170721143149.43721-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 1/2] trace: do not calculate arguments for
 disabled trace-points
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, dgilbert@redhat.com, armbru@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Do not calculate arguments if trace-point is disabled. For this:
 - move to macro do { ... } while (0) scheme
 - use additional macro-layer to handle calls of trace-points where
   a macro generates parameter list
   (like trace_e1000e_mac_set_permanent(MAC_ARG(macaddr)))

This is needed to allow some additional logic in trace-point parameter
calculation, which will not be executed if this trace-point is
disabled.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 scripts/tracetool/format/h.py | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/scripts/tracetool/format/h.py b/scripts/tracetool/format/h.py
index aecf249d66..d0baccc453 100644
--- a/scripts/tracetool/format/h.py
+++ b/scripts/tracetool/format/h.py
@@ -73,12 +73,13 @@ def generate(events, backend, group):
             cond = "true"
 
         out('',
-            'static inline void %(api)s(%(args)s)',
-            '{',
-            '    if (%(cond)s) {',
-            '        %(api_nocheck)s(%(names)s);',
-            '    }',
-            '}',
+            '#define %(api)s(...)  _do_%(api)s(__VA_ARGS__)',
+            '#define _do_%(api)s(%(names)s) \\',
+            'do { \\',
+            '    if (%(cond)s) { \\',
+            '        %(api_nocheck)s(%(names)s); \\',
+            '    } \\',
+            '} while (0)',
             api=e.api(),
             api_nocheck=e.api(e.QEMU_TRACE_NOCHECK),
             args=e.args,
-- 
2.11.1
