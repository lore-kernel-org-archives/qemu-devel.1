Received: from eggs.gnu.org ([2001:4830:134:3::10]:53277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gMcvV-0008WC-25
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 12:56:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gMcvP-0002jq-VI
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 12:56:36 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:33931)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gMcvJ-0002fJ-Kb
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 12:56:27 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 13 Nov 2018 18:54:37 +0100
Message-Id: <20181113175437.26492-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH] tests/tcg/multiarch: fix 32bit linux-test on
 64bit host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Laurent Vivier <laurent@vivier.eu>

Fix:

  TEST    linux-test on i386
  .../tests/tcg/multiarch/linux-test.c:201: readdir

readdir() calls getdents64() to have the list of the entries in a
directory, and getdents64() can return 64bit d_off values (with ext4,
for instance) that will not fit in the 32bit d_off field of the
readdir() dirent structure.

To avoid that, use readdir64() to use a 64bit d_off field too.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 tests/tcg/multiarch/linux-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/multiarch/linux-test.c b/tests/tcg/multiarch/linux-test.c
index e80eccc0ce..fa4243fc04 100644
--- a/tests/tcg/multiarch/linux-test.c
+++ b/tests/tcg/multiarch/linux-test.c
@@ -83,7 +83,7 @@ static void test_file(void)
     struct utimbuf tbuf;
     struct iovec vecs[2];
     DIR *dir;
-    struct dirent *de;
+    struct dirent64 *de;
     /* TODO: make common tempdir creation for tcg tests */
     char template[] = "/tmp/linux-test-XXXXXX";
     char *tmpdir = mkdtemp(template);
@@ -186,7 +186,7 @@ static void test_file(void)
         error("opendir");
     len = 0;
     for(;;) {
-        de = readdir(dir);
+        de = readdir64(dir);
         if (!de)
             break;
         if (strcmp(de->d_name, ".") != 0 &&
-- 
2.17.2
