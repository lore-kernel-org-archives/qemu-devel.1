Received: from eggs.gnu.org ([209.51.188.92]:34561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hBJ2Y-0005Zf-34
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:01:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hBJ2W-0001P6-Nl
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:01:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hBJ2V-0001NK-Sa
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:01:20 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0D50565419
	for <qemu-devel@nongnu.org>; Tue,  2 Apr 2019 13:01:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CF84164047
	for <qemu-devel@nongnu.org>; Tue,  2 Apr 2019 13:01:13 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  2 Apr 2019 15:01:05 +0200
Message-Id: <20190402130112.15142-2-armbru@redhat.com>
In-Reply-To: <20190402130112.15142-1-armbru@redhat.com>
References: <20190402130112.15142-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/8] vl: Fix error location of positional
 arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

We blame badness in positional arguments on the last option argument:

    $ qemu-system-x86_64 -vnc :1 bad.img
    qemu-system-x86_64: -vnc :1: Could not open 'foo': No such file or di=
rectory

I believe we've done this ever since we reported locations.  Fix it to

    qemu-system-x86_64: bad.img: Could not open 'bad.img': No such file o=
r directory

Reported-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190318183312.4684-1-armbru@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
---
 vl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/vl.c b/vl.c
index d61d5604e5..24572de0bd 100644
--- a/vl.c
+++ b/vl.c
@@ -3119,6 +3119,7 @@ int main(int argc, char **argv, char **envp)
         if (optind >=3D argc)
             break;
         if (argv[optind][0] !=3D '-') {
+            loc_set_cmdline(argv, optind, 1);
             drive_add(IF_DEFAULT, 0, argv[optind++], HD_OPTS);
         } else {
             const QEMUOption *popt;
--=20
2.17.2
