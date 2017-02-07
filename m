Received: from eggs.gnu.org ([2001:4830:134:3::10]:51708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbFeD-0000BZ-Cp
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 18:58:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbFeC-0007zP-8m
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 18:58:09 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  8 Feb 2017 00:57:57 +0100
Message-Id: <20170207235757.2026-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH] progress: Show current progress on SIGINFO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Currently we only print progress information on retrieval of SIGUSR1.
Some systems have a dedicated SIGINFO for this, however, so it should be
handled appropriately if it is available.

Buglink: https://bugs.launchpad.net/qemu/+bug/1662468
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
Can anyone test this on a BSD system? O:-)
---
 util/qemu-progress.c | 3 +++
 qemu-img.texi        | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/util/qemu-progress.c b/util/qemu-progress.c
index f745233763..3c2223c1a2 100644
--- a/util/qemu-progress.c
+++ b/util/qemu-progress.c
@@ -88,6 +88,9 @@ static void progress_dummy_init(void)
     action.sa_handler = sigusr_print;
     action.sa_flags = 0;
     sigaction(SIGUSR1, &action, NULL);
+#ifdef SIGINFO
+    sigaction(SIGINFO, &action, NULL);
+#endif
 
     /*
      * SIGUSR1 is SIG_IPI and gets blocked in qemu_init_main_loop(). In the
diff --git a/qemu-img.texi b/qemu-img.texi
index 174aae38b7..b7e849b22b 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -84,7 +84,8 @@ with or without a command shows help and lists the supported formats
 @item -p
 display progress bar (compare, convert and rebase commands only).
 If the @var{-p} option is not used for a command that supports it, the
-progress is reported when the process receives a @code{SIGUSR1} signal.
+progress is reported when the process receives a @code{SIGUSR1} or
+@code{SIGINFO} signal.
 @item -q
 Quiet mode - do not print any output (except errors). There's no progress bar
 in case both @var{-q} and @var{-p} options are used.
-- 
2.11.0
