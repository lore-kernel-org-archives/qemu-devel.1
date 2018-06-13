Received: from eggs.gnu.org ([2001:4830:134:3::10]:50784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dimastep@yandex-team.ru>) id 1fT10s-0002TE-Gg
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:20:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dimastep@yandex-team.ru>) id 1fT10n-0004S0-Te
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:20:18 -0400
Received: from forwardcorp1j.cmail.yandex.net ([2a02:6b8:0:1630::190]:52564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dimastep@yandex-team.ru>)
	id 1fT10n-0004Pt-MF
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:20:13 -0400
From: Dima Stepanov <dimastep@yandex-team.ru>
Date: Wed, 13 Jun 2018 11:19:54 +0300
Message-Id: <1528877995-5043-2-git-send-email-dimastep@yandex-team.ru>
In-Reply-To: <1528877995-5043-1-git-send-email-dimastep@yandex-team.ru>
References: <1528877995-5043-1-git-send-email-dimastep@yandex-team.ru>
Subject: [Qemu-devel] [PATCH v2 1/2] memfd: fix possible usage of the
 uninitialized file descriptor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: wrfsh@yandex-team.ru

The qemu_memfd_alloc_check() routine allocates the fd variable on stack.
This variable is initialized inside the qemu_memfd_alloc() function.
There are several cases when *fd will be left unintialized which can
lead to the unexpected close() in the qemu_memfd_free() call.

Set file descriptor to -1 before calling the qemu_memfd_alloc routine.

Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
---
 util/memfd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/util/memfd.c b/util/memfd.c
index d248a53..6287946 100644
--- a/util/memfd.c
+++ b/util/memfd.c
@@ -187,6 +187,7 @@ bool qemu_memfd_alloc_check(void)
         int fd;
         void *ptr;
 
+        fd = -1;
         ptr = qemu_memfd_alloc("test", 4096, 0, &fd, NULL);
         memfd_check = ptr ? MEMFD_OK : MEMFD_KO;
         qemu_memfd_free(ptr, 4096, fd);
-- 
2.7.4
