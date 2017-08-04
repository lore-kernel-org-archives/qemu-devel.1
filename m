Received: from eggs.gnu.org ([2001:4830:134:3::10]:33720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ddkGr-0007CZ-6w
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 17:36:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ddkGq-0001ki-AD
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 17:36:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ddkGq-0001jx-45
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 17:36:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2269580468
	for <qemu-devel@nongnu.org>; Fri,  4 Aug 2017 21:36:35 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  4 Aug 2017 18:36:24 -0300
Message-Id: <20170804213625.3756-5-ehabkost@redhat.com>
In-Reply-To: <20170804213625.3756-1-ehabkost@redhat.com>
References: <20170804213625.3756-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11 4/5] qmp-shell: Accept QMP command as
 argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com

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
 scripts/qmp/qmp-shell | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index 6113aaf..947fc36 100755
--- a/scripts/qmp/qmp-shell
+++ b/scripts/qmp/qmp-shell
@@ -410,6 +410,10 @@ def main():
         default=True, help='Skip negotiate (for qemu-ga)')
     parser.add_argument('addr', metavar='ADDRESS',
         help='QMP socket address (Unix socket path or TCP address:port)')
+    parser.add_argument('cmd', metavar='COMMAND', nargs='?',
+        help='QMP command to be exeucted')
+    parser.add_argument('cmdargs', metavar='ARG=VALUE', nargs='*',
+        help='Argument to QMP command')
     args = parser.parse_args()
 
     try:
@@ -429,10 +433,13 @@ def main():
     except qemu.error:
         die('Could not connect to %s' % args.addr)
 
-    qemu.show_banner()
     qemu.set_verbosity(args.verbose)
-    while qemu.read_exec_command(qemu.get_prompt()):
-        pass
+    if args.cmd:
+        qemu.execute_cmdargs([args.cmd] + args.cmdargs)
+    else:
+        qemu.show_banner()
+        while qemu.read_exec_command(qemu.get_prompt()):
+            pass
     qemu.close()
 
 if __name__ == '__main__':
-- 
2.9.4
