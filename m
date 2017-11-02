Received: from eggs.gnu.org ([2001:4830:134:3::10]:48856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tuxillo@quantumachine.net>) id 1eAInF-0008U6-Cb
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 12:56:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tuxillo@quantumachine.net>) id 1eAInC-0000dX-BM
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 12:56:37 -0400
Received: from mailrelay.quantumachine.net ([37.59.103.225]:47276)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tuxillo@quantumachine.net>) id 1eAInC-0000c3-1s
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 12:56:34 -0400
Received: from mail.quantumachine.net (unknown [185.48.86.222])
	by mailrelay.quantumachine.net (Postfix) with ESMTP id 726215D
	for <qemu-devel@nongnu.org>; Thu,  2 Nov 2017 17:56:31 +0100 (CET)
Date: Thu, 02 Nov 2017 16:56:29 +0000
Message-ID: <20171102165629.Horde.3vL2RJXzulVHv5PiXG00Bz4@www.quantumachine.net>
From: Antonio Huete =?utf-8?b?Smltw6luZXo=?= <tuxillo@quantumachine.net>
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] sockets: Normalize test for addrinfo flag
 AI_V4MAPPED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

 From 2b4d9d8cb617445af8f3b062f917dfea42dbdc27 Mon Sep 17 00:00:00 2001
From: Antonio Huete Jimenez <tuxillo@quantumachine.net>
Date: Thu, 2 Nov 2017 17:46:24 +0100
Subject: [PATCH] sockets: Normalize test for addrinfo flag AI_V4MAPPED

Signed-off-by: Antonio Huete Jimenez <tuxillo@quantumachine.net>
---
  util/qemu-sockets.c | 54  
+++++++++++++++++++++++++++++++++--------------------
  1 file changed, 34 insertions(+), 20 deletions(-)

diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index b47fb45885..ce35b6a998 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -44,7 +44,6 @@
  # define AI_NUMERICSERV 0
  #endif

-
  static int inet_getport(struct addrinfo *e)
  {
      struct sockaddr_in *i4;
@@ -149,6 +148,31 @@ int inet_ai_family_from_address(InetSocketAddress *addr,
      return PF_UNSPEC;
  }

+static int
+check_ai_v4mapped(const char *host, const char *port, struct addrinfo *ai,
+               struct addrinfo *res)
+{
+    static int useV4Mapped = -1;
+    int rc;
+
+    /* At least FreeBSD and OS-X 10.6 declare AI_V4MAPPED but
+     * then don't implement it in their getaddrinfo().
+     * Unconditionally deselect AI_V4MAPPED option upon
+     * getaddrinfo() failure, the next call to it will have to
+     * do the error handling.
+     */
+    if (atomic_read(&useV4Mapped) == -1) {
+        rc = getaddrinfo(host, port, ai, &res);
+        if (rc == 0 && (ai->ai_flags & AI_V4MAPPED)) {
+            atomic_set(&useV4Mapped, 1);
+        } else {
+            atomic_set(&useV4Mapped, 0);
+        }
+    }
+
+    return useV4Mapped;
+}
+
  static int create_fast_reuse_socket(struct addrinfo *e)
  {
      int slisten = qemu_socket(e->ai_family, e->ai_socktype, e->ai_protocol);
@@ -378,14 +402,10 @@ static struct addrinfo  
*inet_parse_connect_saddr(InetSocketAddress *saddr,
      struct addrinfo ai, *res;
      int rc;
      Error *err = NULL;
-    static int useV4Mapped = 1;

      memset(&ai, 0, sizeof(ai));

-    ai.ai_flags = AI_CANONNAME | AI_ADDRCONFIG;
-    if (atomic_read(&useV4Mapped)) {
-        ai.ai_flags |= AI_V4MAPPED;
-    }
+    ai.ai_flags = AI_CANONNAME | AI_ADDRCONFIG | AI_V4MAPPED;
      ai.ai_family = inet_ai_family_from_address(saddr, &err);
      ai.ai_socktype = SOCK_STREAM;

@@ -399,21 +419,11 @@ static struct addrinfo  
*inet_parse_connect_saddr(InetSocketAddress *saddr,
          return NULL;
      }

-    /* lookup */
-    rc = getaddrinfo(saddr->host, saddr->port, &ai, &res);
-
-    /* At least FreeBSD and OS-X 10.6 declare AI_V4MAPPED but
-     * then don't implement it in their getaddrinfo(). Detect
-     * this and retry without the flag since that's preferrable
-     * to a fatal error
-     */
-    if (rc == EAI_BADFLAGS &&
-        (ai.ai_flags & AI_V4MAPPED)) {
-        atomic_set(&useV4Mapped, 0);
+    if ((check_ai_v4mapped(saddr->host, saddr->port, &ai, res)) == 0) {
          ai.ai_flags &= ~AI_V4MAPPED;
-        rc = getaddrinfo(saddr->host, saddr->port, &ai, &res);
      }
-    if (rc != 0) {
+
+    if ((rc = getaddrinfo(saddr->host, saddr->port, &ai, &res)) != 0) {
          error_setg(errp, "address resolution failed for %s:%s: %s",
                     saddr->host, saddr->port, gai_strerror(rc));
          return NULL;
@@ -469,7 +479,7 @@ static int inet_dgram_saddr(InetSocketAddress *sraddr,

      /* lookup peer addr */
      memset(&ai,0, sizeof(ai));
-    ai.ai_flags = AI_CANONNAME | AI_V4MAPPED | AI_ADDRCONFIG;
+    ai.ai_flags = AI_CANONNAME | AI_ADDRCONFIG | AI_V4MAPPED;
      ai.ai_family = inet_ai_family_from_address(sraddr, &err);
      ai.ai_socktype = SOCK_DGRAM;

@@ -488,6 +498,10 @@ static int inet_dgram_saddr(InetSocketAddress *sraddr,
          goto err;
      }

+    if ((check_ai_v4mapped(addr, port, &ai, &peer)) == 0) {
+        ai.ai_flags &= ~AI_V4MAPPED;
+    }
+
      if ((rc = getaddrinfo(addr, port, &ai, &peer)) != 0) {
          error_setg(errp, "address resolution failed for %s:%s: %s",  
addr, port,
                     gai_strerror(rc));
-- 
2.14.1
