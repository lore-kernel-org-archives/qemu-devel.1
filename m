Received: from eggs.gnu.org ([209.51.188.92]:59028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1glqGv-0006NA-Nc
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 02:14:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1glqGs-0001oP-O6
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 02:14:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1glqGs-0001Rf-AE
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 02:14:54 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 22 Jan 2019 08:08:35 +0100
Message-Id: <1548140916-6923-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1548140916-6923-1-git-send-email-thuth@redhat.com>
References: <1548140916-6923-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v4 20/26] virtio-net: Fix VirtIONet typedef
 redefinition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Commit 2974e916df8 introduced the VirtioNetRscChain structure which
refer to a VirtIONet, declared later, thus required VirtIONet typedef
to use a forward declaration.
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
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/virtio/virtio-net.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-ne=
t.h
index c7ec1a7..bd66275 100644
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
1.8.3.1
