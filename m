Received: from eggs.gnu.org ([2001:4830:134:3::10]:33276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4T-0001m9-Sd
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4M-0006YZ-UR
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:54 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43329)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA4D-0006Gs-5Y
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:45 -0400
Received: by mail-wr1-x442.google.com with SMTP id k5-v6so4943528wre.10
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:03:38 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:02:03 +0200
Message-Id: <1534870966-9287-32-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 31/74] lsi_scsi: add support for PPR Extended
 Message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: George Kennedy <george.kennedy@oracle.com>

From: George Kennedy <george.kennedy@oracle.com>

The LSI 53c895a code does not handle the PPR Extended Message. Add
support to handle PPR Extended Message like SDTR and WDTR are handled.
That is, to skip past the message bytes and ignore the message.

Signed-off-by: George Kennedy <george.kennedy@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/lsi53c895a.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 160657f..955ba94 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -959,6 +959,10 @@ static void lsi_do_msgout(LSIState *s)
                 DPRINTF("WDTR (ignored)\n");
                 lsi_skip_msgbytes(s, 1);
                 break;
+            case 4:
+                DPRINTF("PPR (ignored)\n");
+                lsi_skip_msgbytes(s, 5);
+                break;
             default:
                 goto bad;
             }
-- 
1.8.3.1
