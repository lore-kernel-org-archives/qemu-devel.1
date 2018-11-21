Received: from eggs.gnu.org ([2001:4830:134:3::10]:50408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gPaeK-0003bt-7m
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:07:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gPaeI-0000pH-43
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:07:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gPaeG-0000lP-40
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 17:07:06 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Nov 2018 02:06:18 +0400
Message-Id: <20181121220647.18844-2-marcandre.lureau@redhat.com>
In-Reply-To: <20181121220647.18844-1-marcandre.lureau@redhat.com>
References: <20181121220647.18844-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 for-3.2 v2 01/30] fixup! net: do not depend
 on slirp internals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Jan Kiszka <jan.kiszka@siemens.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Somehow, I broke the build and failed to detect it. Please squash!

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 net/colo.h |  1 +
 net/util.h | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/net/colo.h b/net/colo.h
index 420d916af2..b2f60e4d56 100644
--- a/net/colo.h
+++ b/net/colo.h
@@ -18,6 +18,7 @@
 #include "qemu/jhash.h"
 #include "qemu/timer.h"
 #include "net/eth.h"
+#include "util.h"
=20
 #define HASHTABLE_MAX_SIZE 16384
=20
diff --git a/net/util.h b/net/util.h
index 358185fd50..0e0748913a 100644
--- a/net/util.h
+++ b/net/util.h
@@ -25,6 +25,9 @@
 #ifndef QEMU_NET_UTIL_H
 #define QEMU_NET_UTIL_H
=20
+#include "qemu/osdep.h"
+
+typedef uint32_t tcp_seq;
=20
 /*
  * Structure of an internet header, naked of options.
@@ -50,6 +53,29 @@ struct ip {
     struct in_addr ip_src, ip_dst;  /* source and dest address */
 } QEMU_PACKED;
=20
+/*
+ * TCP header.
+ * Per RFC 793, September, 1981.
+ */
+#define tcphdr slirp_tcphdr
+struct tcphdr {
+    uint16_t th_sport;      /* source port */
+    uint16_t th_dport;      /* destination port */
+    tcp_seq th_seq;         /* sequence number */
+    tcp_seq th_ack;         /* acknowledgement number */
+#ifdef HOST_WORDS_BIGENDIAN
+    uint8_t th_off:4,       /* data offset */
+            th_x2:4;        /* (unused) */
+#else
+    uint8_t th_x2:4,        /* (unused) */
+            th_off:4;       /* data offset */
+#endif
+    uint8_t th_flags;
+    uint16_t th_win;        /* window */
+    uint16_t th_sum;        /* checksum */
+    uint16_t th_urp;        /* urgent pointer */
+};
+
 static inline bool in6_equal_net(const struct in6_addr *a,
                                  const struct in6_addr *b,
                                  int prefix_len)
--=20
2.20.0.rc1
