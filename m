Received: from eggs.gnu.org ([2001:4830:134:3::10]:37491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cp1Ah-0003gx-KD
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 19:20:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cp1Ac-0004pn-KG
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 19:20:35 -0400
Received: from 10.mo69.mail-out.ovh.net ([46.105.73.241]:48694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cp1Ac-0004pd-DN
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 19:20:30 -0400
Received: from player738.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 874171C870
	for <qemu-devel@nongnu.org>; Sat, 18 Mar 2017 00:20:27 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Sat, 18 Mar 2017 00:20:19 +0100
Message-ID: <148979281961.4342.6047114276763582872.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3] 9pfs: proxy: assert if unmarshal fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Replies from the virtfs proxy are made up of a fixed-size header (8 bytes)
and a payload of variable size (maximum 64kb). When receiving a reply,
the proxy backend first reads the whole header and then unmarshals it.
If the header is okay, it then does the same operation with the payload.

Since the proxy backend uses a pre-allocated buffer which has enough room
for a header and the maximum payload size, marshalling should never fail
with fixed size arguments. Any error here is likely to result from a more
serious corruption in QEMU and we'd better dump core right away.

This patch adds error checks where they are missing and converts the
associated error paths into assertions.

This should also address Coverity's complaints CID 1348519 and CID 1348520,
about not always checking the return value of proxy_unmarshal().

Signed-off-by: Greg Kurz <groug@kaod.org>
---
v3: - completely get rid of sizeof() and QEMU_BUILD_BUG_ON() as it was
      confusing. Only use literal values in checks finally.
---
 hw/9pfs/9p-proxy.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/9pfs/9p-proxy.c b/hw/9pfs/9p-proxy.c
index f4aa7a9d70f8..28b20a7c3dfa 100644
--- a/hw/9pfs/9p-proxy.c
+++ b/hw/9pfs/9p-proxy.c
@@ -165,7 +165,8 @@ static int v9fs_receive_response(V9fsProxy *proxy, int type,
         return retval;
     }
     reply->iov_len = PROXY_HDR_SZ;
-    proxy_unmarshal(reply, 0, "dd", &header.type, &header.size);
+    retval = proxy_unmarshal(reply, 0, "dd", &header.type, &header.size);
+    assert(retval == 4 * 2);
     /*
      * if response size > PROXY_MAX_IO_SZ, read the response but ignore it and
      * return -ENOBUFS
@@ -194,9 +195,7 @@ static int v9fs_receive_response(V9fsProxy *proxy, int type,
     if (header.type == T_ERROR) {
         int ret;
         ret = proxy_unmarshal(reply, PROXY_HDR_SZ, "d", status);
-        if (ret < 0) {
-            *status = ret;
-        }
+        assert(ret == 4);
         return 0;
     }
 
@@ -213,6 +212,7 @@ static int v9fs_receive_response(V9fsProxy *proxy, int type,
                                  &prstat.st_atim_sec, &prstat.st_atim_nsec,
                                  &prstat.st_mtim_sec, &prstat.st_mtim_nsec,
                                  &prstat.st_ctim_sec, &prstat.st_ctim_nsec);
+        assert(retval == 8 * 3 + 4 * 3 + 8 * 10);
         prstat_to_stat(response, &prstat);
         break;
     }
@@ -225,6 +225,7 @@ static int v9fs_receive_response(V9fsProxy *proxy, int type,
                                  &prstfs.f_files, &prstfs.f_ffree,
                                  &prstfs.f_fsid[0], &prstfs.f_fsid[1],
                                  &prstfs.f_namelen, &prstfs.f_frsize);
+        assert(retval == 8 * 11);
         prstatfs_to_statfs(response, &prstfs);
         break;
     }
@@ -246,7 +247,8 @@ static int v9fs_receive_response(V9fsProxy *proxy, int type,
         break;
     }
     case T_GETVERSION:
-        proxy_unmarshal(reply, PROXY_HDR_SZ, "q", response);
+        retval = proxy_unmarshal(reply, PROXY_HDR_SZ, "q", response);
+        assert(retval == 8);
         break;
     default:
         return -1;
@@ -274,18 +276,16 @@ static int v9fs_receive_status(V9fsProxy *proxy,
         return retval;
     }
     reply->iov_len = PROXY_HDR_SZ;
-    proxy_unmarshal(reply, 0, "dd", &header.type, &header.size);
-    if (header.size != sizeof(int)) {
-        *status = -ENOBUFS;
-        return 0;
-    }
+    retval = proxy_unmarshal(reply, 0, "dd", &header.type, &header.size);
+    assert(retval == 4 * 2);
     retval = socket_read(proxy->sockfd,
                          reply->iov_base + PROXY_HDR_SZ, header.size);
     if (retval < 0) {
         return retval;
     }
     reply->iov_len += header.size;
-    proxy_unmarshal(reply, PROXY_HDR_SZ, "d", status);
+    retval = proxy_unmarshal(reply, PROXY_HDR_SZ, "d", status);
+    assert(retval == 4);
     return 0;
 }
 
