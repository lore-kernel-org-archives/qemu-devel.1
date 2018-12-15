Received: from eggs.gnu.org ([2001:4830:134:3::10]:34195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gYANw-0004aX-R6
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 08:53:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gYANw-0007xG-1x
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 08:53:40 -0500
From: Eric Blake <eblake@redhat.com>
Date: Sat, 15 Dec 2018 07:53:03 -0600
Message-Id: <20181215135324.152629-2-eblake@redhat.com>
In-Reply-To: <20181215135324.152629-1-eblake@redhat.com>
References: <20181215135324.152629-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 01/22] qemu-nbd: Use program name in error
 messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: nsoffer@redhat.com, jsnow@redhat.com, rjones@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This changes output from:

$ qemu-nbd nosuch
Failed to blk_new_open 'nosuch': Could not open 'nosuch': No such file or directory

to something more consistent with qemu-img and qemu:

$ qemu-nbd nosuch
qemu-nbd: Failed to blk_new_open 'nosuch': Could not open 'nosuch': No such file or directory

Update the lone affected test to match.  (Hmm - is it sad that we don't
do much testing of expected failures?)

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qemu-nbd.c                 | 1 +
 tests/qemu-iotests/233.out | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index ca7109652e5..e169b839ece 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -571,6 +571,7 @@ int main(int argc, char **argv)
 #endif

     module_call_init(MODULE_INIT_TRACE);
+    error_set_progname(argv[0]);
     qcrypto_init(&error_fatal);

     module_call_init(MODULE_INIT_QOM);
diff --git a/tests/qemu-iotests/233.out b/tests/qemu-iotests/233.out
index 94acd9b9479..5f416721b03 100644
--- a/tests/qemu-iotests/233.out
+++ b/tests/qemu-iotests/233.out
@@ -27,7 +27,7 @@ virtual size: 64M (67108864 bytes)
 disk size: unavailable

 == check TLS with different CA fails ==
-option negotiation failed: Verify failed: No certificate was found.
+qemu-nbd: option negotiation failed: Verify failed: No certificate was found.
 qemu-img: Could not open 'driver=nbd,host=127.0.0.1,port=PORT,tls-creds=tls0': The certificate hasn't got a known issuer

 == perform I/O over TLS ==
-- 
2.17.2
