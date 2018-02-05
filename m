Received: from eggs.gnu.org ([2001:4830:134:3::10]:44515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimS8-0004KJ-6k
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eimS6-0004ud-Je
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:20 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:40437)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eimS6-0004uJ-D4
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:29:18 -0500
Received: by mail-wm0-x242.google.com with SMTP id v123so28068425wmd.5
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 11:29:18 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Feb 2018 20:28:24 +0100
Message-Id: <1517858941-5538-11-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
References: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 10/47] readline: don't free completions in
 readline_free()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>

From: Greg Kurz <groug@kaod.org>

Since commit e5dc1a6c6c43, QEMU aborts on exit if completion was used
in the monitor:

*** Error in `obj/ppc64-softmmu/qemu-system-ppc64': double free or
 corruption (fasttop): 0x00000100331069d0 ***

 /home/greg/Work/qemu/qemu-spapr/util/readline.c:514
 /home/greg/Work/qemu/qemu-spapr/monitor.c:586
 /home/greg/Work/qemu/qemu-spapr/monitor.c:4125
 argv=<optimized out>, envp=<optimized out>) at
 /home/greg/Work/qemu/qemu-spapr/vl.c:4795

Completion strings are not persistent accross completions (why would
they?). They are allocated under readline_completion(), which already
takes care of freeing them before returning.

Maybe all completion related bits should be moved out of ReadLineState
to a dedicated structure ?

In the meantime, let's drop the offending lines from readline_free()
to fix the crash.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <151627206353.4505.4602428849861610759.stgit@bahia.lan>
Fixes: e5dc1a6c6c43
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/readline.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/util/readline.c b/util/readline.c
index 24ec839..ec91ee0 100644
--- a/util/readline.c
+++ b/util/readline.c
@@ -510,9 +510,6 @@ void readline_free(ReadLineState *rs)
     for (i = 0; i < READLINE_MAX_CMDS; i++) {
         g_free(rs->history[i]);
     }
-    for (i = 0; i < READLINE_MAX_COMPLETIONS; i++) {
-        g_free(rs->completions[i]);
-    }
     g_free(rs);
 }
 
-- 
1.8.3.1
