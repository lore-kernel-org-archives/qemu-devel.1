Received: from eggs.gnu.org ([2001:4830:134:3::10]:52410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fUtsJ-0005y3-OD
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 09:07:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fUtsG-0002d8-Tx
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 09:07:15 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:35100)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fUtsG-0002cj-OM
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 09:07:12 -0400
Received: by mail-wr0-x229.google.com with SMTP id l10-v6so16790011wrn.2
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 06:07:12 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 18 Jun 2018 14:07:02 +0100
Message-Id: <20180618130709.19730-2-alex.bennee@linaro.org>
In-Reply-To: <20180618130709.19730-1-alex.bennee@linaro.org>
References: <20180618130709.19730-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 1/8] docker: Add "cc" subcommand
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: famz@redhat.com, cota@braap.org, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Signed-off-by: Fam Zheng <famz@redhat.com>
[AJB: add if args.paths check]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v2
  - add if args.paths check to avoid iterating null argument
---
 tests/docker/docker.py | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 306e14cf69..4cd6f9b8ec 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -409,6 +409,31 @@ class ProbeCommand(SubCommand):
         return
 
 
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
+        if args.paths:
+            for p in args.paths:
+                cmd += ["-v", "%s:%s:ro,z" % (p, p)]
+        cmd += [args.image, "cc"]
+        cmd += argv
+        return Docker().command("run", cmd, args.quiet)
+
+
 def main():
     parser = argparse.ArgumentParser(description="A Docker helper",
             usage="%s <subcommand> ..." % os.path.basename(sys.argv[0]))
-- 
2.17.1
