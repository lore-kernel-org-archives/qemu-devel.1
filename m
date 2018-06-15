Received: from eggs.gnu.org ([2001:4830:134:3::10]:60013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTvHU-0007O1-F3
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 16:25:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTvHT-0000Sg-Fs
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 16:25:12 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:41460)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fTvHT-0000Qc-8C
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 16:25:11 -0400
Received: by mail-wr0-x22b.google.com with SMTP id h10-v6so11027808wrq.8
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 13:25:11 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 15 Jun 2018 20:47:03 +0100
Message-Id: <20180615194705.28019-53-alex.bennee@linaro.org>
In-Reply-To: <20180615194705.28019-1-alex.bennee@linaro.org>
References: <20180615194705.28019-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 52/54] docker: docker.py adding age check
 command
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

This is useful for querying if an image is too old.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/docker.py | 49 ++++++++++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 11 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 3666197a16..ad0c47921a 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -29,6 +29,7 @@ from tarfile import TarFile, TarInfo
 from StringIO import StringIO
 from shutil import copy, rmtree
 from pwd import getpwuid
+from datetime import datetime,timedelta
 
 
 FILTERED_ENV_NAMES = ['ftp_proxy', 'http_proxy', 'https_proxy']
@@ -184,6 +185,10 @@ class Docker(object):
         labels = json.loads(resp)[0]["Config"].get("Labels", {})
         return labels.get("com.qemu.dockerfile-checksum", "")
 
+    def get_image_creation_time(self, tag):
+        resp = self._output(["inspect", tag])
+        return json.loads(resp)[0]["Created"]
+
     def build_image(self, tag, docker_dir, dockerfile,
                     quiet=True, user=False, argv=None, extra_files_cksum=[]):
         if argv == None:
@@ -450,21 +455,43 @@ class CheckCommand(SubCommand):
     def args(self, parser):
         parser.add_argument("tag",
                             help="Image Tag")
-        parser.add_argument("dockerfile",
-                            help="Dockerfile name")
+        parser.add_argument("dockerfile", default=None,
+                            help="Dockerfile name", nargs='?')
+        parser.add_argument("--checktype", choices=["checksum", "age"],
+                            default="checksum", help="check type")
+        parser.add_argument("--olderthan", default=60, type=int,
+                            help="number of minutes")
 
     def run(self, args, argv):
-        dockerfile = open(args.dockerfile, "rb").read()
         tag = args.tag
-
         dkr = Docker()
-        if dkr.image_matches_dockerfile(tag, dockerfile):
-            if not args.quiet:
-                print("Image is up to date.")
-            return 0
-        else:
-            print("Image needs updating")
-            return 1
+
+        if args.checktype == "checksum":
+            if not args.dockerfile:
+                print("Need a dockerfile for tag:%s" % (tag))
+                return 1
+
+            dockerfile = open(args.dockerfile, "rb").read()
+
+            if dkr.image_matches_dockerfile(tag, dockerfile):
+                if not args.quiet:
+                    print("Image is up to date")
+                return 0
+            else:
+                print("Image needs updating")
+                return 1
+        elif args.checktype == "age":
+            timestr = dkr.get_image_creation_time(tag).split(".")[0]
+            created = datetime.strptime(timestr, "%Y-%m-%dT%H:%M:%S")
+            past = datetime.now() - timedelta(minutes=args.olderthan)
+            if created < past:
+                print ("Image created @ %s more than %d minutes old" %
+                       (timestr, args.olderthan))
+                return 1
+            else:
+                if not args.quiet:
+                    print ("Image less than %d minutes old" % (args.olderthan))
+                return 0
 
 
 def main():
-- 
2.17.1
