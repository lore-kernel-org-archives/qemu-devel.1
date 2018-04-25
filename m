Received: from eggs.gnu.org ([2001:4830:134:3::10]:38705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fBKJu-0000H6-EJ
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 09:18:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fBKJr-00076k-AY
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 09:18:50 -0400
Received: from 16.mo6.mail-out.ovh.net ([87.98.139.208]:38567)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fBKJr-00075y-4C
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 09:18:47 -0400
Received: from player697.ha.ovh.net (unknown [10.109.120.92])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 999F91579B6
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 15:18:45 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed, 25 Apr 2018 15:18:28 +0200
Message-Id: <20180425131828.15604-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] cpus: tcg: fix never exiting loop on unplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Commit 9b0605f9837b ("cpus: tcg: unregister thread with RCU, fix
exiting of loop on unplug") changed the exit condition of the loop in
the vCPU thread function but forgot to remove the beginning 'while (1)'
statement. The resulting code :

	while (1) {
	...
	} while (!cpu->unplug || cpu_can_run(cpu));

is a sequence of two distinct two while() loops, the first not exiting
in case of an unplug event.

Remove the first while (1) to fix CPU unplug.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 cpus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cpus.c b/cpus.c
index 38eba8bff334..e1d94038fd0d 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1648,7 +1648,7 @@ static void *qemu_tcg_cpu_thread_fn(void *arg)
     /* process any pending work */
     cpu->exit_request =3D 1;
=20
-    while (1) {
+    do {
         if (cpu_can_run(cpu)) {
             int r;
             qemu_mutex_unlock_iothread();
--=20
2.13.6
