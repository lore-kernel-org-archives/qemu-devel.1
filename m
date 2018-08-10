Received: from eggs.gnu.org ([2001:4830:134:3::10]:57822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fo7Sc-0000i4-PP
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 09:28:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fo7SY-0006OD-3w
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 09:28:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47502 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fo7SX-0006NV-U1
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 09:28:06 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri, 10 Aug 2018 08:28:00 -0500
Message-Id: <20180810132800.38549-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4] tests/libqtest: Improve kill_qemu()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, thuth@redhat.com, mst@redhat.com, armbru@redhat.com, f4bug@amsat.org, alex.bennee@linaro.org, rth@twiddle.net

In kill_qemu() we have an assert that checks that the QEMU process
didn't dump core:
            assert(!WCOREDUMP(wstatus));

Unfortunately the WCOREDUMP macro here means the resulting message
is not very easy to comprehend on at least some systems:

ahci-test: tests/libqtest.c:113: kill_qemu: Assertion `!(((__extension__ (((union { __typeof(wstatus) __in; int __i; }) { .__in = (wstatus) }).__i))) & 0x80)' failed.

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

/i386/ahci/sanity: tests/libqtest.c:119: kill_qemu() detected QEMU death from signal 11 (Segmentation fault) (core dumped)
Aborted (core dumped)

(Of course, the really useful information would be why the QEMU
process dumped core in the first place, but we don't have that
by the time the test program has picked up the exit status.)

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Eric Blake <eblake@redhat.com>

---
v4: don't special-case death without WCOREDUMP [Markus]
v3: use TFR() instead of open-coding the retry loop [Thomas]
---
 tests/libqtest.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 098af6aec44..57cf89015e0 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -107,10 +107,28 @@ static void kill_qemu(QTestState *s)
         pid_t pid;

         kill(s->qemu_pid, SIGTERM);
-        pid = waitpid(s->qemu_pid, &wstatus, 0);
+        TFR(pid = waitpid(s->qemu_pid, &wstatus, 0));

-        if (pid == s->qemu_pid && WIFSIGNALED(wstatus)) {
-            assert(!WCOREDUMP(wstatus));
+        assert(pid == s->qemu_pid);
+        /*
+         * We expect qemu to exit with status 0; anything else is
+         * fishy and should be logged with as much detail as possible.
+         */
+        if (wstatus) {
+            if (WIFEXITED(wstatus)) {
+                fprintf(stderr, "%s:%d: kill_qemu() tried to terminate QEMU "
+                        "process but encountered exit status %d\n",
+                        __FILE__, __LINE__, WEXITSTATUS(wstatus));
+            } else if (WIFSIGNALED(wstatus)) {
+                int sig = WTERMSIG(wstatus);
+                const char *signame = strsignal(sig) ?: "unknown ???";
+                const char *dump = WCOREDUMP(wstatus) ? " (dumped core)" : "";
+
+                fprintf(stderr, "%s:%d: kill_qemu() detected QEMU death "
+                        "from signal %d (%s)%s\n",
+                        __FILE__, __LINE__, sig, signame, dump);
+            }
+            abort();
         }
     }
 }
-- 
2.14.4
