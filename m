Received: from eggs.gnu.org ([2001:4830:134:3::10]:60177)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from
	<SRS0=Iw5G=7E=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
	id 1dd25o-0003Ky-Sr
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 18:26:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from
	<SRS0=Iw5G=7E=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
	id 1dd25k-0003sW-OL
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 18:26:16 -0400
Received: from sonata.ens-lyon.org ([140.77.166.138]:55803)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from
	<SRS0=Iw5G=7E=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
	id 1dd25k-0003r3-I5
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 18:26:12 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Thu,  3 Aug 2017 00:26:07 +0200
Message-Id: <20170802222607.32085-3-samuel.thibault@ens-lyon.org>
In-Reply-To: <20170802222607.32085-1-samuel.thibault@ens-lyon.org>
References: <20170802222607.32085-1-samuel.thibault@ens-lyon.org>
Subject: [Qemu-devel] [PULL 2/2] slirp: check len against dhcp options array
 end
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Prasad J Pandit <pjp@fedoraproject.org>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

While parsing dhcp options string in 'dhcp_decode', if an options'
length 'len' appeared towards the end of 'bp_vend' array, ensuing
read could lead to an OOB memory access issue. Add check to avoid it.

Reported-by: Reno Robert <renorobert@gmail.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/bootp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/slirp/bootp.c b/slirp/bootp.c
index 5a4646c182..5dd1a415b5 100644
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
2.13.2
