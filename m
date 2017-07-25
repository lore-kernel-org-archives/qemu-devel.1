Received: from eggs.gnu.org ([2001:4830:134:3::10]:44507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dZzyr-00046Y-6W
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:34:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dZzyq-0004PU-Cl
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:34:33 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:38297)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dZzyq-0004Ol-6E
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:34:32 -0400
Received: by mail-wm0-x22f.google.com with SMTP id m85so42437050wma.1
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 06:34:32 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 25 Jul 2017 14:34:23 +0100
Message-Id: <20170725133425.436-5-alex.bennee@linaro.org>
In-Reply-To: <20170725133425.436-1-alex.bennee@linaro.org>
References: <20170725133425.436-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.10 v2 4/6] docker: docker.py make
 --no-cache skip checksum test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

If you invoke with NOCACHE=1 we pass --no-cache in the argv to
docker.py but may still not force a rebuild if the dockerfile checksum
hasn't changed. By testing for its presence we can force builds
without having to manually remove the docker image.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/docker.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index ee40ca04d9..aab1648cc5 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -261,7 +261,8 @@ class BuildCommand(SubCommand):
         tag = args.tag
 
         dkr = Docker()
-        if dkr.image_matches_dockerfile(tag, dockerfile):
+        if "--no-cache" not in argv and \
+           dkr.image_matches_dockerfile(tag, dockerfile):
             if not args.quiet:
                 print "Image is up to date."
         else:
-- 
2.13.0
