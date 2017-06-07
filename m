Received: from eggs.gnu.org ([2001:4830:134:3::10]:43071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dIRja-0005Qw-Ol
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 23:34:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dIRjY-0000wc-FJ
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 23:34:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33278)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dIRjY-0000wS-91
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 23:34:12 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Wed,  7 Jun 2017 11:34:03 +0800
Message-Id: <1496806444-27910-2-git-send-email-jasowang@redhat.com>
In-Reply-To: <1496806444-27910-1-git-send-email-jasowang@redhat.com>
References: <1496806444-27910-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 1/2] net/rocker: Cleanup the useless return
 value check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>

From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>

None of pci_dma_read()'s callers check the return value except
rocker. There is no need to check it because it always return
0. So the check work is useless. Remove it entirely.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
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
2.7.4
