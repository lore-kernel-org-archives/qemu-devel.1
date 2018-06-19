Received: from eggs.gnu.org ([2001:4830:134:3::10]:38637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVIvD-00042l-7t
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:52:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVIvA-0001gb-HO
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:51:55 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:32832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fVIv6-0001cr-LJ
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:51:52 -0400
Received: by mail-wr0-x244.google.com with SMTP id k16-v6so193613wro.0
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 08:51:48 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 19 Jun 2018 16:44:30 +0100
Message-Id: <20180619154435.18898-52-alex.bennee@linaro.org>
In-Reply-To: <20180619154435.18898-1-alex.bennee@linaro.org>
References: <20180619154435.18898-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 51/56] docker: docker.py don't conflate
 checksums for extra_files
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

This just gets confusing especially as the helper function doesn't
even take into account any extra files (or the executable). Currently
the actual check just ignores them and also passes the result through
_dockerfile_preprocess so we fix that too.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index e6685f6d81..0a0155c941 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -203,8 +203,10 @@ class Docker(object):
 
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
@@ -319,7 +321,7 @@ class BuildCommand(SubCommand):
                 _copy_binary_with_libs(args.include_executable, docker_dir)
             for filename in args.extra_files or []:
                 _copy_with_mkdir(filename, docker_dir)
-                cksum += [_file_checksum(filename)]
+                cksum += [(filename, _file_checksum(filename))]
 
             argv += ["--build-arg=" + k.lower() + "=" + v
                         for k, v in os.environ.iteritems()
-- 
2.17.1
