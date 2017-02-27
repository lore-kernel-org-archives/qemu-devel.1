Received: from eggs.gnu.org ([2001:4830:134:3::10]:43754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ciJJ7-0004fm-Er
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:17:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ciJJ2-0000Eb-MF
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:17:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ciJJ2-0000EN-G1
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 06:17:28 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 55C633A76A4
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 11:17:28 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 27 Feb 2017 12:17:26 +0100
Message-Id: <20170227111726.9237-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] tests-aio-multithread: use atomic_read properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com

nodes[id].next is written by other threads.  If atomic_read is not used
(matching atomic_set in mcs_mutex_lock!) the compiler can optimize the
whole "if" away!

Reported-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
