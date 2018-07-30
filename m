Received: from eggs.gnu.org ([2001:4830:134:3::10]:39368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fk3cJ-0003Ow-Qs
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 04:33:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fk3cG-0004VV-FV
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 04:33:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42322 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fk3cG-0004VA-B2
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 04:33:20 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 30 Jul 2018 10:32:57 +0200
Message-Id: <20180730083317.11765-4-armbru@redhat.com>
In-Reply-To: <20180730083317.11765-1-armbru@redhat.com>
References: <20180730083317.11765-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 03/23] libqtest: Clean up how we read
 device_del messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, f4bug@amsat.org, eblake@redhat.com

qtest_qmp_device_del() still uses the qmp("") hack to receive a
message, even though we have qmp_receive() since commit 66e0c7b187e.
Put it to use.

Bonus: gets rid of empty format strings.  A step towards compile-time
format string checking without triggering -Wformat-zero-length.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
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
