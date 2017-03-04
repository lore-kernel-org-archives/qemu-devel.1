Received: from eggs.gnu.org ([2001:4830:134:3::10]:33292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ckF6m-0004GP-Lg
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 14:12:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ckF6h-0004Ys-IV
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 14:12:48 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:33509)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ckF6h-0004Yg-Ec
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 14:12:43 -0500
Received: by mail-qk0-x244.google.com with SMTP id j127so16997570qke.0
	for <qemu-devel@nongnu.org>; Sat, 04 Mar 2017 11:12:43 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat,  4 Mar 2017 16:12:30 -0300
Message-Id: <20170304191230.11296-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] tests/docker: support proxy / corporate
 firewall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

if FTP_PROXY/HTTP_PROXY/HTTPS_PROXY standard environment variables available,
pass them to the docker daemon to build images.
this is required when building behind corporate proxy/firewall, but also help
when using local cache server (ie: apt/yum).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/docker.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 9fd32ab5fa..02bf9363e1 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -22,12 +22,16 @@ import argparse
 import tempfile
 import re
 import signal
+import string
 from tarfile import TarFile, TarInfo
 from StringIO import StringIO
 from shutil import copy, rmtree
 from pwd import getpwuid
 
 
+FILTERED_ENV_NAMES = ['FTP_PROXY', 'HTTP_PROXY', 'HTTPS_PROXY']
+
+
 DEVNULL = open(os.devnull, 'wb')
 
 
@@ -272,6 +276,12 @@ class BuildCommand(SubCommand):
                 _copy_binary_with_libs(args.include_executable,
                                        docker_dir)
 
+            filtered_keys = map(string.upper, FILTERED_ENV_NAMES)
+            filtered_keys += map(string.lower, FILTERED_ENV_NAMES)
+            for filtered_key in filtered_keys:
+                if filtered_key in os.environ.keys():
+                    argv += ["--build-arg=" + filtered_key +
+                                "=" + os.environ[filtered_key]]
             dkr.build_image(tag, docker_dir, dockerfile,
                             quiet=args.quiet, user=args.user, argv=argv)
 
-- 
2.11.0
