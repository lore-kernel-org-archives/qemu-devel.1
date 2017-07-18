Received: from eggs.gnu.org ([2001:4830:134:3::10]:46499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dXQ0I-0007Q9-NY
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:45:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dXQ0F-00035K-Mu
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:45:22 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:33693)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dXQ0F-00034Y-Ga
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:45:19 -0400
Received: by mail-wr0-x230.google.com with SMTP id a10so23430529wrd.0
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 03:45:17 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 18 Jul 2017 11:44:42 +0100
Message-Id: <20170718104513.23947-2-alex.bennee@linaro.org>
In-Reply-To: <20170718104513.23947-1-alex.bennee@linaro.org>
References: <20170718104513.23947-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/32] docker: allow customizing Travis
 global_env variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, "open list:-----------------..." <qemu-devel@nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

This is useful so that we can do builds at higher than -j3 when running
travis.py locally.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/docker/travis.py b/tests/docker/travis.py
index 8dcc964da4..703a7fde85 100755
--- a/tests/docker/travis.py
+++ b/tests/docker/travis.py
@@ -21,13 +21,12 @@ def load_yaml(fname):
 def conf_iter(conf):
     def env_to_list(env):
         return env if isinstance(env, list) else [env]
-    global_env = conf["env"]["global"]
     for entry in conf["matrix"]["include"]:
-        yield {"env": global_env + env_to_list(entry["env"]),
+        yield {"env": env_to_list(entry["env"]),
                "compiler": entry["compiler"]}
     for entry in itertools.product(conf["compiler"],
                                    conf["env"]["matrix"]):
-        yield {"env": global_env + env_to_list(entry[1]),
+        yield {"env": env_to_list(entry[1]),
                "compiler": entry[0]}
 
 def main():
@@ -35,6 +34,7 @@ def main():
         sys.stderr.write("Usage: %s <travis-file>\n" % sys.argv[0])
         return 1
     conf = load_yaml(sys.argv[1])
+    print "\n".join((": ${%s}" % var for var in conf["env"]["global"]))
     for config in conf_iter(conf):
         print "("
         print "\n".join(config["env"])
-- 
2.13.0
