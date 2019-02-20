Received: from eggs.gnu.org ([209.51.188.92]:42019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwGSa-0007lR-La
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 20:14:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwGSY-0005V6-0A
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 20:14:04 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Wed, 20 Feb 2019 02:02:28 +0100
Message-Id: <20190220010232.18731-22-philmd@redhat.com>
In-Reply-To: <20190220010232.18731-1-philmd@redhat.com>
References: <20190220010232.18731-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 21/25] s390x/sclp: Use size_t in
 process_mdb()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Prasad J Pandit <pjp@fedoraproject.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Gerd Hoffmann <kraxel@redhat.com>, Zhang Chen <zhangckid@gmail.com>, xen-devel@lists.xenproject.org, Cornelia Huck <cohuck@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Amit Shah <amit@kernel.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, Corey Minyard <minyard@acm.org>, "Michael S. Tsirkin" <mst@redhat.com>, Paul Durrant <paul.durrant@citrix.com>, Halil Pasic <pasic@linux.ibm.com>, Stefano Stabellini <sstabellini@kernel.org>, qemu-s390x@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Since it is unlikely we have sizeof(mdbo->mto.message) < 0,
we can convert this variable to an unsigned type.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/char/sclpconsole-lm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/char/sclpconsole-lm.c b/hw/char/sclpconsole-lm.c
index 49543e2c83..48c76d863e 100644
--- a/hw/char/sclpconsole-lm.c
+++ b/hw/char/sclpconsole-lm.c
@@ -208,7 +208,7 @@ static int write_console_data(SCLPEvent *event, const=
 uint8_t *buf, int len)
 static int process_mdb(SCLPEvent *event, MDBO *mdbo)
 {
     int rc;
-    int len;
+    uint16_t len;
     uint8_t buffer[SIZE_BUFFER];
     const size_t hlen =3D sizeof(mdbo->length)
             + sizeof(mdbo->type)
@@ -217,6 +217,7 @@ static int process_mdb(SCLPEvent *event, MDBO *mdbo)
             + sizeof(mdbo->mto._reserved);
=20
     len =3D be16_to_cpu(mdbo->length);
+    assert(len >=3D hlen);
     len -=3D hlen;
     assert(len <=3D SIZE_BUFFER);
=20
--=20
2.20.1
