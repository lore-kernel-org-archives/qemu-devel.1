Received: from eggs.gnu.org ([2001:4830:134:3::10]:40059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKP6R-0006wl-Da
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 08:42:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKP6M-0005fq-NL
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 08:42:11 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu, 30 Nov 2017 07:41:57 -0600
Message-Id: <20171130134159.9697-2-eblake@redhat.com>
In-Reply-To: <20171130134159.9697-1-eblake@redhat.com>
References: <20171130134159.9697-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] net: Drop unusual use of do { } while (0); 
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Jason Wang <jasowang@redhat.com>

For a couple of macros in pcnet.c, we have to provide a new scope
to avoid compiler warnings about declarations in the middle of a
switch statement that aren't in a sub-scope.  But use of
'do { ... } while (0);' merely to provide that new scope is arcane
overkill, compared to just using '{ ... }'.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 hw/net/pcnet.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/net/pcnet.c b/hw/net/pcnet.c
index 654455355f..641bf2fd88 100644
--- a/hw/net/pcnet.c
+++ b/hw/net/pcnet.c
@@ -455,32 +455,32 @@ static inline void pcnet_rmd_store(PCNetState *s, struct pcnet_RMD *rmd,
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
@@ -488,22 +488,22 @@ static inline void pcnet_rmd_store(PCNetState *s, struct pcnet_RMD *rmd,
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
2.14.3
