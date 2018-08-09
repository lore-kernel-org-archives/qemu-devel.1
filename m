Received: from eggs.gnu.org ([2001:4830:134:3::10]:55464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fnjMi-0001ig-ON
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:44:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fnjMh-00066l-Pr
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:44:28 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  9 Aug 2018 13:44:14 +0200
Message-Id: <20180809114417.28718-2-marcandre.lureau@redhat.com>
In-Reply-To: <20180809114417.28718-1-marcandre.lureau@redhat.com>
References: <20180809114417.28718-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/4] tests: fix crumple/recursive leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Hannes Reinecke <hare@suse.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

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
2.18.0.547.g1d89318c48
