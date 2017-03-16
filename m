Received: from eggs.gnu.org ([2001:4830:134:3::10]:54635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtQ-00065R-9I
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1coOtN-0006yr-3H
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1coOtM-0006wp-U4
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:28:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B248D81247
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 06:28:08 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 16 Mar 2017 07:27:18 +0100
Message-Id: <1489645685-4750-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1489645685-4750-1-git-send-email-armbru@redhat.com>
References: <1489645685-4750-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL for 2.9 02/49] qmp: allow setting properties to
 empty string in qmp-shell
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: "Daniel P. Berrange" <berrange@redhat.com>

The qmp-shell property parser currently rejects attempts to
set string properties to the empty string eg

  (QEMU) migrate-set-parameters  tls-hostname=
  Error while parsing command line: Expected a key=value pair, got 'tls-hostname='
command format: <command-name>  [arg-name1=arg1] ... [arg-nameN=argN]

This is caused by checking the wrong condition after splitting
the parameter on '='. The "partition" method will return "" for
the separator field, if the seperator was not present, so that
is the correct thing to check for malformed syntax.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-Id: <20170302122429.7737-1-berrange@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qmp/qmp-shell | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index 0373b24..eccb88a 100755
--- a/scripts/qmp/qmp-shell
+++ b/scripts/qmp/qmp-shell
@@ -166,8 +166,8 @@ class QMPShell(qmp.QEMUMonitorProtocol):
 
     def __cli_expr(self, tokens, parent):
         for arg in tokens:
-            (key, _, val) = arg.partition('=')
-            if not val:
+            (key, sep, val) = arg.partition('=')
+            if sep != '=':
                 raise QMPShellError("Expected a key=value pair, got '%s'" % arg)
 
             value = self.__parse_value(val)
-- 
2.7.4
