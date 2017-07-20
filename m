Received: from eggs.gnu.org ([2001:4830:134:3::10]:41610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYDsp-0000Zs-NF
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:01:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYDsn-0007a2-ST
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:00:59 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:36581)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dYDsn-0007ZX-Mq
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:00:57 -0400
Received: by mail-wr0-x230.google.com with SMTP id y43so72597077wrd.3
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 09:00:57 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 20 Jul 2017 17:00:42 +0100
Message-Id: <20170720160042.20153-3-alex.bennee@linaro.org>
In-Reply-To: <20170720160042.20153-1-alex.bennee@linaro.org>
References: <20170720160042.20153-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH for 2.10 v1 2/2] docker: ignore submodules
 when checking diff
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

The QEMU tree often has dirty submodules in it but this will confuse
things as git stash is not going to save their state directly. They
are likely just dirty from build files anyway. Ignore them in the
diff-index command.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index ff580edfad..2a560a5327 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -20,7 +20,7 @@ IMAGES ?= %
 # Make archive from git repo $1 to tar.gz $2
 make-archive-maybe = $(if $(wildcard $1/*), \
 	$(call quiet-command, \
-		(cd $1; if git diff-index --quiet HEAD -- 2>/dev/null; then \
+		(cd $1; if git diff-index --quiet --ignore-submodules HEAD -- 2>/dev/null; then \
 			git archive -1 HEAD --format=tar.gz; \
 		else \
 			git archive -1 $$(git stash create) --format=tar.gz; \
-- 
2.13.0
