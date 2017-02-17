Received: from eggs.gnu.org ([2001:4830:134:3::10]:44098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=y3pv=Z6=redhat.com=mst@kernel.org>)
	id 1ceobf-0003ua-9f
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:54:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=y3pv=Z6=redhat.com=mst@kernel.org>)
	id 1ceobe-0005ON-Dx
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:54:15 -0500
Received: from mail.kernel.org ([198.145.29.136]:34250)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=y3pv=Z6=redhat.com=mst@kernel.org>)
	id 1ceobe-0005Nl-7C
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 14:54:14 -0500
Date: Fri, 17 Feb 2017 21:54:06 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1487361200-29966-5-git-send-email-mst@redhat.com>
References: <1487361200-29966-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1487361200-29966-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/23] memory: make memory_listener_unregister
 idempotent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Paolo Bonzini <pbonzini@redhat.com>

Make it easy to unregister a MemoryListener without tracking whether it
had been registered before.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 memory.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/memory.c b/memory.c
index 6c58373..ed8b5aa 100644
--- a/memory.c
+++ b/memory.c
@@ -2371,8 +2371,13 @@ void memory_listener_register(MemoryListener *list=
ener, AddressSpace *as)
=20
 void memory_listener_unregister(MemoryListener *listener)
 {
+    if (!listener->address_space) {
+        return;
+    }
+
     QTAILQ_REMOVE(&memory_listeners, listener, link);
     QTAILQ_REMOVE(&listener->address_space->listeners, listener, link_as=
);
+    listener->address_space =3D NULL;
 }
=20
 void address_space_init(AddressSpace *as, MemoryRegion *root, const char=
 *name)
--=20
MST
