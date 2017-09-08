Received: from eggs.gnu.org ([2001:4830:134:3::10]:52493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqFPg-00062S-5S
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:17:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqFPb-0000Ro-DB
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:17:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dqFPb-0000Qm-7i
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:17:19 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  8 Sep 2017 17:16:55 +0800
Message-Id: <20170908091700.14867-3-famz@redhat.com>
In-Reply-To: <20170908091700.14867-1-famz@redhat.com>
References: <20170908091700.14867-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 2/7] docker: Add "cc" subcommand
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, thuth@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, programmingkidx@gmail.com, crosa@redhat.com, pbonzini@redhat.com, rth@twiddle.net

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/docker.py | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 81c87ee329..419ebe665f 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -367,6 +367,29 @@ class ImagesCommand(SubCommand):
     def run(self, args, argv):
         return Docker().command("images", argv, args.quiet)
 
+class CcCommand(SubCommand):
+    """Compile sources with cc in images"""
+    name = "cc"
+
+    def args(self, parser):
+        parser.add_argument("--image", "-i", required=True,
+                            help="The docker image in which to run cc")
+        parser.add_argument("--source-path", "-s", nargs="*", dest="paths",
+                            help="""Extra paths to (ro) mount into container for
+                            reading sources""")
+
+    def run(self, args, argv):
+        if argv and argv[0] == "--":
+            argv = argv[1:]
+        cwd = os.getcwd()
+        cmd = ["--rm", "-w", cwd,
+               "-v", "%s:%s:rw" % (cwd, cwd)]
+        for p in args.paths:
+           cmd += ["-v", "%s:%s:ro,z" % (p, p)]
+        cmd += [args.image, "cc"]
+        cmd += argv
+        return Docker().command("run", cmd, True)
+
 def main():
     parser = argparse.ArgumentParser(description="A Docker helper",
             usage="%s <subcommand> ..." % os.path.basename(sys.argv[0]))
-- 
2.13.5
