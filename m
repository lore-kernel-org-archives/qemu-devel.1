Received: from eggs.gnu.org ([2001:4830:134:3::10]:56287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d6Ic0-000229-Dh
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:24:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d6Iby-0008HD-M2
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:24:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d6Iby-0008Fr-Dr
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:24:10 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6D4D9C059754
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 15:24:09 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu,  4 May 2017 17:23:47 +0200
Message-Id: <1493911445-19568-11-git-send-email-armbru@redhat.com>
In-Reply-To: <1493911445-19568-1-git-send-email-armbru@redhat.com>
References: <1493911445-19568-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/28] QemuOpts: Simplify qemu_opts_to_qdict()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

Noticed while investigating Coccinelle cleanups. There is no need
for a temporary variable when we can use the new macro to do the
same thing with less typing.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20170427215821.19397-9-eblake@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 util/qemu-option.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/util/qemu-option.c b/util/qemu-option.c
index a36cafa..5977bfc 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -1054,7 +1054,6 @@ void qemu_opts_absorb_qdict(QemuOpts *opts, QDict *=
qdict, Error **errp)
 QDict *qemu_opts_to_qdict(QemuOpts *opts, QDict *qdict)
 {
     QemuOpt *opt;
-    QObject *val;
=20
     if (!qdict) {
         qdict =3D qdict_new();
@@ -1063,8 +1062,7 @@ QDict *qemu_opts_to_qdict(QemuOpts *opts, QDict *qd=
ict)
         qdict_put_str(qdict, "id", opts->id);
     }
     QTAILQ_FOREACH(opt, &opts->head, next) {
-        val =3D QOBJECT(qstring_from_str(opt->str));
-        qdict_put_obj(qdict, opt->name, val);
+        qdict_put_str(qdict, opt->name, opt->str);
     }
     return qdict;
 }
--=20
2.7.4
