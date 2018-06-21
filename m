Received: from eggs.gnu.org ([2001:4830:134:3::10]:54526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVt8Y-0005mU-6y
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:32:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVt8X-0003uQ-BH
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:32:06 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:42773)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fVt8X-0003ti-3u
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:32:05 -0400
Received: by mail-wr0-x242.google.com with SMTP id w10-v6so1826597wrk.9
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 23:32:04 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 21 Jun 2018 07:26:04 +0100
Message-Id: <20180621062605.941-57-alex.bennee@linaro.org>
In-Reply-To: <20180621062605.941-1-alex.bennee@linaro.org>
References: <20180621062605.941-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 56/57] tests/docker/Makefile.include: only
 force SID to NOCACHE if old
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

Now we can check the age of a docker image we can be a little more
intelligent about re-building Sid images and only force NOCACHE if
it is "old".

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index c0f09505bb..91d9665517 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -75,8 +75,14 @@ docker-image-debian-win64-cross: docker-image-debian8-mxe
 # force a re-build of the base image if we ever need to build one of
 # its children.
 ifndef SKIP_DOCKER_BUILD
+ifeq ($(HAVE_USER_DOCKER),y)
+SID_AGE=$(shell $(DOCKER_SCRIPT) check --checktype=age --olderthan=180 --quiet qemu:debian-sid)
+ifeq ($(SID_AGE),)
+else
 docker-image-debian-sid: NOCACHE=1
 endif
+endif
+endif
 
 docker-image-debian-alpha-cross: docker-image-debian-sid
 docker-image-debian-hppa-cross: docker-image-debian-sid
-- 
2.17.1
