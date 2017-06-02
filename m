Received: from eggs.gnu.org ([2001:4830:134:3::10]:50750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dGnJl-0007AS-Bo
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:12:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dGnJk-00034w-Fb
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:12:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dGnJk-00034S-9k
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:12:44 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  2 Jun 2017 18:12:21 +0400
Message-Id: <20170602141229.15326-2-marcandre.lureau@redhat.com>
In-Reply-To: <20170602141229.15326-1-marcandre.lureau@redhat.com>
References: <20170602141229.15326-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 1/9] exec: check kvm mmu notifiers earlier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, ehabkost@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

Move kvm mmu notifiers check before calling file_ram_alloc(), with the
other xen precondition. (file_ram_alloc() will be reused in other cases
than -mem-path).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 exec.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/exec.c b/exec.c
index b1db12fe36..9c6c3cfe87 100644
--- a/exec.c
+++ b/exec.c
@@ -1496,12 +1496,6 @@ static void *file_ram_alloc(RAMBlock *block,
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
@@ -1944,6 +1938,12 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size=
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
2.13.0.91.g00982b8dd
