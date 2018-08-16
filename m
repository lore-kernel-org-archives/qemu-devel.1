Received: from eggs.gnu.org ([2001:4830:134:3::10]:50515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqDmT-0000qa-3D
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:37:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqDmH-0005Bq-PG
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:37:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53660 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fqDmB-00058r-To
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:37:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4748C406E81C
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 08:37:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-56.ams2.redhat.com
	[10.36.116.56])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1EDEE2166BA0
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 08:37:03 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 16 Aug 2018 10:36:38 +0200
Message-Id: <20180816083701.3932-3-armbru@redhat.com>
In-Reply-To: <20180816083701.3932-1-armbru@redhat.com>
References: <20180816083701.3932-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/25] libqtest: Clean up how we read device_del
 messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

qtest_qmp_device_del() still uses the qmp("") hack to receive a
message, even though we have qmp_receive() since commit 66e0c7b187e.
Put it to use.

Bonus: gets rid of empty format strings.  A step towards compile-time
format string checking without triggering -Wformat-zero-length.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180806065344.7103-3-armbru@redhat.com>
---
 tests/libqtest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 9cb4096639..071d7eb7b1 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -1090,7 +1090,7 @@ void qtest_qmp_device_del(const char *id)
     g_assert(response1);
     g_assert(!qdict_haskey(response1, "error"));
=20
-    response2 =3D qmp("");
+    response2 =3D qmp_receive();
     g_assert(response2);
     g_assert(!qdict_haskey(response2, "error"));
=20
--=20
2.17.1
