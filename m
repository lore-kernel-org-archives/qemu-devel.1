Received: from eggs.gnu.org ([2001:4830:134:3::10]:38682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fXzz5-00070O-0X
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 22:15:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fXzz4-0002J9-4B
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 22:15:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fXzz3-0002IA-Uf
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 22:15:02 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 26 Jun 2018 23:14:21 -0300
Message-Id: <20180627021423.18404-5-ehabkost@redhat.com>
In-Reply-To: <20180627021423.18404-1-ehabkost@redhat.com>
References: <20180627021423.18404-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 4/6] docker: Use os.environ.items() instead of
 .iteritems()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Cleber Rosa <crosa@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Mapping.iteritems() doesn't exist in Python 3.

Note that Mapping.items() exists in both Python 3 and Python 2,
but it returns a list (and not an iterator) in Python 2.  The
existing code will work on both cases, though.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/docker/docker.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index db6b463b92..bc34bd872b 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -355,7 +355,7 @@ class BuildCommand(SubCommand):
                 cksum += [(filename, _file_checksum(filename))]
 
             argv += ["--build-arg=" + k.lower() + "=" + v
-                        for k, v in os.environ.iteritems()
+                        for k, v in os.environ.items()
                         if k.lower() in FILTERED_ENV_NAMES]
             dkr.build_image(tag, docker_dir, dockerfile,
                             quiet=args.quiet, user=args.user, argv=argv,
-- 
2.18.0.rc1.1.g3f1ff2140
