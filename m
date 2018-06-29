Received: from eggs.gnu.org ([2001:4830:134:3::10]:56321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fZ0Nw-0008Du-8M
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:52:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fZ0Nv-0006f1-Dw
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:52:52 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:32874)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fZ0Nv-0006ci-3B
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:52:51 -0400
Received: by mail-wm0-x229.google.com with SMTP id z6-v6so2894382wma.0
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 13:52:50 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 29 Jun 2018 21:52:27 +0100
Message-Id: <20180629205232.27190-17-alex.bennee@linaro.org>
In-Reply-To: <20180629205232.27190-1-alex.bennee@linaro.org>
References: <20180629205232.27190-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 16/21] docker: add env parser to docker.py
 build step
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

We need to pass environment variables down to the debbootstrap.pre
script to be able to specify build parameters.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/docker.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index b279836154..388e86ada2 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -293,6 +293,8 @@ class BuildCommand(SubCommand):
         parser.add_argument("--add-current-user", "-u", dest="user",
                             action="store_true",
                             help="Add the current user to image's passwd")
+        parser.add_argument("--env", "-E", action='append', nargs=1,
+                            help="Set FOO=BAR in envronment")
         parser.add_argument("tag",
                             help="Image Tag")
         parser.add_argument("dockerfile",
@@ -302,6 +304,12 @@ class BuildCommand(SubCommand):
         dockerfile = open(args.dockerfile, "rb").read()
         tag = args.tag
 
+        # Process env setting
+        if args.env:
+            for e in args.env:
+                (env, val) = e[0].split("=")
+                os.environ[env] = val
+
         dkr = Docker()
         if "--no-cache" not in argv and \
            dkr.image_matches_dockerfile(tag, dockerfile):
-- 
2.17.1
