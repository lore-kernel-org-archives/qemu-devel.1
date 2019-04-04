Received: from eggs.gnu.org ([209.51.188.92]:55057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.kanda@oracle.com>) id 1hC49i-0001Cr-1t
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 11:19:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.kanda@oracle.com>) id 1hC49h-0002cz-5G
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 11:19:54 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:40778)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.kanda@oracle.com>)
	id 1hC49g-0002Wh-P4
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 11:19:53 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x34F8x7f034625
	for <qemu-devel@nongnu.org>; Thu, 4 Apr 2019 15:19:47 GMT
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by aserp2130.oracle.com with ESMTP id 2rhwydfym9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <qemu-devel@nongnu.org>; Thu, 04 Apr 2019 15:19:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x34FJP5V196179
	for <qemu-devel@nongnu.org>; Thu, 4 Apr 2019 15:19:47 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by aserp3020.oracle.com with ESMTP id 2rm9mjpmp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <qemu-devel@nongnu.org>; Thu, 04 Apr 2019 15:19:47 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x34FJjFX011775
	for <qemu-devel@nongnu.org>; Thu, 4 Apr 2019 15:19:46 GMT
From: Mark Kanda <mark.kanda@oracle.com>
Date: Thu,  4 Apr 2019 10:21:26 -0500
Message-Id: <1554391286-26981-1-git-send-email-mark.kanda@oracle.com>
Subject: [Qemu-devel] [PATCH] e1000: Never increment the RX undersize count
 register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: bhavesh.davda@oracle.com, Chris Kenna <chris.kenna@oracle.com>

From: Chris Kenna <chris.kenna@oracle.com>

In situations where e1000 receives an undersized Ethernet frame,
QEMU increments the emulated "Receive Undersize Count (RUC)"
register when padding the frame.

This is incorrect because this an expected scenario (e.g. with
VLAN tag stripping) and not an error. As such, QEMU should not
increment the emulated RUC.

Fixes: 3b2743017749 ("e1000: Implementing various counters")

Reviewed-by: Mark Kanda <mark.kanda@oracle.com>
Reviewed-by: Bhavesh Davda <bhavesh.davda@oracle.com>
Signed-off-by: Chris Kenna <chris.kenna@oracle.com>
---
 hw/net/e1000.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 9b39bcc..121452d 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -901,7 +901,6 @@ e1000_receive_iov(NetClientState *nc, const struct iovec *iov, int iovcnt)
     if (size < sizeof(min_buf)) {
         iov_to_buf(iov, iovcnt, 0, min_buf, size);
         memset(&min_buf[size], 0, sizeof(min_buf) - size);
-        e1000x_inc_reg_if_not_full(s->mac_reg, RUC);
         min_iov.iov_base = filter_buf = min_buf;
         min_iov.iov_len = size = sizeof(min_buf);
         iovcnt = 1;
-- 
1.8.3.1
