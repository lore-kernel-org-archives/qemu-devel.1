Received: from eggs.gnu.org ([2001:4830:134:3::10]:41501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dEIWf-0008AH-2d
	for qemu-devel@nongnu.org; Fri, 26 May 2017 12:55:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dEIWe-0003co-Eg
	for qemu-devel@nongnu.org; Fri, 26 May 2017 12:55:45 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 26 May 2017 18:55:07 +0200
Message-Id: <20170526165518.7580-6-mreitz@redhat.com>
In-Reply-To: <20170526165518.7580-1-mreitz@redhat.com>
References: <20170526165518.7580-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 05/16] block/file-posix: Small fixes in
 raw_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Variables should be declared at the start of a block, and if a certain
parameter value is not supported it may be better to return -ENOTSUP
instead of -EINVAL.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 block/file-posix.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 7cc6bf6..f5a662e 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1915,6 +1915,8 @@ static int raw_create(const char *filename, QemuOpt=
s *opts, Error **errp)
 #endif
     case PREALLOC_MODE_FULL:
     {
+        int64_t num =3D 0, left =3D total_size;
+
         /*
          * Knowing the final size from the beginning could allow the fil=
e
          * system driver to do less allocations and possibly avoid
@@ -1926,7 +1928,6 @@ static int raw_create(const char *filename, QemuOpt=
s *opts, Error **errp)
             goto out_close;
         }
=20
-        int64_t num =3D 0, left =3D total_size;
         buf =3D g_malloc0(65536);
=20
         while (left > 0) {
@@ -1958,7 +1959,7 @@ static int raw_create(const char *filename, QemuOpt=
s *opts, Error **errp)
         }
         break;
     default:
-        result =3D -EINVAL;
+        result =3D -ENOTSUP;
         error_setg(errp, "Unsupported preallocation mode: %s",
                    PreallocMode_lookup[prealloc]);
         break;
--=20
2.9.4
