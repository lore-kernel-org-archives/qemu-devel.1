Received: from eggs.gnu.org ([2001:4830:134:3::10]:33648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gHBRF-0002qN-0p
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 13:34:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gHBR8-0001C9-Cy
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 13:34:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gHBR8-0001A4-4W
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 13:34:46 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 29 Oct 2018 18:34:35 +0100
Message-Id: <20181029173437.32559-3-pbonzini@redhat.com>
In-Reply-To: <20181029173437.32559-1-pbonzini@redhat.com>
References: <20181029173437.32559-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 2/4] scsi-generic: avoid out-of-bounds access
 to VPD page list
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

A device can report an excessive number of VPD pages when asked for a
list; this can cause an out-of-bounds access to buf in
scsi_generic_set_vpd_bl_emulation.  It should not happen, but
it is technically not incorrect so handle it: do not check any byte
past the allocation length that was sent to the INQUIRY command.

Reported-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index aebb7cdd82..c5497bbea8 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -538,7 +538,7 @@ static void scsi_generic_set_vpd_bl_emulation(SCSIDevice *s)
     }
 
     page_len = buf[3];
-    for (i = 4; i < page_len + 4; i++) {
+    for (i = 4; i < MIN(sizeof(buf), page_len + 4); i++) {
         if (buf[i] == 0xb0) {
             s->needs_vpd_bl_emulation = false;
             return;
-- 
2.17.1
