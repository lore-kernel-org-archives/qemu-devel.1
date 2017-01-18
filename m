Received: from eggs.gnu.org ([2001:4830:134:3::10]:37880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cTsim-0003BQ-Fc
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:04:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cTsii-0007hg-QU
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:04:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cTsii-0007h2-KU
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:04:20 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BD7EC61B86
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 16:04:20 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 18 Jan 2017 20:03:17 +0400
Message-Id: <20170118160332.13390-11-marcandre.lureau@redhat.com>
In-Reply-To: <20170118160332.13390-1-marcandre.lureau@redhat.com>
References: <20170118160332.13390-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 10/25] qmp: check that async command have an
 'id'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, kraxel@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The async support mandates that request have an 'id' (see documentation
in following patch).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi/qmp-dispatch.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index b6b0aed1b8..76c7402ac8 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -109,6 +109,11 @@ static QObject *do_qmp_dispatch(QObject *request, Qm=
pReturn *qret, Error **errp)
         }
         break;
     case QCT_ASYNC:
+        if (!qdict_haskey(qret->rsp, "id")) {
+            error_setg(errp, "An async command requires an 'id'");
+            break;
+        }
+
         cmd->fn_async(args, qret);
         break;
     }
--=20
2.11.0.295.gd7dffce1c
