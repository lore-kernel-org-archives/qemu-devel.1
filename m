Received: from eggs.gnu.org ([2001:4830:134:3::10]:44438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKufj-0007JA-Vd
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 18:24:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKufj-00048h-7M
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 18:24:43 -0500
From: Eric Blake <eblake@redhat.com>
Date: Fri,  1 Dec 2017 17:24:27 -0600
Message-Id: <20171201232433.25193-2-eblake@redhat.com>
In-Reply-To: <20171201232433.25193-1-eblake@redhat.com>
References: <20171201232433.25193-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/7] net: Drop unusual use of do { } while
 (0);
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, qemu-trivial@nongnu.org, pbonzini@redhat.com, Jason Wang <jasowang@redhat.com>

For a couple of macros in pcnet.c, we have to provide a new scope
to avoid compiler warnings about declarations in the middle of a
switch statement that aren't in a sub-scope.  But use of
'do { ... } while (0);' merely to provide that new scope is arcane
overkill, compared to just using '{ ... }'.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
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
