Received: from eggs.gnu.org ([2001:4830:134:3::10]:47407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1emR2f-0005qO-QH
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 16:26:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1emR2c-0000mI-Sq
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 16:26:09 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38160 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1emR2c-0000lX-Ok
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 16:26:06 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E5DCEF8FE8
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 21:26:05 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 15 Feb 2018 22:25:50 +0100
Message-Id: <20180215212552.26997-5-marcandre.lureau@redhat.com>
In-Reply-To: <20180215212552.26997-1-marcandre.lureau@redhat.com>
References: <20180215212552.26997-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/6] vhost-user-test: do not hang if chardev
 creation failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Before the chardev name fix, the following error may happen: "attempt
to add duplicate property 'chr-test' to object (type 'container')",
due to races.

Sadly, error_vprintf() uses g_test_message(), so you have to use
read the cryptic --debug-log to see it. Later, it would make sense to
use g_critical() instead, and catch errors with
g_test_expect_message() (in glib 2.34).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/vhost-user-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 67e5f7f858..efd28411d3 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -513,6 +513,7 @@ static void test_server_create_chr(TestServer *server=
, const gchar *opt)
     chr =3D qemu_chr_new(server->chr_name, chr_path);
     g_free(chr_path);
=20
+    g_assert_nonnull(chr);
     qemu_chr_fe_init(&server->chr, chr, &error_abort);
     qemu_chr_fe_set_handlers(&server->chr, chr_can_read, chr_read,
                              chr_event, NULL, server, NULL, true);
--=20
2.16.1.73.g5832b7e9f2
