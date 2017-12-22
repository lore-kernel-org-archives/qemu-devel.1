Received: from eggs.gnu.org ([2001:4830:134:3::10]:37795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eSCsQ-0007Mu-T9
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:15:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eSCsQ-0000HH-14
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:15:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57210)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eSCsP-0000GP-Qn
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:15:57 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Dec 2017 10:15:23 +0800
Message-Id: <1513908937-16034-5-git-send-email-jasowang@redhat.com>
In-Reply-To: <1513908937-16034-1-git-send-email-jasowang@redhat.com>
References: <1513908937-16034-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/18] net: introduce net_crc32_le() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Jason Wang <jasowang@redhat.com>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This provides a standard ethernet CRC32 little-endian implementation.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 include/net/net.h |  2 ++
 net/net.c         | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/net/net.h b/include/net/net.h
index 586098c..4afac1a 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -228,7 +228,9 @@ NetClientState *net_hub_port_find(int hub_id);
 void qdev_set_nic_properties(DeviceState *dev, NICInfo *nd);
=20
 #define POLYNOMIAL_BE 0x04c11db6
+#define POLYNOMIAL_LE 0xedb88320
 uint32_t net_crc32(const uint8_t *p, int len);
+uint32_t net_crc32_le(const uint8_t *p, int len);
 unsigned compute_mcast_idx(const uint8_t *ep);
=20
 #define vmstate_offset_macaddr(_state, _field)                       \
diff --git a/net/net.c b/net/net.c
index a14dc99..4ecaf80 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1603,6 +1603,28 @@ uint32_t net_crc32(const uint8_t *p, int len)
     return crc;
 }
=20
+uint32_t net_crc32_le(const uint8_t *p, int len)
+{
+    uint32_t crc;
+    int carry, i, j;
+    uint8_t b;
+
+    crc =3D 0xffffffff;
+    for (i =3D 0; i < len; i++) {
+        b =3D *p++;
+        for (j =3D 0; j < 8; j++) {
+            carry =3D (crc & 0x1) ^ (b & 0x01);
+            crc >>=3D 1;
+            b >>=3D 1;
+            if (carry) {
+                crc ^=3D POLYNOMIAL_LE;
+            }
+        }
+    }
+
+    return crc;
+}
+
 unsigned compute_mcast_idx(const uint8_t *ep)
 {
     return net_crc32(ep, ETH_ALEN) >> 26;
--=20
2.7.4
