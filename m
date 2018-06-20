Received: from eggs.gnu.org ([2001:4830:134:3::10]:56211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fVd6W-00033F-26
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:24:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fVd6S-0004Pn-3N
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:24:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35516 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fVd6R-0004Pa-Up
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:24:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2B0EC738E6
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 13:24:51 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 20 Jun 2018 15:24:19 +0200
Message-Id: <1529501059-163139-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH] vl.c: do not allow --daemonize in combination
 with --preconfig CLI option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pkrempa@redhat.com, mprivozn@redhat.com, ehabkost@redhat.com, berrange@redhat.com

some users when using --daemonize expect that QEMU will parse CLI options,
initialize VM and only then complete daemonzation by signalling lead
process to exit and start listening on monitor socket. So users treat
parent process exit as sync point to connect to QEMU's monitor.

That however doesn't work when --preconfig options is used, since it
provides monitor before completing daemonization and expects user to
issue exit-preconfig command when additional configuration via monitor
is finished. We also can't move completing daemonization before
preconfig monitor becomes available, since that would imply:
  * partially loosing ability to configure QEMU instance in --preconfig
    mode since QEMU might drop privileges, chroot and do other things
    when daemonization is completed
  * lead to loss of error messages in case they would happen after
    daemonization

Be proactive now and make options mutually exclusive, so users would
get clear error message instead of waiting for lead process exit
indefinitely before connecting to monitor.

PS:
In case someone would come up with usecase where both options should
be enabled at the same time we could drop this restriction as far
as daemonization point is left where it is now (os_setup_post).

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 vl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/vl.c b/vl.c
index b3426e0..569bc7f 100644
--- a/vl.c
+++ b/vl.c
@@ -4134,6 +4134,12 @@ int main(int argc, char **argv, char **envp)
     }
 
     if (is_daemonized()) {
+        if (!preconfig_exit_requested) {
+            error_report("'preconfig' and 'daemonize' options are "
+                         "mutually exclusive");
+            exit(EXIT_FAILURE);
+        }
+
         /* According to documentation and historically, -nographic redirects
          * serial port, parallel port and monitor to stdio, which does not work
          * with -daemonize.  We can redirect these to null instead, but since
-- 
2.7.4
