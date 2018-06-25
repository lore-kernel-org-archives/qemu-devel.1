Received: from eggs.gnu.org ([2001:4830:134:3::10]:57580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fXaAi-0006h8-RP
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 18:41:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fXaAh-0000Y6-St
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 18:41:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fXaAh-0000Wa-MD
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 18:41:19 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 25 Jun 2018 19:41:09 -0300
Message-Id: <20180625224110.5147-2-ehabkost@redhat.com>
In-Reply-To: <20180625224110.5147-1-ehabkost@redhat.com>
References: <20180625224110.5147-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 1/2] vl.c: do not allow --daemonize in
 combination with --preconfig CLI option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

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
Message-Id: <1529501059-163139-1-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 vl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/vl.c b/vl.c
index d451f45dc5..a37dfe4684 100644
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
2.18.0.rc1.1.g3f1ff2140
