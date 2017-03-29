Received: from eggs.gnu.org ([2001:4830:134:3::10]:47895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ctGiv-0004KN-Tu
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 12:45:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ctGiu-00069e-UO
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 12:45:29 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 29 Mar 2017 18:45:18 +0200
Message-Id: <1490805920-17029-7-git-send-email-armbru@redhat.com>
In-Reply-To: <1490805920-17029-1-git-send-email-armbru@redhat.com>
References: <1490805920-17029-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [for-2.9 6/8] qapi-schema: SocketAddressFlat variants
 'vsock' and 'fd'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, pbonzini@redhat.com

Note that the new variants are impossible in qemu_gluster_glfs_init(),
because the gconf->server can only come from qemu_gluster_parse_uri()
or qemu_gluster_parse_json(), and neither can create anything but
'tcp' or 'unix'.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/gluster.c  |  2 ++
 qapi-schema.json | 19 ++++++++-----------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/block/gluster.c b/block/gluster.c
index fb0aafe..cf29b5f 100644
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
diff --git a/qapi-schema.json b/qapi-schema.json
index b921994..927c9a2 100644
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
+# than a simple union.  Nicer because it avoids nesting (i.e. more {})
+# on the wire.
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
-- 
2.7.4
