Received: from eggs.gnu.org ([2001:4830:134:3::10]:46589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f5z72-00007z-Cm
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 15:39:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f5z71-0006JT-I3
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 15:39:28 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:41727)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f5z71-0006Ip-C3
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 15:39:27 -0400
Received: by mail-wr0-x243.google.com with SMTP id s12so13927716wrc.8
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 12:39:27 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 10 Apr 2018 20:39:01 +0100
Message-Id: <20180410193919.28026-7-alex.bennee@linaro.org>
In-Reply-To: <20180410193919.28026-1-alex.bennee@linaro.org>
References: <20180410193919.28026-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 06/24] docker: extend "cc" command to accept
 compiler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, famz@redhat.com, cota@braap.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

When calling our cross-compilation images we want to call something
other than the default cc.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/docker.py | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 8733266153..9444f4bea4 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -397,6 +397,8 @@ class CcCommand(SubCommand):
     def args(self, parser):
         parser.add_argument("--image", "-i", required=True,
                             help="The docker image in which to run cc")
+        parser.add_argument("--cc",
+                            help="The compiler executable to call")
         parser.add_argument("--source-path", "-s", nargs="*", dest="paths",
                             help="""Extra paths to (ro) mount into container for
                             reading sources""")
@@ -407,9 +409,19 @@ class CcCommand(SubCommand):
         cwd = os.getcwd()
         cmd = ["--rm", "-w", cwd,
                "-v", "%s:%s:rw" % (cwd, cwd)]
-        for p in args.paths:
-           cmd += ["-v", "%s:%s:ro,z" % (p, p)]
-        cmd += [args.image, "cc"]
+
+        if args.paths:
+            for p in args.paths:
+                cmd += ["-v", "%s:%s:ro,z" % (p, p)]
+
+        cmd += [args.image]
+
+        # The compile command we are running
+        if args.cc:
+            cmd += [args.cc]
+        else:
+            cmd += ["cc"]
+
         cmd += argv
         return Docker().command("run", cmd, True)
 
-- 
2.16.2
