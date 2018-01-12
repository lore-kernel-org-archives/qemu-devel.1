Received: from eggs.gnu.org ([2001:4830:134:3::10]:41983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxZC-0007rt-3k
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxZ9-0005rF-70
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:10 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:42801)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eZxZ9-0005qr-02
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:07 -0500
Received: by mail-wr0-x242.google.com with SMTP id e41so4698395wre.9
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 03:32:06 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jan 2018 12:31:04 +0100
Message-Id: <1515756676-3860-41-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
References: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 40/52] net: Drop unusual use of do { } while (0); 
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

For a couple of macros in pcnet.c, we have to provide a new scope
to avoid compiler warnings about declarations in the middle of a
switch statement that aren't in a sub-scope.  But use of
'do { ... } while (0);' merely to provide that new scope is arcane
overkill, compared to just using '{ ... }'.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20171201232433.25193-2-eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/net/pcnet.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/net/pcnet.c b/hw/net/pcnet.c
index 39d5d93..606b05c 100644
--- a/hw/net/pcnet.c
+++ b/hw/net/pcnet.c
@@ -456,32 +456,32 @@ static inline void pcnet_rmd_store(PCNetState *s, struct pcnet_RMD *rmd,
 #define CHECK_RMD(ADDR,RES) do {                \
     switch (BCR_SWSTYLE(s)) {                   \
     case 0x00:                                  \
-        do {                                    \
+        {                                       \
             uint16_t rda[4];                    \
             s->phys_mem_read(s->dma_opaque, (ADDR), \
                 (void *)&rda[0], sizeof(rda), 0); \
             (RES) |= (rda[2] & 0xf000)!=0xf000; \
             (RES) |= (rda[3] & 0xf000)!=0x0000; \
-        } while (0);                            \
+        }                                       \
         break;                                  \
     case 0x01:                                  \
     case 0x02:                                  \
-        do {                                    \
+        {                                       \
             uint32_t rda[4];                    \
             s->phys_mem_read(s->dma_opaque, (ADDR), \
                 (void *)&rda[0], sizeof(rda), 0); \
             (RES) |= (rda[1] & 0x0000f000L)!=0x0000f000L; \
             (RES) |= (rda[2] & 0x0000f000L)!=0x00000000L; \
-        } while (0);                            \
+        }                                       \
         break;                                  \
     case 0x03:                                  \
-        do {                                    \
+        {                                       \
             uint32_t rda[4];                    \
             s->phys_mem_read(s->dma_opaque, (ADDR), \
                 (void *)&rda[0], sizeof(rda), 0); \
             (RES) |= (rda[0] & 0x0000f000L)!=0x00000000L; \
             (RES) |= (rda[1] & 0x0000f000L)!=0x0000f000L; \
-        } while (0);                            \
+        }                                       \
         break;                                  \
     }                                           \
 } while (0)
@@ -489,22 +489,22 @@ static inline void pcnet_rmd_store(PCNetState *s, struct pcnet_RMD *rmd,
 #define CHECK_TMD(ADDR,RES) do {                \
     switch (BCR_SWSTYLE(s)) {                   \
     case 0x00:                                  \
-        do {                                    \
+        {                                       \
             uint16_t xda[4];                    \
             s->phys_mem_read(s->dma_opaque, (ADDR), \
                 (void *)&xda[0], sizeof(xda), 0); \
             (RES) |= (xda[2] & 0xf000)!=0xf000; \
-        } while (0);                            \
+        }                                       \
         break;                                  \
     case 0x01:                                  \
     case 0x02:                                  \
     case 0x03:                                  \
-        do {                                    \
+        {                                       \
             uint32_t xda[4];                    \
             s->phys_mem_read(s->dma_opaque, (ADDR), \
                 (void *)&xda[0], sizeof(xda), 0); \
             (RES) |= (xda[1] & 0x0000f000L)!=0x0000f000L; \
-        } while (0);                            \
+        }                                       \
         break;                                  \
     }                                           \
 } while (0)
-- 
1.8.3.1
