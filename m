Received: from eggs.gnu.org ([2001:4830:134:3::10]:33886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbFB-00006J-LN
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:29:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbF8-0000ht-G9
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:29:53 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:44501)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbF8-0000hO-CU
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:29:50 -0500
Received: by mail-qk0-x243.google.com with SMTP id v188so15086157qkh.11
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 09:29:50 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 Jan 2018 14:29:04 -0300
Message-Id: <20180108172904.8772-13-f4bug@amsat.org>
In-Reply-To: <20180108172904.8772-1-f4bug@amsat.org>
References: <20180108172904.8772-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 12/12] slirp: use
 HOST_SUPPORTS_UNALIGNED_ACCESS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Access struct in6_addr with 'void *', then cast to 'u8 *' to avoid alignment
issues.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
ugly...

 slirp/ip6.h | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/slirp/ip6.h b/slirp/ip6.h
index c6493a0856..4eaeaa9a0a 100644
--- a/slirp/ip6.h
+++ b/slirp/ip6.h
@@ -51,11 +51,19 @@
                         0x00, 0x00, 0x00, 0x00,\
                         0x00, 0x00, 0x00, 0x00 } }
 
+#ifdef HOST_SUPPORTS_UNALIGNED_ACCESS
 static inline bool in6_equal(const struct in6_addr *a, const struct in6_addr *b)
 {
     return memcmp(a, b, sizeof(*a)) == 0;
 }
+#else
+static inline bool in6_equal(const void *a, const void *b)
+{
+    return memcmp(a, b, sizeof(struct in6_addr)) == 0;
+}
+#endif
 
+#ifdef HOST_SUPPORTS_UNALIGNED_ACCESS
 static inline bool in6_equal_net(const struct in6_addr *a,
                                  const struct in6_addr *b,
                                  int prefix_len)
@@ -71,7 +79,28 @@ static inline bool in6_equal_net(const struct in6_addr *a,
     return a->s6_addr[prefix_len / 8] >> (8 - (prefix_len % 8))
         == b->s6_addr[prefix_len / 8] >> (8 - (prefix_len % 8));
 }
+#else
+static inline bool in6_equal_net(const void *a,
+                                 const void *b,
+                                 int prefix_len)
+{
+    const uint8_t *aa = (uint8_t *)a;
+    const uint8_t *ab = (uint8_t *)b;
+
+    if (memcmp(a, b, prefix_len / 8) != 0) {
+        return 0;
+    }
+
+    if (prefix_len % 8 == 0) {
+        return 1;
+    }
+
+    return (aa[prefix_len / 8] >> (8 - (prefix_len % 8)))
+        == (ab[prefix_len / 8] >> (8 - (prefix_len % 8)));
+}
+#endif
 
+#ifdef HOST_SUPPORTS_UNALIGNED_ACCESS
 static inline bool in6_equal_mach(const struct in6_addr *a,
                                   const struct in6_addr *b,
                                   int prefix_len)
@@ -89,6 +118,28 @@ static inline bool in6_equal_mach(const struct in6_addr *a,
     return (a->s6_addr[prefix_len / 8] & ((1U << (8 - (prefix_len % 8))) - 1))
         == (b->s6_addr[prefix_len / 8] & ((1U << (8 - (prefix_len % 8))) - 1));
 }
+#else
+static inline bool in6_equal_mach(const void *a,
+                                  const void *b,
+                                  int prefix_len)
+{
+    const uint8_t *aa = (uint8_t *)a;
+    const uint8_t *ab = (uint8_t *)b;
+
+    if (memcmp(&(aa[DIV_ROUND_UP(prefix_len, 8)]),
+               &(ab[DIV_ROUND_UP(prefix_len, 8)]),
+               16 - DIV_ROUND_UP(prefix_len, 8)) != 0) {
+        return 0;
+    }
+
+    if (prefix_len % 8 == 0) {
+        return 1;
+    }
+
+    return (aa[prefix_len / 8] & ((1U << (8 - (prefix_len % 8))) - 1))
+        == (ab[prefix_len / 8] & ((1U << (8 - (prefix_len % 8))) - 1));
+}
+#endif
 
 
 #define in6_equal_router(a)\
@@ -112,10 +163,17 @@ static inline bool in6_equal_mach(const struct in6_addr *a,
 #define in6_zero(a)\
     (in6_equal(a, &(struct in6_addr)ZERO_ADDR))
 
+#ifdef HOST_SUPPORTS_UNALIGNED_ACCESS
 static inline bool in6_multicast(const struct in6_addr *a)
 {
     return a->s6_addr[0] == 0xff;
 }
+#else
+static inline bool in6_multicast(const void *a)
+{
+    return ((const uint8_t *)a)[0] == 0xff;
+}
+#endif
 
 /* Compute emulated host MAC address from its ipv6 address */
 static inline void in6_compute_ethaddr(struct in6_addr ip,
-- 
2.15.1
