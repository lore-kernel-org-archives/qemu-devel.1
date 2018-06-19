Received: from eggs.gnu.org ([2001:4830:134:3::10]:38959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVIvO-0004CK-1f
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:52:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVIvE-0001nN-S8
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:52:05 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:39235)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fVIvE-0001ly-9E
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:51:56 -0400
Received: by mail-wr0-x230.google.com with SMTP id w7-v6so170761wrn.6
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 08:51:56 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 19 Jun 2018 16:44:31 +0100
Message-Id: <20180619154435.18898-53-alex.bennee@linaro.org>
In-Reply-To: <20180619154435.18898-1-alex.bennee@linaro.org>
References: <20180619154435.18898-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 52/56] docker: docker.py add check sub-command
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

This command allows you to check if we need to re-build a docker
image. If the image isn't in the repository or the checksums don't
match then we return false and some text (for processing in
makefiles).

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
  - fix prints to be "modern"
  - PEP8 fixes
  - split inspect into function

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 0a0155c941..770b22424b 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -181,8 +181,14 @@ class Docker(object):
                                        stderr=subprocess.STDOUT,
                                        **kwargs)
 
+    def inspect_tag(self, tag):
+        try:
+            return self._output(["inspect", tag])
+        except subprocess.CalledProcessError:
+            return None
+
     def get_image_dockerfile_checksum(self, tag):
-        resp = self._output(["inspect", tag])
+        resp = self.inspect_tag(tag)
         labels = json.loads(resp)[0]["Config"].get("Labels", {})
         return labels.get("com.qemu.dockerfile-checksum", "")
 
@@ -444,6 +450,36 @@ class CcCommand(SubCommand):
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
+        info = dkr.inspect_tag(tag)
+        if info is None:
+            print("Image does not exist")
+            return 1
+
+        if dkr.image_matches_dockerfile(tag, dockerfile):
+            if not args.quiet:
+                print("Image is up to date")
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
