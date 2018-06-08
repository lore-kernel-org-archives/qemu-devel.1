Received: from eggs.gnu.org ([2001:4830:134:3::10]:51387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fRJsV-0008FN-3c
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 12:04:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fRJsS-0002ui-NQ
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 12:04:39 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:43056)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fRJsS-0002sy-Hu
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 12:04:36 -0400
Received: by mail-wr0-x229.google.com with SMTP id d2-v6so13898758wrm.10
	for <qemu-devel@nongnu.org>; Fri, 08 Jun 2018 09:04:36 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  8 Jun 2018 17:04:31 +0100
Message-Id: <20180608160432.8734-3-alex.bennee@linaro.org>
In-Reply-To: <20180608160432.8734-1-alex.bennee@linaro.org>
References: <20180608160432.8734-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 2/3] dcoker: docker.py add check sub-command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, pbonzini@redhat.com, stefanha@redhat.com, stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This command allows you to check if we need to re-build a docker
image. If the image isn't in the repository or the checksums don't
match then we return false and some text (for processing in
makefiles).

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/docker.py | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 80efa641c5..c2763957c9 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -441,6 +441,28 @@ class CcCommand(SubCommand):
         return Docker().command("run", cmd, args.quiet)
 
 
+class CheckCommand(SubCommand):
+    """Check if we need to re-build a docker image out of a dockerfile. Arguments: <tag> <dockerfile>"""
+    name = "check"
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
+                print "Image is up to date."
+            return 0
+        else:
+            print "Image needs updating"
+            return 1
+
 def main():
     parser = argparse.ArgumentParser(description="A Docker helper",
             usage="%s <subcommand> ..." % os.path.basename(sys.argv[0]))
-- 
2.17.1
