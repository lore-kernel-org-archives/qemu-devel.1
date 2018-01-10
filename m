Received: from eggs.gnu.org ([2001:4830:134:3::10]:33965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eZMws-0001J6-Ni
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 15:26:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eZMwr-0001Jo-On
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 15:26:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eZMwr-0001I7-9W
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 15:26:09 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 10 Jan 2018 20:25:51 +0000
Message-Id: <20180110202553.31889-2-stefanha@redhat.com>
In-Reply-To: <20180110202553.31889-1-stefanha@redhat.com>
References: <20180110202553.31889-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] tracetool: prefix parse errors with line
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
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Include the file line number in the message that is printed when
trace-events parse errors are raised.

Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/tracetool/__init__.py | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
index 0670ec17d5..fbccaaa0cf 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -300,13 +300,18 @@ def read_events(fobj):
     """
 
     events = []
-    for line in fobj:
+    for lineno, line in enumerate(fobj):
         if not line.strip():
             continue
         if line.lstrip().startswith('#'):
             continue
 
-        event = Event.build(line)
+        try:
+            event = Event.build(line)
+        except ValueError as e:
+            arg0 = 'Error on line %d: %s' % (lineno + 1, e.args[0])
+            e.args = (arg0,) + e.args[1:]
+            raise
 
         # transform TCG-enabled events
         if "tcg" not in event.properties:
-- 
2.14.3
