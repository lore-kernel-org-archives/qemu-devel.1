Received: from eggs.gnu.org ([2001:4830:134:3::10]:41593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ct2Fu-0002uY-BN
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 21:18:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ct2Fr-0006LH-D3
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 21:18:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51779)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ct2Fr-0006Ko-6k
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 21:18:31 -0400
Date: Wed, 29 Mar 2017 04:18:28 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1490750257-19907-4-git-send-email-mst@redhat.com>
References: <1490750257-19907-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1490750257-19907-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/3] virtio: fix vring_align() on 64-bit windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Eric Blake <eblake@redhat.com>, Stefan Weil <sw@weilnetz.de>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Andrew Baumann <Andrew.Baumann@microsoft.com>

long is 32-bits on 64-bit windows, which caused the top half of the
address to be truncated; this patch changes it to use the
QEMU_ALIGN_UP macro which does not suffer the same problem

Signed-off-by: Andrew Baumann <Andrew.Baumann@microsoft.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 include/hw/virtio/virtio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 15efcf2..7b6edba 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -34,7 +34,7 @@ struct VirtQueue;
 static inline hwaddr vring_align(hwaddr addr,
                                              unsigned long align)
 {
-    return (addr + align - 1) & ~(align - 1);
+    return QEMU_ALIGN_UP(addr, align);
 }
=20
 typedef struct VirtQueue VirtQueue;
--=20
MST
