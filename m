Received: from eggs.gnu.org ([2001:4830:134:3::10]:48866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCq-0001kl-VN
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCn-0006A3-OJ
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45217)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCn-00067V-El
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:33 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0E8Wc041818
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:32 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cmur4vq5b-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:32 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 18:16:31 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:14:41 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-67-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 66/79] hid: Reset kbd modifiers on reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alexander Graf <agraf@suse.de>, Gerd Hoffmann <kraxel@redhat.com>

From: Alexander Graf <agraf@suse.de>

When resetting the keyboard, we need to reset not just the pending keystrokes,
but also any pending modifiers. Otherwise there's a race when we're getting
reset while running an escape sequence (modifier 0x100).

Cc: qemu-stable@nongnu.org
Signed-off-by: Alexander Graf <agraf@suse.de>
Message-id: 1498117295-162030-1-git-send-email-agraf@suse.de
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
(cherry picked from commit 51dbea77a29ea46173373a6dad4ebd95d4661f42)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/input/hid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/input/hid.c b/hw/input/hid.c
index fa9cc4c..a0892e8 100644
--- a/hw/input/hid.c
+++ b/hw/input/hid.c
@@ -483,6 +483,7 @@ void hid_reset(HIDState *hs)
         memset(hs->kbd.keycodes, 0, sizeof(hs->kbd.keycodes));
         memset(hs->kbd.key, 0, sizeof(hs->kbd.key));
         hs->kbd.keys = 0;
+        hs->kbd.modifiers = 0;
         break;
     case HID_MOUSE:
     case HID_TABLET:
-- 
2.7.4
