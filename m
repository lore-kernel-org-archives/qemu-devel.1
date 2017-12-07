Received: from eggs.gnu.org ([2001:4830:134:3::10]:39936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <george.kennedy@oracle.com>) id 1eMy36-0006vK-RW
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 10:25:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <george.kennedy@oracle.com>) id 1eMy31-0005UV-EM
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 10:25:20 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:59696)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <george.kennedy@oracle.com>)
	id 1eMy31-0005SA-1s
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 10:25:15 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.21/8.16.0.21) with SMTP id
	vB7FMKOC020126
	for <qemu-devel@nongnu.org>; Thu, 7 Dec 2017 15:25:12 GMT
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
	by userp2120.oracle.com with ESMTP id 2epd12qvhd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 07 Dec 2017 15:25:12 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id vB7FPBbm023394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK) for <qemu-devel@nongnu.org>; Thu, 7 Dec 2017 15:25:11 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id vB7FPAkb008498
	for <qemu-devel@nongnu.org>; Thu, 7 Dec 2017 15:25:11 GMT
References: <1511980051-20457-2-git-send-email-george.kennedy@oracle.com>
From: George Kennedy <george.kennedy@oracle.com>
Message-ID: <a2b410dd-1150-16a4-9376-069117a14c98@oracle.com>
Date: Thu, 7 Dec 2017 10:25:35 -0500
MIME-Version: 1.0
In-Reply-To: <1511980051-20457-2-git-send-email-george.kennedy@oracle.com>
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

The LSI 53c895a code does not handle the PPR Extended Message. Add support to handle PPR
Extended Message like SDTR and WDTR are handled. That is, to skip past the message
bytes and ignore the message.

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
