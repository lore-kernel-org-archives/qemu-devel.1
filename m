Received: from eggs.gnu.org ([2001:4830:134:3::10]:54335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVt8P-0005ef-0s
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:31:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVt8N-0003im-Eh
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:31:57 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:33816)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fVt8N-0003i1-8Q
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:31:55 -0400
Received: by mail-wm0-x231.google.com with SMTP id l15-v6so1887232wmc.1
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 23:31:55 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 21 Jun 2018 07:26:03 +0100
Message-Id: <20180621062605.941-56-alex.bennee@linaro.org>
In-Reply-To: <20180621062605.941-1-alex.bennee@linaro.org>
References: <20180621062605.941-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 55/57] docker: docker.py adding age check
 command
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

This is useful for querying if an image is too old.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index e4f37820e0..b279836154 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -32,6 +32,7 @@ except ImportError:
     from io import StringIO
 from shutil import copy, rmtree
 from pwd import getpwuid
+from datetime import datetime,timedelta
 
 
 FILTERED_ENV_NAMES = ['ftp_proxy', 'http_proxy', 'https_proxy']
@@ -190,6 +191,9 @@ class Docker(object):
         except subprocess.CalledProcessError:
             return None
 
+    def get_image_creation_time(self, info):
+        return json.loads(info)[0]["Created"]
+
     def get_image_dockerfile_checksum(self, tag):
         resp = self.inspect_tag(tag)
         labels = json.loads(resp)[0]["Config"].get("Labels", {})
@@ -461,11 +465,14 @@ class CheckCommand(SubCommand):
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
 
         dkr = Docker()
@@ -474,13 +481,32 @@ class CheckCommand(SubCommand):
             print("Image does not exist")
             return 1
 
-        if dkr.image_matches_dockerfile(tag, dockerfile):
-            if not args.quiet:
-                print("Image is up to date")
-            return 0
-        else:
-            print("Image needs updating")
-            return 1
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
+            timestr = dkr.get_image_creation_time(info).split(".")[0]
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
