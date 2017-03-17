Received: from eggs.gnu.org ([2001:4830:134:3::10]:47977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cot2G-0001rh-KK
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 10:39:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cot2C-0006EY-NY
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 10:39:20 -0400
Received: from 5.mo69.mail-out.ovh.net ([46.105.43.105]:36770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cot2C-0006EH-Dh
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 10:39:16 -0400
Received: from player738.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 96F4B1DE64
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 15:39:14 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 17 Mar 2017 15:39:10 +0100
Message-ID: <148976155089.11859.11860739290129101204.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2] 9pfs: proxy: assert if unmarshal fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Greg Kurz <groug@kaod.org>

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

Note that we don't want to use sizeof() in the checks since the value
we want to use depends on the format rather than the size of the buffer.
Short marshal formats can be handled with numerical values. Size macros
are introduced for bigger ones (ProxyStat and ProxyStatFS).

This should also address Coverity's complaints CID 1348519 and CID 1348520,
about not always checking the return value of proxy_unmarshal().

Signed-off-by: Greg Kurz <groug@kaod.org>
---
v2: - added PROXY_STAT_SZ and PROXY_STATFS_SZ macros
    - updated changelog
---
 hw/9pfs/9p-proxy.c |   24 +++++++++++++-----------
 hw/9pfs/9p-proxy.h |   10 ++++++++--
 2 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/hw/9pfs/9p-proxy.c b/hw/9pfs/9p-proxy.c
index f4aa7a9d70f8..363bea66035e 100644
--- a/hw/9pfs/9p-proxy.c
+++ b/hw/9pfs/9p-proxy.c
@@ -165,7 +165,8 @@ static int v9fs_receive_response(V9fsProxy *proxy, int type,
         return retval;
     }
     reply->iov_len = PROXY_HDR_SZ;
-    proxy_unmarshal(reply, 0, "dd", &header.type, &header.size);
+    retval = proxy_unmarshal(reply, 0, "dd", &header.type, &header.size);
+    assert(retval == 8);
     /*
      * if response size > PROXY_MAX_IO_SZ, read the response but ignore it and
      * return -ENOBUFS
@@ -194,15 +195,14 @@ static int v9fs_receive_response(V9fsProxy *proxy, int type,
     if (header.type == T_ERROR) {
         int ret;
         ret = proxy_unmarshal(reply, PROXY_HDR_SZ, "d", status);
-        if (ret < 0) {
-            *status = ret;
-        }
+        assert(ret == 4);
         return 0;
     }
 
     switch (type) {
     case T_LSTAT: {
         ProxyStat prstat;
+        QEMU_BUILD_BUG_ON(sizeof(prstat) != PROXY_STAT_SZ);
         retval = proxy_unmarshal(reply, PROXY_HDR_SZ,
                                  "qqqdddqqqqqqqqqq", &prstat.st_dev,
                                  &prstat.st_ino, &prstat.st_nlink,
@@ -213,11 +213,13 @@ static int v9fs_receive_response(V9fsProxy *proxy, int type,
                                  &prstat.st_atim_sec, &prstat.st_atim_nsec,
                                  &prstat.st_mtim_sec, &prstat.st_mtim_nsec,
                                  &prstat.st_ctim_sec, &prstat.st_ctim_nsec);
+        assert(retval == PROXY_STAT_SZ);
         prstat_to_stat(response, &prstat);
         break;
     }
     case T_STATFS: {
         ProxyStatFS prstfs;
+        QEMU_BUILD_BUG_ON(sizeof(prstfs) != PROXY_STATFS_SZ);
         retval = proxy_unmarshal(reply, PROXY_HDR_SZ,
                                  "qqqqqqqqqqq", &prstfs.f_type,
                                  &prstfs.f_bsize, &prstfs.f_blocks,
@@ -225,6 +227,7 @@ static int v9fs_receive_response(V9fsProxy *proxy, int type,
                                  &prstfs.f_files, &prstfs.f_ffree,
                                  &prstfs.f_fsid[0], &prstfs.f_fsid[1],
                                  &prstfs.f_namelen, &prstfs.f_frsize);
+        assert(retval == PROXY_STATFS_SZ);
         prstatfs_to_statfs(response, &prstfs);
         break;
     }
@@ -246,7 +249,8 @@ static int v9fs_receive_response(V9fsProxy *proxy, int type,
         break;
     }
     case T_GETVERSION:
-        proxy_unmarshal(reply, PROXY_HDR_SZ, "q", response);
+        retval = proxy_unmarshal(reply, PROXY_HDR_SZ, "q", response);
+        assert(retval == 8);
         break;
     default:
         return -1;
@@ -274,18 +278,16 @@ static int v9fs_receive_status(V9fsProxy *proxy,
         return retval;
     }
     reply->iov_len = PROXY_HDR_SZ;
-    proxy_unmarshal(reply, 0, "dd", &header.type, &header.size);
-    if (header.size != sizeof(int)) {
-        *status = -ENOBUFS;
-        return 0;
-    }
+    retval = proxy_unmarshal(reply, 0, "dd", &header.type, &header.size);
+    assert(retval == 8);
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
 
diff --git a/hw/9pfs/9p-proxy.h b/hw/9pfs/9p-proxy.h
index b84301d001b0..918c45016a3c 100644
--- a/hw/9pfs/9p-proxy.h
+++ b/hw/9pfs/9p-proxy.h
@@ -79,7 +79,10 @@ typedef struct {
     uint64_t st_mtim_nsec;
     uint64_t st_ctim_sec;
     uint64_t st_ctim_nsec;
-} ProxyStat;
+} QEMU_PACKED ProxyStat;
+
+#define PROXY_STAT_SZ \
+    (8 + 8 + 8 + 4 + 4 + 4 + 8 + 8 + 8 + 8 + 8 + 8 + 8 + 8 + 8 + 8)
 
 typedef struct {
     uint64_t f_type;
@@ -92,5 +95,8 @@ typedef struct {
     uint64_t f_fsid[2];
     uint64_t f_namelen;
     uint64_t f_frsize;
-} ProxyStatFS;
+} QEMU_PACKED ProxyStatFS;
+
+#define PROXY_STATFS_SZ (8 + 8 + 8 + 8 + 8 + 8 + 8 + 8 * 2 + 8 + 8)
+
 #endif
