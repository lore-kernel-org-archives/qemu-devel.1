Received: from eggs.gnu.org ([2001:4830:134:3::10]:38719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Milos.Stojanovic@rt-rk.com>) id 1dAHaq-0004vo-JP
	for qemu-devel@nongnu.org; Mon, 15 May 2017 11:07:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Milos.Stojanovic@rt-rk.com>) id 1dAHak-0006u1-Ht
	for qemu-devel@nongnu.org; Mon, 15 May 2017 11:07:28 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:47362 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Milos.Stojanovic@rt-rk.com>)
	id 1dAHak-0006tB-5X
	for qemu-devel@nongnu.org; Mon, 15 May 2017 11:07:22 -0400
From: =?UTF-8?q?Milo=C5=A1=20Stojanovi=C4=87?= <Milos.Stojanovic@rt-rk.com>
Date: Mon, 15 May 2017 16:59:53 +0200
Message-Id: <1494860396-24930-14-git-send-email-Milos.Stojanovic@rt-rk.com>
In-Reply-To: <1494860396-24930-1-git-send-email-Milos.Stojanovic@rt-rk.com>
References: <1494860396-24930-1-git-send-email-Milos.Stojanovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 13/16] [RFC] linux-user: add functions for
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
Cc: laurent@vivier.eu, Miodrag.Dinic@rt-rk.com, Aleksandar.Markovic@rt-rk.com, Petar.Jovanovic@rt-rk.com, yongbok.kim@imgtec.com, Milos.Stojanovic@rt-rk.com

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
Change from v1 to v2:
tswapal_target_sigset() is no longer static since it was breaking the bui=
ld.

 linux-user/qemu.h         |  1 +
 linux-user/signal.c       | 27 +++++++++++++++++++++++++++
 linux-user/syscall_defs.h |  4 ++++
 3 files changed, 32 insertions(+)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 6ce0811..7049517 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -391,6 +391,7 @@ void host_to_target_siginfo(target_siginfo_t *tinfo, =
const siginfo_t *info);
 void target_to_host_siginfo(siginfo_t *info, const target_siginfo_t *tin=
fo);
 int target_to_host_signal(int sig);
 int host_to_target_signal(int sig);
+void tswapal_target_sigset(target_sigset_t *d, const target_sigset_t *s)=
;
 long do_sigreturn(CPUArchState *env);
 long do_rt_sigreturn(CPUArchState *env);
 abi_long do_sigaltstack(abi_ulong uss_addr, abi_ulong uoss_addr, abi_ulo=
ng sp);
diff --git a/linux-user/signal.c b/linux-user/signal.c
index b96d508..5c441db 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -207,6 +207,33 @@ void target_to_host_old_sigset(sigset_t *sigset,
     target_to_host_sigset(sigset, &d);
 }
=20
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
+void tswapal_target_sigset(target_sigset_t *d, const target_sigset_t *s)
+{
+    int i;
+
+    for (i =3D 0; i < TARGET_NSIG_WORDS; i++) {
+        d->sig[i] =3D tswapal(s->sig[i]);
+    }
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
