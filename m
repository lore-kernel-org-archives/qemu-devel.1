Received: from eggs.gnu.org ([2001:4830:134:3::10]:53273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cRHA9-0001ry-1z
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 06:33:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cRHA6-0001MR-VB
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 06:33:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46784)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cRHA6-0001M9-Jk
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 06:33:50 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C24AC4D697
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 11:33:50 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 11 Jan 2017 12:33:39 +0100
Message-Id: <20170111113347.7577-2-marcandre.lureau@redhat.com>
In-Reply-To: <20170111113347.7577-1-marcandre.lureau@redhat.com>
References: <20170111113347.7577-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/9] exec: check kvm mmu notifiers earlier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Move kvm mmu notifiers check before calling file_ram_alloc(), with the
other xen precondition. (the function will be reused in other cases than
-mem-path).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 exec.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/exec.c b/exec.c
index 47835c1dc1..172baba30e 100644
--- a/exec.c
+++ b/exec.c
@@ -1273,12 +1273,6 @@ static void *file_ram_alloc(RAMBlock *block,
     int fd =3D -1;
     int64_t file_size;
=20
-    if (kvm_enabled() && !kvm_has_sync_mmu()) {
-        error_setg(errp,
-                   "host lacks kvm mmu notifiers, -mem-path unsupported"=
);
-        return NULL;
-    }
-
     for (;;) {
         fd =3D open(path, O_RDWR);
         if (fd >=3D 0) {
@@ -1703,6 +1697,12 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size=
, MemoryRegion *mr,
         return NULL;
     }
=20
+    if (kvm_enabled() && !kvm_has_sync_mmu()) {
+        error_setg(errp,
+                   "host lacks kvm mmu notifiers, -mem-path unsupported"=
);
+        return NULL;
+    }
+
     if (phys_mem_alloc !=3D qemu_anon_ram_alloc) {
         /*
          * file_ram_alloc() needs to allocate just like
--=20
2.11.0
