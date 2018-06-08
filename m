Received: from eggs.gnu.org ([2001:4830:134:3::10]:51388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fRJsV-0008FO-4I
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 12:04:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fRJsR-0002sA-4M
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 12:04:39 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:46900)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fRJsQ-0002rb-TZ
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 12:04:35 -0400
Received: by mail-wr0-x242.google.com with SMTP id v13-v6so13912838wrp.13
	for <qemu-devel@nongnu.org>; Fri, 08 Jun 2018 09:04:34 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  8 Jun 2018 17:04:30 +0100
Message-Id: <20180608160432.8734-2-alex.bennee@linaro.org>
In-Reply-To: <20180608160432.8734-1-alex.bennee@linaro.org>
References: <20180608160432.8734-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 1/3] docker: docker.py don't conflate
 checksums for extra_files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, pbonzini@redhat.com, stefanha@redhat.com, stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This just gets confusing especially as the helper function doesn't
even take into account any extra files (or the executable). Currently
the actual check just ignores them and also passes the result through
_dockerfile_preprocess so we fix that too.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/docker.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 37bfa98005..80efa641c5 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -200,8 +200,10 @@ class Docker(object):
 
         tmp_df.write("\n")
         tmp_df.write("LABEL com.qemu.dockerfile-checksum=%s" %
-                     _text_checksum("\n".join([dockerfile] +
-                                    extra_files_cksum)))
+                     _text_checksum(_dockerfile_preprocess(dockerfile)))
+        for f, c in extra_files_cksum:
+            tmp_df.write("LABEL com.qemu.%s-checksum=%s" % (f, c))
+
         tmp_df.flush()
 
         self._do_check(["build", "-t", tag, "-f", tmp_df.name] + argv + \
@@ -316,7 +318,7 @@ class BuildCommand(SubCommand):
                 _copy_binary_with_libs(args.include_executable, docker_dir)
             for filename in args.extra_files or []:
                 _copy_with_mkdir(filename, docker_dir)
-                cksum += [_file_checksum(filename)]
+                cksum += [(filename, _file_checksum(filename))]
 
             argv += ["--build-arg=" + k.lower() + "=" + v
                         for k, v in os.environ.iteritems()
-- 
2.17.1
