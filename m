Received: from eggs.gnu.org ([2001:4830:134:3::10]:45219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gHnwi-0003Un-9j
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 06:41:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gHnwd-0001wq-5U
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 06:41:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gHnwc-0001u5-Q3
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 06:41:50 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 31 Oct 2018 14:41:36 +0400
Message-Id: <20181031104136.9953-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] vhost-user-bridge: fix "unknown type name"
 compilation error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: victork@redhat.com, cota@braap.org, pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

osdep.h should be included first:

  CC      tests/vhost-user-bridge.o
In file included from /home/elmarco/src/qemu/tests/vhost-user-bridge.c:32=
:
/home/elmarco/src/qemu/include/qemu/atomic.h:480:1: error: unknown type n=
ame =E2=80=98int64_t=E2=80=99
 int64_t  atomic_read_i64(const int64_t *ptr);
 ^~~~~~~
/home/elmarco/src/qemu/include/qemu/atomic.h:480:32: error: unknown type =
name =E2=80=98int64_t=E2=80=99
 int64_t  atomic_read_i64(const int64_t *ptr);
                                ^~~~~~~
/home/elmarco/src/qemu/include/qemu/atomic.h:481:1: error: unknown type n=
ame =E2=80=98uint64_t=E2=80=99
 uint64_t atomic_read_u64(const uint64_t *ptr);
 ^~~~~~~~
/home/elmarco/src/qemu/include/qemu/atomic.h:481:32: error: unknown type =
name =E2=80=98uint64_t=E2=80=99
 uint64_t atomic_read_u64(const uint64_t *ptr);
                                ^~~~~~~~
/home/elmarco/src/qemu/include/qemu/atomic.h:482:21: error: unknown type =
name =E2=80=98int64_t=E2=80=99
 void atomic_set_i64(int64_t *ptr, int64_t val);
                     ^~~~~~~
/home/elmarco/src/qemu/include/qemu/atomic.h:482:35: error: unknown type =
name =E2=80=98int64_t=E2=80=99
 void atomic_set_i64(int64_t *ptr, int64_t val);
                                   ^~~~~~~
/home/elmarco/src/qemu/include/qemu/atomic.h:483:21: error: unknown type =
name =E2=80=98uint64_t=E2=80=99
 void atomic_set_u64(uint64_t *ptr, uint64_t val);
                     ^~~~~~~~
/home/elmarco/src/qemu/include/qemu/atomic.h:483:36: error: unknown type =
name =E2=80=98uint64_t=E2=80=99
 void atomic_set_u64(uint64_t *ptr, uint64_t val);
                                    ^~~~~~~~

(regression from 782da5b2921c4d18777d5d5bd9385b9f7beae360)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/vhost-user-bridge.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/vhost-user-bridge.c b/tests/vhost-user-bridge.c
index 0884294141..6e17370397 100644
--- a/tests/vhost-user-bridge.c
+++ b/tests/vhost-user-bridge.c
@@ -29,8 +29,9 @@
=20
 #define _FILE_OFFSET_BITS 64
=20
-#include "qemu/atomic.h"
 #include "qemu/osdep.h"
+
+#include "qemu/atomic.h"
 #include "qemu/iov.h"
 #include "standard-headers/linux/virtio_net.h"
 #include "contrib/libvhost-user/libvhost-user.h"
--=20
2.19.1.708.g4ede3d42df
