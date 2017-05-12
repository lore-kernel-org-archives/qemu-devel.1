Received: from eggs.gnu.org ([2001:4830:134:3::10]:50037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Milos.Stojanovic@rt-rk.com>) id 1d98LK-00043W-Lf
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:02:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Milos.Stojanovic@rt-rk.com>) id 1d98LI-0006SN-5C
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:02:42 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:46741 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Milos.Stojanovic@rt-rk.com>)
	id 1d98LH-0006RZ-UA
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:02:40 -0400
From: =?UTF-8?q?Milo=C5=A1=20Stojanovi=C4=87?= <Milos.Stojanovic@rt-rk.com>
Date: Fri, 12 May 2017 13:02:21 +0200
Message-Id: <1494586944-7253-14-git-send-email-Milos.Stojanovic@rt-rk.com>
In-Reply-To: <1494586944-7253-1-git-send-email-Milos.Stojanovic@rt-rk.com>
References: <1494586944-7253-1-git-send-email-Milos.Stojanovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 13/16] [RFC] linux-user: add functions for
 working with the target signal mask
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

Add functions tswapal_target_sigset(), target_to_abi_ulong_old_sigset()
and abi_ulong_to_target_old_sigset().

The tswapal_target_sigset() function transforms target signal sets
from target to host endianness. This is helpful for tracking and working
with the target signal masks in the host endianness rather then keeping
it in the target endianness.

The target_to_abi_ulong_old_sigset() and abi_ulong_to_target_old_sigset()
functions are used for translating the signal set between the old way of
storing it in abi_ulong and the new target_sigset_t structure. They can
be used for expanding old implementations of certain system calls to
include the tracking of the target signal masks.

Signed-off-by: Milo=C5=A1 Stojanovi=C4=87 <Milos.Stojanovic@rt-rk.com>
---
 linux-user/signal.c       | 27 +++++++++++++++++++++++++++
 linux-user/syscall_defs.h |  4 ++++
 2 files changed, 31 insertions(+)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index d72caaf..0c1e231 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -207,6 +207,33 @@ void target_to_host_old_sigset(sigset_t *sigset,
     target_to_host_sigset(sigset, &d);
 }
=20
+static void tswapal_target_sigset(target_sigset_t *d, const target_sigse=
t_t *s)
+{
+    int i;
+
+    for (i =3D 0; i < TARGET_NSIG_WORDS; i++) {
+        d->sig[i] =3D tswapal(s->sig[i]);
+    }
+}
+
+void target_to_abi_ulong_old_sigset(abi_ulong *old_sigset,
+                                    const target_sigset_t *target_sigset=
)
+{
+    target_sigset_t d;
+    tswapal_target_sigset(&d, target_sigset);
+
+    memcpy(old_sigset, &d.sig, sizeof(target_sigset_t));
+}
+
+void abi_ulong_to_target_old_sigset(target_sigset_t *target_sigset,
+                                    const abi_ulong *old_sigset)
+{
+    target_sigset_t d;
+
+    memcpy(&d.sig, old_sigset, sizeof(target_sigset_t));
+    tswapal_target_sigset(target_sigset, &d);
+}
+
 int block_signals(void)
 {
     TaskState *ts =3D (TaskState *)thread_cpu->opaque;
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 40c5027..7eec420 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -426,6 +426,10 @@ void host_to_target_old_sigset(abi_ulong *old_sigset=
,
                                const sigset_t *sigset);
 void target_to_host_old_sigset(sigset_t *sigset,
                                const abi_ulong *old_sigset);
+void target_to_abi_ulong_old_sigset(abi_ulong *old_sigset,
+                                    const target_sigset_t *target_sigset=
);
+void abi_ulong_to_target_old_sigset(target_sigset_t *target_sigset,
+                                    const abi_ulong *old_sigset);
 struct target_sigaction;
 int do_sigaction(int sig, const struct target_sigaction *act,
                  struct target_sigaction *oact);
--=20
1.9.1
