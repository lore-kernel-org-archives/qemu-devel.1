Received: from eggs.gnu.org ([2001:4830:134:3::10]:43336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKCK-0004ii-OL
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:47:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKCH-0001dg-N2
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:47:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60192)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKCH-0001cj-DZ
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:57 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0hZuK130750
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:56 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27bdkvs7cv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:56 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 19:46:54 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:50 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-57-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 56/67] block/curl: Remember all sockets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>

From: Max Reitz <mreitz@redhat.com>

For some connection types (like FTP, generally), more than one socket
may be used (in FTP's case: control vs. data stream). As of commit
838ef602498b8d1985a231a06f5e328e2946a81d ("curl: Eliminate unnecessary
use of curl_multi_socket_all"), we have to remember all of the sockets
used by libcurl, but in fact we only did that for a single one. Since
one libcurl connection may use multiple sockets, however, we have to
remember them all.

Cc: qemu-stable@nongnu.org
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20161025025431.24714-4-mreitz@redhat.com
Signed-off-by: Jeff Cody <jcody@redhat.com>
(cherry picked from commit ff5ca1664af85b24a4180d595ea6873fd3deac57)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/curl.c | 47 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index f47f4e6..600d032 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -105,12 +105,17 @@ typedef struct CURLAIOCB {
     size_t end;
 } CURLAIOCB;
 
+typedef struct CURLSocket {
+    int fd;
+    QLIST_ENTRY(CURLSocket) next;
+} CURLSocket;
+
 typedef struct CURLState
 {
     struct BDRVCURLState *s;
     CURLAIOCB *acb[CURL_NUM_ACB];
     CURL *curl;
-    curl_socket_t sock_fd;
+    QLIST_HEAD(, CURLSocket) sockets;
     char *orig_buf;
     size_t buf_start;
     size_t buf_off;
@@ -164,10 +169,27 @@ static int curl_sock_cb(CURL *curl, curl_socket_t fd, int action,
 {
     BDRVCURLState *s;
     CURLState *state = NULL;
+    CURLSocket *socket;
+
     curl_easy_getinfo(curl, CURLINFO_PRIVATE, (char **)&state);
-    state->sock_fd = fd;
     s = state->s;
 
+    QLIST_FOREACH(socket, &state->sockets, next) {
+        if (socket->fd == fd) {
+            if (action == CURL_POLL_REMOVE) {
+                QLIST_REMOVE(socket, next);
+                g_free(socket);
+            }
+            break;
+        }
+    }
+    if (!socket) {
+        socket = g_new0(CURLSocket, 1);
+        socket->fd = fd;
+        QLIST_INSERT_HEAD(&state->sockets, socket, next);
+    }
+    socket = NULL;
+
     DPRINTF("CURL (AIO): Sock action %d on fd %d\n", action, (int)fd);
     switch (action) {
         case CURL_POLL_IN:
@@ -355,6 +377,7 @@ static void curl_multi_check_completion(BDRVCURLState *s)
 static void curl_multi_do(void *arg)
 {
     CURLState *s = (CURLState *)arg;
+    CURLSocket *socket, *next_socket;
     int running;
     int r;
 
@@ -362,10 +385,13 @@ static void curl_multi_do(void *arg)
         return;
     }
 
-    do {
-        r = curl_multi_socket_action(s->s->multi, s->sock_fd, 0, &running);
-    } while(r == CURLM_CALL_MULTI_PERFORM);
-
+    /* Need to use _SAFE because curl_multi_socket_action() may trigger
+     * curl_sock_cb() which might modify this list */
+    QLIST_FOREACH_SAFE(socket, &s->sockets, next, next_socket) {
+        do {
+            r = curl_multi_socket_action(s->s->multi, socket->fd, 0, &running);
+        } while (r == CURLM_CALL_MULTI_PERFORM);
+    }
 }
 
 static void curl_multi_read(void *arg)
@@ -469,6 +495,7 @@ static CURLState *curl_init_state(BlockDriverState *bs, BDRVCURLState *s)
 #endif
     }
 
+    QLIST_INIT(&state->sockets);
     state->s = s;
 
     return state;
@@ -478,6 +505,14 @@ static void curl_clean_state(CURLState *s)
 {
     if (s->s->multi)
         curl_multi_remove_handle(s->s->multi, s->curl);
+
+    while (!QLIST_EMPTY(&s->sockets)) {
+        CURLSocket *socket = QLIST_FIRST(&s->sockets);
+
+        QLIST_REMOVE(socket, next);
+        g_free(socket);
+    }
+
     s->in_use = 0;
 }
 
-- 
1.9.1
