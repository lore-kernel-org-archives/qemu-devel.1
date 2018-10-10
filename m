Received: from eggs.gnu.org ([2001:4830:134:3::10]:34526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gA7iY-00027l-LJ
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 02:11:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gA7iW-0008FU-1j
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 02:11:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56880)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gA7iV-0007rZ-Om
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 02:11:31 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3934D30001D3
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 06:11:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E65411054FBA
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 06:11:16 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 10 Oct 2018 08:11:13 +0200
Message-Id: <20181010061113.6057-6-armbru@redhat.com>
In-Reply-To: <20181010061113.6057-1-armbru@redhat.com>
References: <20181010061113.6057-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 5/5] ivshmem: Fix unplug of device
 "ivshmem-plain"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Commit 2aece63c8a "hostmem: detect host backend memory is being used
properly" fixed "ivshmem-plain" to reject memory backends that are
already in use, and to block their deletion while in use.  Two bugs
escaped review:

* New ivshmem_plain_exit() fails to call ivshmem_exit().  This breaks
  unplug.  Reproducer: migration after unplug still fails with
  "Migration is disabled when using feature 'peer mode' in device
  'ivshmem'".

* It failed to update legacy "ivshmem".  Harmless, because it creates
  the memory backend itself, and nothing else should use it.

Fix by moving the two host_memory_backend_set_mapped() calls into
ivshmem_common_realize() and ivshmem_exit(), guarded by s->hostmem.

Fixes: 2aece63c8a9d2c3a8ff41d2febc4cdeff2633331
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20180926163709.22876-1-armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/misc/ivshmem.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index 6febbabcaa..8cb17b9dd4 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -911,6 +911,7 @@ static void ivshmem_common_realize(PCIDevice *dev, Er=
ror **errp)
         IVSHMEM_DPRINTF("using hostmem\n");
=20
         s->ivshmem_bar2 =3D host_memory_backend_get_memory(s->hostmem);
+        host_memory_backend_set_mapped(s->hostmem, true);
     } else {
         Chardev *chr =3D qemu_chr_fe_get_driver(&s->server_chr);
         assert(chr);
@@ -993,6 +994,10 @@ static void ivshmem_exit(PCIDevice *dev)
         vmstate_unregister_ram(s->ivshmem_bar2, DEVICE(dev));
     }
=20
+    if (s->hostmem) {
+        host_memory_backend_set_mapped(s->hostmem, false);
+    }
+
     if (s->peers) {
         for (i =3D 0; i < s->nb_peers; i++) {
             close_peer_eventfds(s, i);
@@ -1101,14 +1106,6 @@ static void ivshmem_plain_realize(PCIDevice *dev, =
Error **errp)
     }
=20
     ivshmem_common_realize(dev, errp);
-    host_memory_backend_set_mapped(s->hostmem, true);
-}
-
-static void ivshmem_plain_exit(PCIDevice *pci_dev)
-{
-    IVShmemState *s =3D IVSHMEM_COMMON(pci_dev);
-
-    host_memory_backend_set_mapped(s->hostmem, false);
 }
=20
 static void ivshmem_plain_class_init(ObjectClass *klass, void *data)
@@ -1117,7 +1114,6 @@ static void ivshmem_plain_class_init(ObjectClass *k=
lass, void *data)
     PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
=20
     k->realize =3D ivshmem_plain_realize;
-    k->exit =3D ivshmem_plain_exit;
     dc->props =3D ivshmem_plain_properties;
     dc->vmsd =3D &ivshmem_plain_vmsd;
 }
--=20
2.17.1
