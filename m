Received: from eggs.gnu.org ([2001:4830:134:3::10]:58496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <george.kennedy@oracle.com>) id 1eORCI-0001w4-8b
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 11:44:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <george.kennedy@oracle.com>) id 1eORCC-0003ZU-Pk
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 11:44:54 -0500
References: <a2b410dd-1150-16a4-9376-069117a14c98@oracle.com>
From: George Kennedy <george.kennedy@oracle.com>
Message-ID: <5b24ac58-738a-ac39-f4ed-6cffb3727a26@oracle.com>
Date: Mon, 11 Dec 2017 11:45:02 -0500
MIME-Version: 1.0
In-Reply-To: <a2b410dd-1150-16a4-9376-069117a14c98@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: [Qemu-devel] [Qemu-trivial] [PATCH] lsi_scsi: add support for PPR
 Extended Message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

The LSI 53c895a code does not handle the PPR Extended Message. Add 
support to handle PPR Extended Message like SDTR and WDTR are handled. 
That is, to skip past the message bytes and ignore the message.

---
  hw/scsi/lsi53c895a.c | 4 ++++
  1 file changed, 4 insertions(+)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 595c260..1e02a89 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -961,6 +961,10 @@ static void lsi_do_msgout(LSIState *s)
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
