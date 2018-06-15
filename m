Received: from eggs.gnu.org ([2001:4830:134:3::10]:56298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTuyP-0000iY-HC
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 16:05:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTuyO-0007uf-IW
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 16:05:29 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:44063)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fTuyO-0007uJ-BI
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 16:05:28 -0400
Received: by mail-wr0-x236.google.com with SMTP id x4-v6so10997473wro.11
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 13:05:28 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 15 Jun 2018 20:47:01 +0100
Message-Id: <20180615194705.28019-51-alex.bennee@linaro.org>
In-Reply-To: <20180615194705.28019-1-alex.bennee@linaro.org>
References: <20180615194705.28019-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 50/54] docker: docker.py add check
 sub-command
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

This command allows you to check if we need to re-build a docker
image. If the image isn't in the repository or the checksums don't
match then we return false and some text (for processing in
makefiles).

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
  - fix prints to be "modern"
  - PEP8 fixes
---
 tests/docker/docker.py | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 2593a12d04..3666197a16 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -442,6 +442,31 @@ class CcCommand(SubCommand):
         return Docker().command("run", cmd, args.quiet)
 
 
+class CheckCommand(SubCommand):
+    """Check if we need to re-build a docker image out of a dockerfile.
+    Arguments: <tag> <dockerfile>"""
+    name = "check"
+
+    def args(self, parser):
+        parser.add_argument("tag",
+                            help="Image Tag")
+        parser.add_argument("dockerfile",
+                            help="Dockerfile name")
+
+    def run(self, args, argv):
+        dockerfile = open(args.dockerfile, "rb").read()
+        tag = args.tag
+
+        dkr = Docker()
+        if dkr.image_matches_dockerfile(tag, dockerfile):
+            if not args.quiet:
+                print("Image is up to date.")
+            return 0
+        else:
+            print("Image needs updating")
+            return 1
+
+
 def main():
     parser = argparse.ArgumentParser(description="A Docker helper",
             usage="%s <subcommand> ..." % os.path.basename(sys.argv[0]))
-- 
2.17.1
