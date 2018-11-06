Received: from eggs.gnu.org ([2001:4830:134:3::10]:40144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gK9Cq-0002lF-3M
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 16:48:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gK93X-0001Uu-UC
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 16:38:43 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:53596)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gK93W-0000WI-Hx
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 16:38:39 -0500
Received: by mail-wm1-x32e.google.com with SMTP id f10-v6so85694wme.3
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 13:38:22 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	l186-v6sm3223526wma.13.2018.11.06.13.38.20
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 06 Nov 2018 13:38:20 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Nov 2018 22:37:59 +0100
Message-Id: <1541540283-45699-14-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1541540283-45699-1-git-send-email-pbonzini@redhat.com>
References: <1541540283-45699-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 13/17] scsi-generic: avoid out-of-bounds access
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

A device can report an excessive number of VPD pages when asked for a
list; this can cause an out-of-bounds access to buf in
scsi_generic_set_vpd_bl_emulation.  It should not happen, but
it is technically not incorrect so handle it: do not check any byte
past the allocation length that was sent to the INQUIRY command.

Reported-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index aebb7cd..c5497bb 100644
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
1.8.3.1
