Received: from eggs.gnu.org ([2001:4830:134:3::10]:41632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYDsq-0000aT-Bn
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:01:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYDsm-0007Z4-Oc
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:01:00 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:35291)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dYDsm-0007YE-Hy
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:00:56 -0400
Received: by mail-wm0-x229.google.com with SMTP id w126so28369393wme.0
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 09:00:56 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 20 Jul 2017 17:00:41 +0100
Message-Id: <20170720160042.20153-2-alex.bennee@linaro.org>
In-Reply-To: <20170720160042.20153-1-alex.bennee@linaro.org>
References: <20170720160042.20153-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH for 2.10 v1 1/2] docker: fix dirty/stash
 detection on some systems
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.bennee@gmail.com
Cc: alex@bennee.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, "open list:-----------------..." <qemu-devel@nongnu.org>

I reported this a while ago but evidently forgot to push the patch
upstream. Without this I wasn't seeing the dirty tree state submitted
to the docker build which is very confusing.

Reference:
  Subject: [PATCH 1/6] tests/docker/Makefile.include: fix diff-index call
  Date: Fri, 28 Oct 2016 17:33:34 +0100
  Message-Id: <20161028163339.31096-2-alex.bennee@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index d7dafdbd27..ff580edfad 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -20,7 +20,7 @@ IMAGES ?= %
 # Make archive from git repo $1 to tar.gz $2
 make-archive-maybe = $(if $(wildcard $1/*), \
 	$(call quiet-command, \
-		(cd $1; if git diff-index --quiet HEAD -- &>/dev/null; then \
+		(cd $1; if git diff-index --quiet HEAD -- 2>/dev/null; then \
 			git archive -1 HEAD --format=tar.gz; \
 		else \
 			git archive -1 $$(git stash create) --format=tar.gz; \
-- 
2.13.0
