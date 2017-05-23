Received: from eggs.gnu.org ([2001:4830:134:3::10]:38737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dD8xZ-0005kt-53
	for qemu-devel@nongnu.org; Tue, 23 May 2017 08:30:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dD8xV-00012v-Rb
	for qemu-devel@nongnu.org; Tue, 23 May 2017 08:30:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dD8xV-00012D-Kq
	for qemu-devel@nongnu.org; Tue, 23 May 2017 08:30:41 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 23 May 2017 14:30:30 +0200
Message-Id: <1495542638-12335-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1495542638-12335-1-git-send-email-armbru@redhat.com>
References: <1495542638-12335-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/9] scripts/qmp/qom-set: fix the value argument
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
Cc: Greg Kurz <groug@kaod.org>

From: Greg Kurz <groug@kaod.org>

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
Message-Id: <149373610338.5144.9635049015143453288.stgit@bahia.lan>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qmp/qom-set | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qmp/qom-set b/scripts/qmp/qom-set
index 54ecfec..94e2778 100755
--- a/scripts/qmp/qom-set
+++ b/scripts/qmp/qom-set
@@ -61,4 +61,4 @@ else:
 srv =3D QEMUMonitorProtocol(socket_path)
 srv.connect()
=20
-print srv.command('qom-set', path=3Dpath, property=3Dprop, value=3Dsys.a=
rgv[2])
+print srv.command('qom-set', path=3Dpath, property=3Dprop, value=3Dvalue=
)
--=20
2.7.4
