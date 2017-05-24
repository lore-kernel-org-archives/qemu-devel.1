Received: from eggs.gnu.org ([2001:4830:134:3::10]:35256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dDMV3-0004pl-IX
	for qemu-devel@nongnu.org; Tue, 23 May 2017 22:58:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dDMV0-0000jG-IU
	for qemu-devel@nongnu.org; Tue, 23 May 2017 22:58:13 -0400
Received: from [59.151.112.132] (port=44194 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dDMV0-0000hc-4x
	for qemu-devel@nongnu.org; Tue, 23 May 2017 22:58:10 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Wed, 24 May 2017 10:57:18 +0800
Message-ID: <20170524025718.2287-1-maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] net/rocker: Cleanup the useless return value
 check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, jiri@resnulli.us, jasowang@redhat.com

None of pci_dma_read()'s callers check the return value except
rocker. There is no need to check it because it always return
0. So the check work is useless. Remove it entirely.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
---
 hw/net/rocker/rocker.c      | 9 +++------
 hw/net/rocker/rocker_desc.c | 4 +---
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index 6e70fdd..4f0f6d7 100644
--- a/hw/net/rocker/rocker.c
+++ b/hw/net/rocker/rocker.c
@@ -244,11 +244,9 @@ static int tx_consume(Rocker *r, DescInfo *info)
             goto err_no_mem;
         }
 
-        if (pci_dma_read(dev, frag_addr, iov[iovcnt].iov_base,
-                     iov[iovcnt].iov_len)) {
-            err = -ROCKER_ENXIO;
-            goto err_bad_io;
-        }
+        pci_dma_read(dev, frag_addr, iov[iovcnt].iov_base,
+                     iov[iovcnt].iov_len);
+
         iovcnt++;
     }
 
@@ -261,7 +259,6 @@ static int tx_consume(Rocker *r, DescInfo *info)
     err = fp_port_eg(r->fp_port[port], iov, iovcnt);
 
 err_too_many_frags:
-err_bad_io:
 err_no_mem:
 err_bad_attr:
     for (i = 0; i < ROCKER_TX_FRAGS_MAX; i++) {
diff --git a/hw/net/rocker/rocker_desc.c b/hw/net/rocker/rocker_desc.c
index ac02797..6184c40 100644
--- a/hw/net/rocker/rocker_desc.c
+++ b/hw/net/rocker/rocker_desc.c
@@ -69,9 +69,7 @@ char *desc_get_buf(DescInfo *info, bool read_only)
         return NULL;
     }
 
-    if (pci_dma_read(dev, le64_to_cpu(info->desc.buf_addr), info->buf, size)) {
-        return NULL;
-    }
+    pci_dma_read(dev, le64_to_cpu(info->desc.buf_addr), info->buf, size);
 
     return info->buf;
 }
-- 
2.9.3
