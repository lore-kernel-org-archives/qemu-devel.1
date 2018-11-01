Received: from eggs.gnu.org ([2001:4830:134:3::10]:59629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gIEoI-0005ug-0l
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 11:23:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gIEoE-00048w-Co
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 11:23:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gIEoE-00047I-5I
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 11:22:58 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8EAA74DD49
	for <qemu-devel@nongnu.org>; Thu,  1 Nov 2018 15:22:56 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu,  1 Nov 2018 16:15:19 +0100
Message-Id: <1541085319-211335-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] ivshmem: fix memory backend leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, philmd@redhat.com

object_new() returns a new backend with refcount =3D=3D 1 and
then later object_property_add_child() increases refcount to 2
So when ivshmem is destroyed, the backend it has created isn't
destroyed along with it as children cleanup will bring
backend's refcount only to 1, which leaks backend including
resources it is using.

Drop the original reference from object_new() once backend
is attached to its parent.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 v2:
  *   s/desroyed/destroyed/
        Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
  * pick up Mark's Rb
---
 hw/misc/ivshmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index f88910e..ecfd10a 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -1279,6 +1279,7 @@ static void desugar_shm(IVShmemState *s)
     object_property_set_bool(obj, true, "share", &error_abort);
     object_property_add_child(OBJECT(s), "internal-shm-backend", obj,
                               &error_abort);
+    object_unref(obj);
     user_creatable_complete(obj, &error_abort);
     s->hostmem =3D MEMORY_BACKEND(obj);
 }
--=20
2.7.4
