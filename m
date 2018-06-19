Received: from eggs.gnu.org ([2001:4830:134:3::10]:35066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVIoF-0006W2-PL
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:44:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVIoE-0006NC-HL
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:44:43 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:45068)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fVIoE-0006Le-Ap
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:44:42 -0400
Received: by mail-wr0-x243.google.com with SMTP id o12-v6so124198wrm.12
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 08:44:42 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 19 Jun 2018 16:43:45 +0100
Message-Id: <20180619154435.18898-7-alex.bennee@linaro.org>
In-Reply-To: <20180619154435.18898-1-alex.bennee@linaro.org>
References: <20180619154435.18898-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 06/56] docker: extend "cc" command to accept
 compiler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

When calling our cross-compilation images we want to call something
other than the default cc.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Fam Zheng <famz@redhat.com>
---
v2
  - use arg.cc default to simplify logic

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
