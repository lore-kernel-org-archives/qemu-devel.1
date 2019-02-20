Received: from eggs.gnu.org ([209.51.188.92]:41085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwGQh-00052t-Ar
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 20:12:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwGMN-0003Rj-OV
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 20:07:40 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Wed, 20 Feb 2019 02:02:13 +0100
Message-Id: <20190220010232.18731-7-philmd@redhat.com>
In-Reply-To: <20190220010232.18731-1-philmd@redhat.com>
References: <20190220010232.18731-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 06/25] gdbstub: Use size_t to hold
 GDBState::last_packet_len
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

In put_packet_binary() we have:

    uint8_t *p;
    for(;;) {
        p =3D s->last_packet;
        *(p++) =3D ...
        s->last_packet_len =3D p - s->last_packet;
        put_buffer(s, (uint8_t *)s->last_packet, s->last_packet_len);

The 'p' pointer start at s->last_packet, then is only incremented.
Since we have "p >=3D s->last_packet", we are sure than
"p - s->last_packet >=3D 0", thus "p - s->last_packet" is positive.

The few other places where s->last_packet_len is set is with constant
positive values.

It makes sense to use size_t to hold last_packet_len values.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gdbstub.c b/gdbstub.c
index 76eca3bb7e..69340d7cd1 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -323,7 +323,7 @@ typedef struct GDBState {
     int line_sum; /* running checksum */
     int line_csum; /* checksum at the end of the packet */
     uint8_t last_packet[MAX_PACKET_LENGTH + 4];
-    int last_packet_len;
+    size_t last_packet_len;
     int signal;
 #ifdef CONFIG_USER_ONLY
     int fd;
--=20
2.20.1
