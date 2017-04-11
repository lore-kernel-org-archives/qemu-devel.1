Received: from eggs.gnu.org ([2001:4830:134:3::10]:48565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cy0so-0002zR-8U
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 14:51:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cy0sn-0004ne-IE
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 14:51:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cy0sn-0004nG-CC
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 14:51:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 54122C05972D
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 18:51:16 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Tue, 11 Apr 2017 13:50:32 -0500
Message-Id: <20170411185034.13460-12-eblake@redhat.com>
In-Reply-To: <20170411185034.13460-1-eblake@redhat.com>
References: <20170411185034.13460-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 11/13] QemuOpts: Simplify
 qemu_opts_to_qdict()
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

Noticed while investigating Coccinelle cleanups. There is no need
for a temporary variable when we can use the new macro to do the
same thing with less typing.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 util/qemu-option.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/util/qemu-option.c b/util/qemu-option.c
index a36cafa..5977bfc 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -1054,7 +1054,6 @@ void qemu_opts_absorb_qdict(QemuOpts *opts, QDict *qdict, Error **errp)
 QDict *qemu_opts_to_qdict(QemuOpts *opts, QDict *qdict)
 {
     QemuOpt *opt;
-    QObject *val;

     if (!qdict) {
         qdict = qdict_new();
@@ -1063,8 +1062,7 @@ QDict *qemu_opts_to_qdict(QemuOpts *opts, QDict *qdict)
         qdict_put_str(qdict, "id", opts->id);
     }
     QTAILQ_FOREACH(opt, &opts->head, next) {
-        val = QOBJECT(qstring_from_str(opt->str));
-        qdict_put_obj(qdict, opt->name, val);
+        qdict_put_str(qdict, opt->name, opt->str);
     }
     return qdict;
 }
-- 
2.9.3
