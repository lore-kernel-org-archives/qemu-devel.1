Received: from eggs.gnu.org ([2001:4830:134:3::10]:34897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gNIgU-0002Qb-IZ
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:31:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gNIgO-00042l-Uv
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:31:52 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51375)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gNIgJ-0003vC-56
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:31:44 -0500
Received: by mail-wm1-x343.google.com with SMTP id w7-v6so19006851wmc.1
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 06:31:32 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Nov 2018 15:31:19 +0100
Message-Id: <20181115143124.19234-6-pbonzini@redhat.com>
In-Reply-To: <20181115143124.19234-1-pbonzini@redhat.com>
References: <20181115143124.19234-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 05/10] vhost-user-test: support
 VHOST_USER_PROTOCOL_F_CROSS_ENDIAN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: lvivier@redhat.com, mst@redhat.com, jasowang@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

This will be useful to run the qtest for ppc64 targets on (for example)
x86_64 hosts.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/vhost-user-test.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 6a805e67be..82fc6c581b 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -51,6 +51,7 @@
 #define VHOST_USER_F_PROTOCOL_FEATURES 30
 #define VHOST_USER_PROTOCOL_F_MQ 0
 #define VHOST_USER_PROTOCOL_F_LOG_SHMFD 1
+#define VHOST_USER_PROTOCOL_F_CROSS_ENDIAN   6
 
 #define VHOST_LOG_PAGE 0x1000
 
@@ -251,7 +252,7 @@ static void wait_for_fds(TestServer *s)
 
 static void read_guest_mem_server(TestServer *s)
 {
-    uint32_t *guest_mem;
+    uint8_t *guest_mem;
     int i, j;
     size_t size;
 
@@ -278,8 +279,8 @@ static void read_guest_mem_server(TestServer *s)
         g_assert(guest_mem != MAP_FAILED);
         guest_mem += (s->memory.regions[i].mmap_offset / sizeof(*guest_mem));
 
-        for (j = 0; j < 256; j++) {
-            uint32_t a = readl(s->memory.regions[i].guest_phys_addr + j*4);
+        for (j = 0; j < 1024; j++) {
+            uint32_t a = readb(s->memory.regions[i].guest_phys_addr + j);
             uint32_t b = guest_mem[j];
 
             g_assert_cmpint(a, ==, b);
@@ -367,6 +368,7 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
         msg.flags |= VHOST_USER_REPLY_MASK;
         msg.size = sizeof(m.payload.u64);
         msg.payload.u64 = 1 << VHOST_USER_PROTOCOL_F_LOG_SHMFD;
+        msg.payload.u64 |= 1 << VHOST_USER_PROTOCOL_F_CROSS_ENDIAN;
         if (s->queues > 1) {
             msg.payload.u64 |= 1 << VHOST_USER_PROTOCOL_F_MQ;
         }
-- 
2.19.1
