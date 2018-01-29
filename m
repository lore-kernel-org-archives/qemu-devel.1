Received: from eggs.gnu.org ([2001:4830:134:3::10]:42189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1egBz0-0008EM-Sg
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:08:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1egByx-0006ww-JB
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:08:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1egByx-0006wX-Ct
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:08:31 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 29 Jan 2018 16:07:38 +0000
Message-Id: <20180129160740.1195-2-stefanha@redhat.com>
In-Reply-To: <20180129160740.1195-1-stefanha@redhat.com>
References: <20180129160740.1195-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 1/3] tracetool: prefix parse errors with line
 numbers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

Include the file line number in the message that is printed when
trace-events parse errors are raised.

[Use enumerate(fobj, 1) to avoid having to increment a 0-based index
later, as suggested by Eric Blake.
--Stefan]

Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20180110202553.31889-2-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/tracetool/__init__.py | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
index 0670ec17d5..a744e26f91 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -300,13 +300,18 @@ def read_events(fobj):
     """
 
     events = []
-    for line in fobj:
+    for lineno, line in enumerate(fobj, 1):
         if not line.strip():
             continue
         if line.lstrip().startswith('#'):
             continue
 
-        event = Event.build(line)
+        try:
+            event = Event.build(line)
+        except ValueError as e:
+            arg0 = 'Error on line %d: %s' % (lineno, e.args[0])
+            e.args = (arg0,) + e.args[1:]
+            raise
 
         # transform TCG-enabled events
         if "tcg" not in event.properties:
-- 
2.14.3
