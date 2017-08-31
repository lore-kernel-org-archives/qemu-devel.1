Received: from eggs.gnu.org ([2001:4830:134:3::10]:42537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dnKkQ-0005SW-3a
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 04:22:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dnKkP-0005vJ-5E
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 04:22:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38784)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dnKkO-0005vD-VF
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 04:22:45 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 31 Aug 2017 09:22:04 +0100
Message-Id: <20170831082210.8362-10-stefanha@redhat.com>
In-Reply-To: <20170831082210.8362-1-stefanha@redhat.com>
References: <20170831082210.8362-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-2.10 09/15] oslib-posix: Print errors before
 aborting on qemu_alloc_stack()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Eduardo Habkost <ehabkost@redhat.com>

If QEMU is running on a system that's out of memory and mmap()
fails, QEMU aborts with no error message at all, making it hard
to debug the reason for the failure.

Add perror() calls that will print error information before
aborting.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20170829212053.6003-1-ehabkost@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 util/oslib-posix.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index cacf0ef5e3..80086c549f 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -530,6 +530,7 @@ void *qemu_alloc_stack(size_t *sz)
     ptr =3D mmap(NULL, *sz, PROT_READ | PROT_WRITE,
                MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
     if (ptr =3D=3D MAP_FAILED) {
+        perror("failed to allocate memory for stack");
         abort();
     }
=20
@@ -544,6 +545,7 @@ void *qemu_alloc_stack(size_t *sz)
     guardpage =3D ptr;
 #endif
     if (mprotect(guardpage, pagesz, PROT_NONE) !=3D 0) {
+        perror("failed to set up stack guard page");
         abort();
     }
=20
--=20
2.13.5
