Received: from eggs.gnu.org ([2001:4830:134:3::10]:35092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVIoG-0006Wq-RF
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:44:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVIoG-0006OE-0E
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:44:44 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:55772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fVIoF-0006Nc-Pu
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:44:43 -0400
Received: by mail-wm0-x229.google.com with SMTP id v16-v6so1146345wmh.5
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 08:44:43 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 19 Jun 2018 16:43:46 +0100
Message-Id: <20180619154435.18898-8-alex.bennee@linaro.org>
In-Reply-To: <20180619154435.18898-1-alex.bennee@linaro.org>
References: <20180619154435.18898-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/56] docker: allow "cc" command to run in user
 context
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 663dfcba4b..c83fd89985 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -418,6 +418,8 @@ class CcCommand(SubCommand):
                             help="The docker image in which to run cc")
         parser.add_argument("--cc", default="cc",
                             help="The compiler executable to call")
+        parser.add_argument("--user",
+                            help="The user-id to run under")
         parser.add_argument("--source-path", "-s", nargs="*", dest="paths",
                             help="""Extra paths to (ro) mount into container for
                             reading sources""")
@@ -431,6 +433,8 @@ class CcCommand(SubCommand):
         if args.paths:
             for p in args.paths:
                 cmd += ["-v", "%s:%s:ro,z" % (p, p)]
+        if args.user:
+            cmd += ["-u", args.user]
         cmd += [args.image, args.cc]
         cmd += argv
         return Docker().command("run", cmd, args.quiet)
-- 
2.17.1
