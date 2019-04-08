Received: from eggs.gnu.org ([209.51.188.92]:55447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hDVO2-0007MD-AD
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 10:36:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hDVO1-0000VV-9W
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 10:36:38 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  8 Apr 2019 16:35:43 +0200
Message-Id: <20190408143543.3982-5-kwolf@redhat.com>
In-Reply-To: <20190408143543.3982-1-kwolf@redhat.com>
References: <20190408143543.3982-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/4] file-posix: Add dynamic-auto-read-only
 QAPI feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

In commit 23dece19da4 ('file-posix: Make auto-read-only dynamic') ,
auto-read-only=3Don changed its behaviour in file-posix for the 4.0
release. This change cannot be detected through the usual mechanisms
like schema introspection. Add a new feature flag to the schema to
allow libvirt to detect the presence of the new behaviour.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 7ccbfff9d0..4f96d5846b 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2843,6 +2843,13 @@
 #                         file is large, do not use in production.
 #                         (default: off) (since: 3.0)
 #
+# If the feature 'dynamic-auto-read-only' is present, enabled auto-read-=
only
+# means that the driver will open the image read-only at first, dynamica=
lly
+# reopen the image file read-write when the first writer is attached to =
the
+# node and reopen read-only when the last writer is detached. This allow=
s to
+# give QEMU write permissions only on demand when an operation actually =
needs
+# write access.
+#
 # Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsFile',
@@ -2852,7 +2859,9 @@
             '*aio': 'BlockdevAioOptions',
 	    '*drop-cache': {'type': 'bool',
 	                    'if': 'defined(CONFIG_LINUX)'},
-            '*x-check-cache-dropped': 'bool' } }
+            '*x-check-cache-dropped': 'bool' },
+  'features': [ { 'name': 'dynamic-auto-read-only',
+                  'if': 'defined(CONFIG_POSIX)' } ] }
=20
 ##
 # @BlockdevOptionsNull:
--=20
2.20.1
