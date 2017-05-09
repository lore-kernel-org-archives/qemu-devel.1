Received: from eggs.gnu.org ([2001:4830:134:3::10]:44261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d80Af-00089h-IH
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:07:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d80AX-0007as-8D
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:07:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d80AX-0007aC-2X
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:06:53 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 22D9D80C0A
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 08:06:52 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  9 May 2017 10:06:43 +0200
Message-Id: <1494317205-2211-27-git-send-email-armbru@redhat.com>
In-Reply-To: <1494317205-2211-1-git-send-email-armbru@redhat.com>
References: <1494317205-2211-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v3 26/28] qmp-shell: Cope with query-commands
 error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qemu-ga doesn't implement it.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20170504125432.21653-3-marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[Commit message tweaked]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qmp/qmp-shell | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index b4d2dbd..1182f82 100755
--- a/scripts/qmp/qmp-shell
+++ b/scripts/qmp/qmp-shell
@@ -131,7 +131,10 @@ class QMPShell(qmp.QEMUMonitorProtocol):
         return arg
=20
     def _fill_completion(self):
-        for cmd in self.cmd('query-commands')['return']:
+        cmds =3D self.cmd('query-commands')
+        if cmds.has_key('error'):
+            return
+        for cmd in cmds['return']:
             self._completer.append(cmd['name'])
=20
     def __completer_setup(self):
--=20
2.7.4
