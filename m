Received: from eggs.gnu.org ([2001:4830:134:3::10]:33639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gHBRE-0002qL-Vg
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 13:34:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gHBR8-0001Be-4l
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 13:34:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gHBR7-00014M-S7
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 13:34:46 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 29 Oct 2018 18:34:34 +0100
Message-Id: <20181029173437.32559-2-pbonzini@redhat.com>
In-Reply-To: <20181029173437.32559-1-pbonzini@redhat.com>
References: <20181029173437.32559-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 1/4] scsi-generic: keep VPD page list sorted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mreitz@redhat.com, Daniel Henrique Barboza <danielhb413@gmail.com>

Block limits emulation is just placing 0xb0 as the final byte of the
VPD pages list.  However, VPD page numbers must be sorted, so change
that to an in-place insert.  Since I couldn't find any disk that triggered
the loop more than once, this was tested by adding manually 0xb1
at the end of the list and checking that 0xb0 was added before.

Reported-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-generic.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index d60c4d0fcf..aebb7cdd82 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -144,7 +144,7 @@ static int execute_command(BlockBackend *blk,
 
 static void scsi_handle_inquiry_reply(SCSIGenericReq *r, SCSIDevice *s)
 {
-    uint8_t page, page_len;
+    uint8_t page, page_idx;
 
     /*
      *  EVPD set to zero returns the standard INQUIRY data.
@@ -190,10 +190,21 @@ static void scsi_handle_inquiry_reply(SCSIGenericReq *r, SCSIDevice *s)
              *
              * This way, the guest kernel will be aware of the support
              * and will use it to proper setup the SCSI device.
+             *
+             * VPD page numbers must be sorted, so insert 0xb0 at the
+             * right place with an in-place insert.  After the initialization
+             * part of the for loop is executed, the device response is
+             * at r[0] to r[page_idx - 1].
              */
-            page_len = r->buf[3];
-            r->buf[page_len + 4] = 0xb0;
-            r->buf[3] = ++page_len;
+            for (page_idx = lduw_be_p(r->buf + 2) + 4;
+                 page_idx > 4 && r->buf[page_idx - 1] >= 0xb0;
+                 page_idx--) {
+                if (page_idx < r->buflen) {
+                    r->buf[page_idx] = r->buf[page_idx - 1];
+                }
+            }
+            r->buf[page_idx] = 0xb0;
+            stw_be_p(r->buf + 2, lduw_be_p(r->buf + 2) + 1);
         }
     }
 }
-- 
2.17.1
