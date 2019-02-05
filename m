Received: from eggs.gnu.org ([209.51.188.92]:35887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5GJ-0002LH-7U
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5GH-0003ms-Ib
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:15:59 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:40706)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gr5GH-0003U3-5p
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:15:57 -0500
Received: by mail-wr1-x433.google.com with SMTP id p4so4706270wrt.7
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 10:15:32 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
	by smtp.gmail.com with ESMTPSA id p5sm8931665wmh.16.2019.02.05.10.15.29
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 05 Feb 2019 10:15:29 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  5 Feb 2019 19:14:13 +0100
Message-Id: <1549390526-24246-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
References: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/76] vhost-user-test: support
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

This will be useful to run the qtest for ppc64 targets on (for example)
x86_64 hosts.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1543851204-41186-10-git-send-email-pbonzini@redhat.com>
---
 tests/vhost-user-test.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 8eb7943..a4f51b5 100644
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
1.8.3.1
