Received: from eggs.gnu.org ([2001:4830:134:3::10]:52268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6MZ-0000q9-AF
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6MX-0000Ex-Hw
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:51 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:36629)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gX6MX-0008I8-4k
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:49 -0500
Received: by mail-wm1-x32d.google.com with SMTP id a18so6412120wmj.1
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 07:23:21 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Dec 2018 16:22:23 +0100
Message-Id: <1544628195-37728-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
References: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/54] vhost-user-bridge: fix "unknown type
 name" compilation error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

osdep.h should be included first:

  CC      tests/vhost-user-bridge.o
In file included from /home/elmarco/src/qemu/tests/vhost-user-bridge.c:32:
/home/elmarco/src/qemu/include/qemu/atomic.h:480:1: error: unknown type name ‘int64_t’
 int64_t  atomic_read_i64(const int64_t *ptr);
 ^~~~~~~
/home/elmarco/src/qemu/include/qemu/atomic.h:480:32: error: unknown type name ‘int64_t’
 int64_t  atomic_read_i64(const int64_t *ptr);
                                ^~~~~~~
/home/elmarco/src/qemu/include/qemu/atomic.h:481:1: error: unknown type name ‘uint64_t’
 uint64_t atomic_read_u64(const uint64_t *ptr);
 ^~~~~~~~
/home/elmarco/src/qemu/include/qemu/atomic.h:481:32: error: unknown type name ‘uint64_t’
 uint64_t atomic_read_u64(const uint64_t *ptr);
                                ^~~~~~~~
/home/elmarco/src/qemu/include/qemu/atomic.h:482:21: error: unknown type name ‘int64_t’
 void atomic_set_i64(int64_t *ptr, int64_t val);
                     ^~~~~~~
/home/elmarco/src/qemu/include/qemu/atomic.h:482:35: error: unknown type name ‘int64_t’
 void atomic_set_i64(int64_t *ptr, int64_t val);
                                   ^~~~~~~
/home/elmarco/src/qemu/include/qemu/atomic.h:483:21: error: unknown type name ‘uint64_t’
 void atomic_set_u64(uint64_t *ptr, uint64_t val);
                     ^~~~~~~~
/home/elmarco/src/qemu/include/qemu/atomic.h:483:36: error: unknown type name ‘uint64_t’
 void atomic_set_u64(uint64_t *ptr, uint64_t val);
                                    ^~~~~~~~

(regression from 782da5b2921c4d18777d5d5bd9385b9f7beae360)

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20181031104136.9953-1-marcandre.lureau@redhat.com>
Reviewed-by: Michal Privoznik <mprivozn@redhat.com>
Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/vhost-user-bridge.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/vhost-user-bridge.c b/tests/vhost-user-bridge.c
index 0cf8d0b..e029e5b 100644
--- a/tests/vhost-user-bridge.c
+++ b/tests/vhost-user-bridge.c
@@ -29,8 +29,9 @@
 
 #define _FILE_OFFSET_BITS 64
 
-#include "qemu/atomic.h"
 #include "qemu/osdep.h"
+
+#include "qemu/atomic.h"
 #include "qemu/iov.h"
 #include "standard-headers/linux/virtio_net.h"
 #include "contrib/libvhost-user/libvhost-user.h"
-- 
1.8.3.1
