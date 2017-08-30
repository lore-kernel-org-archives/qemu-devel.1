Received: from eggs.gnu.org ([2001:4830:134:3::10]:56469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dn3DA-0004I7-JN
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:39:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dn3D7-0004UT-Be
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 09:39:16 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 30 Aug 2017 15:39:03 +0200
Message-Id: <1504100343-26607-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11] hw/misc/ivshmem: Fix
 ivshmem_recv_msg() to also work on big endian systems
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The "slow" ivshmem-tests currently fail when they are running on a
big endian host:

$ uname -m
ppc64
$ V=1 QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64 tests/ivshmem-test -m slow
/x86_64/ivshmem/single: OK
/x86_64/ivshmem/hotplug: OK
/x86_64/ivshmem/memdev: OK
/x86_64/ivshmem/pair: OK
/x86_64/ivshmem/server-msi: qemu-system-x86_64:
 -device ivshmem-doorbell,chardev=chr0,vectors=2: server sent invalid ID message
Broken pipe

The problem is that the server side code in ivshmem_server_send_one_msg()
correctly translates all messages IDs into little endian 64-bit values,
but the client side code in the ivshmem_recv_msg() function does not swap
the byte order back. Fix it by passing the value through le64_to_cpu().

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/misc/ivshmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index 47a015f..b3ef3ec 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -653,7 +653,7 @@ static int64_t ivshmem_recv_msg(IVShmemState *s, int *pfd, Error **errp)
     } while (n < sizeof(msg));
 
     *pfd = qemu_chr_fe_get_msgfd(&s->server_chr);
-    return msg;
+    return le64_to_cpu(msg);
 }
 
 static void ivshmem_recv_setup(IVShmemState *s, Error **errp)
-- 
1.8.3.1
