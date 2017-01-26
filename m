Received: from eggs.gnu.org ([2001:4830:134:3::10]:46861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1cWkwm-0001v3-JV
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 09:22:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1cWkwj-0006pw-FS
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 09:22:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1cWkwj-0006la-9k
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 09:22:41 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7482AC04B302
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 14:22:40 +0000 (UTC)
From: Ladi Prosek <lprosek@redhat.com>
Date: Thu, 26 Jan 2017 15:22:37 +0100
Message-Id: <1485440557-10384-1-git-send-email-lprosek@redhat.com>
Subject: [Qemu-devel] [PATCH] memory: don't sign-extend 32-bit writes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

ldl_p has a signed return type so assigning it to uint64_t implicitly
sign-extends the value. This results in devices with min_access_size = 8
seeing unexpected values passed to their write handlers.

Example: guest performs a 32-bit write of 0x80000000 to an mmio region
and the handler receives 0xFFFFFFFF80000000 in its value argument.

Signed-off-by: Ladi Prosek <lprosek@redhat.com>
---
 exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/exec.c b/exec.c
index f2bed92..b05c5d2 100644
--- a/exec.c
+++ b/exec.c
@@ -2630,7 +2630,7 @@ static MemTxResult address_space_write_continue(AddressSpace *as, hwaddr addr,
                 break;
             case 4:
                 /* 32 bit write access */
-                val = ldl_p(buf);
+                val = (uint32_t)ldl_p(buf);
                 result |= memory_region_dispatch_write(mr, addr1, val, 4,
                                                        attrs);
                 break;
-- 
2.7.4
