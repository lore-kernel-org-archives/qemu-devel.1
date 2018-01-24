Received: from eggs.gnu.org ([2001:4830:134:3::10]:49905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marmarek@invisiblethingslab.com>) id 1eeLuB-00075x-Gw
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 09:20:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marmarek@invisiblethingslab.com>) id 1eeLu6-00080J-M6
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 09:19:59 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:53471)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marmarek@invisiblethingslab.com>)
	id 1eeLu6-0007yG-G0
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 09:19:54 -0500
From: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
	<marmarek@invisiblethingslab.com>
Date: Wed, 24 Jan 2018 15:18:48 +0100
Message-Id: <20180124141848.3969-1-marmarek@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] intel_iommu: allow updating FEADDR and FEUADDR
 with one 64bit write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>

Allow updating those two adjacent 32bit fields with one 64bit write.
This fixes qemu crash when booting Xen inside.

See discussion on Xen side of the thing here:
http://xen.markmail.org/message/6mrmemrnmhxvaxba

Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
---
 hw/i386/intel_iommu.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 2e841cde27..d214dce277 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2129,8 +2129,12 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
 
     /* Fault Event Address Register, 32-bit */
     case DMAR_FEADDR_REG:
-        assert(size == 4);
-        vtd_set_long(s, addr, val);
+        assert(size == 4 || size == 8);
+        if (size == 4) {
+            vtd_set_long(s, addr, val);
+        } else {
+            vtd_set_quad(s, addr, val);
+        }
         break;
 
     /* Fault Event Upper Address Register, 32-bit */
-- 
2.13.6
