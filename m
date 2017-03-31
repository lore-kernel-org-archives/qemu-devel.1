Received: from eggs.gnu.org ([2001:4830:134:3::10]:54277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ctzeA-0003WB-B6
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 12:43:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ctze5-0000xn-Dd
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 12:43:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ctze5-0000wB-7m
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 12:43:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7DE8CC04B93A
	for <qemu-devel@nongnu.org>; Fri, 31 Mar 2017 16:43:27 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 31 Mar 2017 17:43:22 +0100
Message-Id: <20170331164322.24020-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH] char: kick main loop after adding a watch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Richard W . M . Jones" <rjones@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

The ISA serial port device's output can hang when the pipe on stdout
becomes full.  This is a race condition where the vcpu thread executing
serial emulation code adds a watch on stdout while the main loop thread
is blocked in ppoll(2).  If no timer or other event wakes up the main
loop, there will be no further output from the serial device even when
the pipe becomes writable.

Richard W. M. Jones was able to reproduce the hang on recent versions of
guestfs-tools-c and libglib2 on Fedora 26 hosts.

This patch kicks the main loop so the next iteration invokes ppoll(2)
with the watch fd.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1435432
Reported-by: Richard W. M. Jones <rjones@redhat.com>
Tested-by: Richard W. M. Jones <rjones@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 chardev/char.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/chardev/char.c b/chardev/char.c
index 3df1163..6c99c34 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -1059,6 +1059,11 @@ guint qemu_chr_fe_add_watch(CharBackend *be, GIOCondition cond,
     tag = g_source_attach(src, NULL);
     g_source_unref(src);
 
+    /* The main loop may be in blocked waiting on events in another thread.
+     * Kick it so the new watch will be added.
+     */
+    qemu_notify_event();
+
     return tag;
 }
 
-- 
2.9.3
