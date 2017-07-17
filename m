Received: from eggs.gnu.org ([2001:4830:134:3::10]:36818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dX7KT-0005ru-5s
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:48:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dX7KS-00024p-A2
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:48:57 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:35557)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dX7KS-00024E-3J
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:48:56 -0400
Received: by mail-wm0-x22b.google.com with SMTP id w126so78416068wme.0
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 07:48:55 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 17 Jul 2017 15:48:26 +0100
Message-Id: <20170717144848.11793-2-alex.bennee@linaro.org>
In-Reply-To: <20170717144848.11793-1-alex.bennee@linaro.org>
References: <20170717144848.11793-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 01/23] docker: allow customizing Travis
 global_env variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Paolo Bonzini <pbonzini@redhat.com>

This is useful so that we can do builds at higher than -j3 when running
travis.py locally.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/travis.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

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
