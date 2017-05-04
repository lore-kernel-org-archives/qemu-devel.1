Received: from eggs.gnu.org ([2001:4830:134:3::10]:56347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d6Ic2-00023r-0t
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:24:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d6Iby-0008HV-NC
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:24:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49528)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d6Iby-0008G3-Ff
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:24:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 80B5A3D971
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 15:24:09 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu,  4 May 2017 17:23:39 +0200
Message-Id: <1493911445-19568-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1493911445-19568-1-git-send-email-armbru@redhat.com>
References: <1493911445-19568-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/28] test-keyval: fix leaks
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

Spotted by ASAN.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20170503223846.6559-2-marcandre.lureau@redhat.com>
Reviewed-by: Eric blake <eblake@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/test-keyval.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/test-keyval.c b/tests/test-keyval.c
index ba19560..c556b1b 100644
--- a/tests/test-keyval.c
+++ b/tests/test-keyval.c
@@ -628,6 +628,7 @@ static void test_keyval_visit_alternate(void)
     visit_type_AltNumStr(v, "a", &ans, &error_abort);
     g_assert_cmpint(ans->type, =3D=3D, QTYPE_QSTRING);
     g_assert_cmpstr(ans->u.s, =3D=3D, "1");
+    qapi_free_AltNumStr(ans);
     visit_type_AltNumInt(v, "a", &ani, &err);
     error_free_or_abort(&err);
     visit_end_struct(v, NULL);
@@ -651,9 +652,12 @@ static void test_keyval_visit_any(void)
     g_assert(qlist);
     qstr =3D qobject_to_qstring(qlist_pop(qlist));
     g_assert_cmpstr(qstring_get_str(qstr), =3D=3D, "null");
+    QDECREF(qstr);
     qstr =3D qobject_to_qstring(qlist_pop(qlist));
     g_assert_cmpstr(qstring_get_str(qstr), =3D=3D, "1");
     g_assert(qlist_empty(qlist));
+    QDECREF(qstr);
+    qobject_decref(any);
     visit_check_struct(v, &error_abort);
     visit_end_struct(v, NULL);
     visit_free(v);
--=20
2.7.4
