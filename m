Received: from eggs.gnu.org ([2001:4830:134:3::10]:50591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e9H7G-0008To-V4
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 16:57:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e9H7G-0001FB-28
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 16:57:03 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 30 Oct 2017 21:56:29 +0100
Message-Id: <20171030205636.14236-6-eblake@redhat.com>
In-Reply-To: <20171030205636.14236-1-eblake@redhat.com>
References: <20171030205636.14236-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 05/12] nbd/server: Simplify
 nbd_negotiate_options loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

Instead of making each caller check whether a transmission error
occurred, we can sink a common error check to the end of the loop.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20171027104037.8319-6-eblake@redhat.com>
[eblake: squash in compiler warning fix]
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/server.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 05ff7470d5..2f03059b4c 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -678,6 +678,7 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
                 if (!tioc) {
                     return -EIO;
                 }
+                ret = 0;
                 object_unref(OBJECT(client->ioc));
                 client->ioc = QIO_CHANNEL(tioc);
                 break;
@@ -698,9 +699,6 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
                                                  "Option 0x%" PRIx32
                                                  "not permitted before TLS",
                                                  option);
-                if (ret < 0) {
-                    return ret;
-                }
                 /* Let the client keep trying, unless they asked to
                  * quit. In this mode, we've already sent an error, so
                  * we can't ack the abort.  */
@@ -713,9 +711,6 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
             switch (option) {
             case NBD_OPT_LIST:
                 ret = nbd_negotiate_handle_list(client, length, errp);
-                if (ret < 0) {
-                    return ret;
-                }
                 break;

             case NBD_OPT_ABORT:
@@ -738,9 +733,6 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
                     assert(option == NBD_OPT_GO);
                     return 0;
                 }
-                if (ret) {
-                    return ret;
-                }
                 break;

             case NBD_OPT_STARTTLS:
@@ -758,9 +750,6 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
                                                      option, errp,
                                                      "TLS not configured");
                 }
-                if (ret < 0) {
-                    return ret;
-                }
                 break;
             default:
                 if (nbd_drop(client->ioc, length, errp) < 0) {
@@ -772,9 +761,6 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
                                                  "Unsupported option 0x%"
                                                  PRIx32 " (%s)", option,
                                                  nbd_opt_lookup(option));
-                if (ret < 0) {
-                    return ret;
-                }
                 break;
             }
         } else {
@@ -794,6 +780,9 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
                 return -EINVAL;
             }
         }
+        if (ret < 0) {
+            return ret;
+        }
     }
 }

-- 
2.13.6
