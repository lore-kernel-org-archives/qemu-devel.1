Received: from eggs.gnu.org ([2001:4830:134:3::10]:50506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dek88-0004eI-J8
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 11:39:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dek83-0006YS-Ol
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 11:39:44 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:38092)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dek83-0006Xs-IX
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 11:39:39 -0400
Received: by mail-wm0-x230.google.com with SMTP id m85so10136285wma.1
	for <qemu-devel@nongnu.org>; Mon, 07 Aug 2017 08:39:39 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon,  7 Aug 2017 16:39:30 +0100
Message-Id: <20170807153934.29477-3-alex.bennee@linaro.org>
In-Reply-To: <20170807153934.29477-1-alex.bennee@linaro.org>
References: <20170807153934.29477-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.10 v3 2/6] docker: fix dirty/stash
 detection on some systems
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

I reported this a while ago but evidently forgot to push the patch
upstream. Without this I wasn't seeing the dirty tree state submitted
to the docker build which is very confusing.

Reference:
  Subject: [PATCH 1/6] tests/docker/Makefile.include: fix diff-index call
  Date: Fri, 28 Oct 2016 17:33:34 +0100
  Message-Id: <20161028163339.31096-2-alex.bennee@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
