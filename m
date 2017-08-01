Received: from eggs.gnu.org ([2001:4830:134:3::10]:35792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dcerD-0000z5-Mi
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 17:37:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dcerC-0004cV-Q4
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 17:37:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dcerC-0004bu-Je
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 17:37:38 -0400
Date: Wed, 2 Aug 2017 00:37:34 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1501623438-31419-3-git-send-email-mst@redhat.com>
References: <1501623438-31419-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1501623438-31419-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/10] vhost: fix a memory leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peng Hao <peng.hao2@zte.com.cn>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

From: Peng Hao <peng.hao2@zte.com.cn>

vhost exists a call for g_file_get_contents, but not call g_free.

Signed-off-by: Peng Hao<peng.hao2@zte.com.cn>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/virtio/vhost-backend.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
index cb055e8..7f09efa 100644
--- a/hw/virtio/vhost-backend.c
+++ b/hw/virtio/vhost-backend.c
@@ -52,11 +52,13 @@ static int vhost_kernel_memslots_limit(struct vhost_d=
ev *dev)
                             &s, NULL, NULL)) {
         uint64_t val =3D g_ascii_strtoull(s, NULL, 10);
         if (!((val =3D=3D G_MAXUINT64 || !val) && errno)) {
+            g_free(s);
             return val;
         }
         error_report("ignoring invalid max_mem_regions value in vhost mo=
dule:"
                      " %s", s);
     }
+    g_free(s);
     return limit;
 }
=20
--=20
MST
