Received: from eggs.gnu.org ([209.51.188.92]:39217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gtxG6-00045q-Im
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:19:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gtxG4-0005OY-2M
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:19:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gtxG3-0005MY-OV
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:19:35 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 13 Feb 2019 17:18:57 +0100
Message-Id: <20190213161913.22107-10-marcandre.lureau@redhat.com>
In-Reply-To: <20190213161913.22107-1-marcandre.lureau@redhat.com>
References: <20190213161913.22107-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 09/25] chardev: ensure qemu_chr_parse_compat
 reports missing driver error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

If no valid char driver was identified the qemu_chr_parse_compat method
was silent, leaving callers no clue what failed.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-Id: <20190211182442.8542-8-berrange@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 chardev/char.c    | 2 ++
 tests/test-char.c | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/chardev/char.c b/chardev/char.c
index ccba36bafb..b99f3692f7 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -490,6 +490,8 @@ QemuOpts *qemu_chr_parse_compat(const char *label, co=
nst char *filename,
         return opts;
     }
=20
+    error_report("'%s' is not a valid char driver", filename);
+
 fail:
     qemu_opts_del(opts);
     return NULL;
diff --git a/tests/test-char.c b/tests/test-char.c
index 018e2eed93..45203f5d7a 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -932,9 +932,10 @@ static void char_null_test(void)
 static void char_invalid_test(void)
 {
     Chardev *chr;
-
+    g_setenv("QTEST_SILENT_ERRORS", "1", 1);
     chr =3D qemu_chr_new("label-invalid", "invalid");
     g_assert_null(chr);
+    g_unsetenv("QTEST_SILENT_ERRORS");
 }
=20
 static int chardev_change(void *opaque)
--=20
2.21.0.rc0.1.g036caf7885
