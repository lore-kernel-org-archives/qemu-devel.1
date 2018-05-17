Received: from eggs.gnu.org ([2001:4830:134:3::10]:50784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fJMzt-0006Df-9t
	for qemu-devel@nongnu.org; Thu, 17 May 2018 13:47:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fJMzq-0003QN-8e
	for qemu-devel@nongnu.org; Thu, 17 May 2018 13:47:25 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:37341)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fJMzq-0003Py-1w
	for qemu-devel@nongnu.org; Thu, 17 May 2018 13:47:22 -0400
Received: by mail-wr0-x236.google.com with SMTP id h5-v6so6548886wrm.4
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 10:47:21 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 17 May 2018 18:46:30 +0100
Message-Id: <20180517174718.10107-2-alex.bennee@linaro.org>
In-Reply-To: <20180517174718.10107-1-alex.bennee@linaro.org>
References: <20180517174718.10107-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 01/49] docker: add "probe" command for
 configure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This is a helper function for the configure script. It replies yes,
sudo or no to inform the user if non-interactive docker support is
available. We trap the Exception to fail gracefully.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/docker.py | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

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
