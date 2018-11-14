Received: from eggs.gnu.org ([2001:4830:134:3::10]:40471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gMuvu-0001K9-PU
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:10:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gMuvs-0004I0-KQ
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:10:14 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:52557)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gMuvs-0004H2-Ed
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:10:12 -0500
Received: by mail-wm1-x335.google.com with SMTP id r11-v6so15354988wmb.2
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 05:10:12 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 14 Nov 2018 13:10:08 +0000
Message-Id: <20181114131008.27599-3-alex.bennee@linaro.org>
In-Reply-To: <20181114131008.27599-1-alex.bennee@linaro.org>
References: <20181114131008.27599-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 2/2] tests/tcg/multiarch: fix 32bit linux-test
 on 64bit host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Laurent Vivier <laurent@vivier.eu>

Fix:

  TEST    linux-test on i386
  .../tests/tcg/multiarch/linux-test.c:201: readdir

readdir() calls getdents64() to have the list of the entries in a
directory, and getdents64() can return 64bit d_off values (with ext4,
for instance) that will not fit in the 32bit d_off field of the
readdir() dirent structure.

To avoid that, use readdir64() to use a 64bit d_off field too.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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
2.17.1
