Received: from eggs.gnu.org ([2001:4830:134:3::10]:47951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fhfsE-0002bB-Tw
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 14:47:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fhfsD-0007pb-Vt
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 14:47:58 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43694)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fhfsD-0007pA-Nr
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 14:47:57 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jul 2018 19:47:52 +0100
Message-Id: <20180723184752.22150-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-3.0] tests/libqtest: Improve kill_qemu()
 assert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>

In kill_qemu() we have an assert that checks that the QEMU process
didn't dump core:
            assert(!WCOREDUMP(wstatus));

Unfortunately the WCOREDUMP macro here means the resulting message
is not very easy to comprehend on at least some systems:

ahci-test: tests/libqtest.c:113: kill_qemu: Assertion `!(((__extension__ (((union { __typeof(wstatus) __in; int __i; }) { .__in = (wstatus) }).__i))) & 0x80)' failed.

and it doesn't identify what signal the process took.

Instead of using a raw assert, print the information in an
easier to understand way:

/i386/ahci/sanity: tests/libqtest.c:119: kill_qemu() tried to terminate QEMU process but it dumped core with signal 11 (Segmentation fault)
Aborted (core dumped)

(Of course, the really useful information would be why the QEMU
process dumped core in the first place, but we don't have that
by the time the test program has picked up the exit status.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
changes v1->v2: addressed some of the bikeshedding with:
 * print file-and-line in the fprintf message, and then
   just abort(), rather than assert(0)
 * print the signal name via strsignal() as well

 tests/libqtest.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 098af6aec44..bfc86a15f4b 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -110,7 +110,16 @@ static void kill_qemu(QTestState *s)
         pid = waitpid(s->qemu_pid, &wstatus, 0);
 
         if (pid == s->qemu_pid && WIFSIGNALED(wstatus)) {
-            assert(!WCOREDUMP(wstatus));
+            if (WCOREDUMP(wstatus)) {
+                int sig = WTERMSIG(wstatus);
+                const char *signame = strsignal(sig) ?: "unknown ???";
+
+                fprintf(stderr,
+                        "%s:%d: kill_qemu() tried to terminate QEMU "
+                        "process but it dumped core with signal %d (%s)\n",
+                        __FILE__, __LINE__, sig, signame);
+                abort();
+            }
         }
     }
 }
-- 
2.17.1
