Received: from eggs.gnu.org ([2001:4830:134:3::10]:57251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e824P-0001E6-EL
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 06:40:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e824O-0005bZ-Li
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 06:40:57 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri, 27 Oct 2017 12:40:30 +0200
Message-Id: <20171027104037.8319-6-eblake@redhat.com>
In-Reply-To: <20171027104037.8319-1-eblake@redhat.com>
References: <20171027104037.8319-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v6 05/12] nbd/server: Simplify
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
Cc: pbonzini@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

Instead of making each caller check whether a transmission error
occurred, we can sink a common error check to the end of the loop.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v6: split from length validation [Vladimir]
---
 nbd/server.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 05ff7470d5..6af708662d 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -698,9 +698,6 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
                                                  "Option 0x%" PRIx32
                                                  "not permitted before TLS",
                                                  option);
-                if (ret < 0) {
-                    return ret;
-                }
                 /* Let the client keep trying, unless they asked to
                  * quit. In this mode, we've already sent an error, so
                  * we can't ack the abort.  */
@@ -713,9 +710,6 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
             switch (option) {
             case NBD_OPT_LIST:
                 ret = nbd_negotiate_handle_list(client, length, errp);
-                if (ret < 0) {
-                    return ret;
-                }
                 break;

             case NBD_OPT_ABORT:
@@ -738,9 +732,6 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
                     assert(option == NBD_OPT_GO);
                     return 0;
                 }
-                if (ret) {
-                    return ret;
-                }
                 break;

             case NBD_OPT_STARTTLS:
@@ -758,9 +749,6 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
                                                      option, errp,
                                                      "TLS not configured");
                 }
-                if (ret < 0) {
-                    return ret;
-                }
                 break;
             default:
                 if (nbd_drop(client->ioc, length, errp) < 0) {
@@ -772,9 +760,6 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
                                                  "Unsupported option 0x%"
                                                  PRIx32 " (%s)", option,
                                                  nbd_opt_lookup(option));
-                if (ret < 0) {
-                    return ret;
-                }
                 break;
             }
         } else {
@@ -794,6 +779,9 @@ static int nbd_negotiate_options(NBDClient *client, uint16_t myflags,
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
