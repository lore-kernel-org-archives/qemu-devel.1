Received: from eggs.gnu.org ([2001:4830:134:3::10]:38277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eX84i-0000VK-CO
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:09:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eX84h-0005OZ-Hq
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:09:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eX84h-0005No-Bq
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:08:59 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9417B6B25B
	for <qemu-devel@nongnu.org>; Thu,  4 Jan 2018 16:08:58 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  4 Jan 2018 17:05:16 +0100
Message-Id: <20180104160523.22995-12-marcandre.lureau@redhat.com>
In-Reply-To: <20180104160523.22995-1-marcandre.lureau@redhat.com>
References: <20180104160523.22995-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 11/18] tests: fix migration-test leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, famz@redhat.com, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Direct leak of 12 byte(s) in 2 object(s) allocated from:
    #0 0x7f50d403c850 in malloc (/lib64/libasan.so.4+0xde850)
    #1 0x7f50d1ddf98f in vasprintf (/lib64/libc.so.6+0x8098f)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 tests/migration-test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index be598d3257..799e24ebc6 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -358,13 +358,14 @@ static void migrate_check_parameter(QTestState *who=
, const char *parameter,
                                     const char *value)
 {
     QDict *rsp, *rsp_return;
-    const char *result;
+    char *result;
=20
     rsp =3D wait_command(who, "{ 'execute': 'query-migrate-parameters' }=
");
     rsp_return =3D qdict_get_qdict(rsp, "return");
     result =3D g_strdup_printf("%" PRId64,
                              qdict_get_try_int(rsp_return,  parameter, -=
1));
     g_assert_cmpstr(result, =3D=3D, value);
+    g_free(result);
     QDECREF(rsp);
 }
=20
--=20
2.15.1.355.g36791d7216
