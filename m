Received: from eggs.gnu.org ([2001:4830:134:3::10]:52240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d5Z01-0003lg-Sc
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:41:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d5Yzx-00063k-SP
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:41:57 -0400
Received: from 5.mo5.mail-out.ovh.net ([87.98.173.103]:60223)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1d5Yzx-00062f-LB
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:41:53 -0400
Received: from player786.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 03E49E9BE7
	for <qemu-devel@nongnu.org>; Tue,  2 May 2017 16:41:51 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Tue, 02 May 2017 16:41:43 +0200
Message-ID: <149373610338.5144.9635049015143453288.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] scripts/qmp/qom-set: fix the value argument
 passed to srv.command()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

When invoking the script with -s, we end up passing a bogus value
to QEMU:

$ ./scripts/qmp/qom-set -s /var/tmp/qmp-sock-exp /machine.accel kvm
{}
$ ./scripts/qmp/qom-get -s /var/tmp/qmp-sock-exp /machine.accel
/var/tmp/qmp-sock-exp

This happens because sys.argv[2] isn't necessarily the command line
argument that holds the value. It is sys.argv[4] when -s was also
passed.

Actually, the code already has a variable to handle that. This patch
simply uses it.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 scripts/qmp/qom-set |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qmp/qom-set b/scripts/qmp/qom-set
index 54ecfecc531e..94e27789224c 100755
--- a/scripts/qmp/qom-set
+++ b/scripts/qmp/qom-set
@@ -61,4 +61,4 @@ else:
 srv = QEMUMonitorProtocol(socket_path)
 srv.connect()
 
-print srv.command('qom-set', path=path, property=prop, value=sys.argv[2])
+print srv.command('qom-set', path=path, property=prop, value=value)
