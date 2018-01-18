Received: from eggs.gnu.org ([2001:4830:134:3::10]:36602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ec7dQ-00064X-Ma
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 05:41:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ec7dN-0008Po-II
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 05:41:28 -0500
Received: from 4.mo5.mail-out.ovh.net ([178.33.111.247]:53112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ec7dN-0008Fa-BS
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 05:41:25 -0500
Received: from player760.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 0298917DEC5
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 11:41:14 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 18 Jan 2018 11:41:03 +0100
Message-ID: <151627206353.4505.4602428849861610759.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] readline: don't free completions in
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Since commit e5dc1a6c6c43, QEMU aborts on exit if completion was used
in the monitor:

*** Error in `obj/ppc64-softmmu/qemu-system-ppc64': double free or
 corruption (fasttop): 0x00000100331069d0 ***

#0  0x00007ffff267eff0 in raise () from /lib64/libc.so.6
#1  0x00007ffff268136c in abort () from /lib64/libc.so.6
#2  0x00007ffff26c6b48 in __libc_message () from /lib64/libc.so.6
#3  0x00007ffff26d69fc in free () from /lib64/libc.so.6
#4  0x00007ffff28cb794 in g_free () from /lib64/libglib-2.0.so.0
#5  0x00000000106230e4 in readline_free (rs=0x11223e60) at
 /home/greg/Work/qemu/qemu-spapr/util/readline.c:514
#6  0x0000000010074cc4 in monitor_data_destroy (mon=0x1121c9f0) at
 /home/greg/Work/qemu/qemu-spapr/monitor.c:586
#7  0x000000001007bcc8 in monitor_cleanup () at
 /home/greg/Work/qemu/qemu-spapr/monitor.c:4125
#8  0x0000000010291274 in main (argc=<optimized out>,
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
---
 util/readline.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/util/readline.c b/util/readline.c
index 24ec839854cf..ec91ee0fea6f 100644
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
 
