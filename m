Received: from eggs.gnu.org ([2001:4830:134:3::10]:54032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fppzh-0000ka-IF
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 03:13:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fppzd-00089K-7S
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 03:13:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41640 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fppzU-00085y-JO
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 03:13:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 425E07A7ED
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 07:13:12 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 15 Aug 2018 09:13:07 +0200
Message-Id: <20180815071308.11777-5-armbru@redhat.com>
In-Reply-To: <20180815071308.11777-1-armbru@redhat.com>
References: <20180815071308.11777-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/5] tests: fix crumple/recursive leak
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

Spotted by ASAN:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D27907=3D=3DERROR: LeakSanitizer: detected memory leaks

Direct leak of 4120 byte(s) in 1 object(s) allocated from:
    #0 0x7f913458ce50 in calloc (/lib64/libasan.so.5+0xeee50)
    #1 0x7f9133fd641d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5241d)
    #2 0x5561c6643c95 in qdict_crumple_test_recursive /home/elmarco/src/q=
q/tests/check-block-qdict.c:438
    #3 0x7f9133ff7c49  (/lib64/libglib-2.0.so.0+0x73c49)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180809114417.28718-2-marcandre.lureau@redhat.com>
[Screwed up in commit 2860b2b2cb8]
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/check-block-qdict.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/check-block-qdict.c b/tests/check-block-qdict.c
index 478807f839..73d3e9f574 100644
--- a/tests/check-block-qdict.c
+++ b/tests/check-block-qdict.c
@@ -491,6 +491,7 @@ static void qdict_crumple_test_recursive(void)
     empty_list_0 =3D qobject_to(QDict, qlist_pop(empty_list));
     g_assert(empty_list_0);
     g_assert_cmpint(qdict_size(empty_list_0), =3D=3D, 0);
+    qobject_unref(empty_list_0);
=20
     qobject_unref(src);
     qobject_unref(dst);
--=20
2.17.1
