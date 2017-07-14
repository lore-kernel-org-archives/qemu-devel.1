Received: from eggs.gnu.org ([2001:4830:134:3::10]:60692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVwzI-0001Hy-Hs
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:34:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVwzG-0005Hk-FV
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:34:16 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:36303)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVwzG-0005HM-8o
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:34:14 -0400
Received: by mail-wr0-x243.google.com with SMTP id 77so11258900wrb.3
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 02:34:14 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 14 Jul 2017 11:34:06 +0200
Message-Id: <20170714093407.11526-2-pbonzini@redhat.com>
In-Reply-To: <20170714093407.11526-1-pbonzini@redhat.com>
References: <20170714093407.11526-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] docker: allow customizing Travis
 global_env variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com

This is useful so that we can do builds at higher than -j3 when running
travis.py locally.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
