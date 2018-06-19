Received: from eggs.gnu.org ([2001:4830:134:3::10]:39171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVIvW-0004JC-LX
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:52:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVIvJ-0001tF-6b
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:52:14 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:50189)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fVIvI-0001s3-S1
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:52:01 -0400
Received: by mail-wm0-x242.google.com with SMTP id e16-v6so1229584wmd.0
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 08:52:00 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 19 Jun 2018 16:44:29 +0100
Message-Id: <20180619154435.18898-51-alex.bennee@linaro.org>
In-Reply-To: <20180619154435.18898-1-alex.bennee@linaro.org>
References: <20180619154435.18898-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 50/56] docker: docker.py use "version" to probe
 usage
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

The "images" command is a fairly heavyweight command to run as it
involves searching the whole docker file-system inventory. On a
machine with a lot of images this makes start-up fairly expensive.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v8
  - use version instead of ps, add comment

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index c83fd89985..e6685f6d81 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -49,7 +49,9 @@ def _guess_docker_command():
     commands = [["docker"], ["sudo", "-n", "docker"]]
     for cmd in commands:
         try:
-            if subprocess.call(cmd + ["images"],
+            # docker version will return the client details in stdout
+            # but still report a status of 1 if it can't contact the daemon
+            if subprocess.call(cmd + ["version"],
                                stdout=DEVNULL, stderr=DEVNULL) == 0:
                 return cmd
         except OSError:
-- 
2.17.1
