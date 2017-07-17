Received: from eggs.gnu.org ([2001:4830:134:3::10]:41418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1dX4kU-0006op-14
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:03:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1dX4kQ-00071t-VT
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:03:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1dX4kQ-00070U-QC
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:03:34 -0400
From: P J P <ppandit@redhat.com>
Date: Mon, 17 Jul 2017 17:33:26 +0530
Message-Id: <20170717120326.27967-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH] slirp: check len against dhcp options array end
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, Reno Robert <renorobert@gmail.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

While parsing dhcp options string in 'dhcp_decode', if an options'
length 'len' appeared towards the end of 'bp_vend' array, ensuing
read could lead to an OOB memory access issue. Add check to avoid it.

Reported-by: Reno Robert <renorobert@gmail.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 slirp/bootp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/slirp/bootp.c b/slirp/bootp.c
index 5a4646c..5dd1a41 100644
--- a/slirp/bootp.c
+++ b/slirp/bootp.c
@@ -123,6 +123,9 @@ static void dhcp_decode(const struct bootp_t *bp, int *pmsg_type,
             if (p >= p_end)
                 break;
             len = *p++;
+            if (p + len > p_end) {
+                break;
+            }
             DPRINTF("dhcp: tag=%d len=%d\n", tag, len);
 
             switch(tag) {
-- 
2.9.4
