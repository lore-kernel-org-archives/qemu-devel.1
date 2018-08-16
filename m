Received: from eggs.gnu.org ([2001:4830:134:3::10]:50764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqDn0-0001J3-BQ
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:37:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqDmr-0005Xo-3B
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:37:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53676 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fqDmq-0005C3-0K
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:37:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 54B5240776FD
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 08:37:06 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 16 Aug 2018 10:37:00 +0200
Message-Id: <20180816083701.3932-25-armbru@redhat.com>
In-Reply-To: <20180816083701.3932-1-armbru@redhat.com>
References: <20180816083701.3932-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 24/25] tests/libqtest: Improve kill_qemu()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

In kill_qemu() we have an assert that checks that the QEMU process
didn't dump core:
            assert(!WCOREDUMP(wstatus));

Unfortunately the WCOREDUMP macro here means the resulting message
is not very easy to comprehend on at least some systems:

ahci-test: tests/libqtest.c:113: kill_qemu: Assertion `!(((__extension__ =
(((union { __typeof(wstatus) __in; int __i; }) { .__in =3D (wstatus) })._=
_i))) & 0x80)' failed.

and it doesn't identify what signal the process took. What's more,
WCOREDUMP is not reliable - in some cases, setrlimit() coupled with
kernel dump settings can result in the flag not being set.  It's
better to log ALL death by signal, instead of caring whether a core
dump was attempted (although once we know a signal happened, also
mentioning if a core dump is present can be helpful).

Furthermore, we are NOT detecting EINTR (while EINTR shouldn't be
happening if we didn't install signal handlers, it's still better
to always be robust).

Finally, even non-signal death with a non-zero status is suspicious,
since qemu's SIGINT handler is supposed to result in exit(0).

Instead of using a raw assert, print the information in an
easier to understand way:

/i386/ahci/sanity: tests/libqtest.c:129: kill_qemu() detected QEMU death =
from signal 11 (Segmentation fault) (core dumped)

(Of course, the really useful information would be why the QEMU
process dumped core in the first place, but we don't have that
by the time the test program has picked up the exit status.)

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180810132800.38549-1-eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Core dump reporting and commit message tweaked]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 tests/libqtest.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 3706f30aa2..b703fca26d 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -107,10 +107,28 @@ static void kill_qemu(QTestState *s)
         pid_t pid;
=20
         kill(s->qemu_pid, SIGTERM);
-        pid =3D waitpid(s->qemu_pid, &wstatus, 0);
+        TFR(pid =3D waitpid(s->qemu_pid, &wstatus, 0));
=20
-        if (pid =3D=3D s->qemu_pid && WIFSIGNALED(wstatus)) {
-            assert(!WCOREDUMP(wstatus));
+        assert(pid =3D=3D s->qemu_pid);
+        /*
+         * We expect qemu to exit with status 0; anything else is
+         * fishy and should be logged with as much detail as possible.
+         */
+        if (wstatus) {
+            if (WIFEXITED(wstatus)) {
+                fprintf(stderr, "%s:%d: kill_qemu() tried to terminate Q=
EMU "
+                        "process but encountered exit status %d\n",
+                        __FILE__, __LINE__, WEXITSTATUS(wstatus));
+            } else if (WIFSIGNALED(wstatus)) {
+                int sig =3D WTERMSIG(wstatus);
+                const char *signame =3D strsignal(sig) ?: "unknown ???";
+                const char *dump =3D WCOREDUMP(wstatus) ? " (core dumped=
)" : "";
+
+                fprintf(stderr, "%s:%d: kill_qemu() detected QEMU death =
"
+                        "from signal %d (%s)%s\n",
+                        __FILE__, __LINE__, sig, signame, dump);
+            }
+            abort();
         }
     }
 }
--=20
2.17.1
