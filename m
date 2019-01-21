Received: from eggs.gnu.org ([209.51.188.92]:53073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gle22-00082t-Ir
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:10:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gle21-00083M-Gx
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:10:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gle21-000823-8z
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:10:45 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon, 21 Jan 2019 19:10:30 +0100
Message-Id: <20190121181030.2112-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] virtio-net: Fix VirtIONet typedef redefinition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Thomas Huth <thuth@redhat.com>, Wei Xu <wexu@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Commit 2974e916df8 introduced the VirtioNetRscChain structure which
refer to a VirtIONet, declared later, thus required VirtIONet typedef
to be declarated forward.
However, when compiling with Clang in -std=3Dgnu99 mode, this triggers
the following warning/error:

    CC      hw/net/virtio-net.o
  In file included from qemu/hw/net/virtio-net.c:22:
  include/hw/virtio/virtio-net.h:189:3: error: redefinition of typedef 'V=
irtIONet' is a C11 feature [-Werror,-Wtypedef-redefinition]
  } VirtIONet;
    ^
  include/hw/virtio/virtio-net.h:110:26: note: previous definition is her=
e
  typedef struct VirtIONet VirtIONet;
                           ^
  1 error generated.
  make: *** [rules.mak:69: hw/net/virtio-net.o] Error 1

Fix it by removing the duplicate typedef definition.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/hw/virtio/virtio-net.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-ne=
t.h
index c7ec1a755f..bd662752d2 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -106,7 +106,6 @@ typedef struct VirtioNetRscSeg {
     NetClientState *nc;
 } VirtioNetRscSeg;
=20
-struct VirtIONet;
 typedef struct VirtIONet VirtIONet;
=20
 /* Chain is divided by protocol(ipv4/v6) and NetClientInfo */
@@ -136,7 +135,7 @@ typedef struct VirtIONetQueue {
     struct VirtIONet *n;
 } VirtIONetQueue;
=20
-typedef struct VirtIONet {
+struct VirtIONet {
     VirtIODevice parent_obj;
     uint8_t mac[ETH_ALEN];
     uint16_t status;
@@ -186,7 +185,7 @@ typedef struct VirtIONet {
     int announce_counter;
     bool needs_vnet_hdr_swap;
     bool mtu_bypass_backend;
-} VirtIONet;
+};
=20
 void virtio_net_set_netclient_name(VirtIONet *n, const char *name,
                                    const char *type);
--=20
2.20.1
