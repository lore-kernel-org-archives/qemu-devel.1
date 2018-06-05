Received: from eggs.gnu.org ([2001:4830:134:3::10]:53171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fQEVH-0000vI-KE
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:08:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fQESv-0004Jz-1E
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:08:11 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:36039)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fQESu-0004JE-Lb
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:05:44 -0400
Received: by mail-wm0-x236.google.com with SMTP id v131-v6so6185897wma.1
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 09:05:44 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  5 Jun 2018 17:05:36 +0100
Message-Id: <20180605160541.10664-2-alex.bennee@linaro.org>
In-Reply-To: <20180605160541.10664-1-alex.bennee@linaro.org>
References: <20180605160541.10664-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 1/6] docker: add "probe" command for configure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, berrange@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

This is a helper function for the configure script. It replies yes,
sudo or no to inform the user if non-interactive docker support is
available. We trap the Exception to fail gracefully.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Fam Zheng <famz@redhat.com>

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 1246ba9578..f8267586eb 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -390,6 +390,24 @@ class ImagesCommand(SubCommand):
     def run(self, args, argv):
         return Docker().command("images", argv, args.quiet)
 
+
+class ProbeCommand(SubCommand):
+    """Probe if we can run docker automatically"""
+    name = "probe"
+
+    def run(self, args, argv):
+        try:
+            docker = Docker()
+            if docker._command[0] == "docker":
+                print "yes"
+            elif docker._command[0] == "sudo":
+                print "sudo"
+        except Exception:
+            print "no"
+
+        return
+
+
 def main():
     parser = argparse.ArgumentParser(description="A Docker helper",
             usage="%s <subcommand> ..." % os.path.basename(sys.argv[0]))
-- 
2.17.0
