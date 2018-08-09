Received: from eggs.gnu.org ([2001:4830:134:3::10]:38682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1fnlhb-0007VB-G3
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:14:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1fnlha-0000V8-KL
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:14:11 -0400
Received: from mo6-p00-ob.smtp.rzone.de ([2a01:238:20a:202:5300::6]:16269)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1fnlha-0000Tu-4X
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:14:10 -0400
From: Olaf Hering <olaf@aepfle.de>
Date: Thu,  9 Aug 2018 16:14:03 +0200
Message-Id: <20180809141403.11296-1-olaf@aepfle.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1] exec: handle NULL pointer in
 flatview_read_continue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "open list:Overall" <qemu-devel@nongnu.org>
Cc: Olaf Hering <olaf@aepfle.de>

The codepaths behind qemu_ram_ptr_length can return NULL.
Avoid crashing the device-model in such case, just move on.

Signed-off-by: Olaf Hering <olaf@aepfle.de>
---
This happens if calling xendevicemodel_create_ioreq_server() is disabled,
and eventually if that function returns an error.
---
 exec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/exec.c b/exec.c
index 4f5df07b6a..0d30e48571 100644
--- a/exec.c
+++ b/exec.c
@@ -3318,7 +3318,8 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
         } else {
             /* RAM case */
             ptr = qemu_ram_ptr_length(mr->ram_block, addr1, &l, false);
-            memcpy(buf, ptr, l);
+	    if (ptr)
+                memcpy(buf, ptr, l);
         }
 
         if (release_lock) {
