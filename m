Received: from eggs.gnu.org ([2001:4830:134:3::10]:52766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e0BQb-0007qp-9v
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 15:03:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e0BQY-0002MO-2F
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 15:03:25 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu,  5 Oct 2017 14:02:45 -0500
Message-Id: <20171005190248.5537-4-eblake@redhat.com>
In-Reply-To: <20171005190248.5537-1-eblake@redhat.com>
References: <20171005190248.5537-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 3/6] iotests: Restore stty settings on
 completion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, jsnow@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Executing qemu with a terminal as stdin will temporarily alter stty
settings on that terminal (for example, disabling echo), because of
how we run both the monitor and any multiplexing with guest input.
Normally, qemu restores the original settings on exit; but if an
iotest triggers qemu to abort in the middle, we can be left with
the altered terminal setup.  This can make life very annoying when
debugging an iotest failure (not everyone remembers the trick of
blind-typing 'stty sane' without echo, and some people prefer
terminal settings that are slightly different than the defaults
picked by 'stty sane').

It is possible to avoid qemu corrupting the terminal by not passing
a terminal to qemu's stdin in the first place (as in, use
'./check ... </dev/null'), but that's extra typing to have to
remember.  But running 'exec </dev/null' in the harness seems like
it might be too heavy of a hammer.  So I instead went the the
solution of saving and restoring the stty settings, only when the
harness detects that it is run interactively.

I tested this patch by forcing an allocation failure (I can't
guarantee that this particular limit will work on all setups, but
it shows the idea):
 $ (ulimit -S -v 500000; ./check -qcow2 1)

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v3: new patch
---
 tests/qemu-iotests/check | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 176cb8e937..e6b6ff7a04 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -134,6 +134,13 @@ export VALGRIND_QEMU=
 export IMGKEYSECRET=
 export IMGOPTSSYNTAX=false

+# Save current tty settings, since an aborting qemu call may leave things
+# screwed up
+STTY_RESTORE=
+if test -t 0; then
+    STTY_RESTORE=$(stty -g)
+fi
+
 for r
 do

@@ -664,6 +671,9 @@ END        { if (NR > 0) {
         needwrap=false
     fi

+    if test -n "$STTY_RESTORE"; then
+        stty $STTY_RESTORE
+    fi
     rm -f "${TEST_DIR}"/*.out "${TEST_DIR}"/*.err "${TEST_DIR}"/*.time
     rm -f "${TEST_DIR}"/check.pid "${TEST_DIR}"/check.sts
     rm -f $tmp.*
-- 
2.13.6
