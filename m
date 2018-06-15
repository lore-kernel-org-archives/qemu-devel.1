Received: from eggs.gnu.org ([2001:4830:134:3::10]:52288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTugj-0002Ur-LK
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:47:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTugi-0005HW-G6
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:47:13 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:38765)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fTugi-0005G9-93
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:47:12 -0400
Received: by mail-wr0-x242.google.com with SMTP id e18-v6so10983222wrs.5
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 12:47:12 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 15 Jun 2018 20:46:17 +0100
Message-Id: <20180615194705.28019-7-alex.bennee@linaro.org>
In-Reply-To: <20180615194705.28019-1-alex.bennee@linaro.org>
References: <20180615194705.28019-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 06/54] docker: extend "cc" command to accept
 compiler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

When calling our cross-compilation images we want to call something
other than the default cc.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Fam Zheng <famz@redhat.com>
---
v2
  - use arg.cc default to simplify logic
---
 tests/docker/docker.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 4cd6f9b8ec..663dfcba4b 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -416,6 +416,8 @@ class CcCommand(SubCommand):
     def args(self, parser):
         parser.add_argument("--image", "-i", required=True,
                             help="The docker image in which to run cc")
+        parser.add_argument("--cc", default="cc",
+                            help="The compiler executable to call")
         parser.add_argument("--source-path", "-s", nargs="*", dest="paths",
                             help="""Extra paths to (ro) mount into container for
                             reading sources""")
@@ -429,7 +431,7 @@ class CcCommand(SubCommand):
         if args.paths:
             for p in args.paths:
                 cmd += ["-v", "%s:%s:ro,z" % (p, p)]
-        cmd += [args.image, "cc"]
+        cmd += [args.image, args.cc]
         cmd += argv
         return Docker().command("run", cmd, args.quiet)
 
-- 
2.17.1
