Received: from eggs.gnu.org ([2001:4830:134:3::10]:38566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Milos.Stojanovic@rt-rk.com>) id 1dAHaH-0004KC-Tl
	for qemu-devel@nongnu.org; Mon, 15 May 2017 11:06:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Milos.Stojanovic@rt-rk.com>) id 1dAHaC-0006nc-Vv
	for qemu-devel@nongnu.org; Mon, 15 May 2017 11:06:53 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:47181 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Milos.Stojanovic@rt-rk.com>)
	id 1dAHaC-0006nH-Nq
	for qemu-devel@nongnu.org; Mon, 15 May 2017 11:06:48 -0400
From: =?UTF-8?q?Milo=C5=A1=20Stojanovi=C4=87?= <Milos.Stojanovic@rt-rk.com>
Date: Mon, 15 May 2017 16:59:52 +0200
Message-Id: <1494860396-24930-13-git-send-email-Milos.Stojanovic@rt-rk.com>
In-Reply-To: <1494860396-24930-1-git-send-email-Milos.Stojanovic@rt-rk.com>
References: <1494860396-24930-1-git-send-email-Milos.Stojanovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 12/16] [RFC] linux-user: fix sigismember()
 check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, riku.voipio@iki.fi
Cc: laurent@vivier.eu, Miodrag.Dinic@rt-rk.com, Aleksandar.Markovic@rt-rk.com, Petar.Jovanovic@rt-rk.com, yongbok.kim@imgtec.com, Milos.Stojanovic@rt-rk.com

Fix copying between the host and target signal sets for the case when the
target set is larger than the host set.

sigismember() returns 1 if the specified signal number is a member of
the specified signal set, but it can also return -1 if an error occurs
(e.g. an out of range signal number is specified). All non-zero values
would cause the signal to be added, so a comparison with 1 is added to
assure that only the signals which are really in the set get added to
the other set.

Signed-off-by: Milo=C5=A1 Stojanovi=C4=87 <Milos.Stojanovic@rt-rk.com>
---
 linux-user/signal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index ae4da79..b96d508 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -149,7 +149,7 @@ static void host_to_target_sigset_internal(target_sig=
set_t *d,
     int i;
     target_sigemptyset(d);
     for (i =3D 1; i <=3D TARGET_NSIG; i++) {
-        if (sigismember(s, i)) {
+        if (sigismember(s, i) =3D=3D 1) {
             target_sigaddset(d, host_to_target_signal(i));
         }
     }
@@ -171,7 +171,7 @@ static void target_to_host_sigset_internal(sigset_t *=
d,
     int i;
     sigemptyset(d);
     for (i =3D 1; i <=3D TARGET_NSIG; i++) {
-        if (target_sigismember(s, i)) {
+        if (target_sigismember(s, i) =3D=3D 1) {
             sigaddset(d, target_to_host_signal(i));
         }
     }
--=20
1.9.1
