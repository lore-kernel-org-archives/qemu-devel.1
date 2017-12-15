Received: from eggs.gnu.org ([2001:4830:134:3::10]:42591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ePrag-0004ie-1b
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 10:08:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ePrab-0001gn-Vr
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 10:07:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:21928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ePrab-0001fN-QP
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 10:07:53 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F063021BA1
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 15:07:52 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 15 Dec 2017 16:06:57 +0100
Message-Id: <20171215150659.1811-12-marcandre.lureau@redhat.com>
In-Reply-To: <20171215150659.1811-1-marcandre.lureau@redhat.com>
References: <20171215150659.1811-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 11/13] tests: fix qmp-test leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>

Direct leak of 913 byte(s) in 43 object(s) allocated from:
    #0 0x55880a15df60 in __interceptor_malloc (/home/elmarco/src/qq/build=
/tests/qmp-test+0x110f60)
    #1 0x7f3f20fd098f in _IO_vasprintf (/lib64/libc.so.6+0x8098f)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 tests/qmp-test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index c5a5c10b41..36feb2204b 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -271,7 +271,7 @@ static void add_query_tests(QmpSchema *schema)
 {
     SchemaInfoList *tail;
     SchemaInfo *si, *arg_type, *ret_type;
-    const char *test_name;
+    char *test_name;
=20
     /* Test the query-like commands */
     for (tail =3D schema->list; tail; tail =3D tail->next) {
@@ -297,6 +297,7 @@ static void add_query_tests(QmpSchema *schema)
=20
         test_name =3D g_strdup_printf("qmp/%s", si->name);
         qtest_add_data_func(test_name, si->name, test_query);
+        g_free(test_name);
     }
 }
=20
--=20
2.15.1.355.g36791d7216
