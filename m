Received: from eggs.gnu.org ([2001:4830:134:3::10]:50026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Milos.Stojanovic@rt-rk.com>) id 1d98LK-00043K-EG
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:02:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Milos.Stojanovic@rt-rk.com>) id 1d98LG-0006RP-UK
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:02:42 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:46442 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Milos.Stojanovic@rt-rk.com>)
	id 1d98LG-0006QC-Ne
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:02:38 -0400
From: =?UTF-8?q?Milo=C5=A1=20Stojanovi=C4=87?= <Milos.Stojanovic@rt-rk.com>
Date: Fri, 12 May 2017 13:02:18 +0200
Message-Id: <1494586944-7253-11-git-send-email-Milos.Stojanovic@rt-rk.com>
In-Reply-To: <1494586944-7253-1-git-send-email-Milos.Stojanovic@rt-rk.com>
References: <1494586944-7253-1-git-send-email-Milos.Stojanovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 10/16] [RFC] linux-user: add support for
 tracking the target signal mask
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

If TRACK_TARGET_SIGMASK is defined, add fields in the TaskState structure
which will hold the target signal and suspend mask and add support for
initialization and forking. No functional changes are being introduced in
this commit. The TRACK_TARGET_SIGMASK will be defined in a later commit
where the target signal masks will be needed in order to implement
multiplexing of real-time target signals which are out of the host range.

Currently, QEMU has a copy of the host signal and suspend masks and that
is usually enough, since most of the time the signal mask of the target
architecture is either the same length or narrower. If however the signal
mask is wider, then part of it won't be tracked.

This commit enables adding support for separately tracking the target
signal masks in the following commits.

Signed-off-by: Milo=C5=A1 Stojanovi=C4=87 <Milos.Stojanovic@rt-rk.com>
---
 linux-user/qemu.h    | 5 +++++
 linux-user/signal.c  | 3 +++
 linux-user/syscall.c | 3 +++
 3 files changed, 11 insertions(+)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 4edd7d0..6ce0811 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -139,6 +139,11 @@ typedef struct TaskState {
      * currently in the middle of such a syscall
      */
     sigset_t sigsuspend_mask;
+#ifdef TRACK_TARGET_SIGMASK
+    /* Track the target signal and suspend masks. */
+    target_sigset_t target_signal_mask;
+    target_sigset_t target_sigsuspend_mask;
+#endif
     /* Nonzero if we're leaving a sigsuspend and sigsuspend_mask is vali=
d. */
     int in_sigsuspend;
=20
diff --git a/linux-user/signal.c b/linux-user/signal.c
index a67db04..2bc6669 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -485,6 +485,9 @@ void signal_init(void)
=20
     /* Set the signal mask from the host mask. */
     sigprocmask(0, 0, &ts->signal_mask);
+#ifdef TRACK_TARGET_SIGMASK
+    host_to_target_sigset_internal(&ts->target_signal_mask, &ts->signal_=
mask);
+#endif
=20
     /* set all host signal handlers. ALL signals are blocked during
        the handlers to serialize them. */
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d3b769e..94ecae3 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6279,6 +6279,9 @@ static int do_fork(CPUArchState *env, unsigned int =
flags, abi_ulong newsp,
         ts->bprm =3D parent_ts->bprm;
         ts->info =3D parent_ts->info;
         ts->signal_mask =3D parent_ts->signal_mask;
+#ifdef TRACK_TARGET_SIGMASK
+        ts->target_signal_mask =3D parent_ts->target_signal_mask;
+#endif
=20
         if (flags & CLONE_CHILD_CLEARTID) {
             ts->child_tidptr =3D child_tidptr;
--=20
1.9.1
