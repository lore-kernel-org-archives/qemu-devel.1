Received: from eggs.gnu.org ([2001:4830:134:3::10]:49974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Milos.Stojanovic@rt-rk.com>) id 1d98LJ-00042R-A2
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:02:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Milos.Stojanovic@rt-rk.com>) id 1d98LG-0006RI-Sg
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:02:41 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:46443 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Milos.Stojanovic@rt-rk.com>)
	id 1d98LG-0006Q9-Li
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:02:38 -0400
From: =?UTF-8?q?Milo=C5=A1=20Stojanovi=C4=87?= <Milos.Stojanovic@rt-rk.com>
Date: Fri, 12 May 2017 13:02:19 +0200
Message-Id: <1494586944-7253-12-git-send-email-Milos.Stojanovic@rt-rk.com>
In-Reply-To: <1494586944-7253-1-git-send-email-Milos.Stojanovic@rt-rk.com>
References: <1494586944-7253-1-git-send-email-Milos.Stojanovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 11/16] [RFC] linux-user: add target_sigdelset()
 and target_sigorset()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, riku.voipio@iki.fi
Cc: Milos.Stojanovic@rt-rk.com

Add two inline functions that work with the signal set of the target.

target_sigdelset() removes a signal from target_sigset_t.
target_sigorset() creates a union of two target_sigset_t.

These functions will be used for introducing support for tracking the
target signal set. Functions for emptying and adding into a target signal
set already exist so this commit will serve as a supplement.

Signed-off-by: Milo=C5=A1 Stojanovi=C4=87 <Milos.Stojanovic@rt-rk.com>
---
 linux-user/signal.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 2bc6669..59d70ec 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -120,6 +120,12 @@ static inline void target_sigaddset(target_sigset_t =
*set, int signum)
     set->sig[signum / TARGET_NSIG_BPW] |=3D mask;
 }
=20
+static inline void target_sigdelset(target_sigset_t *set, int signum)
+{
+    abi_ulong mask =3D (abi_ulong)1 << (--signum % TARGET_NSIG_BPW);
+    set->sig[signum / TARGET_NSIG_BPW] &=3D ~mask;
+}
+
 static inline int target_sigismember(const target_sigset_t *set, int sig=
num)
 {
     signum--;
@@ -127,6 +133,16 @@ static inline int target_sigismember(const target_si=
gset_t *set, int signum)
     return ((set->sig[signum / TARGET_NSIG_BPW] & mask) !=3D 0);
 }
=20
+static inline void target_sigorset(target_sigset_t *set,
+                                   const target_sigset_t *left,
+                                   const target_sigset_t *right)
+{
+    int i;
+    for (i =3D 0; i < TARGET_NSIG_WORDS; i++) {
+        set->sig[i] =3D left->sig[i] | right->sig[i];
+    }
+}
+
 static void host_to_target_sigset_internal(target_sigset_t *d,
                                            const sigset_t *s)
 {
--=20
1.9.1
