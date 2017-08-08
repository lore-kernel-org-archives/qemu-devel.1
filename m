Received: from eggs.gnu.org ([2001:4830:134:3::10]:57791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dfBIF-0008Q2-7A
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:40:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dfBID-0000Ue-Rs
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:39:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dfBID-0000Te-MN
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:39:57 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9BD2266199
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 20:39:56 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue,  8 Aug 2017 17:39:34 -0300
Message-Id: <20170808203935.30021-5-ehabkost@redhat.com>
In-Reply-To: <20170808203935.30021-1-ehabkost@redhat.com>
References: <20170808203935.30021-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11 v2 4/5] qmp-shell: Accept QMP command
 as argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>

This is useful for testing QMP commands in scripts.

Example usage, combined with 'jq' for filtering the results:

  $ ./scripts/qmp/qmp-shell /tmp/qmp qom-list path=/ | jq -r .return[].name
  machine
  type
  chardevs
  backend
  $

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 -> v2:
* Rewritten using optparse module
---
 scripts/qmp/qmp-shell | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index 4b9a420..4b7374e 100755
--- a/scripts/qmp/qmp-shell
+++ b/scripts/qmp/qmp-shell
@@ -400,7 +400,7 @@ def die(msg):
 
 def main():
     parser = optparse.OptionParser(description='QMP shell utility')
-    parser.set_usage("%prog [options] <UNIX socket path> | <TCP address:port>")
+    parser.set_usage("%prog [options] <UNIX socket path> | <TCP address:port> [COMMAND [ARG=VALUE]...]")
     parser.add_option('-v', action='store_true', dest='verbose',
         help='Verbose (echo command sent and received)')
     parser.add_option('-p', action='store_true', dest='pretty',
@@ -411,10 +411,11 @@ def main():
         default=True, help='Skip negotiate (for qemu-ga)')
     opts,args = parser.parse_args()
 
-    if len(args) != 1:
+    if len(args) < 1:
         parser.print_help(sys.stderr)
         sys.exit(1)
     addr = args[0]
+    cmdargs = args[1:]
 
     try:
         if opts.hmp:
@@ -433,10 +434,13 @@ def main():
     except qemu.error:
         die('Could not connect to %s' % addr)
 
-    qemu.show_banner()
     qemu.set_verbosity(opts.verbose)
-    while qemu.read_exec_command(qemu.get_prompt()):
-        pass
+    if len(cmdargs):
+        qemu.execute_cmdargs(cmdargs)
+    else:
+        qemu.show_banner()
+        while qemu.read_exec_command(qemu.get_prompt()):
+            pass
     qemu.close()
 
 if __name__ == '__main__':
-- 
2.9.4
