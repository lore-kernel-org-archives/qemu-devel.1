Received: from eggs.gnu.org ([2001:4830:134:3::10]:55048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dK27O-0001Ag-9P
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 08:37:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dK27L-0006W3-65
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 08:37:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1dK27K-0006VH-Vo
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 08:37:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C722E81233
	for <qemu-devel@nongnu.org>; Sun, 11 Jun 2017 12:37:17 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
Date: Sun, 11 Jun 2017 14:37:14 +0200
Message-Id: <20170611123714.31292-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH] qemu-nbd: Ignore SIGPIPE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>

qemu proper has done so for 13 years
(8a7ddc38a60648257dc0645ab4a05b33d6040063), qemu-img and qemu-io have
done so for four years (526eda14a68d5b3596be715505289b541288ef2a).
Ignoring this signal is especially important in qemu-nbd because
otherwise a client can easily take down the qemu-nbd server by dropping
the connection when the server wants to send something, for example:

$ qemu-nbd -x foo -f raw -t null-co:// &
[1] 12726
$ qemu-io -c quit nbd://localhost/bar
can't open device nbd://localhost/bar: No export with name 'bar' available
[1]  + 12726 broken pipe  qemu-nbd -x foo -f raw -t null-co://

In this case, the client sends an NBD_OPT_ABORT and closes the
connection (because it is not required to wait for a reply), but the
server replies with an NBD_REP_ACK (because it is required to reply).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
I tried to find some other reproducer instead of using a qemu client
(e.g. nping -c 1 --tcp-connect localhost -p 10809, which gives the same
pattern of <FIN-ACK, >PSH-ACK, <RST as qemu-io) but to no avail. This
only results in the write being successful and the next read failing;
interestingly, sendmsg()'s man page states that EPIPE is only returned
when the local end is closed. However, I have not found the NBD server
to close that local end anywhere.

In any case, ignoring SIGPIPE is the right thing to do. We get an EPIPE
anyway, and this is fully sufficient to let us know that the connection
is dead.
---
 qemu-nbd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index b7ab86b..b2eeedb 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -580,6 +580,10 @@ int main(int argc, char **argv)
     sa_sigterm.sa_handler = termsig_handler;
     sigaction(SIGTERM, &sa_sigterm, NULL);
 
+#ifdef CONFIG_POSIX
+    signal(SIGPIPE, SIG_IGN);
+#endif
+
     module_call_init(MODULE_INIT_TRACE);
     qcrypto_init(&error_fatal);
 
-- 
2.9.4
