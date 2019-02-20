Received: from eggs.gnu.org ([209.51.188.92]:41990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwGSY-0007gz-AV
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 20:14:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwGSN-0005RX-8J
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 20:13:58 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Wed, 20 Feb 2019 02:02:25 +0100
Message-Id: <20190220010232.18731-19-philmd@redhat.com>
In-Reply-To: <20190220010232.18731-1-philmd@redhat.com>
References: <20190220010232.18731-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 18/25] s390x/3270: Let
 insert_IAC_escape_char() use size_t
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

This function takes size_t argument and return a size_t.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/char/terminal3270.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/char/terminal3270.c b/hw/char/terminal3270.c
index 35b079d5c4..1cb48a3c6f 100644
--- a/hw/char/terminal3270.c
+++ b/hw/char/terminal3270.c
@@ -199,9 +199,10 @@ static int read_payload_3270(EmulatedCcw3270Device *=
dev)
 }
=20
 /* TN3270 uses binary transmission, which needs escape IAC to IAC IAC */
-static int insert_IAC_escape_char(uint8_t *outv, int out_len)
+static size_t insert_IAC_escape_char(uint8_t *outv, size_t out_len)
 {
-    int IAC_num =3D 0, new_out_len, i, j;
+    size_t new_out_len;
+    int IAC_num =3D 0, i, j;
=20
     for (i =3D 0; i < out_len; i++) {
         if (outv[i] =3D=3D IAC) {
@@ -232,7 +233,7 @@ static int write_payload_3270(EmulatedCcw3270Device *=
dev, uint8_t cmd)
     int count =3D ccw_dstream_avail(get_cds(t));
     int bound =3D (OUTPUT_BUFFER_SIZE - 3) / 2;
     int len =3D MIN(count, bound);
-    int out_len =3D 0;
+    size_t out_len =3D 0;
=20
     if (!t->handshake_done) {
         if (!(t->outv[0] =3D=3D IAC && t->outv[1] !=3D IAC)) {
--=20
2.20.1
