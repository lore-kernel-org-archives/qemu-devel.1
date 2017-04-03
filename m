Received: from eggs.gnu.org ([2001:4830:134:3::10]:45680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cv3zw-0006Gb-6m
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 11:34:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cv3zv-0007QE-9p
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 11:34:28 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon,  3 Apr 2017 17:33:47 +0200
Message-Id: <20170403153355.19722-8-mreitz@redhat.com>
In-Reply-To: <20170403153355.19722-1-mreitz@redhat.com>
References: <20170403153355.19722-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 07/15] qapi-schema: SocketAddressFlat variants
 'vsock' and 'fd'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: Markus Armbruster <armbru@redhat.com>

Note that the new variants are impossible in qemu_gluster_glfs_init(),
because the gconf->server can only come from qemu_gluster_parse_uri()
or qemu_gluster_parse_json(), and neither can create anything but
'inet' or 'unix'.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 1490895797-29094-7-git-send-email-armbru@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi-schema.json | 19 ++++++++-----------
 block/gluster.c  |  2 ++
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index b921994ae3..250e4dc49b 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -4144,7 +4144,7 @@
 # Since: 2.9
 ##
 { 'enum': 'SocketAddressFlatType',
-  'data': [ 'unix', 'inet' ] }
+  'data': [ 'inet', 'unix', 'vsock', 'fd' ] }
 
 ##
 # @SocketAddressFlat:
@@ -4153,22 +4153,19 @@
 #
 # @type:       Transport type
 #
-# This is similar to SocketAddress, only distinction:
-#
-# 1. SocketAddressFlat is a flat union, SocketAddress is a simple union.
-#    A flat union is nicer than simple because it avoids nesting
-#    (i.e. more {}) on the wire.
-#
-# 2. SocketAddressFlat supports only types 'unix' and 'inet', because
-#    that's what its current users need.
+# This is just like SocketAddress, except it's a flat union rather
+# than a simple union.  Nicer because it avoids nesting on the wire,
+# i.e. this form has fewer {}.
 #
 # Since: 2.9
 ##
 { 'union': 'SocketAddressFlat',
   'base': { 'type': 'SocketAddressFlatType' },
   'discriminator': 'type',
-  'data': { 'unix': 'UnixSocketAddress',
-            'inet': 'InetSocketAddress' } }
+  'data': { 'inet': 'InetSocketAddress',
+            'unix': 'UnixSocketAddress',
+            'vsock': 'VsockSocketAddress',
+            'fd': 'String' } }
 
 ##
 # @getfd:
diff --git a/block/gluster.c b/block/gluster.c
index fb0aafeaa3..cf29b5f9a4 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -429,6 +429,8 @@ static struct glfs *qemu_gluster_glfs_init(BlockdevOptionsGluster *gconf,
                                    server->value->u.inet.host,
                                    (int)port);
             break;
+        case SOCKET_ADDRESS_FLAT_TYPE_VSOCK:
+        case SOCKET_ADDRESS_FLAT_TYPE_FD:
         default:
             abort();
         }
-- 
2.12.1
