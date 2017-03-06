Received: from eggs.gnu.org ([2001:4830:134:3::10]:51610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ckzfM-0008SL-8E
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 15:55:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ckzfI-00046t-7Y
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 15:55:36 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:33610)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ckzfI-00046E-2n
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 15:55:32 -0500
Received: by mail-qk0-x242.google.com with SMTP id j127so29439826qke.0
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 12:55:31 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  6 Mar 2017 17:55:20 -0300
Message-Id: <20170306205520.32311-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3] tests/docker: support proxy / corporate
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

if ftp_proxy/http_proxy/https_proxy standard environment variables available,
pass them to the docker daemon to build images.
this is required when building behind corporate proxy/firewall, but also help
when using local cache server (ie: apt/yum).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---

v3: corrected test example
v2: use Fam Zheng's pythonized one-line,
    renamed env vars to lowercase.

debian builds can be tested using Sameer Naik docker image
(see https://github.com/sameersbn/docker-apt-cacher-ng#quickstart)

$ docker run --name apt-cacher-ng -d --restart=always \
  --publish 3142:3142 \
  --volume /var/cache/apt-cacher-ng:/var/cache/apt-cacher-ng \
  --privileged \
  sameersbn/apt-cacher-ng:latest

$ HTTP_PROXY=http://172.17.0.1:3142 make docker-test-build@debian-armhf-cross
                    ^
                    +-- docker gateway extracted with:
                    
$ docker inspect apt-cacher-ng | jq '[.. | objects | ."Gateway"] | unique'
[
  "172.17.0.1"
]

 tests/docker/docker.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 9fd32ab5fa..8747f6a440 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -28,6 +28,9 @@ from shutil import copy, rmtree
 from pwd import getpwuid
 
 
+FILTERED_ENV_NAMES = ['ftp_proxy', 'http_proxy', 'https_proxy']
+
+
 DEVNULL = open(os.devnull, 'wb')
 
 
@@ -272,6 +275,9 @@ class BuildCommand(SubCommand):
                 _copy_binary_with_libs(args.include_executable,
                                        docker_dir)
 
+            argv += ["--build-arg=" + k.lower() + "=" + v
+                        for k, v in os.environ.iteritems()
+                        if k.lower() in FILTERED_ENV_NAMES]
             dkr.build_image(tag, docker_dir, dockerfile,
                             quiet=args.quiet, user=args.user, argv=argv)
 
-- 
2.11.0
