Received: from eggs.gnu.org ([2001:4830:134:3::10]:45921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ciOGK-0007rg-7f
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:35:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ciOGH-0008Q8-PN
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:35:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ciOGH-0008Q1-Jk
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:34:57 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 27 Feb 2017 16:34:47 +0000
Message-Id: <20170227163447.20428-5-stefanha@redhat.com>
In-Reply-To: <20170227163447.20428-1-stefanha@redhat.com>
References: <20170227163447.20428-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/4] tests-aio-multithread: use atomic_read
 properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

nodes[id].next is written by other threads.  If atomic_read is not used
(matching atomic_set in mcs_mutex_lock!) the compiler can optimize the
whole "if" away!

Reported-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Tested-by: Greg Kurz <groug@kaod.org>
Message-id: 20170227111726.9237-1-pbonzini@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/test-aio-multithread.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/test-aio-multithread.c b/tests/test-aio-multithread.c
index f11e990..8b0b40e 100644
--- a/tests/test-aio-multithread.c
+++ b/tests/test-aio-multithread.c
@@ -309,7 +309,7 @@ static void mcs_mutex_lock(void)
 static void mcs_mutex_unlock(void)
 {
     int next;
-    if (nodes[id].next =3D=3D -1) {
+    if (atomic_read(&nodes[id].next) =3D=3D -1) {
         if (atomic_read(&mutex_head) =3D=3D id &&
             atomic_cmpxchg(&mutex_head, id, -1) =3D=3D id) {
             /* Last item in the list, exit.  */
@@ -323,7 +323,7 @@ static void mcs_mutex_unlock(void)
     }
=20
     /* Wake up the next in line.  */
-    next =3D nodes[id].next;
+    next =3D atomic_read(&nodes[id].next);
     nodes[next].locked =3D 0;
     qemu_futex_wake(&nodes[next].locked, 1);
 }
--=20
2.9.3
