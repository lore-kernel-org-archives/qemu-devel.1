Received: from eggs.gnu.org ([2001:4830:134:3::10]:52473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fUtsO-0005yi-9N
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 09:07:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fUtsN-0002gE-Co
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 09:07:20 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:37870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fUtsN-0002fl-4Z
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 09:07:19 -0400
Received: by mail-wr0-x22a.google.com with SMTP id d8-v6so16781852wro.4
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 06:07:19 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 18 Jun 2018 14:07:08 +0100
Message-Id: <20180618130709.19730-8-alex.bennee@linaro.org>
In-Reply-To: <20180618130709.19730-1-alex.bennee@linaro.org>
References: <20180618130709.19730-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 7/8] docker: docker.py add check sub-command
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

This command allows you to check if we need to re-build a docker
image. If the image isn't in the repository or the checksums don't
match then we return false and some text (for processing in
makefiles).

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
  - fix prints to be "modern"
  - PEP8 fixes
  - split inspect into function
---
 tests/docker/docker.py | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 325915a6f9..c157ff826a 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -179,8 +179,14 @@ class Docker(object):
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
 
@@ -442,6 +448,36 @@ class CcCommand(SubCommand):
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
